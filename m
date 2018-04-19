Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx49gnScEMTyOuJeZhKXfNE2O1AVFakNg2X0MtsZlivug6+RLwn1sjEOzCPCjbB2qx5/9b6mB
ARC-Seal: i=1; a=rsa-sha256; t=1524145589; cv=none;
        d=google.com; s=arc-20160816;
        b=Cm0S2+L4vuNahCrZ7c//fa7STxTQ9PcZ3ogIUEd7suFRgvXstvpwd7YAu4ZDZ07E4K
         658J5I8fhpe1v3o/lqGMunEA4AAc1BOqSgWwmrabUEkl0Bpsy177AHSaxsTez2rep3hJ
         UEoH6/+yPTrEiqRmNNSeHIbWxGy1qUn/0XLa0lvYN/JqrgjPIsFjDjlQfSRMDSL1fSdp
         N6yF+7B52v+bMc7P5FoD8wSgnYGj0P4Oi317A1R9sjxR5NjLtmowjPvEOoE7EQfBLx+u
         9kHDuLYV9jHAOErSDgvrzAgAtnTeixTkO+d2qisc+Lh1u2wTnUYNzcERIKe9YI8YxsUC
         2NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=w6J6Ze6BlE3IN4B9qZMUC50Fj73dGLz5HF/mNRzY+Bg=;
        b=WdldR/kwJZfptyhZ6tf3tTC5eXbPmatmbr3ImY3ZN5mgqF1avaQUcQgKl6y+/ovMBC
         lVINlsUdP+V1ULQ0ujtkQGZrAMqbAfLBE+AEIi9ihDjfq8Tq1LLy0YesYvNalNo8GiW1
         c/Y52Ji05ytPB5B0hvvinDoF/dYnJUFk1wS6TZ5cPaTk0jKmGkKDRB8GXMawNmj7TdS6
         I2zdHgnu/cBLwF6i24j54N071T1ZdQFMmsSJdTM7hNDTzA6CN7lx6r/+ECa9KT+o/4Al
         oRofZJSwAFEYYeh1Eme+6nVcx90Av1LGhse7A6NdXg/E3gAwY78RvfxsuC/NrkpnYEyI
         trEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Thu, 19 Apr 2018 15:46:27 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419134627.GA2387@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419121840.GF3896@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598182485753806076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:18:41PM +0200, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 02:02:39PM +0200, Vitezslav Samel wrote:
> >   Here it is:
> 
> Thanks!
> 
> > -------------------------------------------------------------
> > microcode: __reload_late: CPU1
> > microcode: __reload_late: CPU3
> > microcode: __reload_late: CPU2
> > microcode: __reload_late: CPU0
> > microcode: __reload_late: CPU1 reloading
> > microcode: __reload_late: CPU3 reloading
> > microcode: __reload_late: CPU2 reloading
> > microcode: __reload_late: CPU0 reloading
> > microcode: __reload_late: CPU3 returning 0x0
> 
> Aaaha, there it is.
> 
> Ok, debug patch v2, please do the same.

  Here it is:

------------------------------------------------------------
microcode: __reload_late: CPU0
microcode: __reload_late: CPU3
microcode: __reload_late: CPU2
microcode: __reload_late: CPU1
microcode: __reload_late: CPU0 reloading
microcode: __reload_late: CPU2 reloading
microcode: __reload_late: CPU1 reloading
microcode: __reload_late: CPU3 reloading
microcode: find_patch: CPU2, NADA
microcode: apply_microcode_intel: CPU2, NFOUND
microcode: __reload_late: CPU2 returning 0x3
microcode: find_patch: CPU1, NADA
microcode: apply_microcode_intel: CPU1, NFOUND
microcode: __reload_late: CPU1 returning 0x3
microcode: find_patch: CPU3, NADA
microcode: apply_microcode_intel: CPU3, NFOUND
microcode: __reload_late: CPU3 returning 0x3
microcode: find_patch: CPU0, NADA
microcode: updated to revision 0x24, date = 2018-01-21
microcode: __reload_late: CPU0 waiting to exit
microcode: Timeout while waiting for CPUs rendezvous, remaining: 3
Kernel panic - not syncing: Timeout during microcode update!

CPU: 0 PID: 11 Comm: migration/0 Not tainted 4.16.3 #1
Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 2.2 02/05/2015
Call Trace:
 dump_stack+0x46/0x65
 panic+0xca/0x208
 __reload_late+0x122/0x130
 multi_cpu_stop+0x55/0xa0
 ? cpu_stop_queue_work+0x80/0x80
 cpu_stopper_thread+0x7d/0x100
 ? sort_range+0x20/0x20
 smpboot_thread_fn+0x11f/0x1e0
 kthread+0x101/0x120
 ? __kthread_create_on_node+0x150/0x150
 ? __kthread_create_on_node+0x40/0x150
 ret_from_fork+0x35/0x40
Shutting down cpus with NMI
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Timeout during microcode update!
------------------------------------------------------------

	Cheers,

		Vita


> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 10c4fc2c91f8..737f93422d0b 100644
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
> @@ -560,6 +562,8 @@ static int __reload_late(void *info)
>  	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
>  		return -1;
>  
> +	pr_info("%s: CPU%d reloading\n", __func__, cpu);
> +
>  	spin_lock(&update_lock);
>  	apply_microcode_local(&err);
>  	spin_unlock(&update_lock);
> @@ -571,9 +575,12 @@ static int __reload_late(void *info)
>  	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
>  		ret = 1;
>  	} else {
> +		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, err);
>  		return ret;
>  	}
>  
> +	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
> +
>  	/*
>  	 * Increase the wait timeout to a safe value here since we're
>  	 * serializing the microcode update and that could take a while on a
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 32b8e5724f96..ad0a19154c40 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -727,21 +727,32 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
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
> @@ -805,8 +816,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
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
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
