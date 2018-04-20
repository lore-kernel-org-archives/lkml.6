Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AB8JxZp3RltziFlkiuNC+4QouoeMsTJVtN9gzRRR/tJq2BWH4HBHBqgLuSWBU2fm6xIB1nKALppM
ARC-Seal: i=1; a=rsa-sha256; t=1524205222; cv=none;
        d=google.com; s=arc-20160816;
        b=HB5IVTP6bWuAJ7nbYjWAmC+Rsg5vKmjsSf6kkbolJWQdPIcCSxk/ykGvN7dTMgMFbr
         TJgcKdG8cbdDBmIrJ4V3l2X7ZWiI22TkeLd37ZX7ksaPEAWiL/eM/puEtgj8fAQ3AlSK
         bV//EKaEqX7clxSk4tREB9SFwaw9dXMDxFzGrNu741P1ylj2KOsMZq9cvjOPvSwROeF5
         LUuPaQHFmu0+EzQDOJNukAuV/BifUgFx9zvaVQKcKCU5VPy/B8X9zm5jH96S+qYtXEh3
         cgQC/5HxlpTfqgGhkoMPxu2aLEcaH4vMWQXNnCZOzP9XCxm5MbmQTvFvuOm1vi+iADzK
         vq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=3LssHOE/Oury1eeMm4IERwmG+jDb5y0kKJUZZsWUWU4=;
        b=MGbfCS+u+QnjYsluywxITFZ+iB/a5DX1fq+hsgH4xPnkwAAa/bbMiVJJdwA985tBr8
         Mbjd6OK9xFDv7GayeogxPOAvFEYw5/k5DsMhCg15jEhY4Gx7dCwM3s8koMRMSq34ZxTb
         kdg3Z6BM8TLGIKwiq7g/BPIBbY9/CLObxyCNGEQjt5dPnPR5TIVSqMaozzGQPOT1sfP7
         tPKLEWWbtvqIMJZVbjjpg3uVre/jA2pmwv5heJA8mN/YR0khsa5Ivv2WZkJltWnMmzo1
         obgRBWuKE39LVET2VyJ45+5UD/6xokaWKMmGhE2HIUnFk1nQU0yAv9BYMZqE3SgEL306
         pqOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Fri, 20 Apr 2018 08:20:21 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180420062021.GA2253@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419163734.GB3905@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598245015813437898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 06:37:34PM +0200, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 03:46:27PM +0200, Vitezslav Samel wrote:
> > ------------------------------------------------------------
> > microcode: __reload_late: CPU0
> > microcode: __reload_late: CPU3
> > microcode: __reload_late: CPU2
> > microcode: __reload_late: CPU1
> > microcode: __reload_late: CPU0 reloading
> > microcode: __reload_late: CPU2 reloading
> > microcode: __reload_late: CPU1 reloading
> > microcode: __reload_late: CPU3 reloading
> > microcode: find_patch: CPU2, NADA
> 
> Ok, I think I have it. Please run the patch below, it still has the
> debugging output so please paste it here once you've done the exact same
> exercise.
> 
> It should not explode this time! (Famous last words :-))

  ;-)  This time it works.

(Ashok: all test were against stable 4.16.3)

------------------------------------------------------
microcode: __reload_late: CPU1
microcode: __reload_late: CPU0
microcode: __reload_late: CPU2
microcode: __reload_late: CPU3
microcode: __reload_late: CPU1 reloading
microcode: __reload_late: CPU0 reloading
microcode: __reload_late: CPU3 reloading
microcode: __reload_late: CPU2 reloading
microcode: find_patch: CPU0, phdr: 0x24, uci: 0x1c
microcode: find_patch: CPU0, find_matching_signature: sig: 0x306c3, pf: 0x2
microcode: find_patch: CPU0, found phdr: 0x24
microcode: updated to revision 0x24, date = 2018-01-21
microcode: __reload_late: CPU0 waiting to exit
microcode: find_patch: CPU3, phdr: 0x24, uci: 0x1c
microcode: find_patch: CPU3, find_matching_signature: sig: 0x306c3, pf: 0x2
microcode: find_patch: CPU3, found phdr: 0x24
microcode: __reload_late: CPU3 waiting to exit
microcode: find_patch: CPU2, phdr: 0x24, uci: 0x1c
microcode: find_patch: CPU2, find_matching_signature: sig: 0x306c3, pf: 0x2
microcode: find_patch: CPU2, found phdr: 0x24
microcode: __reload_late: CPU2 waiting to exit
microcode: find_patch: CPU1, phdr: 0x24, uci: 0x1c
microcode: find_patch: CPU1, find_matching_signature: sig: 0x306c3, pf: 0x2
microcode: find_patch: CPU1, found phdr: 0x24
microcode: __reload_late: CPU1 waiting to exit
x86/CPU: CPU features have changed after loading microcode, but might not take effect.
x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
------------------------------------------------------

	Thank you very much,

		Vita


