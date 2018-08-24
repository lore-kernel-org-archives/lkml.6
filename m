Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B37C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694A22151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694A22151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeHXR2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:28:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeHXR2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:28:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 800D4AE8E;
        Fri, 24 Aug 2018 13:53:24 +0000 (UTC)
Subject: Re: [PATCH v2] xen: move pv irq related functions under CONFIG_XEN_PV
 umbrella
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com
References: <20180808061918.5033-1-jgross@suse.com>
 <b7909bb0-ed7c-2640-3f50-136c9e8abf3d@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNHkp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmRlPsLAeQQTAQIAIwUCU4xw6wIbAwcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJELDendYovxMvi4UH/Ri+OXlObzqMANruTd4N
 zmVBAZgx1VW6jLc8JZjQuJPSsd/a+bNr3BZeLV6lu4Pf1Yl2Log129EX1KWYiFFvPbIiq5M5
 kOXTO8Eas4CaScCvAZ9jCMQCgK3pFqYgirwTgfwnPtxFxO/F3ZcS8jovza5khkSKL9JGq8Nk
 czDTruQ/oy0WUHdUr9uwEfiD9yPFOGqp4S6cISuzBMvaAiC5YGdUGXuPZKXLpnGSjkZswUzY
 d9BVSitRL5ldsQCg6GhDoEAeIhUC4SQnT9SOWkoDOSFRXZ+7+WIBGLiWMd+yKDdRG5RyP/8f
 3tgGiB6cyuYfPDRGsELGjUaTUq3H2xZgIPfOwE0EU4xwFgEIAMsx+gDjgzAY4H1hPVXgoLK8
 B93sTQFN9oC6tsb46VpxyLPfJ3T1A6Z6MVkLoCejKTJ3K9MUsBZhxIJ0hIyvzwI6aYJsnOew
 cCiCN7FeKJ/oA1RSUemPGUcIJwQuZlTOiY0OcQ5PFkV5YxMUX1F/aTYXROXgTmSaw0aC1Jpo
 w7Ss1mg4SIP/tR88/d1+HwkJDVW1RSxC1PWzGizwRv8eauImGdpNnseneO2BNWRXTJumAWDD
 pYxpGSsGHXuZXTPZqOOZpsHtInFyi5KRHSFyk2Xigzvh3b9WqhbgHHHE4PUVw0I5sIQt8hJq
 5nH5dPqz4ITtCL9zjiJsExHuHKN3NZsAEQEAAcLAXwQYAQIACQUCU4xwFgIbDAAKCRCw3p3W
 KL8TL0P4B/9YWver5uD/y/m0KScK2f3Z3mXJhME23vGBbMNlfwbr+meDMrJZ950CuWWnQ+d+
 Ahe0w1X7e3wuLVODzjcReQ/v7b4JD3wwHxe+88tgB9byc0NXzlPJWBaWV01yB2/uefVKryAf
 AHYEd0gCRhx7eESgNBe3+YqWAQawunMlycsqKa09dBDL1PFRosF708ic9346GLHRc6Vj5SRA
 UTHnQqLetIOXZm3a2eQ1gpQK9MmruO86Vo93p39bS1mqnLLspVrL4rhoyhsOyh0Hd28QCzpJ
 wKeHTd0MAWAirmewHXWPco8p1Wg+V+5xfZzuQY0f4tQxvOpXpt4gQ1817GQ5/Ed/wsDtBBgB
 CAAgFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAlrd8NACGwIAgQkQsN6d1ii/Ey92IAQZFggA
 HRYhBFMtsHpB9jjzHji4HoBcYbtP2GO+BQJa3fDQAAoJEIBcYbtP2GO+TYsA/30H/0V6cr/W
 V+J/FCayg6uNtm3MJLo4rE+o4sdpjjsGAQCooqffpgA+luTT13YZNV62hAnCLKXH9n3+ZAgJ
 RtAyDWk1B/0SMDVs1wxufMkKC3Q/1D3BYIvBlrTVKdBYXPxngcRoqV2J77lscEvkLNUGsu/z
 W2pf7+P3mWWlrPMJdlbax00vevyBeqtqNKjHstHatgMZ2W0CFC4hJ3YEetuRBURYPiGzuJXU
 pAd7a7BdsqWC4o+GTm5tnGrCyD+4gfDSpkOT53S/GNO07YkPkm/8J4OBoFfgSaCnQ1izwgJQ
 jIpcG2fPCI2/hxf2oqXPYbKr1v4Z1wthmoyUgGN0LPTIm+B5vdY82wI5qe9uN6UOGyTH2B3p
 hRQUWqCwu2sqkI3LLbTdrnyDZaixT2T0f4tyF5Lfs+Ha8xVMhIyzNb1byDI5FKCb
