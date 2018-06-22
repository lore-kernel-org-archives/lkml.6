Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF54C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496CF24769
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqjTAFy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496CF24769
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934359AbeFVStS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:49:18 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:39639 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeFVStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:49:17 -0400
Received: by mail-pg0-f47.google.com with SMTP id w12-v6so3337688pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BFIXmd+g4ihjCcgYZskwn6CUGTlTH6dJv1Qnkq946qc=;
        b=PqjTAFy92x3CvSsLK13B1bqxnOsDT4s7BEgEhhf178HPWAOMK4v1eIB6wI2N2tQ4jj
         p682eO8K9rhQhru08KMYc/huVIay+6lgd9YMfSt+WjGkot64ICEz81dC1dweve9sp3G7
         kgc+Ta3cR/lYBeSJiBu1F5ue0EwA232exqpVKi90/4K8chKlo3Msa0RdxDEnY4gSm7Fo
         aVRu8iPE65IWl3My6nJXSGs1wsDfiWmzJp+7RVzz79UGVkoyA9fjV/R3EVlWQIwfVJk+
         ELVcbBHCCooTEdVXND8XSmk9wq1IQA3H0BsA/PGxEeLErUepMZf3M9PxcPoXdnCpsS7E
         +kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BFIXmd+g4ihjCcgYZskwn6CUGTlTH6dJv1Qnkq946qc=;
        b=aGs9OfTs74TnwELedCOiCxwfkQiURF3PndvjgDff0+xf6lrZh/21dduOhez2hO7cvD
         lOHaYu8kxJv+PPsh41ChNaQJVJtMEmYb3BPd79NyPA/5L17aJdgDb2eFzcozQW5hUIKr
         KD0HTmSUBdzUUXzJ3svGO8lRrQnw88u9eGCcXsd5/kndLsRIpY5ZsoYZVDQC8/JFqmPI
         t6nyNSh+EPWHdgLewWXqlgF/iNfk/kZDum+0PaZd1evGRmoTiokckl1z6hnOLcjDXx4k
         MBZAs2q7ojfaufaZEKYl8diZZtrnpukPGrz+ABCzzG6/rvNYnaV6I0bOkfkyPY3IcwdR
         4dFQ==
X-Gm-Message-State: APt69E0Lu8/sDxFJpOio/VnJtbdNFriD0zMo2QfWR8MsTfnqr4LWayrH
        6m9E1pxI8Rioyim+qBG+OhCMTg==
X-Google-Smtp-Source: ADUXVKJnDf0Yv8b5Ec6GfxPl9FEpeZ2r0B3o+lnIa9+Y1z0Ht58jojHxNZdCgNQBHEA195NgWBosdw==
X-Received: by 2002:a65:5c89:: with SMTP id a9-v6mr2527021pgt.104.1529693356331;
        Fri, 22 Jun 2018 11:49:16 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q4-v6sm10498983pgt.64.2018.06.22.11.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:49:15 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:49:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180622142917.GB10465@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1806221147090.110785@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com> <alpine.DEB.2.21.1806141339580.4543@chino.kir.corp.google.com> <20180615065541.GA24039@dhcp22.suse.cz> <alpine.DEB.2.21.1806151559360.49038@chino.kir.corp.google.com>
 <20180619083316.GB13685@dhcp22.suse.cz> <20180620130311.GM13685@dhcp22.suse.cz> <alpine.DEB.2.21.1806201325330.158126@chino.kir.corp.google.com> <20180621074537.GC10465@dhcp22.suse.cz> <alpine.DEB.2.21.1806211347050.213939@chino.kir.corp.google.com>
 <20180622074257.GQ10465@dhcp22.suse.cz> <20180622142917.GB10465@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Michal Hocko wrote:

> > > preempt_disable() is required because it calls kvm_kick_many_cpus() with 
> > > wait == true because KVM_REQ_APIC_PAGE_RELOAD sets KVM_REQUEST_WAIT and 
> > > thus the smp_call_function_many() is going to block until all cpus can run 
> > > ack_flush().
> > 
> > I will make sure to talk to the maintainer of the respective code to
> > do the nonblock case correctly.
> 
> I've just double checked this particular code and the wait path and this
> one is not a sleep. It is a busy wait for IPI to get handled. So this
> one should be OK AFAICS. Anyway I will send an RFC and involve
> respective maintainers to make sure I am not making any incorrect
> assumptions.

Do you believe that having the only potential source of memory freeing 
busy waiting for all other cpus on the system to run ack_flush() is 
particularly dangerous given the fact that they may be allocating 
themselves?
