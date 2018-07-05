Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B76C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9951523EF0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSRvkNt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9951523EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeGEQMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:12:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:12:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h40-v6so1481161wrh.2;
        Thu, 05 Jul 2018 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SIthdNZ6CQ2L/xdJFRTutFsySu97NiA+oOnNmY/32s=;
        b=cSRvkNt941aDO/juQgM3SpxSW7XEO3tuRd0wZOyx5jUI+lAvOqy8EHHy9V3zoBL6+O
         xxkJ9E1+cLq8xRGrSwPl2Jk3VQ6qfcQYOajyt5Xe9nFKfNsSX+APcb9wGUJ88wreYHSp
         0VHU6N+5fF2IOunQpZyGAO+JikUBQPY7tWP+wbxkmGlpS5hQtEAXnN3udu0F2+nbSmOX
         mrBzv6Hr6dCMAltIlUkT79pvURd8IaeX8PR6dTT6OKu5Cai+NSdKMddPae4zpM+i7YVi
         rIw6Rb/Q0pBphNUseB2q8bizu8IcBiDKSXX8ansA48cZtx1gLyKUqbq/r2nhyRNHFhRy
         HM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6SIthdNZ6CQ2L/xdJFRTutFsySu97NiA+oOnNmY/32s=;
        b=sVuCV25IH91/U/Ze3Zrbo+2X9lb7WGururmFYUxgQecdMOWyGHFJfcM82Ws3WGpOtn
         JQvjs3D84nCWTcgth37x5zPffxnHo+sGKGqbuALjvUTFaiQvH8PjeHS4Sj2hBIBIs6Qm
         g8KNTlbAbzcdyKx1Z8mh6LZHvjn7Zt+2JgSzJ4xKs/AfxD+9T3JXowgWgI7ZRJJXzjR4
         vsQHa3DHpHrTsM/QRPbF5tUW8JtKgDk7Es3ePt+xZcNp+vIhLDZES609ct1w6rRloHwk
         nLVjA4oKcPbri+j+aFD8sK7eoHpwdjuyP0PDTKfyv0lTWmjDFis+g1WXzt9tiUk9W8ai
         BkJw==
X-Gm-Message-State: APt69E2qboVTIgO9JCnige3+f9oyyVQikAafb2MCUk3fJHxUuZ9q2iPA
        HWiaHMETSgdnlUfrzSIP7WCLQm6J
X-Google-Smtp-Source: AAOMgpeNkH5B9hjBIR22j80io0Q9KsSJtgmhOTo+f1B9JWoXY3DurtdRZmZtJXpPwqZaS0JI1ZCzZQ==
X-Received: by 2002:adf:8796:: with SMTP id b22-v6mr5298010wrb.92.1530807126141;
        Thu, 05 Jul 2018 09:12:06 -0700 (PDT)
Received: from [192.168.10.165] ([82.84.124.111])
        by smtp.googlemail.com with ESMTPSA id j131-v6sm9392930wmb.25.2018.07.05.09.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 09:12:05 -0700 (PDT)
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
To:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
Date:   Thu, 5 Jul 2018 18:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621212518.19914-5-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2018 23:25, Pavel Tatashin wrote:
> KVM clock is initialized later compared to other hypervisor because it has
> dependency on memblock allocator.
> 
> Lets bring it inline with other hypervisors by removing this dependency by
> using memory from BSS instead of allocating it.
> 
> The benefits:
> - remove ifdef from common code
> - earlier availability of TSC.
> - remove dependency on memblock, and reduce code
> - earlier kvm sched_clock()
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

The reason for this is to avoid wasting a lot of BSS memory when KVM is
not in use.  Thomas is going to send his take on this!

Paolo

