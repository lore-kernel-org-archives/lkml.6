Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89766C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A9E2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A9E2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHXR1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbeHXR1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9C16AE8E;
        Fri, 24 Aug 2018 13:52:56 +0000 (UTC)
Subject: Re: [PATCH v2 00/11] x86/paravirt: several cleanups
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org
References: <20180813073739.26108-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <45bfe8ab-683f-ab79-e3c6-c0a707b667c2@suse.com>
Date:   Fri, 24 Aug 2018 15:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 09:37, Juergen Gross wrote:
> This series removes some no longer needed stuff from paravirt
> infrastructure and puts large quantities of paravirt ops under a new
> config option PARAVIRT_XXL which is selected by XEN_PV only.
> 
> A pvops kernel without XEN_PV being configured is about 2.5% smaller
> with this series applied.
> 
> tip commit 5800dc5c19f34e6e03b5adab1282535cb102fafd ("x86/paravirt:
> Fix spectre-v2 mitigations for paravirt guests") is a prerequisite
> for this series.
> 
> The last 4 patches of this series require my Xen cleanup series
> https://lore.kernel.org/lkml/20180717120113.12756-1-jgross@suse.com/
> which hides more Xen PV-only code behind CONFIG_XEN_PV.
> 
> Changes in V2:
> - patch 4: shorten pv_ops sub-structure names (Jan Beulich)
> - patch 11: new patch
> 
> Juergen Gross (11):
>   x86/paravirt: make paravirt_patch_call() and paravirt_patch_jmp()
>     static
>   x86/paravirt: remove clobbers parameter from paravirt patch functions
>   x86/paravirt: remove clobbers from struct paravirt_patch_site
>   x86/paravirt: use a single ops structure
>   x86/paravirt: remove unused paravirt bits
>   x86/paravirt: introduce new config option PARAVIRT_XXL
>   x86/paravirt: move items in pv_info under PARAVIRT_XXL umbrella
>   x86/paravirt: move the Xen-only pv_cpu_ops under the PARAVIRT_XXL
>     umbrella
>   x86/paravirt: move the Xen-only pv_irq_ops under the PARAVIRT_XXL
>     umbrella
>   x86/paravirt: move the Xen-only pv_mmu_ops under the PARAVIRT_XXL
>     umbrella
>   x86/paravirt: remove unneeded mmu related paravirt ops bits
> 
>  arch/x86/Kconfig                            |   3 +
>  arch/x86/hyperv/mmu.c                       |   4 +-
>  arch/x86/include/asm/debugreg.h             |   2 +-
>  arch/x86/include/asm/desc.h                 |   4 +-
>  arch/x86/include/asm/fixmap.h               |   2 +-
>  arch/x86/include/asm/irqflags.h             |  56 ++--
>  arch/x86/include/asm/mmu_context.h          |   4 +-
>  arch/x86/include/asm/msr.h                  |   4 +-
>  arch/x86/include/asm/paravirt.h             | 399 +++++++++++++---------------
>  arch/x86/include/asm/paravirt_types.h       |  77 +++---
>  arch/x86/include/asm/pgalloc.h              |   2 +-
>  arch/x86/include/asm/pgtable-3level_types.h |   2 +-
>  arch/x86/include/asm/pgtable.h              |   7 +-
>  arch/x86/include/asm/processor.h            |   4 +-
>  arch/x86/include/asm/ptrace.h               |   3 +-
>  arch/x86/include/asm/segment.h              |   2 +-
>  arch/x86/include/asm/special_insns.h        |   4 +-
>  arch/x86/kernel/alternative.c               |   2 +-
>  arch/x86/kernel/asm-offsets.c               |  13 +-
>  arch/x86/kernel/asm-offsets_64.c            |   9 +-
>  arch/x86/kernel/cpu/common.c                |   4 +-
>  arch/x86/kernel/cpu/vmware.c                |   4 +-
>  arch/x86/kernel/head_64.S                   |   2 +-
>  arch/x86/kernel/kvm.c                       |  17 +-
>  arch/x86/kernel/kvmclock.c                  |   4 +-
>  arch/x86/kernel/paravirt-spinlocks.c        |  15 +-
>  arch/x86/kernel/paravirt.c                  | 292 ++++++++++----------
>  arch/x86/kernel/paravirt_patch_32.c         |  57 ++--
>  arch/x86/kernel/paravirt_patch_64.c         |  65 ++---
>  arch/x86/kernel/tsc.c                       |   2 +-
>  arch/x86/kernel/vsmp_64.c                   |  24 +-
>  arch/x86/xen/Kconfig                        |   1 +
>  arch/x86/xen/enlighten_pv.c                 |  31 ++-
>  arch/x86/xen/irq.c                          |   2 +-
>  arch/x86/xen/mmu_hvm.c                      |   2 +-
>  arch/x86/xen/mmu_pv.c                       |  28 +-
>  arch/x86/xen/spinlock.c                     |  11 +-
>  arch/x86/xen/time.c                         |   4 +-
>  drivers/xen/time.c                          |   2 +-
>  39 files changed, 575 insertions(+), 595 deletions(-)
> 

Ping?


Juergen
