Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0914AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F66320853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhyGkM+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F66320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJVUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:51:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43160 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeJVUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:51:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so32006785oie.10;
        Mon, 22 Oct 2018 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1UlO0IzegVDuzniMaq2OYmjxl4Xq5pSRe4OMBenZc4=;
        b=qhyGkM+qMq05uwr6va+Bl19dfr1OeChbOBooHZbxLF9oW91j5inqw4PHGvNVmoSmbe
         xWYvpndb0XZ/jYoEsRwf4WBwaNMA0qoTM9j2qiN+hqZEVJ5GjlDUnzSinDrMhoU7z1Wo
         gQb5i+Cl0iT+VVNoDMsoo3NLJzj/FrfSw2GKikzmDPbFGWBuqU4YLQ9X1Fnr4jyZ+jGd
         qM5CT4oiF+RDHn74hfjlmDKUeroGIO9q7aTsbEgCmOAdIFBxT4lxtUdjtTNoTUxZoq91
         Sshfc+8v6i3donUVeISEDkgI6thJNh9ux7vTzNj3wF+w5QFgBiMpCSHpvYGzJ9BIZ0ye
         HylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1UlO0IzegVDuzniMaq2OYmjxl4Xq5pSRe4OMBenZc4=;
        b=rLMsTUmsssi/bpN7Aooo6gbMXdMO8NgAThewnBCV5bj7NToC6Z1ZLojrsiz96rC/qx
         j00HZGyzCUHT7jS+DHhL67zyhogcRevlB9YxS9NC1eZGtDwd+Zlqf+Sl3aysCgx40vj6
         oET1hcnhxiZmVf1QFUwUvQQkt9OT0PF0tWOIkD2f/h5o3sTm80PXrAEcH/Fcy8d0Wr1k
         vJR4Rgk/8U0zQU1ovp6pDu5WSZf4R8SJFSnssC50RLFoF1uvVuTD6oBOCLPBL53W9cEV
         O6AtacARmRDiUSworGLii79WN3ozY2ScM0uuTp3KoZ1/cT3DJBgTzklVN3s5+85uV+uH
         Cs+w==
X-Gm-Message-State: ABuFfoj384o+yvwEc7mD0Dfaxuw2JHhBM2QVWIKr9mCSP/LdOzMbsnIA
        /uAJcIaoQ1VQM+lgJ97qjoBwFvdbbzbKN/YD30Y=
X-Google-Smtp-Source: ACcGV61yPvYhrzEJD+DKAUMNasr6EXNgFwlkr5qRdoJqLw4MwjEtMFFFJoI+hn+GaoFJn+pYK+0zWaRVs71zmG2L7qk=
X-Received: by 2002:aca:3006:: with SMTP id w6-v6mr24859014oiw.342.1540211599388;
 Mon, 22 Oct 2018 05:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com> <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 22 Oct 2018 09:33:16 -0300
Message-ID: <CAOMZO5CeZN5QhGha8rOm6qvSPmeVAPjQogmYsHLj5BE4CJ2jAQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for
 wireless SOM variant
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 6:28 AM Alex Gonzalez <alex.gonzalez@digi.com> wrote:
>
> The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
> QCA6564 wireless chip with dual WiFi and Bluetooth.
>
> Both the ConnectCore 6UL SBC Express and Pro boards fit a wireless SOM.
>
> The Wifi is connected through the SDIO interface on usdhc1 and the
> Bluetooth is connected via uart1.
>
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
