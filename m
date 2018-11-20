Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCBEC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2534420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/JhevL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2534420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeKUDtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:49:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I+8Ok8d3U7ODhT6w9ubsS4qTzg7vYuk5vhO0Db4ECIs=; b=X/JhevL5RIpdVTkxKR652x/Bv
        JCu18806N+sEXYqj7D8zNEIM/ZD2VNlb2UQq57PoBEzCmKjYCarQI27OjG8a2kG1mBYoSteoi3QOT
        JBFQDou1md9Ap9t6x7VjAmxUF1OF4jtEIZ2R/KRRrx0niyNOGZ8JQdE15cLnL+D/hz5/EJ4JmMOx7
        Kx0suzHHwMxDUhgxT0K5vOc4G22VHMNW/XCzAxpbUCwqjhYupxbWbbub3NuXqudLyQaTo7tUVV/lX
        j4EhMGnj5k4a0wi51xxMNFl3S6NRaQ1uLu+SnaMRw2e+9dYmqq8/urZbH8t/hzv+y6VWXi+WaWZKb
        0XXg/OpwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP9gI-0000by-DG; Tue, 20 Nov 2018 17:19:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E20C22029FD58; Tue, 20 Nov 2018 18:19:20 +0100 (CET)
Date:   Tue, 20 Nov 2018 18:19:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-4.21 1/2] cpuset: Minor cgroup2 interface
 updates
Message-ID: <20181120171920.GA2131@hirez.programming.kicks-ass.net>
References: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
 <20181120124624.GL2131@hirez.programming.kicks-ass.net>
 <20181120154410.GQ2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120154410.GQ2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:44:10AM -0800, Tejun Heo wrote:
> Hello, Peter.
> 
> On Tue, Nov 20, 2018 at 01:46:24PM +0100, Peter Zijlstra wrote:
> > Why though? The Changelog doesn't give rationale for the actual changes.
> 
> Ah yeah, sorry about that.
> 
> > And I'm not sure I agree with either one of them.
> > 
> > The partition is a scheduling feature;
> 
> So is everything with cpuset.cpus prefix.  They're all modifying how
> scheduler handles the cpus.

Fair enough I suppose.

> > and I like 0/1 much better to type, so why not allow that?
> 
> Mostly for consistency and it's generally better to keep interfaces
> minimal - e.g. what if we need to add support for more key words to
> the file?  Would we assign incrementing integers to them?

Or just not give them a numeric alias at all.

But numbers are more minimal than words, so lets just get rid of them
pesky word things ;-)

Alternatively; we could use kstrtobool(). That accepts a metric ton of
input ;-)
