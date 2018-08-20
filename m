Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A42174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gEdG2Mu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A42174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeHUBkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:40:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:40:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so6131391pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RJP9vgO1XwEL6l8WeQO2Quhsb5jIRvIzdh+fIFyWg/M=;
        b=gEdG2Mu0AZD8E+jQiARmrUegeveMo8bwYTXt8zcF2mn5vcwK9uB8FiKZNTmLhLR6KP
         HkQvhp62odrEVFvKywVcr/BeSIA7g5e9PV50nimxyfQsJkIOFKtcFrT6bqOPnJLUOMer
         EoGof9LkAUeLIUEyC4cO/nUMT2L3NOf3YV3c77L4fS+34MgwOvit2ad7MOwj7NPZDTyY
         KP36aDHJ6/NWUZ9Acu3l3v38UHrLAznz+mWCGJGwnkcB2F9usc1YzyvL+xF+2vJ3nSpQ
         uBFe03P3M3BFDJKZmcDOtFimVJ52CfqxMbwEITarxqHsNvICetAoGDwD738H778JaO0M
         XfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RJP9vgO1XwEL6l8WeQO2Quhsb5jIRvIzdh+fIFyWg/M=;
        b=cCkXnYqOOoA1oSeKP/7OcedSW8IFwjEkfHeiqJvGhb6zqZsvUcNikHWbHvmez2gdZJ
         Z1x3lRoGzgd1kgQN6FoO+A4kqaXZnwLB72iqjwH2297fHdfesC0qils/0djRYhiIdD5q
         580cols17uNgsL/aSq5m/Ktjc+icG43lFsoa77r+6MvdhxXQTlqTwRORIcbfqCQWwlUv
         zMAHufgvsvw1sBLMB04halgu8oYv9p8A6XuV97s8rS2TbYilpOmSGVE1FJt3jp7ICKtn
         k3KRjW6zT9qyp1fM8ztxz5mb8Zq5DzrqZHtzNatoEVjqVVtNIty40ZWJQOiWkDrKpeRK
         r1xQ==
X-Gm-Message-State: AOUpUlEb2QRvlsfEN+iAnxuyETnevmXykx6N5Xe0JUWoZhLtQhDFYs1D
        MNNjHQGztYaucIVPde6fOOQ8TnVSLe4=
X-Google-Smtp-Source: AA+uWPyYfDBLBy0m23KINzIt1tjPvR5vciYVIWyZ95eotYW/CF75UvHn0w7wZzMjnLBIxxI9Wf9D+Q==
X-Received: by 2002:a63:4104:: with SMTP id o4-v6mr12938991pga.146.1534803776969;
        Mon, 20 Aug 2018 15:22:56 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r18-v6sm13176015pgj.51.2018.08.20.15.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 15:22:55 -0700 (PDT)
Date:   Mon, 20 Aug 2018 15:22:55 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Aug 2018 15:11:24 PDT (-0700)
Subject:     Re: [PATCH v4 3/5] Cleanup ISA string setting
In-Reply-To: <1533698685-18022-4-git-send-email-alankao@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        albert@sifive.com, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, alankao@andestech.com,
        greentime@andestech.com, vincentc@andestech.com,
        zong@andestech.com, nickhu@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-e7585e65-b47f-48c2-97dd-5cc19396c0a7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 20:24:43 PDT (-0700), alankao@andestech.com wrote:
> Just a side note: (Assume that atomic and compressed is on)
>
> Before this patch, assembler was always given the riscv64imafdc
> MARCH string because there are fld/fsd's in entry.S; compiler was
> always given riscv64imac because kernel doesn't need floating point
> code generation.  After this, the MARCH string in AFLAGS and CFLAGS
> become the same.
>
> Signed-off-by: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Vincent Chen <vincentc@andestech.com>
> Cc: Zong Li <zong@andestech.com>
> Cc: Nick Hu <nickhu@andestech.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Makefile | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6d4a5f6c3f4f..e0fe6790624f 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -26,7 +26,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>
>  	KBUILD_CFLAGS += -mabi=lp64
>  	KBUILD_AFLAGS += -mabi=lp64
> -	KBUILD_MARCH = rv64im
>  	LDFLAGS += -melf64lriscv
>  else
>  	BITS := 32
> @@ -34,22 +33,20 @@ else
>
>  	KBUILD_CFLAGS += -mabi=ilp32
>  	KBUILD_AFLAGS += -mabi=ilp32
> -	KBUILD_MARCH = rv32im
>  	LDFLAGS += -melf32lriscv
>  endif
>
>  KBUILD_CFLAGS += -Wall
>
> -ifeq ($(CONFIG_RISCV_ISA_A),y)
> -	KBUILD_ARCH_A = a
> -endif
> -ifeq ($(CONFIG_RISCV_ISA_C),y)
> -	KBUILD_ARCH_C = c
> -endif
> -
> -KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> +# ISA string setting
> +riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
> +riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
> +riscv-march-$(CONFIG_RISCV_ISA_A)	:= $(riscv-march-y)a
> +riscv-march-y				:= $(riscv-march-y)fd
> +riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> +KBUILD_CFLAGS += -march=$(riscv-march-y)
> +KBUILD_AFLAGS += -march=$(riscv-march-y)
>
> -KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)

We used to have "fd" disabled in KBUILD_CFLAGS because we wanted to ensure that 
any use of floating-point types within the kernel would trigger the inclusion 
of soft-float libraries rather than emitting hardware floating-point 
instructions.  The worry here is that we'd end up corrupting the user's 
floating-point state with the kernel accesses because of the lazy save/restore 
stuff going on.

I remember at some point it was illegal to use floating-point within the 
kernel, but for some reason I thought that had changed.  I do see a handful of 
references to "float" and "double" in the kernel source, and most of references 
to kernel_fpu_begin() appear to be in SSE-specific stuff.  My one worry are the 
usages in drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c, as I can't quickly 
demonstrate they won't happen.

If we do this I think we should at least ensure kernel_fpu_{begin,end}() do the 
right thing for RISC-V.  I'd still feel safer telling the C compiler to 
disallow floating-point, though, as I'm a bit paranoid that GCC might go and 
emit a floating-point instruction even when it's not explicitly asked for.  I 
just asked Jim, who actually understands GCC, and he said that it'll spill to 
floating-point registers if the cost function determines it's cheaper than the 
stack.  While he thinks that's unlikely, I don't really want to rely a GCC cost 
function for the correctness of our kernel port.

I'd like to avoid having "-march=*fd*" in CFLAGS, unless someone can convince 
me it's safe and that I'm just being too paranoid :).

>  KBUILD_CFLAGS += -mno-save-restore
>  KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
