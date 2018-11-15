Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5399C2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5399C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbeKPE60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:58:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeKPE6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:58:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18833AFD0;
        Thu, 15 Nov 2018 18:49:27 +0000 (UTC)
Date:   Thu, 15 Nov 2018 10:49:17 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lance Roy <ldr709@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH tip/core/rcu 6/7] mm: Replace spin_is_locked() with
 lockdep
Message-ID: <20181115184917.6goqg67hpojfhk42@linux-r8p5>
Mail-Followup-To: "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lance Roy <ldr709@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
References: <20181111200421.GA10551@linux.ibm.com>
 <20181111200443.10772-6-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181111200443.10772-6-paulmck@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018, Paul E. McKenney wrote:

>From: Lance Roy <ldr709@gmail.com>
>
>lockdep_assert_held() is better suited to checking locking requirements,
>since it only checks if the current thread holds the lock regardless of
>whether someone else does. This is also a step towards possibly removing
>spin_is_locked().

So fyi I'm not crazy about these kind of patches simply because lockdep
is a lot less used out of anything that's not a lab, and we can be missing
potential offenders. There's obviously nothing wrong about what you describe
above perse, just my two cents.

Thansk,
Davidlohr
