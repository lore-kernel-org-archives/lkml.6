Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16B8217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="luHlY+jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16B8217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHUW5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:57:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45364 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeHUW5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:57:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so8966637pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mob0I7+4tcXZeuZKanoO4Y4JUKkyljXOkEsLC7xlt2c=;
        b=luHlY+jJ4u9kY4UEd+G5DPCkwPZeUT1l90qvMDKc5IN3lqLZHtTjlA+vYoRY+EwDWU
         jt1pSwNQogsRm8ZaQXPxhKFJ69fOZp+wCbSFmNNyfP0j8tfqnbmuvNKSKC8Sdk8FDe2Q
         DhEUcFtnowI9gpQbGs+E6OvE2lIp4KKpdlFnqxTTWcvVsAw7Q+ct17qLXaEF0WsFITDF
         U3SUw9G33HlVfh44wjN9Hb1pLKQ3eZ5YSVKvBHD4AXhegZJnNJ6gFGWW7nbxFxli0lKj
         /mJFj8WtJwO77ttkI16LuRSMDISsmUCVbQuZjBNO26uTDVtbdhKiwi8zF/jnMb5YaEUK
         IEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mob0I7+4tcXZeuZKanoO4Y4JUKkyljXOkEsLC7xlt2c=;
        b=hircU5EMoBlO5Eyo79fY61IsG6Igt4bdA+OVGUCm32hDIpfnomA4DR211GeCwVAHqP
         /yqXacf1EZ3lbiOqDgk0tQeSUyTk7EuKWylH4NzOl6gCtINwf78ejWeqMOCgAROEOZwM
         QuFjb+fcsjxkT23/2su4l/wBhIRtgM7uRUbpArID/E4b8EEnD4btz9c/T/mJxvqhg/QL
         B39JNZ/n4ZkDWZf/eniv7qUVsR+djNtfFt40mHzEjBbiqRbiYUwP6Lj0fLOF6QpMaSic
         OUqf8QNhBxrjq/ms5v1OPvMt6Qj/YUo8ecl/s9xLUT/YGBq0RyYoO27BMTBELA3CcH2a
         xRzA==
X-Gm-Message-State: APzg51Dm+Oc0Fk4EAWRYDPgeq9G2de8w8el1NI+NB0se1cBIaOJ3fHYg
        MAKQHupicyrKcPKRLEeOIHIL1JHqF7k=
X-Google-Smtp-Source: ANB0VdbBWVKZfZSGdae9fRuNim8AhbA8Tjqgbjx2cVGzYV0LuNQmYX3//WhyaEvhz7P/cxygCZx2BQ==
X-Received: by 2002:a63:8c5:: with SMTP id 188-v6mr1117506pgi.75.1534880183960;
        Tue, 21 Aug 2018 12:36:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 1-v6sm27547280pfk.134.2018.08.21.12.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:36:22 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:36:22 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 12:19:08 PDT (-0700)