Message-ID: <a5dca37c-8d97-33b6-41b1-7d08cab526f7@suse.com>
Date:   Fri, 24 Aug 2018 15:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b7909bb0-ed7c-2640-3f50-136c9e8abf3d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 17:13, Boris Ostrovsky wrote:
> x86 maintainers, this needs you ack too even though it has "xen" tag in
> the subject, thanks.

Ping?


Juergen

> 
> 
> On 08/08/2018 02:19 AM, Juergen Gross wrote:
>> All functions in arch/x86/xen/irq.c and arch/x86/xen/xen-asm*.S are
>> specific to PV guests. Include them in the kernel with
>> CONFIG_XEN_PV only.
>>
>> Make the PV specific code in arch/x86/entry/entry_*.S dependent on
>> CONFIG_XEN_PV instead of CONFIG_XEN.
>>
>> The HVM specific code should depend on CONFIG_XEN_PVHVM.
>>
>> While at it reformat the Makefile to make it more readable.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
>> ---
>>  arch/x86/entry/entry_32.S |  8 +++++---
>>  arch/x86/entry/entry_64.S |  8 +++++---
>>  arch/x86/xen/Makefile     | 41 +++++++++++++++++++++++++++++++----------
>>  include/xen/events.h      |  2 ++
>>  4 files changed, 43 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
>> index c371bfee137a..cc4ec4fd58d2 100644
>> --- a/arch/x86/entry/entry_32.S
>> +++ b/arch/x86/entry/entry_32.S
>> @@ -369,7 +369,7 @@ GLOBAL(__begin_SYSENTER_singlestep_region)
>>   * will ignore all of the single-step traps generated in this range.
>>   */
>>  
>> -#ifdef CONFIG_XEN
>> +#ifdef CONFIG_XEN_PV
>>  /*
>>   * Xen doesn't set %esp to be precisely what the normal SYSENTER
>>   * entry point expects, so fix it up before using the normal path.
>> @@ -807,7 +807,7 @@ ENTRY(spurious_interrupt_bug)
>>  	jmp	common_exception
>>  END(spurious_interrupt_bug)
>>  
>> -#ifdef CONFIG_XEN
>> +#ifdef CONFIG_XEN_PV
>>  ENTRY(xen_hypervisor_callback)
>>  	pushl	$-1				/* orig_ax = -1 => not a system call */
>>  	SAVE_ALL
>> @@ -888,11 +888,13 @@ ENTRY(xen_failsafe_callback)
>>  	_ASM_EXTABLE(3b, 8b)
>>  	_ASM_EXTABLE(4b, 9b)
>>  ENDPROC(xen_failsafe_callback)
>> +#endif /* CONFIG_XEN_PV */
>>  
>> +#ifdef CONFIG_XEN_PVHVM
>>  BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
>>  		 xen_evtchn_do_upcall)
>> +#endif
>>  
>> -#endif /* CONFIG_XEN */
>>  
>>  #if IS_ENABLED(CONFIG_HYPERV)
>>  
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 8ae7ffda8f98..3c2526e24dd8 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1049,7 +1049,7 @@ ENTRY(do_softirq_own_stack)
>>  	ret
>>  ENDPROC(do_softirq_own_stack)
>>  
>> -#ifdef CONFIG_XEN
>> +#ifdef CONFIG_XEN_PV
>>  idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
>>  
>>  /*
>> @@ -1129,11 +1129,13 @@ ENTRY(xen_failsafe_callback)
>>  	ENCODE_FRAME_POINTER
>>  	jmp	error_exit
>>  END(xen_failsafe_callback)
>> +#endif /* CONFIG_XEN_PV */
>>  
>> +#ifdef CONFIG_XEN_PVHVM
>>  apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
>>  	xen_hvm_callback_vector xen_evtchn_do_upcall
>> +#endif
>>  
>> -#endif /* CONFIG_XEN */
>>  
>>  #if IS_ENABLED(CONFIG_HYPERV)
>>  apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
>> @@ -1150,7 +1152,7 @@ idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>>  idtentry int3			do_int3			has_error_code=0
>>  idtentry stack_segment		do_stack_segment	has_error_code=1
>>  
>> -#ifdef CONFIG_XEN
>> +#ifdef CONFIG_XEN_PV
>>  idtentry xennmi			do_nmi			has_error_code=0
>>  idtentry xendebug		do_debug		has_error_code=0
>>  idtentry xenint3		do_int3			has_error_code=0
>> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
>> index d83cb5478f54..f723b5aa8f74 100644
>> --- a/arch/x86/xen/Makefile
>> +++ b/arch/x86/xen/Makefile
>> @@ -12,25 +12,46 @@ endif
>>  # Make sure early boot has no stackprotector
>>  nostackp := $(call cc-option, -fno-stack-protector)
>>  CFLAGS_enlighten_pv.o		:= $(nostackp)
>> -CFLAGS_mmu_pv.o		:= $(nostackp)
>> +CFLAGS_mmu_pv.o			:= $(nostackp)
>>  
>> -obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
>> -			time.o xen-asm.o xen-asm_$(BITS).o \
>> -			grant-table.o suspend.o platform-pci-unplug.o
>> +obj-y				+= enlighten.o
>> +obj-y				+= multicalls.o
>> +obj-y				+= mmu.o
>> +obj-y				+= time.o
>> +obj-y				+= grant-table.o
>> +obj-y				+= suspend.o
>> +obj-y				+= platform-pci-unplug.o
>>  
>> -obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
>> -obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
>> -						p2m.o enlighten_pv.o mmu_pv.o
>> -obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
>> +obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
>> +obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
>> +obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
>>  
>> -obj-$(CONFIG_EVENT_TRACING) += trace.o
>> +obj-$(CONFIG_XEN_PV)		+= setup.o
>> +obj-$(CONFIG_XEN_PV)		+= apic.o
>> +obj-$(CONFIG_XEN_PV)		+= pmu.o
>> +obj-$(CONFIG_XEN_PV)		+= suspend_pv.o
>> +obj-$(CONFIG_XEN_PV)		+= p2m.o
>> +obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
>> +obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
>> +obj-$(CONFIG_XEN_PV)		+= irq.o
>> +obj-$(CONFIG_XEN_PV)		+= xen-asm.o
>> +obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
>> +
>> +obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
>> +obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
>> +
>> +obj-$(CONFIG_EVENT_TRACING)	+= trace.o
>>  
>>  obj-$(CONFIG_SMP)		+= smp.o
>>  obj-$(CONFIG_XEN_PV_SMP)  	+= smp_pv.o
>>  obj-$(CONFIG_XEN_PVHVM_SMP)  	+= smp_hvm.o
>> +
>>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
>> +
>>  obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
>> +
>>  obj-$(CONFIG_XEN_DOM0)		+= vga.o
>> +
>>  obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
>> +
>>  obj-$(CONFIG_XEN_EFI)		+= efi.o
>> -obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
>> diff --git a/include/xen/events.h b/include/xen/events.h
>> index c3e6bc643a7b..a48897199975 100644
>> --- a/include/xen/events.h
>> +++ b/include/xen/events.h
>> @@ -89,11 +89,13 @@ unsigned irq_from_evtchn(unsigned int evtchn);
>>  int irq_from_virq(unsigned int cpu, unsigned int virq);
>>  unsigned int evtchn_from_irq(unsigned irq);
>>  
>> +#ifdef CONFIG_XEN_PVHVM
>>  /* Xen HVM evtchn vector callback */
>>  void xen_hvm_callback_vector(void);
>>  #ifdef CONFIG_TRACING
>>  #define trace_xen_hvm_callback_vector xen_hvm_callback_vector
>>  #endif
>> +#endif
>>  int xen_set_callback_via(uint64_t via);
>>  void xen_evtchn_do_upcall(struct pt_regs *regs);
>>  void xen_hvm_evtchn_do_upcall(void);
> 
> 

