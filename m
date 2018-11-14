Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0545C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747DF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747DF2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeKOHPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:15:47 -0500
Received: from mail.binarylogic.ch ([88.198.23.72]:48608 "EHLO
        mail.binarylogic.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOHPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:15:47 -0500
Received: from [IPv6:2001:8e0:2002:7300:94d1:5a64:c83e:664b] (unknown [IPv6:2001:8e0:2002:7300:94d1:5a64:c83e:664b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.binarylogic.ch (Postfix) with ESMTPSA id 52079DF386;
        Wed, 14 Nov 2018 22:10:53 +0100 (CET)
Subject: Re: [RFC/RFT 2/2] RISC-V: kprobes/kretprobe support
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>, Zong Li <zong@andestech.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jim Wilson <jimw@sifive.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20181113195804.22825-1-me@packi.ch>
 <20181113195804.22825-3-me@packi.ch>
 <20181114003730.06f810517a270070734df4ce@kernel.org>
 <20181114074951.0902699286fdf8652f2878a4@kernel.org>
From:   Patrick Staehlin <me@packi.ch>
Openpgp: preference=signencrypt
Autocrypt: addr=me@packi.ch; prefer-encrypt=mutual; keydata=
 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
Message-ID: <05082ba4-33d6-a95c-e049-78791dafc009@packi.ch>
Date:   Wed, 14 Nov 2018 22:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114074951.0902699286fdf8652f2878a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.18 16:49, Masami Hiramatsu wrote:
> On Wed, 14 Nov 2018 00:37:30 -0800
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>>> +
>>> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>>> +{
>>> +	if (is_compressed_insn(opcode))
>>> +		*(u16 *)addr = cpu_to_le16(opcode);
>>> +	else
>>> +		*addr = cpu_to_le32(opcode);
>>> +
> 
> BTW, don't RISC-V need any i-cache flush and per-core serialization
> for patching the text area? (and no text_mutex protection?)

Yes, we should probably call flush_icache_all. This code works on
QEMU/virt but I guess on real hardware you may run into problems,
especially when disarming the kprobe. I'll have a look at the arm64 code
again to see what's missing.

> 
>>> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
>>> new file mode 100644
>>> index 000000000000..c7ceda9556a3
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
>>> @@ -0,0 +1,91 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>> +
>>> +#include <linux/linkage.h>
>>> +
>>> +#include <asm/asm.h>
>>> +#include <asm/asm-offsets.h>
>>> +
>>> +	.text
>>> +	.altmacro
>>> +
>>> +	.macro save_all_base_regs
>>> +	REG_S x1,  PT_RA(sp)
>>> +	REG_S x3,  PT_GP(sp)
>>> +	REG_S x4,  PT_TP(sp)
>>> +	REG_S x5,  PT_T0(sp)
>>> +	REG_S x6,  PT_T1(sp)
>>> +	REG_S x7,  PT_T2(sp)
>>> +	REG_S x8,  PT_S0(sp)
>>> +	REG_S x9,  PT_S1(sp)
>>> +	REG_S x10, PT_A0(sp)
>>> +	REG_S x11, PT_A1(sp)
>>> +	REG_S x12, PT_A2(sp)
>>> +	REG_S x13, PT_A3(sp)
>>> +	REG_S x14, PT_A4(sp)
>>> +	REG_S x15, PT_A5(sp)
>>> +	REG_S x16, PT_A6(sp)
>>> +	REG_S x17, PT_A7(sp)
>>> +	REG_S x18, PT_S2(sp)
>>> +	REG_S x19, PT_S3(sp)
>>> +	REG_S x20, PT_S4(sp)
>>> +	REG_S x21, PT_S5(sp)
>>> +	REG_S x22, PT_S6(sp)
>>> +	REG_S x23, PT_S7(sp)
>>> +	REG_S x24, PT_S8(sp)
>>> +	REG_S x25, PT_S9(sp)
>>> +	REG_S x26, PT_S10(sp)
>>> +	REG_S x27, PT_S11(sp)
>>> +	REG_S x28, PT_T3(sp)
>>> +	REG_S x29, PT_T4(sp)
>>> +	REG_S x30, PT_T5(sp)
>>> +	REG_S x31, PT_T6(sp)
>>> +	.endm
>>> +
>>> +	.macro restore_all_base_regs
>>> +	REG_L x3,  PT_GP(sp)
>>> +	REG_L x4,  PT_TP(sp)
>>> +	REG_L x5,  PT_T0(sp)
>>> +	REG_L x6,  PT_T1(sp)
>>> +	REG_L x7,  PT_T2(sp)
>>> +	REG_L x8,  PT_S0(sp)
>>> +	REG_L x9,  PT_S1(sp)
>>> +	REG_L x10, PT_A0(sp)
>>> +	REG_L x11, PT_A1(sp)
>>> +	REG_L x12, PT_A2(sp)
>>> +	REG_L x13, PT_A3(sp)
>>> +	REG_L x14, PT_A4(sp)
>>> +	REG_L x15, PT_A5(sp)
>>> +	REG_L x16, PT_A6(sp)
>>> +	REG_L x17, PT_A7(sp)
>>> +	REG_L x18, PT_S2(sp)
>>> +	REG_L x19, PT_S3(sp)
>>> +	REG_L x20, PT_S4(sp)
>>> +	REG_L x21, PT_S5(sp)
>>> +	REG_L x22, PT_S6(sp)
>>> +	REG_L x23, PT_S7(sp)
>>> +	REG_L x24, PT_S8(sp)
>>> +	REG_L x25, PT_S9(sp)
>>> +	REG_L x26, PT_S10(sp)
>>> +	REG_L x27, PT_S11(sp)
>>> +	REG_L x28, PT_T3(sp)
>>> +	REG_L x29, PT_T4(sp)
>>> +	REG_L x30, PT_T5(sp)
>>> +	REG_L x31, PT_T6(sp)
>>> +	.endm
> 
> 
> It seems thses macros can be (partially?) shared with entry.S

Yes, I wanted to avoid somebody changing the shared code and breaking
random things. But that's what reviews are for. I'll think of something
for v2.
