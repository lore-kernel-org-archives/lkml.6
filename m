Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7EE5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542942086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx/dcHMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542942086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeFNQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:18:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46674 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:18:27 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so6169895oig.13;
        Thu, 14 Jun 2018 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9wNnMOkGpk82+EJa0/NXzxn/FZFj8ZDbQ3HaXl/LgWg=;
        b=lx/dcHMCjHAzl39XXPFeoHtiHiR9KluYElIN3X15X1oxRkXNbo0qTjUSzcxcg86SpL
         3UzpC3b9Wz4OaGAYqaL4KzGcBvHQ4cAX19jII3/IvrrIHGBra0tDKLrxlH3gB8G70ufr
         uQChLjKNZYp2M7dgv++6kECi+v+CIpV/89LRLQ3XRET8quwT3tyFthZ0hDD+Fwm/EoPC
         rXjatL5UWjJuQlm2OwVN7nzcjNA37vgG/bFYX9oquZypD6tLJUcqPEAmsMticiY+NwtV
         32P9Lp5vsIv709iI2ehCp7cV2yqpCYxIgKM20DRTpos2rgRyE5ibK2TcuyhOj8Vy4HqA
         kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9wNnMOkGpk82+EJa0/NXzxn/FZFj8ZDbQ3HaXl/LgWg=;
        b=cHBS98jZOH5JYodrUSuqyHEahBHjEwOrdRyRQGGG73dqLExV8qyZk6nhhOa28kd0oE
         GEBq+2JxCxijedYlQR4Sxd2ruBwcAePwiDzBKr3t8ITQhmV6ZwhZRJ2uDsLC7masaTNU
         Eqd9toOOk75DoHqHrZH3At62ee+Dkdyos4etl2m2dOhHfO/oOYIjBV5B/Fd7C+oCnJfs
         7SDDK3VwyjsE9Fue0Bvc5EMw3J8ctZSTGTMIW9KnsJXzYHAxI/pj5zLIMcVvsX+qP3Ln
         IcudmE8uwOdYzfSLJnZ8fCFioA92VZpnY5supffADW8NkrNmlEIyc1RQ3IEnl7mzp940
         yibQ==
X-Gm-Message-State: APt69E0C9YDh+A8KCLrrVm8m6FMdv4wFAEgpZ4+RWXBUR9x8nkw7oj7Q
        oXIcC/n9+jmp6grRpY1kwnl07FKZpwa27WWhLm0=
X-Google-Smtp-Source: ADUXVKK4rfYisamWxIhKm/db73s9sH0hEgS1Y/Pk29SwQs26g1qj441JOGbcJyYk0/cIiN9tCVsSg6P+sC33vbWs19M=
X-Received: by 2002:aca:ac16:: with SMTP id v22-v6mr1676277oie.227.1528993106557;
 Thu, 14 Jun 2018 09:18:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:18:25
 -0700 (PDT)
In-Reply-To: <a98dcea5ad61aad741c88be991d6446b4d6bc029.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org> <a98dcea5ad61aad741c88be991d6446b4d6bc029.1528990947.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jun 2018 18:18:25 +0200
X-Google-Sender-Auth: kKLz9ecYDnU8aKNM7E6XXQh4lgQ
Message-ID: <CAJZ5v0hjcH-R+Kdb67o5dxRqMi9qXMDCG6w+hg1RU3HKi933sQ@mail.gmail.com>
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

On Thu, Jun 14, 2018 at 6:09 PM, Mauro Carvalho Chehab
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

This should be Documentation/admin-guide/pm/sleep-states.rst rather.

>   * description of what they mean.
>   *
>   * store() accepts one of those strings, translates it into the proper
> --

Thanks,
Rafael
