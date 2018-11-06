Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF98C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B438F204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKzqVnDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B438F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeKFVR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:17:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbeKFVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GFyEAi/5ntHNaVjY7w8ti5shFbhzc/6OhXu7odl5N4E=; b=BKzqVnDq6A5rInnH4ONRw4+BK
        G/QyJjPFMMjpvvFBZa/DTjQWJm8NEetKTs8CmEmB2vlX7ARuVEj6ceMXi/eLE04uZmBnEB4SXyISN
        AGVVHYDBKqq42MTLzLmMfwIP3q+IOvfncWom4J6bNSWdNxN23N/nmdmJ03WVFpRoHIJsI+mtU4W/z
        5wOYaDNR2J+zyo4PD2A1fwLMZD170trr19XYHKLP6GTAj/hbXqnnN6hH9562esJzlOd3WgYXgT+xN
        ezjAVsp0SmKW+7wHdjVH/LARVjC6AWS+gF9yWjMTa7zPRh5hOlSyxIAka8FpqLISXSU8SwVLw4LBX
        vsIeLk8vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJzuE-0005VX-UW; Tue, 06 Nov 2018 11:52:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB5CD2029F9FF; Tue,  6 Nov 2018 12:52:20 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:52:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 12/12] cpuset: Show descriptive text when reading
 cpuset.sched.partition
Message-ID: <20181106115220.GP22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-13-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-13-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:37PM -0400, Waiman Long wrote:
> Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
> read. A person who is not familiar with the partition code may not
> understand what they mean.
> 
> In order to make cpuset.sched.partition more user-friendly, it will
> now display the following descriptive text on read:
> 
>   "normal" - A normal cpuset, not a partition root
>   "partition" - A partition root
>   "partition invalid" - An invalid partition root

As a person who is familiar with it: "normal" doesn't make sense.

It either is or is not a parition. normal doesn't some into it.