Subject:     Re: [PATCH v4 3/5] Cleanup ISA string setting
In-Reply-To: <20180821024728.GA6169@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        albert@sifive.com, Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        vincentc@andestech.com, zong@andestech.com, nickhu@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-5c233af9-5002-4e9a-9566-f9128b296ee7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 19:47:28 PDT (-0700), alankao@andestech.com wrote:
> On Mon, Aug 20, 2018 at 03:22:55PM -0700, Palmer Dabbelt wrote:
>> On Tue, 07 Aug 2018 20:24:43 PDT (-0700), alankao@andestech.com wrote:
>> >Just a side note: (Assume that atomic and compressed is on)
>> >
>> >Before this patch, assembler was always given the riscv64imafdc
>> >MARCH string because there are fld/fsd's in entry.S; compiler was
>> >always given riscv64imac because kernel doesn't need floating point
>> >code generation.  After this, the MARCH string in AFLAGS and CFLAGS
>> >become the same.
>> >
>> >Signed-off-by: Alan Kao <alankao@andestech.com>
>> >Cc: Greentime Hu <greentime@andestech.com>
>> >Cc: Vincent Chen <vincentc@andestech.com>
>> >Cc: Zong Li <zong@andestech.com>
>> >Cc: Nick Hu <nickhu@andestech.com>
>> >Reviewed-by: Christoph Hellwig <hch@lst.de>
>> >---
>> > arch/riscv/Makefile | 19 ++++++++-----------
>> > 1 file changed, 8 insertions(+), 11 deletions(-)
>> >
>> >diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> >index 6d4a5f6c3f4f..e0fe6790624f 100644
>> >--- a/arch/riscv/Makefile
>> >+++ b/arch/riscv/Makefile
>> >@@ -26,7 +26,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>> >
>> > 	KBUILD_CFLAGS += -mabi=lp64
>> > 	KBUILD_AFLAGS += -mabi=lp64
>> >-	KBUILD_MARCH = rv64im
>> > 	LDFLAGS += -melf64lriscv
>> > else
>> > 	BITS := 32
>> >@@ -34,22 +33,20 @@ else
>> >
>> > 	KBUILD_CFLAGS += -mabi=ilp32
>> > 	KBUILD_AFLAGS += -mabi=ilp32
>> >-	KBUILD_MARCH = rv32im
>> > 	LDFLAGS += -melf32lriscv
>> > endif
>> >
>> > KBUILD_CFLAGS += -Wall
>> >
>> >-ifeq ($(CONFIG_RISCV_ISA_A),y)
>> >-	KBUILD_ARCH_A = a
>> >-endif
>> >-ifeq ($(CONFIG_RISCV_ISA_C),y)
>> >-	KBUILD_ARCH_C = c
>> >-endif
>> >-
>> >-KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
>> >+# ISA string setting
>> >+riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
>> >+riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
>> >+riscv-march-$(CONFIG_RISCV_ISA_A)	:= $(riscv-march-y)a
>> >+riscv-march-y				:= $(riscv-march-y)fd
>> >+riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
>> >+KBUILD_CFLAGS += -march=$(riscv-march-y)
>> >+KBUILD_AFLAGS += -march=$(riscv-march-y)
>> >
>> >-KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
>>
>> We used to have "fd" disabled in KBUILD_CFLAGS because we wanted to ensure
>> that any use of floating-point types within the kernel would trigger the
>> inclusion of soft-float libraries rather than emitting hardware
>> floating-point instructions.  The worry here is that we'd end up corrupting
>> the user's floating-point state with the kernel accesses because of the lazy
>> save/restore stuff going on.
>
> Thanks for pointing that out.
>
> Just as you said, the use of KBUILD_CFLAGS=*fd* is based on the assumption that
> not a single floating-point instruction involves in the kernel, and that might
> be wrong.
>
>> I remember at some point it was illegal to use floating-point within the
>> kernel, but for some reason I thought that had changed.  I do see a handful
>> of references to "float" and "double" in the kernel source, and most of
>> references to kernel_fpu_begin() appear to be in SSE-specific stuff.  My one
>> worry are the usages in drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c, as
>> I can't quickly demonstrate they won't happen.
>
> Empirically, this CFLAGS with *fd* did not cause any trouble to me, but of
> course this is not a good statement to support this patch.
>
> Meanwhile, I find a flaw in "[PATCH 4/5] Allow to Disable FPU Support."
> The purpose of this "[PATCH 3/5] Cleanup ISA String" was to make CONFIG_FPU
> a switch for the appearance of "fd" in both KBUILD_CFLAGS and KBUILD_ASFLAGS,
> but somehow the modification was forgotten.
>
>>
>> If we do this I think we should at least ensure kernel_fpu_{begin,end}() do
>> the right thing for RISC-V.  I'd still feel safer telling the C compiler to
>> disallow floating-point, though, as I'm a bit paranoid that GCC might go and
>> emit a floating-point instruction even when it's not explicitly asked for.
>> I just asked Jim, who actually understands GCC, and he said that it'll spill
>> to floating-point registers if the cost function determines it's cheaper
>> than the stack.  While he thinks that's unlikely, I don't really want to
>> rely a GCC cost function for the correctness of our kernel port.
>
> The purpose of this whole patchset was to remove all floating-point-related
> logic in kernel space (while remainging FPU systems work as usual), so
> implementing the two APIs would be out of scope here.
>
> I suggest that, some people have to provide these APIs if they do need hardware
> floating-point calculation in kernel space (kernel or module) in the future.
> It seems that we don't need those for the kernel and any already supported
> hardware drivers at least for now.  Please correct me if my understanding is
> out-of-date.
>
>>
>> I'd like to avoid having "-march=*fd*" in CFLAGS, unless someone can
>> convince me it's safe and that I'm just being too paranoid :).
>
> I will send a new version of the patchset, which will make sure that CFLAGS has
> no *fd* (3/5) and the CONFIG_FPU did remove *fd* from ASFLAGS (4/5).

Thanks!

>
>>
>> > KBUILD_CFLAGS += -mno-save-restore
>> > KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
>
> Thanks!
>
> Alan
