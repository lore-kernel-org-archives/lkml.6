Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E92208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja7ikoLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E92208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756893AbeFPPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:52:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43142 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeFPPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:52:30 -0400
Received: by mail-ot0-f196.google.com with SMTP id i19-v6so14172874otk.10;
        Sat, 16 Jun 2018 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YDO4vdgLSxBiJM8N5ohdi/1VH3OLIR4x97zll5GqT50=;
        b=Ja7ikoLiKVumhlX8eaGM4sxIfOAehhUGJGuoKiERowqkq9hKM8MylFEzB5kQ3xRnSW
         5qBmDeRkXxpQQG4wQDmbGA5TDq/udVLxMzTRzzgO8IcRC+7B0AsF392oPDHH9OdALuLd
         nUTWnpznt8uFTFYGk4f3rUnRl2Dcg7pGSRRSxHNUEgKGHyNwMs7PiBqpZ63KcQded0pt
         97dzy/DeWqc+NHCBqx2WfbxLoiA0TzeYp2XUJmklkuCN2Za3x+Qe5x0OU/ZPtZMaezcf
         IEkZZY4ZtCm5EkA3+Gpulkc/8pCQQfPcJbIzUgyqFC5mF2thEf5+iVmT6H2gNVi+dsQ/
         aOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YDO4vdgLSxBiJM8N5ohdi/1VH3OLIR4x97zll5GqT50=;
        b=oK2ut2zpe4lNuOAR7o8ajKt8kqNPEs7rBSdo38D1v9im2D8e8gPcIHOLnR0tHZ2VZV
         PeLBMDQY7vl3+VX3ofGgdyXJqCOYfKx/x0M2+HMuTSqKfzY/SF0NngcmYRSZ2aDEjHDk
         bG6SwRt5puNoK18twJRGED6nkkTG7AHqsXhCDi0NgUyu+bv6xrKZV6w6MwArdFDhQFpJ
         qU9PCQ8MxVVCRm4v2jb7AXRFmfWpJg4E5Hxb2oof9hBNMMdfF2LKPMncPFMpDPuvJbei
         J70Rx80bqPrM6lqZRFkW+R4bszTZAGMXw93mKE71U+KSPgqrgsjXZwXp3XoPdN3osgQO
         JVaQ==
X-Gm-Message-State: APt69E15DyyxfEoQnkVCF8vdEXWutbaTSvKfvSeWhxH4TFSc8W/YxT9v
        gry+d5lJzbSK24NL+V5H/oqOp4TSmbU0MLVMl8g=
X-Google-Smtp-Source: ADUXVKIUktA10eenpVtT9YE8b89/030xRoIo9hjHCUc+T/u2vSGOzycJuwC7p5ST1+zGL5inr2RVrLhOjTC59u1Zx4Y=
X-Received: by 2002:a9d:55d7:: with SMTP id z23-v6mr3943162oti.271.1529164349982;
 Sat, 16 Jun 2018 08:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 08:52:29
 -0700 (PDT)
In-Reply-To: <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org> <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 16 Jun 2018 17:52:29 +0200
X-Google-Sender-Auth: cZ0-985e1RM50MFNeUnKMiqDD_c
Message-ID: <CAJZ5v0gVBxDZnNXG4Kf9M0wMwR1R97kg6uNmAYi5Rf-5kPBNQQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/26] fix a series of Documentation/ broken file name references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
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

On Fri, Jun 15, 2018 at 6:30 PM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files move around, their previous links break. Fix the
> references for them.
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/translations/zh_CN/io_ordering.txt | 2 +-
>  drivers/dma/dmaengine.c                          | 2 +-
>  drivers/platform/x86/Kconfig                     | 2 +-
>  drivers/sbus/char/oradax.c                       | 2 +-
>  fs/befs/ChangeLog                                | 2 +-
>  fs/orangefs/orangefs-sysfs.c                     | 2 +-
>  include/linux/platform_data/sc18is602.h          | 2 +-
>  kernel/power/main.c                              | 5 +++--
>  8 files changed, 10 insertions(+), 9 deletions(-)
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
> index 705c2366dafe..d9706da10930 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -455,8 +455,9 @@ struct kobject *power_kobj;
>   * state - control system sleep states.
>   *
>   * show() returns available sleep state labels, which may be "mem", "standby",
> - * "freeze" and "disk" (hibernation).  See Documentation/power/states.txt for a
> - * description of what they mean.
> + * "freeze" and "disk" (hibernation).
> + * See Documentation/admin-guide/pm/sleep-states.rst for a description of
> + * what they mean.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the PM part above.

>   *
>   * store() accepts one of those strings, translates it into the proper
>   * enumerated value, and initiates a suspend transition.
> --
