Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92120C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64521536
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64521536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHPBTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:19:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38642 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeHPBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:19:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37A1CBD8;
        Wed, 15 Aug 2018 22:25:12 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:25:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 0/2] Directed kmem charging
Message-Id: <20180815152511.3ea63aa54c5fac0bfe9370da@linux-foundation.org>
In-Reply-To: <20180627191250.209150-1-shakeelb@google.com>
References: <20180627191250.209150-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 12:12:48 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> The Linux kernel's memory cgroup allows limiting the memory usage of
> the jobs running on the system to provide isolation between the jobs.
> All the kernel memory allocated in the context of the job and marked
> with __GFP_ACCOUNT will also be included in the memory usage and be
> limited by the job's limit.
> 
> The kernel memory can only be charged to the memcg of the process in
> whose context kernel memory was allocated. However there are cases where
> the allocated kernel memory should be charged to the memcg different
> from the current processes's memcg. This patch series contains two such
> concrete use-cases i.e. fsnotify and buffer_head.
> 
> The fsnotify event objects can consume a lot of system memory for large
> or unlimited queues if there is either no or slow listener. The events
> are allocated in the context of the event producer. However they should
> be charged to the event consumer. Similarly the buffer_head objects can
> be allocated in a memcg different from the memcg of the page for which
> buffer_head objects are being allocated.
> 
> To solve this issue, this patch series introduces mechanism to charge
> kernel memory to a given memcg. In case of fsnotify events, the memcg of
> the consumer can be used for charging and for buffer_head, the memcg of
> the page can be charged. For directed charging, the caller can use the
> scope API memalloc_[un]use_memcg() to specify the memcg to charge for
> all the __GFP_ACCOUNT allocations within the scope.

This patchset is not showing signs of having been well reviewed at
this time.  Could people please take another look?

