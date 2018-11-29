Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E9BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FDE20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9R0U0Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FDE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeK3Ei6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:38:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33243 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3Ei5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:38:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so1555933qko.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUeBlSazp8q7PH7NS5jeXi8v+2rFYAsXlS74SjDLeWI=;
        b=C9R0U0Q2IneniGIGY/LSCG1iMl7VpPDd+SAGjqz8CqhJMmgSXgd2lYgfnSFdB6p6V8
         noeolGwhl19qefSLPh0LhbFYUqmWT9KqoWWr7f0ywgvLjtBtZfK50DvJqw9p+zfcpjyc
         tcd2RWPTpAE9I/F1axwHLGOln2nUDWST/oQbv8qatlKFYRQqtchf2nU5KizmFnN5CHW0
         u2I0HBmFyQOZE3qXe7uZYnb+guP5rEeqx60tCg992zTf8C+eSIylq+uFMo8KA4KFF5EK
         qS4dduFHQuNI3rxzuQ5b28wzu6jfIzNTrTvTadsasE0cYo3VLxC1Cf3IK++M7uO++Gme
         wdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUeBlSazp8q7PH7NS5jeXi8v+2rFYAsXlS74SjDLeWI=;
        b=Mdvb2EM3rT3nV2XuSv/GkKy/jDJrLT5Y+Sb9GZmWHg8x8fmrjCNcE3BURfaXJ7SOVo
         aFDCW+hMTtkTHVAyuKuniXEnsLzaWADeGLcBVm/pCbPZmmPPtvQCfcY3wh9kIBktO8oI
         v3KedG8/JjwURsv7s5FYhqeGT8T4IGlu81JD5Y9osCsFHGri1CEwy3nPgP4BrQgGldSm
         L2Glr/NhbQ9R7kB39nCE97wFm7RA+rq8PFpKpaLdC7TgameBEI4V9GjPXMOgDfK24/Zg
         TuT5nuc60YsUYT5nyfiffqcEYy20vQxE9XVYa9EwmAFkqfa6URqgBYxYDlGwphkqjPuU
         CcBw==
X-Gm-Message-State: AA+aEWZAgEOBm+juuD2NanJ8CQEVA8UQ1U4E02I49hRGg0hEMMgcRbU6
        z0rJnLRZLK/SmF9cyA2KZA==
X-Google-Smtp-Source: AFSGD/Wel2wFQhhR5RcQ6gat25n6IUDPFGg62Ux4asNDLHtBiEMtdEnfUqeKzeZho6opn4y4nBImnw==
X-Received: by 2002:a37:c891:: with SMTP id t17mr2110182qkl.31.1543512769409;
        Thu, 29 Nov 2018 09:32:49 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q15sm1356721qkl.81.2018.11.29.09.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:32:49 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:32:46 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 0/5] x86/boot/KASLR: Parse ACPI table and limit KASLR
 to choosing immovable memory
Message-ID: <20181129173245.etpt52om2b5qpdeq@gabell>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Thank you for your continued working.

Could you please build your patches before sending?
Your patches depend on the following kconfig,
so please build them under the config combination.

RANDOMIZE_BASE
MEMORY_HOTREMOVE
EARLY_PARSE_RSDP
KEXEC
EFI

Thanks,
Masa

