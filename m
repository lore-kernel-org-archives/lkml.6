Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC217C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E9320672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545037441;
	bh=1GRTqhANb+vlOZqJ/eEBmuA/nkIB5SSiGK2Zwr46VWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t6698GFi4VgGSm5SOijd8czmnPI1HjIqZ2Zj7Y0zUwyeXmTj/7A3L1jG6Vx97fGy8
	 vL3jezDMugvfvYj7dI9mOK1Cg6cSl5uW68p8gmOD1rkfzb6q+E6Wr9MhcjcCT2Jj3c
	 A3/rWIEj8fjjrtih7uVoHwJh/jLPvzTJ+yLyfNJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbeLQJEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:04:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43908 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeLQJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:04:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so9553880oie.10;
        Mon, 17 Dec 2018 01:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ar9EHeJFcD9rATmrgIwKA5WQ7ycjP1iBPQ1neYg3G80=;
        b=jMAheF5VSVkoPrOqS76Mibqtrmn+muHI+SSLprcyjKLQiDRqpSyl4afP8FiUgQF4oY
         sUNYxCKFZE4hgFm/PkK/OAwDl6RQo5wa7xOlrosusi+rCKGjPpCu00nTmAtnaryeqgUI
         95fiHNSCkj7faa+ekGMCWSKfd1+3LVULkeSMmLcSJmeGsBXkkvqV9ImAIEhBHH87WPPf
         TXWkSVBbSdRZ/dhFEl/mBZQJsS6Lc+DOuG+K7wwm8XqxK+Gv0kWdqVsl3djAeI21QL2Z
         JVsDamFXXial7kot+slfY3Dz/VWFjw5gUsT8V3RCvx8vk/oUyEig+sjlIS6hn9juWeui
         5UvQ==
X-Gm-Message-State: AA+aEWYRsNBbDEW166CgRrTHIUegEUsQuR+gjN5nzaVSXMsVSgyqxK3M
        /EAz0vfHB9pf4ZV0ifXfFgiFymUAXOU3MRmrPVRvgg==
X-Google-Smtp-Source: AFSGD/XcJGF3ouG9c460vh44ZncLvhC5F77MOeIje5rIUJSdUAxAkuBF2sb+VUSvEqxi4YXWk3EQxdgPzfNU9xj1ZB4=
X-Received: by 2002:aca:368a:: with SMTP id d132mr5139285oia.193.1545037438834;
 Mon, 17 Dec 2018 01:03:58 -0800 (PST)
MIME-Version: 1.0
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
In-Reply-To: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Dec 2018 10:03:46 +0100
Message-ID: <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
To:     shunyong.yang@hxt-semitech.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yu.zheng@hxt-semitech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 3:40 AM Shunyong Yang
<shunyong.yang@hxt-semitech.com> wrote:
>
> In some scenario, we need to build initrd with kernel in a single image.
> This can simplify system deployment process by downloading the whole system
> once, such as in IC verification.
>
> This patch adds support to upgrade ACPI tables from built-in initrd.

What do you mean by "upgrade"?

>
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
>  drivers/acpi/Kconfig   |  9 +++++++++
>  drivers/acpi/tables.c  | 12 ++++++++++--
>  include/linux/initrd.h |  3 +++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7cea769c37df..30976496fe77 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -357,6 +357,15 @@ config ACPI_TABLE_UPGRADE
>           initrd, therefore it's safe to say Y.
>           See Documentation/acpi/initrd_table_override.txt for details
>
> +config ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD
> +       bool "Upgrade ACPI tables from built-in initrd"
> +       depends on ACPI_TABLE_UPGRADE
> +       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
> +       def_bool n
> +       help
> +         This option provides functionality to upgrade arbitrary ACPI tables
> +         from built-in uncompressed initrd.
> +
>  config ACPI_DEBUG
>         bool "Debug Statements"
>         help
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 61203eebf3a1..88e3a34443da 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>
>  void __init acpi_table_upgrade(void)
>  {
> -       void *data = (void *)initrd_start;
> -       size_t size = initrd_end - initrd_start;
> +       void *data;
> +       size_t size;
>         int sig, no, table_nr = 0, total_offset = 0;
>         long offset = 0;
>         struct acpi_table_header *table;
>         char cpio_path[32] = "kernel/firmware/acpi/";
>         struct cpio_data file;
>
> +       if (IS_ENABLED(CONFIG_ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD)) {
> +               data = __initramfs_start;
> +               size = __initramfs_size;
> +       } else {
> +               data = (void *)initrd_start;
> +               size = initrd_end - initrd_start;
> +       }
> +
>         if (data == NULL || size == 0)
>                 return;
>
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 84b423044088..02d94aae54c7 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -22,3 +22,6 @@
>  extern void free_initrd_mem(unsigned long, unsigned long);
>
>  extern unsigned int real_root_dev;
> +
> +extern char __initramfs_start[];
> +extern unsigned long __initramfs_size;
> --
> 1.8.3.1
>
