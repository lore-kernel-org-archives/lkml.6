Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519396719; cv=none;
        d=google.com; s=arc-20160816;
        b=rf1aTmRnmzB38Eb5cxlMnfjeNd9IhXut2eAUVUk4YgxhpMH7rN/7ifDUjLvLiQmg6k
         +Lp7+juFw7zzQaainC4NJ0yU5uiiWt4BI5+LB/UauwiBLAaDDvSHiSOkAtEerb1x5bK0
         CM/OUh36LE9WK77ExJiZZHVCWjvm5I/wrOchcu1EtkjNjRjINCacqYdPggxDsi4xJUjW
         qqURRkwcJl8E5ACwm/NnUnLDTDJQOLCVH6B8S1uiQ06cHuZXwK01BnDnTmFHq4kUvLpI
         bklMS1oJeH/SAuQcUscnK80GpWL/xWuR30Vyf6GhqbdZaOx/ThtSmnV/2eMdmlG3uR6i
         83uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=FrG9RNPqrva3d17xeAe07v+mO3GoUjTh0f7SopVd93Q=;
        b=bdlmhAUSHj9pga5DWaYNPJUdhVBFdNFGK07hgemIGHayzRI2fYOHdhMSb9G2WxiLVm
         clblN5PdFajFqUlRoLHF9q6dbxjV2ESRTLv9ytP+xNi1rRhS8CDYU2FrZyQq/xbgL6pv
         5dDs9jUPZXm+I3CP5lBO3/B9lazWdH4VJ4ymjgrYuhcQ668Se1a5cViomqKG7VrKWAg7
         1wM+sOaf8SYdz/Nizse0q3ThnpRft7TVMkc87nbr78LNOUY1vptBis7JzJ9CYSWJuS+1
         OgohKXcJC3Oi+AP1qFz3RX0YCJ4yg1kowDIZ5yzRRPqPBsIg+3910VrBOzO6Bx9KFhLo
         zT8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YhdosNHy;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YhdosNHy;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuHDvi3AZ7u/f9kRm0tIqLo9V+cLgxp/si5qMIDLU8ebSQyvxQ+rgU0oKuUcLOYd4U3QtHHyVO5jdA2kRjkzxQ=
