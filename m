Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593C2204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDe8rrmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593C2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeKAWNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:13:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39683 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:13:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id g10-v6so20932089qtq.6;
        Thu, 01 Nov 2018 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBY5sL5Zy9mI+DssTb3NLs4hwmm/8avIY7AmyIZGvOA=;
        b=EDe8rrmki4lbc8lw8XkNLJ8s5Kgfpy6dy7S+91bkIIMm+ev2pz4gj0xJu/un7tWzRB
         JpSsBENuWLTN7nJinqK1fyLRR9lTeo174qblRTLEw9refIVa1KOKl6SpK9BkqD44nLV/
         55blvL3meg6Hj3XH6WWoPY/Y4H1BtpXQt/NjkDFoir+GNPr5kXwlU6OxU+zwCWJARQJL
         6kC6fYdqPNRK2lWBmpG1e5VCdtNAqHFK8suCtTDwvXz6BDtRGuVm3eMZZQntxiyvEeZc
         p3oQxguIOVzs+MXS1DMvFmOU2t8+0bRuTnhFipgIvcWQA3aCG5KC0HWLq5+WwG35eYoq
         /x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBY5sL5Zy9mI+DssTb3NLs4hwmm/8avIY7AmyIZGvOA=;
        b=l/1s1vHM1K7ai7W1Wk9txvaZopGRE2jQRBf2pfkL8TnXlzM1ZMuaoswZT3B+aELFL8
         +HiwSiXT3lHE8HKTBlTcBzHTgOL+hzb8UUKAj9KiFYDvx7lNWZSPPdOmGTpSbErzQ/Kt
         W50WWvthVouVgkAgBYs9YmP8/CbRopfK92vCieSLY4Enoq/6iEMbP++wiBAMcZhreWh2
         pObUuu/WQ4Q/d8S1UCxX0FTVh+V7EVtUjwSPrQAklDsGeDKJ9+5cHs9deNeyQ2Jf4xOG
         EA67GuweKW91lZMI4pEspqFCUYqlUyDfxRAkixyhKGN2ZT97jLTbOfX3sKAkWMfroH1P
         2I1A==
X-Gm-Message-State: AGRZ1gIoSWJyOb5DeqQFNs4/jPNnIU5o6XighEhCJfKP9FuaUEu6hIny
        clfsdr5Z6dSMmfKAH+AYxPzNwb2uQgx0YF3nctE=
X-Google-Smtp-Source: AJdET5fGRKGoNfoOgpKUcuxjMiLuz3Js4Yw+4qjT5waJ7Q9gdcS+agGk06Mfi9nIRcnhcvQgDZ/tGV7/nDaefxEiJ4Y=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr4887532qtf.99.1541077853051;
 Thu, 01 Nov 2018 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Nov 2018 15:10:40 +0200
Message-ID: <CAHp75VeLikOzXrdZ4zP_Ccr8DGx81hdhLRTdUrLJ85NPo3DHDw@mail.gmail.com>
Subject: Re: [PATCH V5 1/8] pvpanic: move pvpanic to misc as common driver
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

On Thu, Nov 1, 2018 at 8:59 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> move pvpanic.c from drivers/platform/x86 to drivers/misc.
> following patches will use pvpanic device in arm64.

There are few items you need to address in the next revision:
- use proper English grammar, i.e. Capitalize beginning of sentenses
- don't forget the tags people gave you in case you didn't (much) change a patch

Other than that, this one looks good to me

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. WRT tags this one in v6 should have something like:
...

Reviewed-by: me
Acked-by: Mark
Signed-off-by: you

at the end of commit message

>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig                     | 8 +++++++
>  drivers/misc/Makefile                    | 1 +
>  drivers/{platform/x86 => misc}/pvpanic.c | 0
>  drivers/platform/x86/Kconfig             | 8 --------
>  drivers/platform/x86/Makefile            | 1 -
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename drivers/{platform/x86 => misc}/pvpanic.c (100%)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eac..1ba0f62 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,6 +513,14 @@ config MISC_RTSX
>         tristate
>         default MISC_RTSX_PCI || MISC_RTSX_USB
>
> +config PVPANIC
> +       tristate "pvpanic device support"
> +       depends on ACPI || OF
> +       help
> +         This driver provides support for the pvpanic device.  pvpanic is
> +         a paravirtualized device provided by QEMU; it lets a virtual machine
> +         (guest) communicate panic events to the host.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc..df951f4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)        += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-$(CONFIG_MISC_RTSX)                += cardreader/
> +obj-$(CONFIG_PVPANIC)          += pvpanic.o
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
