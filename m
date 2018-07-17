Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB38ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345D2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW8/GK24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6345D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbeGQOYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:24:51 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33853 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:24:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so2160625ois.1;
        Tue, 17 Jul 2018 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MlH4fPylIlQuKSLvWHN/kA1wbKTO2b0uAcfxX4cidfw=;
        b=GW8/GK24hu0So6S7dmdgOKesw2SkAI/xL+j9W6YM3p4aIqpF1juzs3xvSsiv4S3vBL
         W5Qd2Coe+3czZGPgRzd9PF+hZsNeJU0dk+ZtCzfY5SzJ/zD+CfrrXHJHS34lVU/Elheb
         kbt1wtOCaH3oRDJaJA7Fjv1fI0s8Og08U1qBEbcVXT2crRyaNGaNqJSdURymPsTILA5O
         BlWLxL7qEDGDgZwixYastS/Ry2QL75cuNr9jvPPetVc/d3kf5TwQX+TL34p1rxB3Aza/
         dyRuUFCN5HDMDKU8+25oCAH62UGGhBbvsU0yKiURSc6vM9aSzqvvmXF/Te0Zq5PMxk+q
         SLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MlH4fPylIlQuKSLvWHN/kA1wbKTO2b0uAcfxX4cidfw=;
        b=rHgqgBkeUxey5ILJY1vX2hRhhXFoYBT3ChlimVQ+ZZhvo0ePX4hVbAQ0CROcjmVgLb
         9pbdySnMTs9Gu0+gM701qU4ShwMOJho2Mhs7dKhwibXDmE0EwA/ktUaBtGKWT0qqxCbH
         mHaA0g7caN6Gird6H0L5CVxeDm/HvxXH0/zGmPjTLzRkD7q/XIpNYRDyDwW/vxW4kqvP
         OPXrOKsganU9mcOmuJsvTeqcVExMoYTJkYs/mJjMecSrbDKwEG1TO8C+dq14fLJ/wR3N
         QVAoqFIn1F6ZZ85yw7iPlNGYuxLwbpubQk8JvfGyT4L9rYKFCVbENcGyytW4CvDhnFsn
         14eg==
X-Gm-Message-State: AOUpUlHA9ksliqJFkXLtaOML8QM/69wspf2rdQBLRNhA2GGtvGbnhhZ/
        AspctnsPE6iQgN7OfkY8PAUXe/Od6aj5vafbfB4=
X-Google-Smtp-Source: AAOMgpecmtT191d2Ur1bJi6SJms6EOMAPMyCupr5RWgpd98fF3MIdd8XbCuzyOwF4wJKfhadPqpQtpnqAY6tgJrEMRY=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr1945706oif.71.1531835524179;
 Tue, 17 Jul 2018 06:52:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 06:52:03
 -0700 (PDT)
In-Reply-To: <1531721186-19417-1-git-send-email-Anson.Huang@nxp.com>
References: <1531721186-19417-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Jul 2018 10:52:03 -0300
Message-ID: <CAOMZO5D9MBOwQtKVqSD8XUtDBf9RH5+soV2jreBYHZrXzLWm6A@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mxc: add power management support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

[Next time please put the i.mx maintainers on Cc]

On Mon, Jul 16, 2018 at 3:06 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> GPIO registers could lose context on i.MX7D,
> when enter LPSR mode, the whole SoC will be
> powered off except LPSR domain, GPIO banks
> will lose context in this case, need to restore
> the context after resume from LPSR mode.
>
> This patch adds GPIO save/restore for those necessary
> registers, and put the save/restore operations in noirq
> suspend/resume phase, since GPIO is fundamental module
> which could be used by other peripherals' resume phase.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

>  static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
> @@ -434,6 +445,9 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> +       if (of_machine_is_compatible("fsl,imx7d"))
> +               port->support_power_off = true;

This does not scale well as we need to support mx8 soon.

Like I replied in my last message the best solution here is to add a
"fsl,imx7d-gpio" compatible entry in this driver.

Then you can set a flag in the "fsl,imx7d-gpio" case to handle the
'power_off' feature.

With this method there will be no need to touch this driver again for
adding mx8 support.
