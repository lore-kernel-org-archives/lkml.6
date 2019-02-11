Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03857C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C570721479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549882426;
	bh=wyM7Ud2eMcG7ZSUyWthVs3jM05x3yJfFHQcNnxuxtt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MiKmShcaBzXXEYJadzuxgH/TzAKCfhdV8+lvVO6YtSi+U+9ZCH5oGyEvbYSBIsUIB
	 +iijIt5LoV6e76U7mrghpZb2xz4mHeLx+Vh3qqsmNuxby87X0iU1FfzReDA/XOjjVW
	 p8flvg3OZdMrqD4d1LWCzR7/vKAaWUVB8hWLdqjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:53:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54392 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:53:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so16919965wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1poD11d02an8pBfTQY4/kCj729WUHkAwikO1eCpM7Ys=;
        b=UeOsYY0Qiy1ti9FsqTJ6Ff1sTJz/mose5D4XmBHGxevBkbI0zyQ0qWp8Di74tgM0YF
         4veDr79BODaB4akt2Pe7yOrLOJyT8NENOa0VlIMx/NW+A1AR21mjSYQPo6OCdOz9XIuf
         heb9cuTPa/NGjknI+CsHAMrQn4p7Erjf913nUMNYKr0MB+DoymsRbFgmYFP7MaeE7ArC
         erH1ka7b/YQYdfjgnbvZN4VQeCgHQAJSjL53FZe9vad96q6+t6rm+OjULW1m2IXVlkcD
         s/CDpNSSGxodU4HdzK36s30tcRMYIDZtbYqMBvaz5mw5vakuBPs6va9esdejaWYGAxXs
         8ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1poD11d02an8pBfTQY4/kCj729WUHkAwikO1eCpM7Ys=;
        b=Bo+/62ietWS6+8nOgTuWFZcjyMUqtRIqxRnmBuMjHWo8zi5aDBx2OjyumJN5WfjZkO
         Gm+S0gxyqo9pGt6lii0mQ/AdhlV2f6y3ugOrYRk++o4uiw9LKDB+8deGp6EVACt7Qlz9
         OL0a8Ow2VnSWonJgFjlBibD/ImTN2WP7gpbtVDAGUbhR6Wi75oJQsa34TB9U6UusP3Fz
         g49MqIikNOjgTudnTmqXbigdUoteyvzAMGMUffi+1jphYWuYWVAT6697z9GoS555H2dz
         jNL0uIieLCTqeGJ8tciZenZq6dPIoDCBQ0Az7VH5JoT2EiLKySmb5BLowjTr/dSlLdH4
         s+kg==
X-Gm-Message-State: AHQUAuZhe18k1sM4SdOOKRKYMFGxxH5bfgV/tQxyXOC2SQYcjHw9+vX6
        zVMblwLhAWCeXy23ppiIhdo=
X-Google-Smtp-Source: AHgI3IaiBGRlM4+sz+iol9f5kSk5K9rPVwtbgSpcy/ow4NRX8pxDZv6yMOguSmPXPPCmIBKwGNI9Cg==
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr1231418wrx.275.1549882422166;
        Mon, 11 Feb 2019 02:53:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1sm20894872wrw.90.2019.02.11.02.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 02:53:41 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:53:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20190211105339.GA40840@gmail.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Fenghua Yu <fenghua.yu@intel.com> wrote:

> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -61,6 +61,7 @@
>  #include <asm/mpx.h>
>  #include <asm/vm86.h>
>  #include <asm/umip.h>
> +#include <asm/cpu.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -292,9 +293,36 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
>  DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
>  DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
>  DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
>  #undef IP
>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	unsigned int trapnr = X86_TRAP_AC;
> +	char str[] = "alignment check";
> +	int signr = SIGBUS;
> +	int ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
> +			NOTIFY_STOP) {
> +		/* #AC exception could be handled by split lock handler. */
> +		ret = do_ac_split_lock(regs);
> +		if (ret) {
> +			cond_local_irq_enable(regs);
> +
> +			return;
> +		}
> +
> +		cond_local_irq_enable(regs);
> +		/*
> +		 * If not processed by split lock handler, go to generic
> +		 * #AC handler.
> +		 */
> +		do_trap(trapnr, signr, str, regs, error_code, BUS_ADRALN, NULL);
> +	}
> +}

Is there any experience with how frequently this signal is killing 
user-space processes on a modern distro? Any expectation of how frequent 
such SIGBUS task terminations are going to be in the field?

Thanks,

	Ingo