> ---
>  arch/x86/kernel/kvm.c      |  1 +
>  arch/x86/kernel/kvmclock.c | 64 ++++++--------------------------------
>  arch/x86/kernel/setup.c    |  7 ++---
>  3 files changed, 12 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5b2300b818af..c65c232d3ddd 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -628,6 +628,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
>  	.name			= "KVM",
>  	.detect			= kvm_detect,
>  	.type			= X86_HYPER_KVM,
> +	.init.init_platform	= kvmclock_init,
>  	.init.guest_late_init	= kvm_guest_init,
>  	.init.x2apic_available	= kvm_para_available,
>  };
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index bf8d1eb7fca3..01558d41ec2c 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -23,9 +23,9 @@
>  #include <asm/apic.h>
>  #include <linux/percpu.h>
>  #include <linux/hardirq.h>
> -#include <linux/memblock.h>
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/mm.h>
>  
>  #include <asm/mem_encrypt.h>
>  #include <asm/x86_init.h>
> @@ -44,6 +44,11 @@ static int parse_no_kvmclock(char *arg)
>  }
>  early_param("no-kvmclock", parse_no_kvmclock);
>  
> +/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
> +#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
> +#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
> +static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
> +static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
>  /* The hypervisor will put information about time periodically here */
>  static struct pvclock_vsyscall_time_info *hv_clock;
>  static struct pvclock_wall_clock *wall_clock;
> @@ -244,43 +249,12 @@ static void kvm_shutdown(void)
>  	native_machine_shutdown();
>  }
>  
> -static phys_addr_t __init kvm_memblock_alloc(phys_addr_t size,
> -					     phys_addr_t align)
> -{
> -	phys_addr_t mem;
> -
> -	mem = memblock_alloc(size, align);
> -	if (!mem)
> -		return 0;
> -
> -	if (sev_active()) {
> -		if (early_set_memory_decrypted((unsigned long)__va(mem), size))
> -			goto e_free;
> -	}
> -
> -	return mem;
> -e_free:
> -	memblock_free(mem, size);
> -	return 0;
> -}
> -
> -static void __init kvm_memblock_free(phys_addr_t addr, phys_addr_t size)
> -{
> -	if (sev_active())
> -		early_set_memory_encrypted((unsigned long)__va(addr), size);
> -
> -	memblock_free(addr, size);
> -}
> -
>  void __init kvmclock_init(void)
>  {
>  	struct pvclock_vcpu_time_info *vcpu_time;
> -	unsigned long mem, mem_wall_clock;
> -	int size, cpu, wall_clock_size;
> +	int cpu;
>  	u8 flags;
>  
> -	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
> -
>  	if (!kvm_para_available())
>  		return;
>  
> @@ -290,28 +264,11 @@ void __init kvmclock_init(void)
>  	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
>  		return;
>  
> -	wall_clock_size = PAGE_ALIGN(sizeof(struct pvclock_wall_clock));
> -	mem_wall_clock = kvm_memblock_alloc(wall_clock_size, PAGE_SIZE);
> -	if (!mem_wall_clock)
> -		return;
> -
> -	wall_clock = __va(mem_wall_clock);
> -	memset(wall_clock, 0, wall_clock_size);
> -
> -	mem = kvm_memblock_alloc(size, PAGE_SIZE);
> -	if (!mem) {
> -		kvm_memblock_free(mem_wall_clock, wall_clock_size);
> -		wall_clock = NULL;
> -		return;
> -	}
> -
> -	hv_clock = __va(mem);
> -	memset(hv_clock, 0, size);
> +	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
> +	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
>  
>  	if (kvm_register_clock("primary cpu clock")) {
>  		hv_clock = NULL;
> -		kvm_memblock_free(mem, size);
> -		kvm_memblock_free(mem_wall_clock, wall_clock_size);
>  		wall_clock = NULL;
>  		return;
>  	}
> @@ -354,13 +311,10 @@ int __init kvm_setup_vsyscall_timeinfo(void)
>  	int cpu;
>  	u8 flags;
>  	struct pvclock_vcpu_time_info *vcpu_time;
> -	unsigned int size;
>  
>  	if (!hv_clock)
>  		return 0;
>  
> -	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
> -
>  	cpu = get_cpu();
>  
>  	vcpu_time = &hv_clock[cpu].pvti;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 403b2d2c31d2..01fcc8bf7c8f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1014,6 +1014,8 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	init_hypervisor_platform();
>  
> +	tsc_early_delay_calibrate();
> +
>  	x86_init.resources.probe_roms();
>  
>  	/* after parse_early_param, so could debug it */
> @@ -1199,11 +1201,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	memblock_find_dma_reserve();
>  
> -#ifdef CONFIG_KVM_GUEST
> -	kvmclock_init();
> -#endif
> -
> -	tsc_early_delay_calibrate();
>  	if (!early_xdbc_setup_hardware())
>  		early_xdbc_register_console();
>  
> 

