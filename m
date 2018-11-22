Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1960EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512A20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muNICdwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392527AbeKVR4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:56:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKVR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:56:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so8128702wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3qYC51YhnpmHOqLOA2J95UxKH8LtgFZepxiiMNW+gs=;
        b=muNICdwHpuxGPX8ysU45AbNeD0L7tk0kQ/Btnl1EToxPrhUUyBsUMkWqN88IWT5Yuz
         urHyyN8oUrBintIAquZCUCIp1CqRUh+XsccQYIULsg4cSUz6C5R6/E7QaJQ7C7PXj7Oh
         YPcMHyBBcI1X8nAXvmVu6mzjAImABeHxpGc9+Gzfc1Fmlgwp8a5q+39m0oBUhsvHPLDq
         ajk1lqkjupBmhRJdYLm5Q97XD7yZ58DsG5XGFgrS3j+z5nzCZiWDMBdgM7Hz/QqPdr65
         6x5DjFbf1Iefv4zSb1fAsrdRMcWZVxcgjRf7I3rxUkv+mX5Oaj6qexzhM5EIfpZc46dv
         KsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3qYC51YhnpmHOqLOA2J95UxKH8LtgFZepxiiMNW+gs=;
        b=bHF3lCiLS1ixZBLJ7i4MvAL1YT0+i2LD4WfyW8Fp7SbAPM/nRFgLbeGTa2NmBur4ut
         Ki0o3ak07133yiUUiteBZ+0z+YPR44pIyFtgUyfYDSX5PW4QG3pwZGMrWIuTzww2dykl
         voe8fKL7VYwVZsOk68NrUt9tzzFs7anctKTgEDnfHwzLVQ7+cL7k7I3jO87F9u/wO1O+
         qtRKamw9X89qN2KQEgRckbD+VZje5RrLbrNJIvyYjPkpe18c1u41J4xWO2xn5EC+B5E1
         H8kGeRSo+QtevGOD+MRPGxXNVrCdS4xNU8o2tURJWlcF6O/UQUfDmu8C2TpENeMl4anq
         eFyQ==
X-Gm-Message-State: AA+aEWaURXTqasamz5UTqg9xryU5SM2+qwhuk8zvUIh3g5N3yH4cyx/t
        keVs3kphIu8ogwSNnICGEmc=
X-Google-Smtp-Source: AFSGD/WOQ4f9astl9/ICRXVBSWD1ot4/5dgw6vWixB+x2BuUwDyz6efPyI9gyGPXBeWlasRBzCWeLA==
X-Received: by 2002:adf:ae1a:: with SMTP id x26-v6mr8525128wrc.189.1542871079151;
        Wed, 21 Nov 2018 23:17:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i9sm19651461wrs.34.2018.11.21.23.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:17:58 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:17:55 +0100
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
Subject: Re: [patch 23/24] x86/speculation: Enable PRCTL mode for
 spectre_v2_app2app
Message-ID: <20181122071755.GB41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.508280006@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.508280006@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Now that all prerequisites are in place:
> 
>  - Add the prctl command line option
> 
>  - Default the 'auto' mode to 'prctl'
> 
>  - When SMT state changes, update the static key which controls the
>    conditional STIBP evaluation on context switch.
> 
>  - At init update the static key which controls the conditional IBPB
>    evaluation on context switch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    5 ++
>  arch/x86/kernel/cpu/bugs.c                      |   46 +++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 6 deletions(-)
> 
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4246,7 +4246,10 @@
>  				  by spectre_v2=off
>  			auto    - Kernel selects the mitigation depending on
>  				  the available CPU features and vulnerability.
> -				  Default is off.
> +				  Default is prctl.
> +			prctl   - Indirect branch speculation is enabled, but
> +				  mitigation can be enabled via prctl per thread.
> +				  The mitigation control state is inherited on fork.

Please change the order of the last two entries, i.e. make 'auto' the 
last one. This is the pattern we use in other places plus we refer to 
'prctl' before we document it.

>  static const struct {
> @@ -270,6 +272,7 @@ static const struct {
>  	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,	false },
>  	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,	false },
>  	{ "on",		SPECTRE_V2_APP2APP_CMD_FORCE,	true  },
> +	{ "prctl",	SPECTRE_V2_APP2APP_CMD_PRCTL,	false },

Might make sense to order them in a consistent fashion as well.

> +	/*
> +	 * If STIBP is not available or SMT is not possible clear the STIPB
> +	 * mode.
> +	 */
> +	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
> +		mode = SPECTRE_V2_APP2APP_NONE;

Another nit: please match order of the comments to how the condition is 
written in the code.

> +/* Update the static key controlling the evaluation of TIF_SPEC_IB */
> +static void update_indir_branch_cond(void)
> +{
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return;
> +
> +	if (sched_smt_active())
> +		static_branch_enable(&switch_to_cond_stibp);
> +	else
> +		static_branch_disable(&switch_to_cond_stibp);

So in the !SMP case sched_smt_active() is already doing the right thing:

  static inline bool sched_smt_active(void) { return false; }

I.e. couldn't we just remove the extra CONFIG_SMP condition?
This would simplify the code with some very minor expense on !SMP.

Thanks,

	Ingo
