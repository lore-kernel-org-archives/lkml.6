Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710682089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQoNHlVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710682089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeJBAwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:52:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45463 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBAwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:52:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so15024300qtr.12;
        Mon, 01 Oct 2018 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOecgNoGrgdYyAQWQQm7pSL2i3FJxrnIrIYc9B99SCc=;
        b=lQoNHlVgXyizZbeUlkQscn6gi4SyBkpJgZcX2LAGa9hPdrQSHrNOQNOQtJi5VTcwnk
         NEjiad8UgZRykgWFeLkezkLN8IEgOtqx8kqOBnkI3Vq+RMpxUoh1r80xccEZ98u6Er/m
         pCLY/ZPt4vYZGV8dBjBdklc9BOfLqrB+BMfyaiujSCFgCRgezdhj7kTQexR7LgXMLgIY
         ZnQQ8AHyWoOVetcOUrs07Nc52PD02QE2d2bcpix8aAk0xSdLD+LCpAx1BZgZoSj9nAKe
         W5bKMIuf/kB04erJPr8wPzHUQpjChszazk9Xbk508vQv5RWTZ8CL1igVkppNwWrAh80q
         FcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOecgNoGrgdYyAQWQQm7pSL2i3FJxrnIrIYc9B99SCc=;
        b=umZdy1fW0l/jqFM6bkvQn85WoHlj6ZUE0Y61HXN5bfOSsL/t9SteM7poHblaIE7EVz
         4QpOnquh19EkyfpPVXM3XaS9e9ZuOw6l3r16xa/sop51z/SposwCEm2G6MWLUVA67Yko
         JY1P0KufCl044oq5EIwAZ9oS3/DGpzlDavfq3gUdqslx52xEKbUnvyFVF/xmMhQ5gODN
         BkJJ9Ggqy6xvNjeDubWFdQ/Naq0IVoZu4GLBCKnCzX6MM3n8lv2r+D5Lmnhwug2cHm6b
         O6vYL1laRN+pakdgJJsKpdpQEECDSQ+ohT3mb9AmnCBffXe0pRJ7PyiLt5m6HxHvp0NO
         rS/g==
X-Gm-Message-State: ABuFfog/ifp6ruyb109ahr0W+Yk20u6PU+RnF9nhXM6WfeaEmmY4PEh3
        9ZJaN1BMgZxSztt4qkBYPWpb3Qsh31G7twGrN6k=
X-Google-Smtp-Source: ACcGV60iTnXuD+7pPyZDYY/96uH8JYoXMhbSSd8rwROosiwezVY1A1t8eoiiyJM2/MKNt4hF6UYb2cm+bSpUVLq+bRU=
X-Received: by 2002:ac8:2f86:: with SMTP id l6-v6mr9633944qta.83.1538417600393;
 Mon, 01 Oct 2018 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181001174349.26357-1-f.fainelli@gmail.com>
In-Reply-To: <20181001174349.26357-1-f.fainelli@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Oct 2018 21:13:09 +0300
Message-ID: <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>, kramasub@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
> same controller, make it possible to select the STB driver and update
> the Kconfig and help text a bit.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - Make COMPILE_TEST last, as per Geert's recommendation
>
>  drivers/i2c/busses/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 451d4ae50e66..56ccb1ea7da5 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>           If you do not need KONA I2C interface, say N.
>
>  config I2C_BRCMSTB
> -       tristate "BRCM Settop I2C controller"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +       tristate "BRCM Settop/DSL I2C controller"
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> +                  COMPILE_TEST

I would rather split this to two 'depends' entries, though it's
cosmetic and up to you.

>         default y
>         help
>           If you say yes to this option, support will be included for the
> -         I2C interface on the Broadcom Settop SoCs.
> +         I2C interface on the Broadcom Settop/DSL SoCs.
>
>           If you do not need I2C interface, say N.
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
