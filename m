Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8830E206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg15zSGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfAGMws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:52:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46919 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfAGMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:46 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so155315ios.13;
        Mon, 07 Jan 2019 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNar2NXSMOtA0jny5iNFJcSIAx7aAU2c2ousLArqkxs=;
        b=Kg15zSGMBQdT7dJDS444ChW7LdtKP/GX2au++g+KgHbOudWTDgh4JbpVXcpITktePv
         n647dGkcuAJ5RYHbhYb2Qgnjx+Gw4W0H0Q90jpzbe5t9w5YW7auhPSiUx9+tuKSlYB5k
         ABdZqKw4fkINHJGZfNhd+/doDqNY9OoS8/ljWWh9/eswfGcTlLkovZjk5eekbathfGrt
         5rzYLAjMSx9w90bLPqSvry3nrnXi4GeaH04DwZczoMvmxDmhz1QdIv41PrqKK6fok/Qf
         8MIrXpVnLhFjX54R2wqth54yiVjQm7n4Chev1p1JCcrx+c5gsvgevTSHHA8D3bEWxRNJ
         qtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNar2NXSMOtA0jny5iNFJcSIAx7aAU2c2ousLArqkxs=;
        b=FY54ZzAzpgYxHvHfR7Y2Cv9OpKboSI7rTV681m6qRkgnrVhy5r1xM37I3+2zyATZZz
         4hF+qlFjNNLFDeIpDNBS45llAsxkMj7vD2MVLIIv+uKHWIbGx2grs69zoOyRHcMLGY9o
         x4XQNABEbBcIosAJHz7VWy22Kg5NUcyKPH0ggo7ei8oAERTpb/VAyYiupgxqTi6gNd6Z
         5Jls2c8EVYy2JoQtK46yCi7iE3OsMdDV/fXFo6QiJnMTZ+NyoeTSetPUxumtL3CSQgQy
         aAo94AqgOY+bbut+lZI0yy1kyVEVhpjECvCQGOr6f7jSQYmL9qmg6oAVlIBbAiQaZItn
         uTIQ==
X-Gm-Message-State: AJcUukeToHyhBAEblZ1ZeMZmO/QOQcADQX7Rv+HdeqIiROax8P+WOmjL
        m9xIJe1FwsjSnwl1q1OwtbDis1ZvYQLeTTo4UQ==
X-Google-Smtp-Source: ALg8bN6LVsOaoftvTwmNLswwUFmpo4iBGNmqXtlHY/DuNpeACqYtu1DYFJYuHumOCyN4mtMZJefC3/4O7sSoS2Mom/8=
X-Received: by 2002:a6b:3f06:: with SMTP id m6mr39900944ioa.117.1546865565110;
 Mon, 07 Jan 2019 04:52:45 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <1546849485-27933-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1546849485-27933-3-git-send-email-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 7 Jan 2019 20:52:34 +0800
Message-ID: <CAFgQCTtzKukUpeRy-q91gdCKOtpHY3jjNzdFChx0Fj-9PHBM4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
To:     x86@kernel.org, linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:25 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> At present, memblock bottom-up allocation can help us against stamping over
> movable node in very high probability. But if the hotplug info has already
> been parsed, the memblock allocator can step around the movable node by
> itself. This patch pushes the parsing step forward, just ahead of where,
> the memblock allocator can work. Later in this series, the bottom-up
> allocation style can be removed on x86_64.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/setup.c | 15 +++++++++++++++
>  include/linux/acpi.h    |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index acbcd62..df4132c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -805,6 +805,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
>         return 0;
>  }
>
> +/* only need the effect of acpi_numa_memory_affinity_init()
> + * ->memblock_mark_hotplug()
> + */
> +static int early_detect_acpi_memhotplug(void)
> +{
> +#ifdef CONFIG_ACPI_NUMA
> +       acpi_table_upgrade(__va(get_ramdisk_image()), get_ramdisk_size());
> +       acpi_table_init();
> +       acpi_numa_init();

As this is RFC version, I do not suppress this extra printk info yet.
Should do it next version.
> +       acpi_tb_terminate();
> +#endif
> +       return 0;
> +}
> +
>  /*
>   * Determine if we were loaded by an EFI loader.  If so, then we have also been
>   * passed the efi memmap, systab, etc., so we should use these data structures
> @@ -1131,6 +1145,7 @@ void __init setup_arch(char **cmdline_p)
>         trim_platform_memory_ranges();
>         trim_low_memory_range();
>
> +       early_detect_acpi_memhotplug();
>         init_mem_mapping();
>
>         idt_setup_early_pf();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 44dcbba..1b69044 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -235,6 +235,7 @@ int acpi_mps_check (void);
>  int acpi_numa_init (void);
>
>  int acpi_table_init (void);
> +void acpi_tb_terminate(void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>                               int entry_id,
> --
> 2.7.4
>
