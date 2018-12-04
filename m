Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F59C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D34F20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D34F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLDVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:42:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeLDVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:42:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so8961812plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1c1zwl61qtCJlxK15kKZF0TseYgFkgxuUXvBoql0hg0=;
        b=iJvKIB18DMX/BcZRkxlbfMOeMMsgx2mg2eEHdqWv8/6h9FH1pJ5flcNV4+biGy7KCa
         MttkvsYUo6AEeHmbsH3QXXAyPE3H6Ytjvvr/h4V9ED+fG5s94oXwp3vdFD0OCekLHneD
         hPty3wkF/mQHILJfsh9UwySdHTUahe2Q00o0y5ituD2Gs0zQ1ljov3BnBHOXjlpNRHpW
         WuDitbSX03lcgRn4FirztMD4/Vm7rnckyTOebHyWldOvv//Owd+zTtoFc+J+5IDpR4gr
         U8MD6Sizz8Mh68Afd7lL6gYmokKZMsjj3YC7lrAye2qNz4BAy6ph44Q41uCZX+fs91lZ
         nVMg==
X-Gm-Message-State: AA+aEWasTBjzKFoCqECqdyaIC0gsTXCZCdarOdGTpVc0OG/g4KOtdGU0
        XxZXpoBMGNlhgKkULXdGkIo=
X-Google-Smtp-Source: AFSGD/UvDa+Kaq3DBIfrStnBiw7POQkDCsPLbi/z8pQ5hvNSuF6HD1PfzSEEKbl7H8eRZ+7upxqmSw==
X-Received: by 2002:a17:902:b03:: with SMTP id 3mr21462674plq.91.1543959769699;
        Tue, 04 Dec 2018 13:42:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d202sm34623125pfd.58.2018.12.04.13.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:42:48 -0800 (PST)
Message-ID: <1543959767.185366.217.camel@acm.org>
Subject: Re: [PATCH v2 17/24] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 04 Dec 2018 13:42:47 -0800
In-Reply-To: <46b0ff3c-aa6e-7183-3554-19ed112536aa@redhat.com>
References: <20181204002833.55452-1-bvanassche@acm.org>
         <20181204002833.55452-18-bvanassche@acm.org>
         <46b0ff3c-aa6e-7183-3554-19ed112536aa@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 15:27 -0500, Waiman Long wrote:
+AD4 On 12/03/2018 07:28 PM, Bart Van Assche wrote:
+AD4 +AD4 +-/+ACo Must be called with the graph lock held. +ACo-/
+AD4 +AD4 +-static void remove+AF8-class+AF8-from+AF8-lock+AF8-chain(struct lock+AF8-chain +ACo-chain,
+AD4 +AD4 +-					 struct lock+AF8-class +ACo-class)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	u64 chain+AF8-key+ADs
+AD4 +AD4 +-	int i+ADs
+AD4 +AD4 +-
+AD4 +AD4 +-+ACM-ifdef CONFIG+AF8-PROVE+AF8-LOCKING
+AD4 +AD4 +-	for (i +AD0 chain-+AD4-base+ADs i +ADw chain-+AD4-base +- chain-+AD4-depth+ADs i+-+-) +AHs
+AD4 +AD4 +-		if (chain+AF8-hlocks+AFs-i+AF0 +ACEAPQ class - lock+AF8-classes)
+AD4 +AD4 +-			continue+ADs
+AD4 +AD4 +-		if (--chain-+AD4-depth +AD0APQ 0)
+AD4 +AD4 +-			break+ADs
+AD4 +AD4 +-		memmove(+ACY-chain+AF8-hlocks+AFs-i+AF0, +ACY-chain+AF8-hlocks+AFs-i +- 1+AF0,
+AD4 +AD4 +-			(chain-+AD4-base +- chain-+AD4-depth - i) +ACo
+AD4 +AD4 +-			sizeof(chain+AF8-hlocks+AFs-0+AF0))+ADs
+AD4 +AD4 +-		/+ACo
+AD4 +AD4 +-		 +ACo Each lock class occurs at most once in a
+AD4 +AD4 +-		 +ACo lock chain so once we found a match we can
+AD4 +AD4 +-		 +ACo break out of this loop.
+AD4 +AD4 +-		 +ACo-/
+AD4 +AD4 +-		break+ADs
+AD4 +AD4 +-	+AH0
+AD4 +AD4 +-	/+ACo
+AD4 +AD4 +-	 +ACo Note: calling hlist+AF8-del+AF8-rcu() from inside a
+AD4 +AD4 +-	 +ACo hlist+AF8-for+AF8-each+AF8-entry+AF8-rcu() loop is safe.
+AD4 +AD4 +-	 +ACo-/
+AD4 +AD4 +-	if (chain-+AD4-depth +AD0APQ 0) +AHs
+AD4 +AD4 +-		/+ACo To do: decrease chain count. See also inc+AF8-chains(). +ACo-/
+AD4 +AD4 +-		hlist+AF8-del+AF8-rcu(+ACY-chain-+AD4-entry)+ADs
+AD4 +AD4 +-		return+ADs
+AD4 +AD4 +-	+AH0
+AD4 +AD4 +-	chain+AF8-key +AD0 0+ADs
+AD4 +AD4 +-	for (i +AD0 chain-+AD4-base+ADs i +ADw chain-+AD4-base +- chain-+AD4-depth+ADs i+-+-)
+AD4 +AD4 +-		chain+AF8-key +AD0 iterate+AF8-chain+AF8-key(chain+AF8-key, chain+AF8-hlocks+AFs-i+AF0 +- 1)+ADs
+AD4 
+AD4 Do you need to recompute the chain+AF8-key if no entry in the chain is removed?

