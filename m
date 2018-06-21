Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794C421C66
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMJYgyDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794C421C66
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeFUUu5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:50:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44423 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeFUUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:50:56 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so2287118plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MT/4jSlCXNBkWzNStXSryJrC2bf9fR3cmEv9RTBBxmI=;
        b=TMJYgyDNZugso9pQ5RPWt2nhXtOHQO5yHDQZ3mDt8RBNv4KqnbSG+ZSrqvtH7zL9MY
         EqFEan2p01CsHtDrW3xJXlklp+27bFfF4DC+CDHfZ2KWiWBouq+/GLME7ZMtbmqGqA4M
         s2gfG4ZSeMc35YhHxJ2X6dZV1QWsw5etbDAK05TYCNbi5nusid4FdWRrvgbpUH5vb9kc
         2GmT08Tcm/823lffoUwgT6p9X0W2J1DF6zbAV4CqVBHGPLGtiMCvRZd35OKQIsf+UeWB
         SS6pzLj/YsnBfFmm3kxnSlS/UoorB1xKRQn3Qz3vjf1zSxTDUY5RJLeJ6liOX53KMXXZ
         OADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MT/4jSlCXNBkWzNStXSryJrC2bf9fR3cmEv9RTBBxmI=;
        b=X73WxWte6wr/JyNDGH9uHI8Zr0EMFwpQle3oUjbNxa8rHsDepPNz/l2u79yL75VdbM
         TLDc/oSiRLaml10U1ur738kt7ILz8zRMro5P/gDtXW3Oi6NbTm9ADa0YetsSxbg/NTDD
         HXdoQunVj8zMLkHtttYyYOnJJtU1N6nNveq/543GlaSR+uQ3L+y9vJrUDdkrt9dvNHqE
         4ZnorrCX1gIvo/tA1/wPB3c7FKu4CEI5irogUcgNQ92DUa7CIb3aVs0qWFEA24KqZjdT
         /jz/EGPsSKzQVca2TSiVDs1uZC8SEv8+9gTuubM6maCVS4MLH0mXd2u0B54zhHvOfkL+
         6y9Q==
X-Gm-Message-State: APt69E0U3tA5X6BM/9agGNs7BF1NPHCVak/1+EkePiqGJg+XtfkPz0/s
        bchXCe72S59QDjfYhtPb3kG6LA==
X-Google-Smtp-Source: ADUXVKKTunhif7p5WZpo9HD77+ad8Sw43/OFHzUmWz/+Nw26g5DB5bpzuNocuiEAYX4n4KyDLHtZvg==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2-v6mr29508604plb.119.1529614255134;
        Thu, 21 Jun 2018 13:50:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g78-v6sm10481809pfe.39.2018.06.21.13.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:50:54 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:50:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180621074537.GC10465@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1806211347050.213939@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com> <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com> <20180615065541.GA24039@dhcp22.suse.cz> <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz> <20180620130311.GM13685@dhcp22.suse.cz> <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com> <20180621074537.GC10465@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Michal Hocko wrote:

> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 6bcecc325e7e..ac08f5d711be 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
> > >  	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
> > >  }
> > >  
> > > -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > -		unsigned long start, unsigned long end)
> > > +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > > +		unsigned long start, unsigned long end,
> > > +		bool blockable)
> > >  {
> > >  	unsigned long apic_address;
> > >  
> > > @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> > >  	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
> > >  	if (start <= apic_address && apic_address < end)
> > >  		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> > > +
> > > +	return 0;
> > >  }
> > >  
> > >  void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> > 
> > Auditing the first change in the patch, this is incorrect because 
> > kvm_make_all_cpus_request() for KVM_REQ_APIC_PAGE_RELOAD can block in 
> > kvm_kick_many_cpus() and that is after kvm_make_request() has been done.
> 
> I would have to check the code closer. But doesn't
> kvm_make_all_cpus_request call get_cpu which is preempt_disable? I
> definitely plan to talk to respective maintainers about these changes of
> course.
> 

preempt_disable() is required because it calls kvm_kick_many_cpus() with 
wait == true because KVM_REQ_APIC_PAGE_RELOAD sets KVM_REQUEST_WAIT and 
thus the smp_call_function_many() is going to block until all cpus can run 
ack_flush().
