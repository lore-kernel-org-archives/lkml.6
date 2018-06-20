Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C996C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A4E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qchXu39w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A4E20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFTUe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:34:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44482 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeFTUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:34:55 -0400
Received: by mail-pg0-f67.google.com with SMTP id g26-v6so329091pgn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aFtqx6mZlZHx0uA8dGUNzo2UtOCmwN5c3dvMqBnp/+k=;
        b=qchXu39wFaRbUManzjYxr0MjMSn0GI1d6mW53ky3agnvFv99e5Xl2h9UJvz9nM6Drf
         U6/eEy9MyS1qNDnLsqn8pz2GJdl3eT48xnPk+H60UIz9GC/nuERPEAeDzWbs3HgGCazG
         cMo7u+LiWU0urrq67ReCXpc65DqEmpdvuZe1vMYW9aaIdYaR74BWMFTG9nXBPYkCQnA0
         dWWdK01rtNFBu4fBOw7fDFtb5e05EV/RMQiHALXUqZzQYfziR4p5UAOZ1Q0oUSEeWS+f
         Q1n1tJjxQGNPTc8i341rZUx09tSJ2gxpfAGhOtc5tvM0tGeUUnk94tkaYMMeq5poY9C4
         KFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aFtqx6mZlZHx0uA8dGUNzo2UtOCmwN5c3dvMqBnp/+k=;
        b=ZgfFRHgEizKx0mHYW0TUNzYwAptSxXK5LLUPXOOLo9WHF4R/J917zEfT9xvqI6/suQ
         EB3Die3k1CqqHDHp6ySJhM0OQxsLUzXp1PpqwfrNkMsJkTgB6P703uZWnXsOuJttOw6U
         +CqqayJsoJXikQa8LpBXEaLc6yIPvc7RDLsXKTZ18d30IulW/83+TvkWGud+LzzjCFt1
         jCRsqoIHxkcOVP3134Qp2FVj4w14sMW1FBSrXp71kgigPUX/aFAeZRx5VO9DX/q36lI0
         iPyh5a7ntBzpz3SL4hAGMDdUljXp1uVPwHGRKtfUnDr/zJzo6NQtRH4JIVbXQjsPyjo1
         SjQA==
X-Gm-Message-State: APt69E3HHvwWBTDhvscbu7B4J2/UkYLDYhFlWHVKrReDpsDkfS/a/T71
        YGfEUJHeYvCQXR3XidHajS2rsA==
X-Google-Smtp-Source: ADUXVKIUClM2TPe6X8x0oq1+fozYz3xdzvFM4BwrfyZ6KwxB+tiymdGLatxuyorTqaqoVvlv5Kd2pQ==
X-Received: by 2002:a63:79c5:: with SMTP id u188-v6mr19925502pgc.111.1529526894314;
        Wed, 20 Jun 2018 13:34:54 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e1-v6sm3914803pgt.71.2018.06.20.13.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 13:34:53 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:34:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180620130311.GM13685@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com> <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com> <20180615065541.GA24039@dhcp22.suse.cz> <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz> <20180620130311.GM13685@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Michal Hocko wrote:

> On Tue 19-06-18 10:33:16, Michal Hocko wrote:
> [...]
> > As I've said, if you are not willing to work on a proper solution, I
> > will, but my nack holds for this patch until we see no other way around
> > existing and real world problems.
> 
> OK, so I gave it a quick try and it doesn't look all that bad to me.
> This is only for blockable mmu notifiers.  I didn't really try to
> address all the problems down the road - I mean some of the blocking
> notifiers can check the range in their interval tree without blocking
> locks. It is quite probable that only few ranges will be of interest,
> right?
> 
> So this is only to give an idea about the change. It probably even
> doesn't compile. Does that sound sane?

It depends on how invasive we want to make this, it should result in more 
memory being freeable if the invalidate callbacks can guarantee that they 
won't block.  I think it's much more invasive than the proposed patch, 
however.

For the same reason as the mm->mmap_sem backoff, however, this should 
retry for a longer period of time than HZ.  If we can't grab mm->mmap_sem 
the first five times with the trylock because of writer queueing, for 
example, then we only have five attempts for each blockable mmu notifier 
invalidate callback, and any of the numerous locks it can take to declare 
it will not block.

Note that this doesn't solve the issue with setting MMF_OOM_SKIP too early 
on processes with mm->mmap_sem contention or now invalidate callbacks that 
will block; the decision that the mm cannot be reaped should come much 
later.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6bcecc325e7e..ac08f5d711be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
>  	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
>  }
>  
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end)
> +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end,
> +		bool blockable)
>  {
>  	unsigned long apic_address;
>  
> @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
>  	if (start <= apic_address && apic_address < end)
>  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> +
> +	return 0;
>  }
>  
>  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)

Auditing the first change in the patch, this is incorrect because 
kvm_make_all_cpus_request() for KVM_REQ_APIC_PAGE_RELOAD can block in 
kvm_kick_many_cpus() and that is after kvm_make_request() has been done.