Thanks for having pointed that out. I will modify this function such that the
chain key is only recalculated if necessary.

+AD4 +AD4  
+AD4 +AD4 +AEAAQA -4141,14 +-4253,31 +AEAAQA static void zap+AF8-class(struct lock+AF8-class +ACo-class)
+AD4 +AD4  	for (i +AD0 0, entry +AD0 list+AF8-entries+ADs i +ADw nr+AF8-list+AF8-entries+ADs i+-+-, entry+-+-) +AHs
+AD4 +AD4  		if (entry-+AD4-class +ACEAPQ class +ACYAJg entry-+AD4-links+AF8-to +ACEAPQ class)
+AD4 +AD4  			continue+ADs
+AD4 +AD4 +-		links+AF8-to +AD0 entry-+AD4-links+AF8-to+ADs
+AD4 +AD4 +-		WARN+AF8-ON+AF8-ONCE(entry-+AD4-class +AD0APQ links+AF8-to)+ADs
+AD4 +AD4  		list+AF8-del+AF8-rcu(+ACY-entry-+AD4-entry)+ADs
+AD4 +AD4 +-		check+AF8-free+AF8-class(class)+ADs
+AD4 
+AD4 Is the check+AF8-free+AF8-class() call redundant? You are going to call it near
+AD4 the end below.

I think so. I will remove the check+AF8-free+AF8-class() that is inside the for-loop.

+AD4 +AD4 +-static void reinit+AF8-class(struct lock+AF8-class +ACo-class)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	void +ACo-const p +AD0 class+ADs
+AD4 +AD4 +-	const unsigned int offset +AD0 offsetof(struct lock+AF8-class, key)+ADs
+AD4 +AD4 +-
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-class-+AD4-lock+AF8-entry.next)+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-list+AF8-empty(+ACY-class-+AD4-locks+AF8-after))+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-list+AF8-empty(+ACY-class-+AD4-locks+AF8-before))+ADs
+AD4 +AD4 +-	memset(p +- offset, 0, sizeof(+ACo-class) - offset)+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-class-+AD4-lock+AF8-entry.next)+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-list+AF8-empty(+ACY-class-+AD4-locks+AF8-after))+ADs
+AD4 +AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-list+AF8-empty(+ACY-class-+AD4-locks+AF8-before))+ADs
+AD4 +AD4  +AH0
+AD4 
+AD4 Is it safer to just reinit those fields before +ACI-key+ACI instead of using
+AD4 memset()? Lockdep is slow anyway, doing that individually won't
+AD4 introduce any noticeable slowdown.

The warning statements will only be hit if the order of the struct lock+AF8-class members
would be modified. I don't think that we need to change the approach of this function.

+AD4 +AD4 +AEAAQA -4193,18 +-4355,14 +AEAAQA void lockdep+AF8-free+AF8-key+AF8-range(void +ACo-start, unsigned long size)
+AD4 +AD4  	raw+AF8-local+AF8-irq+AF8-restore(flags)+ADs
+AD4 +AD4  
+AD4 +AD4  	/+ACo
+AD4 +AD4 -	 +ACo Wait for any possible iterators from look+AF8-up+AF8-lock+AF8-class() to pass
+AD4 +AD4 -	 +ACo before continuing to free the memory they refer to.
+AD4 +AD4 -	 +ACo
+AD4 +AD4 -	 +ACo sync+AF8-sched() is sufficient because the read-side is IRQ disable.
+AD4 +AD4 +-	 +ACo Do not wait for concurrent look+AF8-up+AF8-lock+AF8-class() calls. If any such
+AD4 +AD4 +-	 +ACo concurrent call would return a pointer to one of the lock classes
+AD4 +AD4 +-	 +ACo freed by this function then that means that there is a race in the
+AD4 +AD4 +-	 +ACo code that calls look+AF8-up+AF8-lock+AF8-class(), namely concurrently accessing
+AD4 +AD4 +-	 +ACo and freeing a synchronization object.
+AD4 +AD4  	 +ACo-/
+AD4 +AD4 -	synchronize+AF8-sched()+ADs
+AD4 +AD4  
+AD4 +AD4 -	/+ACo
+AD4 +AD4 -	 +ACo XXX at this point we could return the resources to the pool+ADs
+AD4 +AD4 -	 +ACo instead we leak them. We would need to change to bitmap allocators
+AD4 +AD4 -	 +ACo instead of the linear allocators we have now.
+AD4 +AD4 -	 +ACo-/
+AD4 +AD4 +-	schedule+AF8-free+AF8-zapped+AF8-classes()+ADs
+AD4 
+AD4 Should you move the graph+AF8-unlock() and raw+AF8-lock+AF8-irq+AF8-restore() down to
+AD4 after this? The schedule+AF8-free+AF8-zapped+AF8-classes must be called with
+AD4 graph+AF8-lock held. Right?

I will modify this and other patches such that all schedule+AF8-free+AF8-zapped+AF8-classes()
calls are protected by the graph lock.

Bart.
