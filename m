Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2547220875
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSC4hz3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933385AbeGJMzp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:55:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46331 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeGJMzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:55:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so5613471ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sl+ObmyF7XbCSJALKJrs6+Ah9BXbBG4qv+8OqXyHfnI=;
        b=RSC4hz3NU2RNZxHM1hQ7jmboHcMmA2kQOFzbqTIYSRCmmTYjj8M/EgvI2LkwSdcYp/
         Rnin3Uq25poOCVU6V0HFuoAtCdGLXLOMLyyBC661tys0qF87hglS108xambzTv/b9cji
         vMKGz3ph8I1dx4uxrFtfni0IO8NYSCEnZasSYOHT/VvBOtxTuMtwDuwa61IK2nP2bLQ7
         Ne/b4TfF/6sgQsTXZr2s94xwTvrnz8DzPIGJlqx0DdKxlecyyfhFMywERTRxIYOnAgyz
         SRMozjwi8DLnXmIUoRU/lrTnf9goTMLRIZJVtP6pNOFJvf8BioMi7Xtt0zUl0Oz1BKfN
         zTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sl+ObmyF7XbCSJALKJrs6+Ah9BXbBG4qv+8OqXyHfnI=;
        b=srGYLvRFW+XtMYvHi6EY7pK4/LW7LZB7e0uFPHajjhMo6XFL1DBV0hzGVNVu6rX8xY
         kYnVNYfoiaMd0qhLCKG1HMRLZw74SCt8vSZJ/CZbgusbHgcUXe2KH5QTYdaBL8CqbeBe
         OrRgnF78g6G+Bv4Eg22OmoB0yxcfmv81TM/yfU0Ro9IXbG2EfznW1ExsysPRB6mTE8cq
         TM7jhmhHUdfanitHXlCjKULwEfeUWVRkzRMKGgKHbEcKUyOk3aEbmPIhs9wKZbojDlDD
         MNJ9XkabdMtclivhVAiTF35LbqKAcqGjcSHRTX2gWm6rhI/1TNQLutgr4BPf3n+iE+VY
         BNhA==
X-Gm-Message-State: APt69E0jXDQ9Ojyx9XUyNSYmO+05TKvOYFFjCYD8U7dZ4ROC65pd4e4+
        cXWO+ME9Stnp0BokDVbkgRf+iOU8mj8IRWSiX0g=
X-Google-Smtp-Source: AAOMgpdoZxqeDYxvqtxNBLFny9Lbhe2G+o+COsZCAFkcHISs3eUtM04LEPYX7wbqmvtfWlLfLL5mvhSQzODziAOIJW0=
X-Received: by 2002:a2e:83cf:: with SMTP id s15-v6mr12806554ljh.101.1531227342464;
 Tue, 10 Jul 2018 05:55:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 05:55:41
 -0700 (PDT)
In-Reply-To: <20180706174724.44594-1-nkela@cisco.com>
References: <20180706174724.44594-1-nkela@cisco.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 14:55:41 +0200
X-Google-Sender-Auth: gKsWQnKXm826pvfJOsOWM1MgynY
Message-ID: <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: add ARM64-specific support for flatmem
To:     Nikunj Kela <nkela@cisco.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        xe-kernel@external.cisco.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:47 PM, Nikunj Kela <nkela@cisco.com> wrote:
> Flatmem is useful in reducing kernel memory usage.
> One usecase is in kdump kernel. We are able to save
> ~14M by moving to flatmem scheme.
>
> Cc: xe-kernel@external.cisco.com
> Cc: Nikunj Kela <nkela@cisco.com>
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..f5b4c49 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>         def_bool ARCH_SPARSEMEM_ENABLE
>
> +config ARCH_FLATMEM_ENABLE
> +       def_bool y
> +
>  config HAVE_ARCH_PFN_VALID
>         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>

I'm getting hundreds of errors in randconfig builds with this:


+ /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld
-EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic
--no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T
./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a
--no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a
--end-group
init/do_mounts.o: In function `mount_block_root':
do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
init/do_mounts.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
`mem_map' which may bind externally can not be used when making a
shared object; recompile with -fPIC
do_mounts.c:(.init.text+0x1e8): dangerous relocation: unsupported relocation
do_mounts.c:(.init.text+0x1f4): undefined reference to `mem_map'
arch/arm64/kernel/vdso.o: In function `vdso_init':
vdso.c:(.init.text+0xb4): undefined reference to `mem_map'
/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21
against symbol `mem_map' which may bind externally can not be used
when making a shared object; recompile with -fPIC
vdso.c:(.init.text+0xb4): dangerous relocation: unsupported relocation
vdso.c:(.init.text+0xbc): undefined reference to `mem_map'
vdso.c:(.init.text+0xec): undefined reference to `mem_map'
arch/arm64/kernel/insn.o:insn.c:(.text+0x2ec): more undefined
references to `mem_map' follow
/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
arch/arm64/kernel/insn.o: relocation R_AARCH64_ADR_PREL_PG_HI21
against symbol `mem_map' which may bind externally can not be used
when making a shared object; recompile with -fPIC

The problem seems to be that CONFIG_NUMA is enabled in my
build, so mem_map[] is not defined anywhere.

     Arnd