> Thx!
> 
> ---
>  arch/x86/kernel/cpu/microcode/core.c  | 11 +++++++----
>  arch/x86/kernel/cpu/microcode/intel.c | 17 ++++++++++++++---
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 10c4fc2c91f8..e84877b0f7d7 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -553,6 +553,8 @@ static int __reload_late(void *info)
>  	enum ucode_state err;
>  	int ret = 0;
>  
> +	pr_info("%s: CPU%d\n", __func__, cpu);
> +
>  	/*
>  	 * Wait for all CPUs to arrive. A load will not be attempted unless all
>  	 * CPUs show up.
> @@ -560,20 +562,21 @@ static int __reload_late(void *info)
>  	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
>  		return -1;
>  
> +	pr_info("%s: CPU%d reloading\n", __func__, cpu);
> +
>  	spin_lock(&update_lock);
>  	apply_microcode_local(&err);
>  	spin_unlock(&update_lock);
>  
> +	/* siblings return UCODE_OK because their engine got updated already */
>  	if (err > UCODE_NFOUND) {
>  		pr_warn("Error reloading microcode on CPU %d\n", cpu);
> -		return -1;
> -	/* siblings return UCODE_OK because their engine got updated already */
>  	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
>  		ret = 1;
> -	} else {
> -		return ret;
>  	}
>  
> +	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
> +
>  	/*
>  	 * Increase the wait timeout to a safe value here since we're
>  	 * serializing the microcode update and that could take a while on a
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 32b8e5724f96..725e0bb6df03 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -485,7 +485,6 @@ static void show_saved_mc(void)
>   */
>  static void save_mc_for_early(u8 *mc, unsigned int size)
>  {
> -#ifdef CONFIG_HOTPLUG_CPU
>  	/* Synchronization during CPU hotplug. */
>  	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
>  
> @@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
>  	show_saved_mc();
>  
>  	mutex_unlock(&x86_cpu_microcode_mutex);
> -#endif
>  }
>  
>  static bool load_builtin_intel_microcode(struct cpio_data *cp)
> @@ -727,21 +725,32 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
>  {
>  	struct microcode_header_intel *phdr;
>  	struct ucode_patch *iter, *tmp;
> +	int cpu = smp_processor_id();
>  
>  	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
>  
>  		phdr = (struct microcode_header_intel *)iter->data;
>  
> +		pr_info("%s: CPU%d, phdr: 0x%x, uci: 0x%x\n",
> +			__func__, cpu, phdr->rev, uci->cpu_sig.rev);
> +
>  		if (phdr->rev <= uci->cpu_sig.rev)
>  			continue;
>  
> +		pr_info("%s: CPU%d, find_matching_signature: sig: 0x%x, pf: 0x%x\n",
> +			__func__, cpu, uci->cpu_sig.sig, uci->cpu_sig.pf);
> +
>  		if (!find_matching_signature(phdr,
>  					     uci->cpu_sig.sig,
>  					     uci->cpu_sig.pf))
>  			continue;
>  
> +
> +		pr_info("%s: CPU%d, found phdr: 0x%x\n", __func__, cpu, phdr->rev);
>  		return iter->data;
>  	}
> +
> +	pr_info("%s: CPU%d, NADA\n", __func__, cpu);
>  	return NULL;
>  }
>  
> @@ -805,8 +814,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  	mc = find_patch(uci);
>  	if (!mc) {
>  		mc = uci->mc;
> -		if (!mc)
> +		if (!mc) {
> +			pr_info("%s: CPU%d, NFOUND\n", __func__, cpu);
>  			return UCODE_NFOUND;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.13.0
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
