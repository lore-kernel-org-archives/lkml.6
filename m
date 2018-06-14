Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3D81EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CE1208B2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCcRfeAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CE1208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeFNRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:21:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36632 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeFNRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:21:14 -0400
Received: by mail-ua0-f194.google.com with SMTP id c23-v6so4638834uan.3;
        Thu, 14 Jun 2018 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrJfc0iQKmAdG9s5NEmfDaOY9O7zG23IN2ew78XVt7k=;
        b=QCcRfeAT7xJLRCYx+hWnVW8gvr4yvL/IUgoZmlJO0kV6q2CJE+1cUcrQfBI1fTfwu4
         IqX4pvk9V6otUqaalYNFwS8b2XyDSh3mryttcO1MjQ/c0kGdjmDXmjIzHjw2kkBOT08J
         oOXpb4240Qr3vyqLrmFVuzN3hQ6VqJgvHvr9tru52ZSDGw5luuZeBT1DCjSvHKuOZkyJ
         zXJJRb5LeNQ+t+Gcbt6Biv9xZHshGoP/Q25xCHpi6aoTstswbFCLZ67v9GU3niUBxDti
         05JpKrQhfHa9GCh+moceDd7PEqomj7xs6ocb2x7g3yVuU4Ow3COfIErcPFJpTRaTtoRc
         PAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrJfc0iQKmAdG9s5NEmfDaOY9O7zG23IN2ew78XVt7k=;
        b=scmqCZJvxFxBEnNOK8luFP80ipWaD+kC6ekfgPTcRcLi+k8Hb3fe8daq4gGEPTDgEk
         qZI3BtcpJmyF0L8k5ObVzn82Oo9NN9QpVnS2HEiJmVf+0RZ3WHaZqcrhHDHzc7YK6VNT
         GewrlMbcVZsAspAaRFz8cE51NgTdibMfA3E4CsmXjvKqP7UzPDbPgKGX2oYQeHEBNJV8
         f/ZFp6oKm3cpUtMEGNPNSf0edp/cZjWjoZj2zC3BSJ3GhbGSmg1eR2uzlJJBhNY2gdx7
         Ndva5VEBYWOyrMbcsTn+G0NGZVN9znUBbGM1t/ew6wXDV/B17SPn/6tsUcU5XHmbDlU5
         YR6g==
X-Gm-Message-State: APt69E0AYTlio0QX2JSO3YCnC4z1ZwHZk5T+Be2ZDhsaa4GPrQvvEBZ1
        +dkHRNIzUFp4NlBOQJVFv+JdJ6k/1qNXEFH5EqA=
X-Google-Smtp-Source: ADUXVKJUFNltq/wtN2zCRvLIOHhQHQthw8usjfkpJvsE3z//dwWA11TU89UJiBd5nWq3fHyZ6civPORPfSZdguntYQw=
X-Received: by 2002:ab0:6008:: with SMTP id j8-v6mr2331017ual.28.1528996872749;
 Thu, 14 Jun 2018 10:21:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 10:21:12
 -0700 (PDT)
