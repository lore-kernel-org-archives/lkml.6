Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6699C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F92208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F92208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeFUIOX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932583AbeFUIOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:14:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66D0430820D8;
        Thu, 21 Jun 2018 08:14:20 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8EC6F7E7;
        Thu, 21 Jun 2018 08:14:08 +0000 (UTC)
Subject: Re: [PATCH v10 6/9] cpuset: Make generate_sched_domains() recognize
 reserved_cpus
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-8-git-send-email-longman@redhat.com>
 <20180620141730.GK2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <df4e36b1-f386-88e9-8179-fce7530f4554@redhat.com>
Date:   Thu, 21 Jun 2018 16:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180620141730.GK2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Jun 2018 08:14:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 10:17 PM, Peter Zijlstra wrote:
> On Mon, Jun 18, 2018 at 12:14:06PM +0800, Waiman Long wrote:
>> The generate_sched_domains() function is modified to make it work
>> correctly with the newly introduced reserved_cpus mask for schedule
>> domains generation.
> Why isn't this (and the previous) patch part of the patch that
> introduces reserved_cpus? It seems weird to have this broken
> intermediate state.

I was trying to break the reserved cpu patch into smaller meaningful
pieces that will be easier to review. The individual patches can be
compiled cleanly one-by-one, though I didn't check if they are
functional if not all of them are applied.

Cheers,
Longman

