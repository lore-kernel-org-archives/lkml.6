Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B930ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A720883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vuIC7TsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359A720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKIBWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:22:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKIBWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zRIBLWsw80zYbxzgs3jgsZeBfHdU+bZkwp0KRbzrlWU=; b=vuIC7TsB1/mdZF2zuBxuSbC60
        kLh7CERmaQnIb9yqgVlwa5V7CypLACpvgBQDgRxRVeSUhIrXjL8ToG9CkR9RBPUi9prQag4gJ0Dkw
        M8KeUG/xNBGsb+vZ5Q98UGB+aJ7QtaNDVobHS2EnKLSMEUngDSwrlg5zFJUcmOqtVqeS7SfwP8sRG
        WK0GR3DwoDq5ZPxxurG8kNpRQH/JsBwecQ8Z0meZtpriC6MSRkFwIoCsuHvJLa6OS/hrMa8vdq9VF
        49LvCBIvbWf99fA8EBDXi8sEsG7pov1JF0PmKbAYveJdtbY735u/OyQ/8hL/vkN9A1928mT5r+LNk
        JeN6tUoRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKmVe-000317-T8; Thu, 08 Nov 2018 15:46:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D05520284F98; Thu,  8 Nov 2018 16:46:17 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:46:17 +0100
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
Subject: Re: [PATCH v15 12/12] cpuset: Expose cpuset.cpus.subpartitions with
 cgroup_debug
Message-ID: <20181108154617.GX9761@hirez.programming.kicks-ass.net>
References: <1541689726-20088-1-git-send-email-longman@redhat.com>
 <1541689726-20088-13-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541689726-20088-13-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:08:46AM -0500, Waiman Long wrote:
> For debugging purpose, it will be useful to expose the content of the
> subparts_cpus as a read-only file to see if the code work correctly.
> However, subparts_cpus will not be used at all in most use cases. So
> adding a new cpuset file that clutters the cgroup directory may not be
> desirable.  This is now being done by using the hidden "cgroup_debug"
> kernel command line option to expose a new "cpuset.cpus.subpartitions"
> file.

One thought I had; would it make sense to make these debug files hidden
("." prefix) ?