In-Reply-To: <a98dcea5ad61aad741c88be991d6446b4d6bc029.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org> <a98dcea5ad61aad741c88be991d6446b4d6bc029.1528990947.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 20:21:12 +0300
Message-ID: <CAHp75VdVf3wfT=Cg2OrPSmvv9OLARtSQZjdF5GWxhFqOy_iVqw@mail.gmail.com>
Subject: Re: [PATCH v3 27/27] fix a series of Documentation/ broken file name references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@zh-kernel.org, dmaengine <dmaengine@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        sparclinux@vger.kernel.org, devel@lists.orangefs.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 7:09 PM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files move around, their previous links break. Fix the
> references for them.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/translations/zh_CN/io_ordering.txt | 2 +-
>  drivers/dma/dmaengine.c                          | 2 +-
>  drivers/platform/x86/Kconfig                     | 2 +-
>  drivers/sbus/char/oradax.c                       | 2 +-
>  fs/befs/ChangeLog                                | 2 +-
>  fs/orangefs/orangefs-sysfs.c                     | 2 +-
>  include/linux/platform_data/sc18is602.h          | 2 +-
>  kernel/power/main.c                              | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
> index e592daf4e014..1f8127bdd415 100644
> --- a/Documentation/translations/zh_CN/io_ordering.txt
> +++ b/Documentation/translations/zh_CN/io_ordering.txt
> @@ -1,4 +1,4 @@
> -Chinese translated version of Documentation/io_orderings.txt
> +Chinese translated version of Documentation/io_ordering.txt
>
>  If you have any comment or update to the content, please contact the
>  original document maintainer directly.  However, if you have a problem
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b451354735d3..08ba8473a284 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -38,7 +38,7 @@
>   * Each device has a channels list, which runs unlocked but is never modified
>   * once the device is registered, it's just setup by the driver.
>   *
> - * See Documentation/dmaengine.txt for more details
> + * See Documentation/driver-api/dmaengine for more details
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f27cb186437d..ac4d48830415 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1052,7 +1052,7 @@ config SAMSUNG_LAPTOP
>           function keys, wireless LED, LCD backlight level.
>
>           It may also provide some sysfs files described in
> -         <file:Documentation/ABI/testing/sysfs-platform-samsung-laptop>
> +         <file:Documentation/ABI/testing/sysfs-driver-samsung-laptop>
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(PDx86 bits)

>           To compile this driver as a module, choose M here: the module
>           will be called samsung-laptop.
> diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
> index 1754f55e2fac..524f9ea62e52 100644
> --- a/drivers/sbus/char/oradax.c
> +++ b/drivers/sbus/char/oradax.c
> @@ -30,7 +30,7 @@
>   * the recommended way for applications to use the coprocessor, and
>   * the driver interface is not intended for general use.
>   *
> - * See Documentation/sparc/oradax/oracle_dax.txt for more details.
> + * See Documentation/sparc/oradax/oracle-dax.txt for more details.
>   */
>
>  #include <linux/uaccess.h>
> diff --git a/fs/befs/ChangeLog b/fs/befs/ChangeLog
> index 16f2dfe8c2f7..aff7eec8f327 100644
> --- a/fs/befs/ChangeLog
> +++ b/fs/befs/ChangeLog
> @@ -389,7 +389,7 @@ Version 0.4 (2001-10-28)
>         (fs/nls/Config.in)
>
>  * Added Configure.help entries for CONFIG_BEFS_FS and CONFIG_DEBUG_BEFS
> -       (Documentation/Configure.help)
> +       (currently at fs/befs/Kconfig)
>
>  2001-08-??
>  ==========
> diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
> index 079a465796f3..dd28079f518c 100644
> --- a/fs/orangefs/orangefs-sysfs.c
> +++ b/fs/orangefs/orangefs-sysfs.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Documentation/ABI/stable/orangefs-sysfs:
> + * Documentation/ABI/stable/sysfs-fs-orangefs:
>   *
>   * What:               /sys/fs/orangefs/perf_counter_reset
>   * Date:               June 2015
> diff --git a/include/linux/platform_data/sc18is602.h b/include/linux/platform_data/sc18is602.h
> index 997b06634152..18602cab7799 100644
> --- a/include/linux/platform_data/sc18is602.h
> +++ b/include/linux/platform_data/sc18is602.h
> @@ -7,7 +7,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> - * For further information, see the Documentation/spi/sc18is602 file.
> + * For further information, see the Documentation/spi/spi-sc18is602 file.
>   */
>
>  /**
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 705c2366dafe..3345ced80112 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -455,7 +455,7 @@ struct kobject *power_kobj;
>   * state - control system sleep states.
>   *
>   * show() returns available sleep state labels, which may be "mem", "standby",
> - * "freeze" and "disk" (hibernation).  See Documentation/power/states.txt for a
> + * "freeze" and "disk" (hibernation).  See Documentation/power/interface.txt for a
>   * description of what they mean.
>   *
>   * store() accepts one of those strings, translates it into the proper
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
