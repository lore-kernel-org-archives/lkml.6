Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36775C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2C2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olzRszd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfBFKCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:02:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33993 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfBFKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:02:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id v14-v6so2684213ljv.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Arc/HoTcPxPIxIRz4p4ijVwmMuDAmNvH5INpp+lLdGg=;
        b=olzRszd1DP/BcKdUngOzSntP7QUg1VfQaAjPgwzfWPQZPuu+nNAR9qxule7bJGEInB
         4/m1PrB+o9USo474VZMHZjVyrv+m64q0JYftQC8gpF6jS+LeEGOTQMMeg5hIyGW15ck0
         chRSkOJ330751kiVi4wzF6I5838zrIn/bJyWCOWANRxpvtaI3zd1KbP8mVWEy/VKI6ui
         98ArApWg8CzSSF9CZau4rKPyvHrhKX+s4k9IZWG8WCoLKMByLxntU7oGiYPXbxB0t26f
         7j8C8MMKIcrx9Tvr+Tdx+ieiVN/jJtzt4y+R0JrhAGTg0Ar6OZiPVEXgLEssCnNF8KOa
         tF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Arc/HoTcPxPIxIRz4p4ijVwmMuDAmNvH5INpp+lLdGg=;
        b=NZZZb0ZI7760KDtcTr1MhXydd1ZFbflWyg5cLJAqvMbgddhrN0nKaC3OLVr7K1uKec
         gFWgL/tthQKHTF5Hog87A1P3Ra4I7RO1/iMiVTDCEA+G8sN3pSvbzM8ZqI3ny6qDIBlc
         7y1Vh/mepkfiXWl6KmKKPBQP1//zeP4g18Q5xMc/ZasmJT2OPOTon38Bi5eQnrQCTmIJ
         Aoo8OMjIkh4SEVTYheSkkgMWuSK9bh6msmAfLjUyQNfkKc5ttT0nBMJGIGb1l7v8Ldxk
         NmcP8S3ns+TA8oK1NGb4w+etzA7AFmjEaUsnQ8G3suyusL+l7NkCBM2XNiAFKI5xEl65
         Ur6A==
X-Gm-Message-State: AHQUAua/wzuJ1kwBQd8ZPAXEjTmYqz8w1casYdSDuWy45+MVJ+A3cvg0
        /9z4OsCTj/bD8jQV0JZKYIM7BYIt9SnGzPNTB7d7GA==
X-Google-Smtp-Source: AHgI3IY7BvWu/E8rMJArxMCWlKKc2qHO+mV/Mwr6UK/YLF6GYw5bj8DVDtEcHsHAFc0XcuCB5t/hPQkc3VvcKncOtus=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr5888973ljh.135.1549447340203;
 Wed, 06 Feb 2019 02:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org> <20190125162302.14036-4-masneyb@onstation.org>
In-Reply-To: <20190125162302.14036-4-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 11:02:08 +0100
Message-ID: <CACRpkdYuH6QnumRnAUbzJCwrj58mog68FJu6Tvi_48bLzsBbZg@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian!

Thanks for this patch!

On Fri, Jan 25, 2019 at 5:23 PM Brian Masney <masneyb@onstation.org> wrote:

> The IRQ handler was hardcoded as handle_level_irq and this patch
> properly sets the handler to either handle_edge_irq or handle_level_irq
> depending on the IRQ type.

Done like so:

> +               flow_handler = handle_edge_irq;

This creates a problem and makes my kernel crash, because
handle_edge_irq() *unconditionally* calls chip->irq_ack(),
and since this chip does not implement .irq_ack(), it crashes.

I tried to just add a void .irq_ack(). That instead made the
kernel hang.

If I just assign handle_level_irq() as before (just replaced
all assignments of handle_edge_irq with handle_level_irq)
it boots nicely, AND the interrupts are working fine on the
ADC calibration path, and further readings of the ADC
generates new IRQs, as expected!

The handle_edge_irq and .irq_ack() call path is for hardware
that require an explicit ACK (such as writing a bit in some
register) when handling edge IRQs. This is necessary in some
hardware because of the transient nature of edge IRQs.
This is not necessary on some hardware that will simply
clear the flag when something is reading the status register.
I think this is the case with PM8xxx and you can safely use
handle_level_irq with all IRQs. It looks counterintuitive and
maybe the function handle_edge_irq() has a stupid name.
Just drop this handle_edge_irq() business for now.

This was tested on the APQ8060 DragonBoard.

However this happens:

[    3.007727] mmci-pl18x 12180000.sdcc: ignoring dependency for
device, assuming no driver
[    3.007970] mmci-pl18x 12200000.sdcc: ignoring dependency for
device, assuming no driver
[    3.014984] mpu3050-i2c 1-0068: ignoring dependency for device,
assuming no driver
[    3.023543] cm3605 cm3605: ignoring dependency for device, assuming no driver
[    3.030532] ak8975 1-000c: ignoring dependency for device, assuming no driver
[    3.037729] bmp280 1-0077: ignoring dependency for device, assuming no driver
[    3.044789] reg-fixed-voltage regulators:xc622a331mrg: ignoring
dependency for device, assuming no driver
[    3.052485] smsc911x 1b800000.ethernet-ebi2: ignoring dependency
for device, assuming no driver

But I think that is because these all use ssbi-gpio interrupts and
these are now handled properly so I will try to fix the device
tree and send a separate patch that you can include.

Yours,
Linus Walleij
