Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67EAFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DADB208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0tAN/P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DADB208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935867AbeFNBaW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:30:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45123 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935530AbeFNBaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:30:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so2529203plz.12;
        Wed, 13 Jun 2018 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=204OgiM34a3LToksRZdcsiAMvYA+vrxdM5yNzbjrgEM=;
        b=L0tAN/P5ZYyaDVnLuRlOY2DQSgtD4mw8ECGC+HSDMn4+XzPO32uwhd1Ih/6NMWd9BI
         52A7TY//vRABJkuU2QQ/jvdhnuJFLEZDLpTTbeik1mwyY+9oXCWTXxkm9xDzfcaq6rwb
         RC6TOfsrxEIFAhgiVNWBgjztdGyZRc0ksOtf/QG2BQI7e3E2drZXkJ1mZ+RLcQkqD2uk
         N40sG2Lu7KKOy0ynCgYqIY8JumF7OTwg3nKYoLM9S3OPKVaygLMVhaf1vLSWTsEzHj19
         GcxrafotjYAIIW/vfVTS2efGzmFmauiGJoZohP+2TtpMu0RJlT0QPaTZ0iu3pkM4YPJw
         r1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=204OgiM34a3LToksRZdcsiAMvYA+vrxdM5yNzbjrgEM=;
        b=buNZiNGkZDrh6jzjwReZdIu8BLwMOQ8hsDK9RTqIbPbIHJpYpwuQo7i0tuo5OjO3hs
         yipVQglfRliN515l1/dzpTcJoSLumE5ad1o1LnpbqDggBl2KWOXx2DHM0lEcXLfhcB+i
         9+BWKNKQCDRxItbokwNcvCc3laLIlxKS7hsAWAlVj6ONjiExOESA5d4F6jRQ8i/pbETg
         UZhkp2QGktb97zO3vlW83jV7ggetZJ1ES1upAcSYjd/i+7iWxQcKWavAza2Zm+vzJzfn
         lx0ibuH/KQwgwugIM4hes7VW7EOnhX5NJ/aFiWnpADdz+bMn0EsOq+eXcRA0SAqHyobS
         5W7w==
X-Gm-Message-State: APt69E3wkDMPObVLaNlGBVND8gVbJ0545gR4g7DUsSFzL8QOe8CwWFZ4
        HmHcZmwAoDrffJmXP4rPv5w=
X-Google-Smtp-Source: ADUXVKLAE3MwDt+/qnMklX6ArKKB++ZmbaeHzRSjtmwuokUp+nznsx0ThdhYGyVeiw1EX1ptTSaRww==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr621926plh.152.1528939819396;
        Wed, 13 Jun 2018 18:30:19 -0700 (PDT)
Received: from 350D (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.googlemail.com with ESMTPSA id v5-v6sm8973458pfd.1.2018.06.13.18.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 18:30:18 -0700 (PDT)
Message-ID: <fb30195ed6f5ab17920938192cf0b7ef8d1d4037.camel@gmail.com>
Subject: Re: [PATCH 02/10] x86/cet: Introduce WRUSS instruction
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu, 14 Jun 2018 11:30:07 +1000
In-Reply-To: <20180607143807.3611-3-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-3-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 07:37 -0700, Yu-cheng Yu wrote:
> WRUSS is a new kernel-mode instruction but writes directly
> to user shadow stack memory.  This is used to construct
> a return address on the shadow stack for the signal
> handler.
> 
> This instruction can fault if the user shadow stack is
> invalid shadow stack memory.  In that case, the kernel does
> fixup.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/special_insns.h          | 44 +++++++++++++++++++++++++++
>  arch/x86/lib/x86-opcode-map.txt               |  2 +-
>  arch/x86/mm/fault.c                           | 13 +++++++-
>  tools/objtool/arch/x86/lib/x86-opcode-map.txt |  2 +-
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 317fc59b512c..8ce532fcc171 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -237,6 +237,50 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +
> +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	int err;
> +
> +	asm volatile("1:.byte 0x66, 0x0f, 0x38, 0xf5, 0x37\n"

It would nice to use something like ASM_WRUSS/Q like ASM_CLAC/ASM_STAC.
Is the 0x37 spurious? I don't see addr/val being used in the instructions
either.

> +		     "xor %[err],%[err]\n"
> +		     "2:\n"
> +		     ".section .fixup,\"ax\"\n"
> +		     "3: mov $-1,%[err]; jmp 2b\n"
> +		     ".previous\n"
> +		     _ASM_EXTABLE(1b, 3b)
> +		: [err] "=a" (err)
> +		: [val] "S" (val), [addr] "D" (addr)
> +		: "memory");
> +	return err;
> +}
> +#else
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +	int err;
> +
> +	asm volatile("1:.byte 0x66, 0x48, 0x0f, 0x38, 0xf5, 0x37\n"
> +		     "xor %[err],%[err]\n"
> +		     "2:\n"
> +		     ".section .fixup,\"ax\"\n"
> +		     "3: mov $-1,%[err]; jmp 2b\n"
> +		     ".previous\n"
> +		     _ASM_EXTABLE(1b, 3b)
> +		: [err] "=a" (err)
> +		: [val] "S" (val), [addr] "D" (addr)
> +		: "memory");
> +	return err;
> +}
> +#endif /* CONFIG_X86_INTEL_CET */
> +
>  #define nop() asm volatile ("nop")
>  
>  
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index e0b85930dd77..72bb7c48a7df 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -789,7 +789,7 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
>  f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
>  f2: ANDN Gy,By,Ey (v)
>  f3: Grp17 (1A)
> -f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
> +f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSS Pq,Qq (66),REX.W
>  f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  EndTable
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2b3b9170109c..f157338862f8 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -640,6 +640,17 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
>  	return 0;
>  }
>  
> +/*
> + * WRUSS is a kernel instrcution and but writes to user
> + * shadow stack memory.  When a fault occurs, both
> + * X86_PF_USER and X86_PF_SHSTK are set.
> + */
> +static int is_wruss(struct pt_regs *regs, unsigned long error_code)
> +{
> +	return (((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
> +		(X86_PF_USER | X86_PF_SHSTK)) && !user_mode(regs));
> +}
> +
>  static const char nx_warning[] = KERN_CRIT
>  "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
>  static const char smep_warning[] = KERN_CRIT
> @@ -851,7 +862,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  	struct task_struct *tsk = current;
>  
>  	/* User mode accesses just cause a SIGSEGV */
> -	if (error_code & X86_PF_USER) {
> +	if ((error_code & X86_PF_USER) && !is_wruss(regs, error_code)) {
>  		/*
>  		 * It's possible to have interrupts off here:
>  		 */
> diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> index e0b85930dd77..72bb7c48a7df 100644
> --- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
> @@ -789,7 +789,7 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
>  f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
>  f2: ANDN Gy,By,Ey (v)
>  f3: Grp17 (1A)
> -f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
> +f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSS Pq,Qq (66),REX.W
>  f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  EndTable

Balbir Singh.

