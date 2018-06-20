Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79574C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB620836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRmlf4t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeFTKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:23:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45370 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeFTKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:23:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so2508550oid.12;
        Wed, 20 Jun 2018 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aX+r9ObavPgRGGQDYJXYTk3HOjPMmfz4J1S37YQGGRc=;
        b=pRmlf4t1ULk/YJCVVcDNO8rxI3TWyVTJvuXxBaN0vW8Ia9tS03NLABQdXTFvioakY6
         DEOB7VgAr3Luefbc1RjWC53BaKTJ4QEbVMavWhKN3OH6lXNeXcPHall72q/ewSfrqA8j
         N5G1+y/5aJrKVAtxFEH7U8jzT6YycZQFA5wUAvYx4c5fvWL68Xzne9dbu38h9y56MXmi
         ElqBEFTry9FJemSh8w+/xcqdr1w0RVuQHrwaYLsbnwvbRX8zawtrl1OsAq1Px2eQtI9F
         oW8tOw0cCw4DnHkUt9qSG5/OH41eE6Ol/zrkPMeJ61E93Gbb/LWtfH8gREWjpB7eVgkj
         wZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aX+r9ObavPgRGGQDYJXYTk3HOjPMmfz4J1S37YQGGRc=;
        b=mDma0xY72RBIkVTgveJP+W7LLDY3syAg09dw3KuY6sl8+5Ywk0PDpw9vCVjrmESJcH
         C3RIsBqhWhPcrTf9x9UluM+wLhBWcqOI2V/bVIqySlDWAzCXkFfrU0bCjQ7BTMaHpW3r
         fnGICm+Zu4bu8QRQ/wxRWF9qHdOxOcXH6MV47YaQJhy9jj5fFeOGKyaLiA31IuFkv9jF
         1Fnr6VaSDd6E6/vtTGEzGYcHK0Xm+bgGWpGXseVdWSuuXackH/EXp4IzMqTdXClp2wiW
         ZFxToOyKC70N2tgW24Mxq96TuZ0dAyc7sN2OR7RifoSxwiXobUcAb7wCbGgerZRR9rUD
         MRNQ==
X-Gm-Message-State: APt69E2jGjqR6Jb3AjrdNxCBj4UflglAoSUtXQPDDrSRxz5wJau90lHq
        YGSOpH2RCYnYjSc7X5yR5jsPBL3gMMn5GJecels=
X-Google-Smtp-Source: ADUXVKJAnzGzYgaX2XKiYyAU0/TURYIPTX2AecdpSpRN3nDB8ZXii5U9YKKHRm4jW/t0ub3GtkhAI68DCeEnRD5mSYo=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr11798488oii.198.1529490229100;
 Wed, 20 Jun 2018 03:23:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 03:23:48
 -0700 (PDT)
In-Reply-To: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
References: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jun 2018 07:23:48 -0300
Message-ID: <CAOMZO5DdLzEVqDLwk-+JGt0RCLM=VgOYwmH8GZmVzgu_Sw8MhA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sll: declare src module to be compatible to
 imx51's src
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:38 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
> compatible string to enable SRC driver to support setting
> CPU resume address for cpu-idle and suspend/resume.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
