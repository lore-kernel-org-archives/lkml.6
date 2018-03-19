Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELut80XlL240KGsS06sOP9loN2ErEygCu2wVMvRBXOiMPr/Lu/6t4mZIQAHs9FGZdv8zRnwV
ARC-Seal: i=1; a=rsa-sha256; t=1521448692; cv=none;
        d=google.com; s=arc-20160816;
        b=gW4ea7sVT+DKl5kmoei+34UBxZ731TQyYhzPbHbXfz+O5dvvqTTII+olbP6P3oGl3O
         8nYzw2a2HCA5tOLXYeYV6xphOTiTF9r8UISOSvy0Zcf1aNPIQX3wsTMrrY2raCgRIboM
         uJqdnkM+ze3HY3f9fTLvwTv5Mftnszh5GuGUOD556OdwnynHORA5hlNbOjfNI70Is3SP
         93xVIbbLVK114p+2IAIpxuTP75VwU2ALbDuXNoc/fSXzjrj+eOFff1a+dKrhvuWKBZqI
         oRGCeY0YJAKCnWgiz3ywtrlj21E9zlbdVkQNHFI33kvsxQUmyfhdd7FOJwMIEdx/2jWO
         LALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=GwhSA4j0RXLzPXkNhkux5OBAzhfet9q9EPCuNlgBkuo=;
        b=nhiBv7L4niLvKRVpN4dz5UquDrARSZTfjQ7LIe708C+/UYUYW4svIE53LqLwzn4654
         Ex1LzCBGkInVYEO8vW00UksPzkfusXBrcE1EFzkOLu3UtRjbPTbNrcH87ZLpgXUEL3MC
         dbUQuhd587/VUaVaU659hACLUjOOOJ+97wWeoVpCYXguO75bdW2TMlFfyRn30Az9BbM6
         ybyfyXpV4W685HaPZBRkBNHZ6/7Y+rg3rGnfO3+RF6DtRisu7hPsOQdk2E7zlBm2jl8U
         m1Rh1ModLD8TNXJZTp8RnckT5xlEiRz5oBxnux2NaFrq4XGfVN1s2fKGOPRUtBu+7nSL
         yc1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH 3/7] Disable instrumentation for some code
To: Abbott Liu <liuwenliang@huawei.com>, linux@armlinux.org.uk,
 aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, f.fainelli@gmail.com, akpm@linux-foundation.org,
 afzal.mohd.ma@gmail.com, alexander.levin@verizon.com
Cc: glider@google.com, dvyukov@google.com, christoffer.dall@linaro.org,
 linux@rasmusvillemoes.dk, mawilcox@microsoft.com, pombredanne@nexb.com,
 ard.biesheuvel@linaro.org, vladimir.murzin@arm.com,
 nicolas.pitre@linaro.org, tglx@linutronix.de, thgarnie@google.com,
 dhowells@redhat.com, keescook@chromium.org, arnd@arndb.de,
 geert@linux-m68k.org, tixy@linaro.org, mark.rutland@arm.com,
 james.morse@arm.com, zhichao.huang@linaro.org, jinb.park7@gmail.com,
 labbott@redhat.com, philip@cog.systems, grygorii.strashko@linaro.org,
 catalin.marinas@arm.com, opendmb@gmail.com, kirill.shutemov@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
References: <20180318125342.4278-1-liuwenliang@huawei.com>
 <20180318125342.4278-4-liuwenliang@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <5ec51db8-196e-fd3d-8cce-2bdaccc52424@arm.com>
Date: Mon, 19 Mar 2018 08:38:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318125342.4278-4-liuwenliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281348586667199?=
X-GMAIL-MSGID: =?utf-8?q?1595354584575726048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/03/18 12:53, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Disable instrumentation for arch/arm/boot/compressed/*
> and arch/arm/vdso/* because those code won't linkd with
> kernel image.
> 
> Disable kasan check in the function unwind_pop_register
> because it doesn't matter that kasan checks failed when
> unwind_pop_register read stack memory of task.
> 
> Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> ---
>  arch/arm/boot/compressed/Makefile | 1 +
>  arch/arm/kernel/unwind.c          | 3 ++-
>  arch/arm/vdso/Makefile            | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..966103e 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
>  endif
>  
>  GCOV_PROFILE		:= n
> +KASAN_SANITIZE		:= n
>  
>  #
>  # Architecture dependencies
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 0bee233..2e55c7d 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -249,7 +249,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
>  		if (*vsp >= (unsigned long *)ctrl->sp_high)
>  			return -URC_FAILURE;
>  
> -	ctrl->vrs[reg] = *(*vsp)++;
> +	ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
> +	(*vsp)++;
>  	return URC_OK;
>  }
>  
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index bb411821..87abbb7 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -30,6 +30,8 @@ CFLAGS_vgettimeofday.o = -O2
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>  
> +KASAN_SANITIZE := n
> +
>  # Force dependency
>  $(obj)/vdso.o : $(obj)/vdso.so
>  
> 

You need to extend this at least to arch/arm/kvm/hyp/Makefile, as the
KASAN shadow region won't be mapped in HYP. See commit a6cdf1c08cbfe for
more details (all the arm64 comments in this patch apply to 32bit as well).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
