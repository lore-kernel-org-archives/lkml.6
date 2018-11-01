Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847B2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A847B2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeKAWsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbeKAWsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:48:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92412AE56;
        Thu,  1 Nov 2018 13:45:06 +0000 (UTC)
Subject: Re: [PATCH] x86/build: Build VSMP support only if selected
To:     Eial Czerwacki <eial@scalemp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     "Shai Fultheim (Shai@ScaleMP.com)" <Shai@ScaleMP.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        X86 ML <x86@kernel.org>, 'Oren Twaig' <oren@scalemp.com>
References: <20181030230905.xHZmM%akpm@linux-foundation.org>
 <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org>
 <alpine.DEB.2.21.1811011032190.1642@nanos.tec.linutronix.de>
 <SN6PR15MB2366D7688B41535AF0A331F9C3CE0@SN6PR15MB2366.namprd15.prod.outlook.com>
 <a8f2ac8e-45dc-1c12-e888-6ad880b1306f@scalemp.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <054cd800-5124-f897-0069-aba49f8eb654@suse.com>
Date:   Thu, 1 Nov 2018 14:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a8f2ac8e-45dc-1c12-e888-6ad880b1306f@scalemp.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 14:10, Eial Czerwacki wrote:
> Greetings,
> 
> On 11/01/2018 12:39 PM, Shai Fultheim (Shai@ScaleMP.com) wrote:
>> On 01/11/18 11:37, Thomas Gleixner wrote:
>>
>>> VSMP support is built even if CONFIG_X86_VSMP is not set. This leads to a build
>>> breakage when CONFIG_PCI is disabled as well.
>>>
>>> Build VSMP code only when selected.
>>
>> This patch disables detect_vsmp_box() on systems without CONFIG_X86_VSMP, due to
>> the recent 6da63eb241a05b0e676d68975e793c0521387141.  This is significant
>> regression that will affect significant number of deployments.
>>
>> We will reply shortly with an updated patch that fix the dependency on pv_irq_ops,
>> and revert to CONFIG_PARAVIRT, with proper protection for CONFIG_PCI.
>>
> 
> here is the proper patch which fixes the issue on hand:
> From ebff534f8cfa55d7c3ab798c44abe879f3fbe2b8 Mon Sep 17 00:00:00 2001
> From: Eial Czerwacki <eial@scalemp.com>
> Date: Thu, 1 Nov 2018 15:08:32 +0200
> Subject: [PATCH] x86/build: Build VSMP support only if CONFIG_PCI is
> selected
> 
> vsmp dependency of pv_irq_ops removed some years ago, so now let's clean
> it up from vsmp_64.c.
> 
> In short, "cap & ctl & (1 << 4)" was always returning 0, as such we can
> remove all the PARAVIRT/PARAVIRT_XXL code handling that.
> 
> However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.
> 
> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> Acked-by: Shai Fultheim <shai@scalemp.com>
> ---
>  arch/x86/Kconfig          |  1 -
>  arch/x86/kernel/vsmp_64.c | 80
> +++--------------------------------------------
>  2 files changed, 5 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c51c989..4b187ca 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -524,7 +524,6 @@ config X86_VSMP
>         bool "ScaleMP vSMP"
>         select HYPERVISOR_GUEST
>         select PARAVIRT

Do you really still need PARAVIRT and HYPERVISOR_GUEST?
Maybe you want IRQ_REMAP instead?

> -       select PARAVIRT_XXL
>         depends on X86_64 && PCI
>         depends on X86_EXTENDED_PLATFORM
>         depends on SMP
> diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
> index 1eae5af..c6d2b76 100644
> --- a/arch/x86/kernel/vsmp_64.c
> +++ b/arch/x86/kernel/vsmp_64.c
> @@ -26,64 +26,7 @@
> 
>  #define TOPOLOGY_REGISTER_OFFSET 0x10
> 
> -#if defined CONFIG_PCI && defined CONFIG_PARAVIRT_XXL
> -/*
> - * Interrupt control on vSMPowered systems:
> - * ~AC is a shadow of IF.  If IF is 'on' AC should be 'off'
> - * and vice versa.
> - */
> -
> -asmlinkage __visible unsigned long vsmp_save_fl(void)
> -{
> -       unsigned long flags = native_save_fl();
> -
> -       if (!(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC))
> -               flags &= ~X86_EFLAGS_IF;
> -       return flags;
> -}
> -PV_CALLEE_SAVE_REGS_THUNK(vsmp_save_fl);
> -
> -__visible void vsmp_restore_fl(unsigned long flags)
> -{
> -       if (flags & X86_EFLAGS_IF)
> -               flags &= ~X86_EFLAGS_AC;
> -       else
> -               flags |= X86_EFLAGS_AC;
> -       native_restore_fl(flags);
> -}
> -PV_CALLEE_SAVE_REGS_THUNK(vsmp_restore_fl);
> -
> -asmlinkage __visible void vsmp_irq_disable(void)
> -{
> -       unsigned long flags = native_save_fl();
> -
> -       native_restore_fl((flags & ~X86_EFLAGS_IF) | X86_EFLAGS_AC);
> -}
> -PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_disable);
> -
> -asmlinkage __visible void vsmp_irq_enable(void)
> -{
> -       unsigned long flags = native_save_fl();
> -
> -       native_restore_fl((flags | X86_EFLAGS_IF) & (~X86_EFLAGS_AC));
> -}
> -PV_CALLEE_SAVE_REGS_THUNK(vsmp_irq_enable);
> -
> -static unsigned __init vsmp_patch(u8 type, void *ibuf,
> -                                 unsigned long addr, unsigned len)
> -{
> -       switch (type) {
> -       case PARAVIRT_PATCH(irq.irq_enable):
> -       case PARAVIRT_PATCH(irq.irq_disable):
> -       case PARAVIRT_PATCH(irq.save_fl):
> -       case PARAVIRT_PATCH(irq.restore_fl):
> -               return paravirt_patch_default(type, ibuf, addr, len);
> -       default:
> -               return native_patch(type, ibuf, addr, len);
> -       }
> -
> -}
> -
> +#if defined CONFIG_PCI
>  static void __init set_vsmp_pv_ops(void)

Wouldn't be a rename of the function be appropriate now?


Juergen