On Thu, Nov 29, 2018 at 04:16:26PM +0800, Chao Fan wrote:
> ***Background:
> People reported that KASLR may randomly choose some positions
> which are located in movable memory regions. This will break memory
> hotplug feature and make the movable memory chosen by KASLR can't be
> removed.
> 
> ***Solutions:
> Get the information of memory hot-remove, then KASLR will know the
> right regions. Information about memory hot-remove is in ACPI
> tables, which will be parsed after start_kernel(), so that KASLR
> can't get the information.
> 
> Somebody suggest to add a kernel parameter to specify the
> immovable memory so that limit KASLR in these regions. Then I make
> a patchset. After several versions, Ingo gave a suggestion:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
> Follow Ingo's suggestion, imitate the ACPI code to parse the ACPI
> tables, so that the kaslr can get necessary memory information in
> ACPI tables.
> I think ACPI code is an independent part, so imitate the codes
> and functions to 'compressed/' directory, so that kaslr won't
> influence the initialization of ACPI.
> 
> PATCH 1/5 Add get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
> PATCH 2/5 Add efi_get_rsdp_addr() to find RSDP from EFI table when
>           booting from EFI.
> PATCH 3/5 Add bios_get_rsdp_addr() to search RSDP in memory when EFI
>           table not found.
> PATCH 4/5 Compute SRAT table from RSDP and walk SRAT table to store
>           the immovable memory regions.
> PATCH 5/5 Calculate the intersection between memory regions from e820/efi
>           memory table and immovable memory regions. Limit KASLR to
>           choosing these regions for randomization.
> 
> v1->v2:
>  -  Simplify some code.
> Follow Baoquan He's suggestion:
>  - Reuse the head file of acpi code.
> 
> v2->v3:
>  - Test in more conditions, so remove the 'RFC' tag.
>  - Change some comments.
> 
> v3->v4:
> Follow Thomas Gleixner's suggetsion:
>  - Put the whole efi related function into #define CONFIG_EFI and return
>    false in the other stub.
> 
> v4->v5:
> Follow Dou Liyang's suggestion:
>  - Add more comments about some functions based on kernel code.
>  - Change some typo in comments.
>  - Clean useless variable.
>  - Add check for the boundary of array.
>  - Add check for 'movable_node' parameter
> 
> v5->v6:
> Follow Baoquan He's suggestion:
>  - Change some log.
>  - Add the check for acpi_rsdp
>  - Change some code logical to make code clear
> 
> v6->v7:
> Follow Rafael's suggestion:
>  - Add more comments and patch log.
> Follow test robot's suggestion:
>  - Add "static" tag for function
> 
> v7-v8:
> Follow Kees Cook's suggestion:
>  - Use mem_overlaps() to check memory region.
>  - Use #ifdef in the definition of function.
> 
> v8-v9:
> Follow Boris' suggestion:
>  - Change code style.
>  - Splite PATCH 1/3 to more path.
>  - Introduce some new function
>  - Use existing function to rework some code
> Follow Masayoshi's suggetion:
>  - Make code more readable
> 
> v9->v10:
> Follow Baoquan's suggestion:
>  - Change some log
>  - Merge last two patch together.
> 
> v10->v11:
> Follow Boris' suggestion:
>  - Link kstrtoull() instead of copying it.
>  - Drop the useless wrapped function.
> 
> v11->v12:
> Follow Boris' suggestion:
>  - Change patch log and code comments.
>  - Add 'CONFIG_EARLY_PARSE_RSDP' to make code easy to read
>  - Put strtoull() to misc.c
> Follow Masa's suggestion:
>  - Remove the detection for 'movable_node'
>  - Change the code logical about cmdline_find_option()
> 
> Any comments will be welcome.
> 
> 
> Chao Fan (5):
>   x86/boot: Add get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
>   x86/boot: Add efi_get_rsdp_addr() to find RSDP from EFI table
>   x86/boot: Add bios_get_rsdp_addr() to search RSDP in memory
>   x86/boot: Parse SRAT table from RSDP and store immovable memory
>   x86/boot/KASLR: Limit KASLR to extracting kernel in immovable memory
> 
>  arch/x86/Kconfig                  |  10 +
>  arch/x86/boot/compressed/Makefile |   2 +
>  arch/x86/boot/compressed/acpitb.c | 322 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c  |  79 ++++++--
>  arch/x86/boot/compressed/misc.c   |   5 +
>  arch/x86/boot/compressed/misc.h   |  24 +++
>  lib/kstrtox.c                     |   5 +
>  7 files changed, 432 insertions(+), 15 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/acpitb.c
> 
> -- 
> 2.19.1
> 
> 
> 
