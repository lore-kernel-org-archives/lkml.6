Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE92081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuOutJfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EE92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeKBSkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:40:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35058 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:40:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so2060510qka.2;
        Fri, 02 Nov 2018 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BD1ERz3h6WXcUif/JINdkQy7uvdYRF1T6fKQO/FKHlY=;
        b=SuOutJfWhBCdUBNbNvowfDOeVqKDoaX3GL7/FD/sJ9PFGevfzGkfyfuIHFqFhMK2RR
         hHZt/B/0RUtyyIeaqY+xC20yVRleIBkqOEcx5QxUHN7OBSwMqmv89hDNwzWhS7PkURVJ
         N87sMwh3fLGlfAQzMqlJdenwmT/2VMpt+9LzLuOXQ1U1Sz71vUxggRinMoi57HFoBL/3
         ED6QJmKpSaZmEyRajk+JVXLaDl76dMB96xwxcSAHrovmx3wlEkL3fUHH/HnhtRI9HnBN
         iPqtQ77wYjD5cMj/ftimlS7Asb0Dsyfuhn5otu2JE4Kj3naSDgpVv+TCCOpFpoWPNB/f
         /J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BD1ERz3h6WXcUif/JINdkQy7uvdYRF1T6fKQO/FKHlY=;
        b=cW8V5pqQgVBtMt5T/ID9VPiKMSdsaMPAwyRQm8PNhhJxGimL4iySWUw1Z2DB4t+bt5
         UYrvKUXe7NXunYijLDV1kUMPVHYQSC+YmfmyNtLQfhtlhWwevWkYBQgqb+Oh4pDxNfn2
         7ADxaxiXEHeaOmTm2nZPJQNxTdgbJbwjFjahrl1FyEC3QeT/AfxLQDbI0y4PXwi1gBPy
         KIofzNUqEROOsFFjTo6SQ5DYTB6bD11G84jvFQvHgVjurxdYgIU185zp72bH5fWw4OjF
         OcSyxNgfqCdcYl+ZvuLn0tNaYfHMbUA+JopnQRcwhuu5FF+BgsXvRiUI/Rkw3hbPDzVK
         rAiQ==
X-Gm-Message-State: AGRZ1gKbvfcpswzCKO9yv0dEt24CGGPoT/xR5ymSp57q1b83pyRfol4/
        ResGvNWZrD8ADkoR2R916u0NoKsQ6DiT1CdAZ0Q=
X-Google-Smtp-Source: AJdET5eJeOUW+7l/Io5tzSNLYebhwh0/5oEaKWz7Q4L8twa6spWIU3qe7jE2/zqAwhotBnt+5w1mFS4/NvenZ7m9pLQ=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr9750500qtj.327.1541151213164;
 Fri, 02 Nov 2018 02:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 11:33:20 +0200
Message-ID: <CAHp75VdRuuE1v9idm=477mNPCkXsSCiMmfM1UhErv-Jzovuk3g@mail.gmail.com>
Subject: Re: [PATCH V6 1/8] pvpanic: move pvpanic to misc as common driver
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:46 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Move pvpanic.c from drivers/platform/x86 to drivers/misc.
> Following patches will use pvpanic device as common driver.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig                     | 8 ++++++++
>  drivers/misc/Makefile                    | 1 +
>  drivers/{platform/x86 => misc}/pvpanic.c | 0
>  drivers/platform/x86/Kconfig             | 8 --------
>  drivers/platform/x86/Makefile            | 1 -
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename drivers/{platform/x86 => misc}/pvpanic.c (100%)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eac..642626a 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,6 +513,14 @@ config MISC_RTSX
>         tristate
>         default MISC_RTSX_PCI || MISC_RTSX_USB
>
> +config PVPANIC
> +       tristate "pvpanic device support"

> +       depends on ACPI || OF

0day bot is rightful in its complain.
From where OF comes here?

> +       help
> +         This driver provides support for the pvpanic device.  pvpanic is
> +         a paravirtualized device provided by QEMU; it lets a virtual machine
> +         (guest) communicate panic events to the host.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc..cd4b2f0 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)        += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-$(CONFIG_MISC_RTSX)                += cardreader/
> +obj-$(CONFIG_PVPANIC)                  += pvpanic.o
> diff --git a/drivers/platform/x86/pvpanic.c b/drivers/misc/pvpanic.c
> similarity index 100%
> rename from drivers/platform/x86/pvpanic.c
> rename to drivers/misc/pvpanic.c
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0c1aa6c..4ac276c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1121,14 +1121,6 @@ config INTEL_SMARTCONNECT
>           This driver checks to determine whether the device has Intel Smart
>           Connect enabled, and if so disables it.
>
> -config PVPANIC
> -       tristate "pvpanic device support"
> -       depends on ACPI
> -       ---help---
> -         This driver provides support for the pvpanic device.  pvpanic is
> -         a paravirtualized device provided by QEMU; it lets a virtual machine
> -         (guest) communicate panic events to the host.
> -
>  config INTEL_PMC_IPC
>         tristate "Intel PMC IPC Driver"
>         depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e6d1bec..e88f44e 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -75,7 +75,6 @@ obj-$(CONFIG_APPLE_GMUX)      += apple-gmux.o
>  obj-$(CONFIG_INTEL_RST)                += intel-rst.o
>  obj-$(CONFIG_INTEL_SMARTCONNECT)       += intel-smartconnect.o
>
> -obj-$(CONFIG_PVPANIC)           += pvpanic.o
>  obj-$(CONFIG_ALIENWARE_WMI)    += alienware-wmi.o
>  obj-$(CONFIG_INTEL_PMC_IPC)    += intel_pmc_ipc.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)  += touchscreen_dmi.o
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
