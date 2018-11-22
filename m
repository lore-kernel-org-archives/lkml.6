Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF81AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A37C20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2VfsaLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbeKVSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:04:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39702 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbeKVSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:04:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so194945wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLE5UwajChPAHaQK1nrBaSAKZvzXm0mq+ohFJvBp+nM=;
        b=Z2VfsaLbvgZ7+/+TyCzLYNtPkbI6hhqzVVKHC3+dGTh/ozUGirt/xioRcrdYXCpTHn
         kmHmR4hbXCc66SuSbKvGJfrbIdYmzVkSodRS6LgqZA38qAA8OOKVI16P/WmYdmiQJVrm
         Yn0Lilupzsd3bOpjpvpZLPvYobAPnO5wpLIOjLuv5vZns7cyV53tH6OCbYj8lCh1AhNn
         pxcXcl/5fM2aKMdOp86f1682pG2eqzjjFrj1Jwsqgs2jb7YsetxFG3DirlioHRDwO4J2
         K47TU1RyQDaCF7CtWIExnfOoBau+fc3MrvO9he8VQCyGIVW6iSi/t3fa18BSm1kklt6h
         /XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLE5UwajChPAHaQK1nrBaSAKZvzXm0mq+ohFJvBp+nM=;
        b=jbqpatMhPgVkrEcAERY8QAxmZA9rGsEldv9swrpkiWKfOhToGD+klqa+zZegZq8P8A
         Brl7PdmaRgb+YABFOXWN8nsKt/6zakUCb4oAXBq7H0Y6tSG2Ga2a3cxglX05VpX/eO56
         GfxdC54noN14cNvnpVjc4gL3gNJGlmX2Iw3817E7PqidAdFLdvx+g0I9CuNRtrpXZikw
         O/DsL9n4/b1gurN/M0jusUa4Q01zVMKVLygxpQEzOYGMclZei/8XvNY3XuKeJ42p3U1C
         6XZGDWUhDAqe3dqRGh10hlf3dWZiqzgVrlbAHWyGw/Q7uL5dkLNghPOfjrw4rEFf6cOG
         d2GQ==
X-Gm-Message-State: AA+aEWaHu1YbVPp/gww2bigNWmwuuONfZ+J5gS26NH75+F4oztmIu5U9
        OYKAfnhGvqHidhgPSCcyiHw=
X-Google-Smtp-Source: AFSGD/VtCx5LPWd4nCPZtJApXqwFTrPA5+UQgg8GkFRU8cZzUbxr2ZA1mPVe6cID49RgusZ1dUr1Kg==
X-Received: by 2002:adf:fc89:: with SMTP id g9mr8249915wrr.96.1542871582410;
        Wed, 21 Nov 2018 23:26:22 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t5sm4813523wmd.15.2018.11.21.23.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:26:21 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:26:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 24/24] x86/speculation: Add seccomp Spectre v2 app to app
 protection mode
Message-ID: <20181122072619.GC41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.602740969@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.602740969@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> If 'prctl' mode of app2app protection from spectre v2 is selected on the
> kernel command-line, STIBP and IBPB are applied on tasks which restrict
> their indirect branch speculation via prctl.
> 
> SECCOMP enables the SSBD mitigation for sandboxed tasks already, so it
> makes sense to prevent spectre v2 application to application attacks as
> well.
> 
> The mitigation guide documents how STIPB works:
>     
>    Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
>    prevents the predicted targets of indirect branches on any logical
>    processor of that core from being controlled by software that executes
>    (or executed previously) on another logical processor of the same core.
>     
> Ergo setting STIBP protects the task itself from being attacked from a task
> running on a different hyper-thread and protects the tasks running on
> different hyper-threads from being attacked.
>     
> IBPB is issued when the task switches out, so malicious sandbox code cannot
> mistrain the branch predictor for the next user space task on the same
> logical processor.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    7 +++++-
>  arch/x86/include/asm/nospec-branch.h            |    1 
>  arch/x86/kernel/cpu/bugs.c                      |   27 +++++++++++++++++++-----
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4228,10 +4228,15 @@
>  				  by spectre_v2=off
>  			auto    - Kernel selects the mitigation depending on
>  				  the available CPU features and vulnerability.
> -				  Default is prctl.
>  			prctl   - Indirect branch speculation is enabled, but
>  				  mitigation can be enabled via prctl per thread.
>  				  The mitigation control state is inherited on fork.
> +			seccomp - Same as "prctl" above, but all seccomp threads
> +				  will enable the mitigation unless they explicitly
> +				  opt out.
> +
> +			Default mitigation:
> +			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
>  
>  			Not specifying this option is equivalent to
>  			spectre_v2_app2app=auto.
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -233,6 +233,7 @@ enum spectre_v2_app2app_mitigation {
>  	SPECTRE_V2_APP2APP_NONE,
>  	SPECTRE_V2_APP2APP_STRICT,
>  	SPECTRE_V2_APP2APP_PRCTL,
> +	SPECTRE_V2_APP2APP_SECCOMP,
>  };
>  
>  /* The Speculative Store Bypass disable variants */
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -256,12 +256,14 @@ enum spectre_v2_app2app_cmd {
>  	SPECTRE_V2_APP2APP_CMD_AUTO,
>  	SPECTRE_V2_APP2APP_CMD_FORCE,
>  	SPECTRE_V2_APP2APP_CMD_PRCTL,
> +	SPECTRE_V2_APP2APP_CMD_SECCOMP,
>  };
>  
>  static const char *spectre_v2_app2app_strings[] = {
>  	[SPECTRE_V2_APP2APP_NONE]	= "App-App Vulnerable",
> -	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: STIBP protection",
> -	[SPECTRE_V2_APP2APP_PRCTL]	= "App-App Mitigation: STIBP via prctl",
> +	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: forced protection",
> +	[SPECTRE_V2_APP2APP_PRCTL]	= "App-App Mitigation: prctl opt-in",
> +	[SPECTRE_V2_APP2APP_SECCOMP]	= "App-App Mitigation: seccomp and prctl opt-in",

This description is not accurate: it's not a 'seccomp and prctl opt-in', 
the seccomp functionality is opt-out, the prctl is opt-in.

So something like:

> +	[SPECTRE_V2_APP2APP_SECCOMP]	= "App-App Mitigation: seccomp by default and prctl opt-in",

or so?

>  void arch_seccomp_spec_mitigate(struct task_struct *task)
>  {
>  	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
>  		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
> +	if (spectre_v2_app2app == SPECTRE_V2_APP2APP_SECCOMP)
> +		indir_branch_prctl_set(task, PR_SPEC_FORCE_DISABLE);
>  }
>  #endif

Hm, so isn't arch_seccomp_spec_mitigate() called right before untrusted 
seccomp code is executed? So why are we disabling the mitigation here?

> +	case SPECTRE_V2_APP2APP_SECCOMP:
> +		return ", STIBP: seccomp and prctl opt-in";
> +	case SPECTRE_V2_APP2APP_SECCOMP:
> +		return ", IBPB: seccomp and prctl opt-in";

Same feedback wrt. potentially confusing use of 'opt-in' here, while 
seccomp is more like an opt-out mechanism.

Thanks,

	Ingo
