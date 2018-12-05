Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35BAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873ED20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtGjyDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873ED20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbeLEMQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:16:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44480 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEMQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:16:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so17291074oig.11;
        Wed, 05 Dec 2018 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwKVrTYXLSSMg9QL1O1AmfDRatCuJQyQS166HfPNS7M=;
        b=RKtGjyDMSe523r3Rps7iqbn0zHshUrhqLDoOy1NGZQ57vIbpvWYr2G+kPzlE8K2ySV
         8llrCDDPHI50+Iz0nbKuTZbiMYpyO5RZuZQjzlkwTYa+edeVjJcxGG+aapHk3zMDhIlR
         Z9PH8ukbC1u4dcFWI2A0AX3PzPrjOgULurbHHoG77h2V5xceyT+6CYhkO91LrGIu9MFd
         EY4ExMYf85Y76+k1H+scoXuxJMxI/ghKNcNdA2FcSNtbRaL2kinKg0MkSZUzghcS9k9X
         Hp9R7g3iB2p+O4cSO9MYAu8ghFRM/Xj9EuRAXy7o+CKCJD6XfdgLe+rZm9AmiVvkaEdD
         ygAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwKVrTYXLSSMg9QL1O1AmfDRatCuJQyQS166HfPNS7M=;
        b=avS4eep9z5oF5Ls6PMG1Op6fXaKKYlYei/iynZu10RwNxKJ/x9Go7tcPluy++JW2NG
         GQjENBilbTw33/7sQRFSpB53M7tMictLQkzABDFW9UNjK5WqF/FOUryqVyuFaQGaSkdy
         weuaO8RGQZrAkgr00Pj7OG4qRorr0b8JnyaMUh+aC5V1YOdfnicq8foR2sKXVkzDZSjj
         lnOQFpY6lteagZnap3BfZr14gKZle8MgeUi530revTPy+IUSWZJlxjk6WYJb9bFNs+Q1
         MPgmT2UeZENchE5ch+WP6Adl01m6MNoguN3mY5n0t6klpGV+6Puazk6FYAWwgy1N/Q8w
         lF1g==
X-Gm-Message-State: AA+aEWbgawzVSwUY5zV6Nr982nkLW0qr4xap+X/qo/jyOUNnBWQojug7
        TpLHHo9sBvPFENGG2mSGxud6Qiq6432hycwj5hQ=
X-Google-Smtp-Source: AFSGD/V03BYC8tHjs+oQl0Za0OfM2LtyUlKXvDI4QWATi6Fpa2h1HZ7SUjRUEKY/0XUnycM2Yn7V803pDFsbWPf8wlc=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr2825735oig.266.1544012170975;
 Wed, 05 Dec 2018 04:16:10 -0800 (PST)
MIME-Version: 1.0
References: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 10:16:15 -0200
Message-ID: <CAOMZO5Awn=KcHFFpE3Quo5BXkqTmVXjz9udrR0KUWUq3e8UShQ@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:14 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add egalax touch screen support on i2c2 bus, it is connected
> to LVDS0, while the existing one on i2c3 bus is connected to
> LVDS1.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
