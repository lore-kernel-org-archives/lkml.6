Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E6C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A53E20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gViMtbc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A53E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeI3AHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:07:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37046 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeI3AHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:07:41 -0400
Received: by mail-it1-f193.google.com with SMTP id m9-v6so6566377ita.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhP9pGm2YvWCOK1DcegOUvHeqpp3ueIbWs8jl+gdSSQ=;
        b=gViMtbc7XpI5Zami65vsFjFs5r9Ss/3p0CP6dAWnDsQPe711UkZNw3dlQcE/Nvv+Gt
         TmfRcP+9BjZdrBRA/cCrmsL/Qnd7i6LxWZqTml7A8GCaq2ahiew1PLBybWGm/P4E2eHR
         UAyL2vGoZxAGWa+O+YqH1d0UdVpYFLhdEtqqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhP9pGm2YvWCOK1DcegOUvHeqpp3ueIbWs8jl+gdSSQ=;
        b=Z72htMONJ/N5CDDJzoLnoVw9YsFdswAidpLy0RP23bGSQEOpEcrUvjMMIP9zhVW/Yg
         TyQNaJArK7WRt30u+5XQFrOyJycFvcC3W7lPuezLiKIMhBeCSb5jnqO8OGST8pCQE9OI
         toRpd2su+qtcWjQe+w8pvtvjpPDZMqJNXetTZui0xHuPrVDMNJWPlxPfB/Cg4tu/jHdg
         wP+ycuWf0ATQcYDdgoqnl2fpXcamGhFFgrxbO7DpIPGfXhx+XUgijBxMc5QpR1/7kiAk
         Sb2p0YQFDnLwQpyrscLlwVt4MQEEfrMlLLMEnPAb66iRJtOaZiAqCDLHdVZk7p+EE5BN
         FKRg==
X-Gm-Message-State: ABuFfojLgQ1Sp3LA1JgyLMpp8NONSsZe9eZGMuAYEJhAOmOVZofax9XI
        tlwu22Bvm4causPyXBy2yABYM2n/uC2y8XC4QUetPA==
X-Google-Smtp-Source: ACcGV63/3MoYlhs6DDMdLZ428xoub2gphlWh8jHVzEAKbcGzSrDJ/ZotgyjJzVbxokkwBb5Tdjk/0/URFmLGjLsEShQ=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr5718221ite.16.1538242705185;
 Sat, 29 Sep 2018 10:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180906122436.25610-1-linus.walleij@linaro.org> <CANcMJZBAerypZGFV+Bc_+J34+8zt7t6+6vnJof7x7PC9bFGq8w@mail.gmail.com>
In-Reply-To: <CANcMJZBAerypZGFV+Bc_+J34+8zt7t6+6vnJof7x7PC9bFGq8w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Sep 2018 19:38:12 +0200
Message-ID: <CACRpkdaom4ob-B7R-L9s61nVkTeWPMzmXzoKs4H7Wz_Hutbgrg@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     John Stultz <john.stultz@linaro.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tom Gall <tom.gall@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 1:32 AM John Stultz <john.stultz@linaro.org> wrote:

>   Anders recently noted a regression in -next when running HiKey,
> where USB fails to function.  I took a look and could reproduce this
> as well, and after some unsuccessful muddling about in the usb
> changes, I bisected it down to your commit here (specifically
> efdfeb079cc3 in -next).
>
> I'm not sure exactly why this would cause trouble, but I suspect it
> has something to do w/ the cable-detect OTG to host-hub switch on the
> HiKey.
>
> Anyway, I just wanted to raise this with you so it can get sorted out
> before that patch hits mainline.

OK how typical, let's see if we can figure it out. I looked at it but
I can't see what it is right off.

I guess it is this from
arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts:

        reg_5v_hub: regulator@2 {
                compatible = "regulator-fixed";
                regulator-name = "5V_HUB";
                regulator-min-microvolt = <5000000>;
                regulator-max-microvolt = <5000000>;
                regulator-boot-on;
                gpio = <&gpio0 7 0>;
                regulator-always-on;
                vin-supply = <&reg_sys_5v>;
        };

It's a regulator with one GPIO.

It used to be fetched here:

+       cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
+       if (IS_ERR(cfg.ena_gpiod))
+               return PTR_ERR(cfg.ena_gpiod);

So first would be to put in a print like this:

if (IS_ERR(cfg.ena_gpiod)) {
    dev_info(&pdev->dev, "error fetching enable GPIO for %s, %d\n",
dev_name(&pdev->dev), PTR_ERR(cfg.ena_gpiod));
    return PTR_ERR(cfg.ena_gpiod);
}
if (!cfg.ena_gpiod)
    dev_info(&pdev->dev, "no enable GPIO for %s\n", dev_name(&pdev->dev));
else
    dev_info(&pdev->dev, "fetched valid enable GPIO for %s\n",
dev_name(&pdev->dev));

So we make sure we get the enable GPIO handle.

Else we need to troubleshoot that.
Look if -ENOENT or -EPROBE_DEFER gets returned for example.

If those works we need to check the flags. Since this GPIO is specified
with gpio = <&gpio0 7 0>; it would nominally mean it is active high.

But there is special code in drivers/gpio/gpiolib-of.c to deal with
regulators, since those lines are by default active low and ignore
the flags in the second cell from the device tree.
In of_gpio_flags_quirks(), we force the GPIO to be active low
unless "enable-active-high" is set. So we need to look
in /sys/kernel/debug/gpio or just lsgpio to see if the active edge
is the same before/after the patch.

Sadly I don't have this board myself!

Yours,
Linus Walleij
