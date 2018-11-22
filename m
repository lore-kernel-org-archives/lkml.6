Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5CC20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWh1jPnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5CC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392604AbeKVSNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:13:04 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35479 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKVSNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:13:04 -0500
Received: by mail-wr1-f50.google.com with SMTP id 96so8189562wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eItnZ1lUUpJdERwvZDD01p1y1Tg+xHjwjab7bAIW87w=;
        b=uWh1jPntKXUZnjtr0SKxeECTKh1K2SmUOLPnUZrTOYFwCGkYYH+wpUF8CmqCEb4e0Q
         M88KqvnMCHrzpXusS0qMWm8DLl8/PT5cuKwGnQ+4uKlTqCg24W1+CaKgcPkEoGb+RIOT
         WxKGhpu8hTqOxcPS+lotB9ikiU0DiqZjLf8nzd20fCpG5PUfkUhn0fkJh8Hs1zlOFReT
         w9PkxB2WH6pFbwJKsaxljj+q6U4JgKS5K7FTT+IkuS2K20ib8MQUWsOfTa3W7I1IqbOx
         cj/2NYFfdo28b24ZeMFrEdAR0rnBqX7ItUzM74R1Uv9F7uPuq0LXEG6aC+6pO+5Dhli/
         TnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eItnZ1lUUpJdERwvZDD01p1y1Tg+xHjwjab7bAIW87w=;
        b=qhwqT1jsWWOMv+cFIEA490RAOTRYD5YXSLUuPnbJ5KDDv3Z2V1gxbeyCDNOsMi5CcK
         1RtcUbEXfVqTXq1UmMDpzeDMXjkJ8Ff38QkGY61SQTuEczxTx0hu5TatSyOQ+/c7LqJ2
         R7ylNZxc/XP6rEIc2M/jaXd7QKIWW3uWtuIpnbr0bgiwi5zw5bX1mCgYqqKOl5bQergv
         T1a9OJa/2wSMTHWY6IL453I2n35raNOUUQzjIqoHX32UpJb1pR9t7hg2mB7HvqTNcrn2
         Fg7EaGoPHcfUHmAwHsEy2EUC9/Nu+IyyCXdJHx3Ax8jjdPxENTDDdDsrtSayHf6hV6f5
         4VTQ==
X-Gm-Message-State: AA+aEWYAyKO2QHi30FO94hQZpGWDqZduc+fXUz2XNYjdDrZEPrmotWXi
        3gOxoj7FsCYZwDVuacGeg7s=
X-Google-Smtp-Source: AFSGD/XUkbQ+RNfh4E5A40DqU/P/eKOEaAq5Q5fPXX/w3bP9Jko9jNHHMWhV4NWLKGDDs0F0ywncMw==
X-Received: by 2002:adf:fb47:: with SMTP id c7-v6mr8420423wrs.200.1542872090634;
        Wed, 21 Nov 2018 23:34:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g198sm4622401wmd.23.2018.11.21.23.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:34:50 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:34:47 +0100
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
Subject: Re: [patch 21/24] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
Message-ID: <20181122073447.GD41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.320605317@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.320605317@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The upcoming fine grained per task STIBP control needs to be updated on CPU
> hotplug as well.
> 
> Split out the code which controls the strict mode so the prctl control code
> can be added later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/cpu/bugs.c |   46 ++++++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -531,40 +531,44 @@ static void __init spectre_v2_select_mit
>  	arch_smt_update();
>  }
>  
> -static bool stibp_needed(void)
> +static void update_stibp_msr(void *info)
>  {
> -	/* Enhanced IBRS makes using STIBP unnecessary. */
> -	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> -		return false;
> -
> -	/* Check for strict app2app mitigation mode */
> -	return spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT;
> +	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>  }


Does Sparse or other tooling warn about unused function parameters? If 
yes then it might make sense to mark it __used?

>  
> -static void update_stibp_msr(void *info)
> +/* Update x86_spec_ctrl_base in case SMT state changed. */
> +static void update_stibp_strict(void)
>  {
> -	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +	u64 mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
> +
> +	if (sched_smt_active())
> +		mask |= SPEC_CTRL_STIBP;
> +
> +	if (mask == x86_spec_ctrl_base)
> +		return;
> +
> +	pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
> +		mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
> +	x86_spec_ctrl_base = mask;
> +	on_each_cpu(update_stibp_msr, NULL, 1);
>  }
>  
>  void arch_smt_update(void)
>  {
> -	u64 mask;
> -
> -	if (!stibp_needed())
> +	/* Enhanced IBRS makes using STIBP unnecessary. No update required. */
> +	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
>  		return;
>  
>  	mutex_lock(&spec_ctrl_mutex);
>  
> -	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
> -	if (sched_smt_active())
> -		mask |= SPEC_CTRL_STIBP;
> -
> -	if (mask != x86_spec_ctrl_base) {
> -		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
> -			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
> -		x86_spec_ctrl_base = mask;
> -		on_each_cpu(update_stibp_msr, NULL, 1);
> +	switch (spectre_v2_app2app) {
> +	case SPECTRE_V2_APP2APP_NONE:
> +		break;
> +	case SPECTRE_V2_APP2APP_STRICT:
> +		update_stibp_strict();
> +		break;
>  	}

So I'm wondering, shouldn't firmware_restrict_branch_speculation_start()/_end()
also enable/disable STIBP? It already enabled/disables IBRS.

Thanks,

	Ingo