MIME-Version: 1.0
In-Reply-To: <CAP71WjzZqcxr-zHFfFUP0jAPfmJm7NM1MpS6tfPkMmj45U7MVg@mail.gmail.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org> <CAP71WjzZqcxr-zHFfFUP0jAPfmJm7NM1MpS6tfPkMmj45U7MVg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 23 Feb 2018 14:38:38 +0000
Message-ID: <CAKv+Gu-Wke9WTDihQLfTdNwL5jPem80g-FiEre=Ux07Tbo=V-A@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Mark Brown <broonie@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592195012503488310?=
X-GMAIL-MSGID: =?utf-8?q?1593202935179258551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 February 2018 at 14:19, Nicolas Dechesne
<nicolas.dechesne@linaro.org> wrote:
> hi,
>
> On Mon, Feb 12, 2018 at 12:38 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Hi Greg,
>>
>> As mentioned by Will, I have created the v4.14 counterpart of his stable
>> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
>> into v4.16-rc1.
>>
>> Given that this is the v4.15 version backported to v4.14, I have removed any
>> mention of 'conflicts' from the commit logs as they are now ambiguous. The
>> patches applied surprisingly cleanly, I only needed to drop two patches that
>> are already in (the same ones Will mentioned in his PR), and drop another one
>> dealing with SPE, support for which did not exist yet in v4.14. I also included
>> the patch
>>
>>   arm64: move TASK_* definitions to <asm/processor.h>
>>
>> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
>>
>> Thanks,
>> Ard.
>>
>> Will Deacon (40):
>>       [Variant 3/Meltdown] arm64: mm: Use non-global mappings for kernel space
>>       [Variant 3/Meltdown] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
>>       [Variant 3/Meltdown] arm64: mm: Move ASID from TTBR0 to TTBR1
>>       [Variant 3/Meltdown] arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
>>       [Variant 3/Meltdown] arm64: mm: Rename post_ttbr0_update_workaround
>>       [Variant 3/Meltdown] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
>>       [Variant 3/Meltdown] arm64: mm: Allocate ASIDs in pairs
>>       [Variant 3/Meltdown] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
>>       [Variant 3/Meltdown] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
>>       [Variant 3/Meltdown] arm64: entry: Add exception trampoline page for exceptions from EL0
>>       [Variant 3/Meltdown] arm64: mm: Map entry trampoline into trampoline and kernel page tables
>>       [Variant 3/Meltdown] arm64: entry: Explicitly pass exception level to kernel_ventry macro
>>       [Variant 3/Meltdown] arm64: entry: Hook up entry trampoline to exception vectors
>>       [Variant 3/Meltdown] arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
>>       [Variant 3/Meltdown] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
>>       [Variant 3/Meltdown] arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
>>       [Variant 3/Meltdown] arm64: kaslr: Put kernel vectors address in separate data page
>>       [Variant 3/Meltdown] arm64: use RET instruction for exiting the trampoline
>>       [Variant 3/Meltdown] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
>>       [Variant 3/Meltdown] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
>>       [Variant 3/Meltdown] arm64: Take into account ID_AA64PFR0_EL1.CSV3
>>       [Variant 3/Meltdown] arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
>>       [Variant 3/Meltdown] arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
>
> we are seeing a regression on Qualcomm Dragonbooard 410c at this
> commit ^. we are seeing the same regression on 4.15.x, where the same
> commit exists too. However there is no regression on mainline.
>
> Starting from this commit , this is the bootlog (with earlyprintk)
>
...
> [    0.239866] alternatives: patching kernel code
> [    0.244070] ------------[ cut here ]------------
> [    0.248350] kernel BUG at ../arch/arm64/mm/mmu.c:138!
> [    0.253128] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.258073] Modules linked in:
> [    0.263455] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.3 #27
> [    0.266495] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    0.272662] pstate: 00000005 (nzcv daif -PAN -UAO)
> [    0.279347] pc : __create_pgd_mapping+0x544/0x660
> [    0.283943] lr : __create_pgd_mapping+0x4d0/0x660
> [    0.288714] sp : ffff000008033cb0
> [    0.293400] x29: ffff000008033cb0 x28: ffff800000e2ffff
> [    0.296701] x27: ffff800000080000 x26: ffff800000200000
> [    0.302083] x25: 0000000080080000 x24: ffff800000e30000
> [    0.307379] x23: ffff7dfffe638000 x22: 00000000bfef6003
> [    0.312673] x21: ffff800000080000 x20: 00e0000000000f93
> [    0.317969] x19: ffff800000e30000 x18: 0000000000000010
> [    0.323264] x17: 000000001f8013fb x16: 000000000522cdac
> [    0.328558] x15: 0000000000000000 x14: 0000000000000400
> [    0.333854] x13: 0000800080000000 x12: 0000000080080000
> [    0.339150] x11: 00e8000000000f13 x10: ffff8000001fffff
> [    0.344445] x9 : ffff800000080000 x8 : 00e0000000000f93
> [    0.349739] x7 : ffff800000090000 x6 : 0040000000000041
> [    0.355034] x5 : 0040000000000001 x4 : 00e8000080080f93
> [    0.360329] x3 : ffff800000080000 x2 : ffff7dfffe639400
> [    0.365624] x1 : ffd7ffffffffff7f x0 : 0008000000000880
> [    0.370922] Process swapper/0 (pid: 1, stack limit = 0x0000000095a442e7)
> [    0.376216] Call trace:
> [    0.382899]  __create_pgd_mapping+0x544/0x660
> [    0.385070]  update_mapping_prot+0x48/0xd8
> [    0.389585]  mark_linear_text_alias_ro+0x68/0x8c
> [    0.393579]  smp_cpus_done+0x60/0x9c
> [    0.398351]  smp_init+0xfc/0x114
> [    0.401909]  kernel_init_freeable+0xcc/0x224
> [    0.405123]  kernel_init+0x10/0x100
> [    0.409374]  ret_from_fork+0x10/0x18
> [    0.412588] Code: 92801001 f2fffae1 ea01001f 54000040 (d4210000)
> [    0.416420] ---[ end trace e7ed67ae05b55982 ]---
> [    0.422430] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    0.422430]
> [    0.427091] SMP: stopping secondary CPUs
> [    0.436203] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b
> [    0.436203]
>
> I understand this is not a lot of data. but I am a bit clueless here.
> One thing worth saying is that we are using custom/proprietary
> firmware here, and CPUs are started in EL1. The DB410c is based on
> APQ8016 SoC from Qualcomm (4x Cortex A53).

OK, so it seems like mark_linear_text_alias_ro() may be putting down
global mappings again.

Could you please try with the below folded in please?

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fa20124c19d5..36282fc05665 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -140,8 +140,13 @@ static void init_pte(pmd_t *pmd, unsigned long
addr, unsigned long end,
                 * only allow updates to the permission attributes.
                 */
                BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)));
+               if (!pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)))
+                       pr_warn("%llx %llx %llx %llx\n", PAGE_KERNEL_RO,
+                               pte_val(old_pte), pte_val(*pte),
+                               pte_val(old_pte) ^ pte_val(*pte));

                phys += PAGE_SIZE;
        } while (pte++, addr += PAGE_SIZE, addr != end);
