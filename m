Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8577C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8503C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068516;
	bh=9bgdd06jclrn5HMIoq9X1Omn+9qG4+HLZ/rpcyny2LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AaHWlMITzSRPCPpozqnylkCKyiOYks6YkxtVLSCj5Jtl6GLbZdhTalxa8LwfZrULk
	 WxjfwRMjX10usXJcOHeEGwTWQAbRTx1t6dbULVs6gogOFPbWfJTHsK7qf/0oAiewTc
	 URgUy4lsNwtc6Dz4mAPm09Qog2SVKa4onBde3f9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeLQRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:41:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33041 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLQRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:41:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so5274120wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUtlUa7KEK5mVLEjR7vxpI30DgHQ+D9dG4DxVa1XAQ0=;
        b=o5tox0Z2Lme4wNm3ewC+uTeXaXu/Jt4NAfEirshYbG5YbLnD3kfdc6eyxLgI/8tEOq
         cHgoXfHA+i1TUWr2W/tJJDI9+Qs98oJ3M5+Qk5w1G5QSCUZYSDiH76GCCf/lkJqk7oLJ
         GM5OmD5ORxEYJypaH1kSRk2JTBVmQqnPc7GjX7ReYdiqbvYwAzpcbJqqXouCRnPUbpGi
         vZnOxSkOr0fz7NZXAH1uA/34zr5vxuaAAHGEd7ISjbZ4FKNQWwLAvUCHfhp4ABskNJm3
         okrBydtOTtO7hbLFdYfR2BVvbgl8aeZRkoxpYeMuzuHrFZhClsLMKMsrqeHWB8J/NItx
         pplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUtlUa7KEK5mVLEjR7vxpI30DgHQ+D9dG4DxVa1XAQ0=;
        b=PokD/XaVjCdYlOv5FGtOTKuPt6tENLtGSfDvWDPonFxg9qyUOUNXhouS+dQKQDcXX5
         TmheX6Bu0621dZugCZ90/Yv8wFjLsUDL+xCvPETQx4HgPO6qIc3ATm+qiK9wDMdwutvR
         Wp9g22qJLmpyQAfd3cGn8IL1T3xieTvhrJTanFHnwuHv0wYt1kyS13Y1koMxdNfgKN9j
         KiMYtwzoGx4OsF3K9IL4fctSArB6BOz7oZp6wdSHxzBpruS5my1Cso7Q4kESJFuo570V
         nFPZ8QIdIzyF1LDMVfGlMw1jErOhy1eqa0qY3wmuUDkgwFMgzHY6XtWo2Hqgrds4m0rr
         7ufg==
X-Gm-Message-State: AA+aEWYyt7sXFQ5jCY0ifU1hpCfibP/B0VaUSW0iEdB8MctnhVZ6t1hI
        qoAa7pvKY/SE2bvzEuPZI9Q=
X-Google-Smtp-Source: AFSGD/XYJNCAmx/9qW+co+jHMfoyR1mEC5+kV2g0Z2EqJ7oW4W43MAxVyXVsDZ1huC+bZxTQ+0BCfw==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr49800wmd.63.1545068512789;
        Mon, 17 Dec 2018 09:41:52 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o17sm20873617wmg.35.2018.12.17.09.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:41:52 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:41:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 4/5] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20181217174149.GD90818@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-5-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214093013.13370-5-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> SRAT should be parsed by RSDP to fix the conflict between KASLR
> and memory-hotremove, then find the immovable memory regions and store
> them in an array called immovable_mem[]. With immovable_mem[], KASLR
> can avoid to extract kernel to specific regions.
> 
> Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
> 'CONFIG_EARLY_PARSE_RSDP' to make ifdeffery clear.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/Kconfig                  |  12 +++
>  arch/x86/boot/compressed/Makefile |   2 +
>  arch/x86/boot/compressed/acpi.c   | 128 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c  |   4 -
>  arch/x86/boot/compressed/misc.h   |  19 +++++
>  5 files changed, 161 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ba7e3464ee92..333c383478b7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2149,6 +2149,18 @@ config X86_NEED_RELOCS
>  	def_bool y
>  	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
>  
> +config EARLY_SRAT_PARSE
> +	bool "Early SRAT table parsing"
> +	def_bool y
> +	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
> +	help
> +	  This option enables early SRAT parsing in compressed boot stage
> +	  so that memory hot-remove ranges do not overlap with KASLR
> +	  chosen ranges. Kernel won't be extracted in hot-removable
> +	  memory, so that make sure memory-hotremove works well with
> +	  KASLR enabled.
> +	  Say Y if you want to use both KASLR and memory-hotremove.

So why would we want to make this a config option, instead of enabling it 
unconditionally?

How reliable are the hot-removable memory markings in various firmware 
versions?

> +/* Compute SRAT table from RSDP. */
> +static struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +	acpi_physical_address acpi_table;
> +	acpi_physical_address root_table;
> +	struct acpi_table_header *header;
> +	struct acpi_table_rsdp *rsdp;
> +	u32 num_entries;
> +	char arg[10];

The '10' is just a magic number attached to a meaningless local variable 
name. Please explain the limit in the code, and the role of the variable 
if it's non-obvious from the name. Or better, try to find a more obvious 
name?

Thanks,

	Ingo
