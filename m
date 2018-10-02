Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AB52064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzaZWz7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AB52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeJBQR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:17:56 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36091 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeJBQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:17:56 -0400
Received: by mail-wm1-f46.google.com with SMTP id n23-v6so1476534wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xSM6ClC5PkVgF/2uYCHLIvXyWD08igqfDzO73h5yYQ=;
        b=qzaZWz7SjjSaRZblzP9l2l/iZSFoMgWAphEMTQIlqm9MlTeTIP7RB8T4+N1eO2Siz7
         bqx1flGM1dMe3qYU2Caij5Dg4J7RgSuvzH2QKdTNtz4jjo2yHmiQV4GRLp+3IkdX1hZR
         KHAF6KSMmG7kCqsbDIPQkoZc78ZSX76yrk9C5rnYY+XRCXgDI2cVptBzMch5DFrboizE
         64+4DgxBYZOmGrDjnuTC/JQSgsRfa5EmmX7KMYkfq6NoP7UY4gNuA9QpYgp/gMOMGs0J
         uZx72Jv2VipEfLC9Q0n3Jp+FY/nibFs6j6o2XWsepA3bgnawiSmeZ+svgy2nxx1WVP8l
         vXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xSM6ClC5PkVgF/2uYCHLIvXyWD08igqfDzO73h5yYQ=;
        b=T16/xP2BmqzKli2VPRz2v/n97dezlJRpXgPJ6reUGcx8pu82ukYu3wNK5Fpl5KnyPG
         ohRmysOwbYJ68ALpIfLvF239nLgqf9W8QPn+qpYS0hpLhLrJpsifWEa1zObXxqeZMAh+
         3gGodzqjk7XnFDuV4+H+oZTGpOnllefbzgQ3tYtHdrrFAhIACVt91z2p6Fw54r/vM/Ys
         LCM2JW4HCgPNLnRb6AMRpVLYt6g7f2vBhBH6QCa/PxiifwNldHASmsxJWz8czQnHbGhS
         GPYt5L0Aq0ffo+W0HoNSYDWFLBPj+YgVAMk7lvyL0oXIHHy3DV7399MYugdNaj36YDXe
         T7dQ==
X-Gm-Message-State: ABuFfoitYdLuwae5ZDtc4m2dsUKnNpawJnob6XiyIog4s876Nf5aytbW
        L6N9dbWYghGz4CxBLRXUhckGkAWm
X-Google-Smtp-Source: ACcGV615ZxIhe4yDNuzQoT2TKG8Fwoek/I26wcTcNTfBSJOAK42MytNv/60jecXFWrbKYw6VjaquIg==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr1311779wmd.92.1538472933944;
        Tue, 02 Oct 2018 02:35:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e127-v6sm9556930wmg.45.2018.10.02.02.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:35:33 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:35:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v2 4/4] x86/speculation: Add prctl to control indirect
 branch speculation per process
Message-ID: <20181002093530.GC122128@gmail.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
 <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> To migitgate possible app to app attack from branch target buffer poisoning,
> a new prctl is provided to control branch speculation for applications in
> user app.  The following interfaces are provided:

s/migitgate
 /mitigate

> 
> prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
> - Disable branch target speculation to protect against app to app
> style attack using IBPB and STIBP
> 
> prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> - Allow branch target speculation, no mitigation for Spectre V2
> 
> prctl(PR_GET_SPECULATION_CTRL, PR_INDIR_BRANCH, 0, 0, 0)
> - Query the indirect branch speculation restriction on a process

Well 'a process' is always 'the current process' in this case, right?

> -			lite   - only turn on mitigation for non-dumpable processes
> +			lite   - turn on mitigation for non-dumpable processes
> +				 or processes that has indirect branch restricted
> +				 via prctl's PR_SET_SPECULATION_CTRL option

s/or processes that has indirect
 /or processes that have been indirect

?

> +	/*
> +	 * If being set on non-current task, delay setting the CPU
> +	 * mitigation until it is next scheduled.
> +	 * Use speculative_store_bypass_update will update SPEC_CTRL MSR
> +	 */
> +	if (task == current && update)
> +		speculative_store_bypass_update_current();

Did you mean:

	Call to speculative_store_bypass_update_current() will update SPEC_CTRL MSR

?


> -	 * For lite protection mode, we only protect the non-dumpable
> -	 * processes.
> +	 * For lite protection mode, we protect processes  
> +	 * where the user explicitly disable indirect branch
> +	 * speculation or mark the process as non-dumpable. 

s/where the user explicitly disable
 /where the user explicitly disables

?

Thanks,

	Ingo
