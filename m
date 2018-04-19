Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx4/j1iXKCi1uE5dGU5XpENa0HsFzw/MtWSYcnUQ9oM272o60EDiITEG0JpkEDAg2kohwmLUI
ARC-Seal: i=1; a=rsa-sha256; t=1524139360; cv=none;
        d=google.com; s=arc-20160816;
        b=c24VvD1ej66qPBEZHv7upundG7juAgnycQaw7wJ04kVw8p7UIasRWQNgpirav1Md40
         sRnPsX4Lkn7j96+ZIlXtEat8pTy8P7ldq845+2rz3jIMhIcEvymBBcbTifG1qZf8LvhV
         Xvq0vjHwMD0bZsjht44xXUiOY4iYaKBbh1K0aiLz8ZXF1SPGMW+8/ZRprP9lM5+Ejigm
         GWPaq32HMHj4jl5KE+mESXc48Nfhu4SnWY0pYsLoSVOkQ/vxkZbNFpr6rYbPiofH55sH
         mkx2mXReIq81Eui2yC+x7ZKu+q7/QQMY0GJfNIXAKbq0TrJ8LZhpgeihi+7ftjOUqJ6Q
         +IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nJO5+DAQDv7LoK6Sg0xE7FzQY+qU1wUeQ20RfKQFK5Y=;
        b=ySoPelO3JgdaM+2INuQVORv1ssrlaEQcPX3GzIihS4a9SNs/COzc/Wwq0A46+eWqRm
         0AOoC7Q9ZtY0Whz7xmT5lzIW8B1XGO5I/jydLJdTbgv3y7xf6xSdJl7nXTT7OrbNGPad
         MJ7dPIpjWLONzOKRKGUtYuWA1KQAo/XUom9PxldlFB+bQR5FVE0Xw1rdU3Q0GQgPGrfC
         HBuTzK/vv9winknVEKP8f8cFo4Lzvhe+CxM5wg0j70IFWdf5qnNU8irwXaCkNSywa7Nt
         oLNctU1L03p54tb4XUbaXfcRUOy3qL2mIKFRIoyOVIqTFAzoiWs0GjJ9CwWoNuXQLd7t
         6slA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Thu, 19 Apr 2018 14:02:39 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419120239.GA2377@pc11.op.pod.cz>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419104829.GE3896@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598175954047813306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 12:48:29PM +0200, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 07:35:31AM +0200, Vitezslav Samel wrote:
> > > - Can you remove your builtin microcode, 
> > > - rename the /lib/firmware/intel-ucode so we don't find it during late loading. 
> > > - let the system boot completely
> > > - then rename the intel-ucode back for this test.
> > > - write 1 to reload and see if that update succeeds or fails?
> > 
> >   Just tested, it fails.
> 
> Can you apply the below patch, do the exact same exercise and catch the
> output? Over serial console or netconsole or if nothing else, do a video
> of the screen with a phone and upload it somewhere?

  Here it is:
-------------------------------------------------------------
microcode: __reload_late: CPU1
microcode: __reload_late: CPU3
microcode: __reload_late: CPU2
microcode: __reload_late: CPU0
microcode: __reload_late: CPU1 reloading
microcode: __reload_late: CPU3 reloading
microcode: __reload_late: CPU2 reloading
microcode: __reload_late: CPU0 reloading
microcode: __reload_late: CPU3 returning 0x0
microcode: __reload_late: CPU2 returning 0x0
microcode: updated to revision 0x24, date = 2018-01-21
microcode: __reload_late: CPU0 waiting to exit
microcode: __reload_late: CPU1 returning 0x0
microcode: Timeout while waiting for CPUs rendezvous, remaining: 3
Kernel panic - not syncing: Timeout during microcode update!

CPU: 0 PID: 11 Comm: migration/0 Not tainted 4.16.3+ #1
Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 2.2 02/05/2015
Call Trace:
 dump_stack+0x46/0x65
 panic+0xca/0x208
 __reload_late+0x11e/0x120
 multi_cpu_stop+0x55/0xa0
 ? cpu_stop_queue_work+0x80/0x80
 cpu_stopper_thread+0x7d/0x100
 ? sort_range+0x20/0x20
 smpboot_thread_fn+0x11f/0x1e0
 kthread+0x101/0x120
 ? __kthread_create_on_node+0x150/0x150
 ? __kthread_create_on_node+0xf0/0x150
 ret_from_fork+0x35/0x40
Shutting down cpus with NMI
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Timeout during microcode update!
-------------------------------------------------------------

	Vita

> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 10c4fc2c91f8..374ec1d75d89 100644
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
> +		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, ret);
>  		return ret;
>  	}
>  
> +	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
> +
>  	/*
>  	 * Increase the wait timeout to a safe value here since we're
>  	 * serializing the microcode update and that could take a while on a
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
