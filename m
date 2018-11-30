Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4942146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4942146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeK3VgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:36:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeK3VgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFBBF15AB;
        Fri, 30 Nov 2018 02:27:33 -0800 (PST)
Received: from [10.1.29.186] (p8cg001049571a15.cambridge.arm.com [10.1.29.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8923F59C;
        Fri, 30 Nov 2018 02:27:32 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181130163008.7d2b213f@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8df82787-3baa-3f3f-a0ed-313db11c4122@arm.com>
Date:   Fri, 30 Nov 2018 15:57:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130163008.7d2b213f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2018 11:00 AM, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm tree, today's linux-next build (powerpc_le perf)
> failed like this:
> 
> bench/numa.c: In function 'bind_to_node':
> bench/numa.c:301:21: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>   if (target_node == NUMA_NO_NODE) {
>                      ^~~~~~~~~~~~
>                      NUMA_NUM_NODES
> bench/numa.c:301:21: note: each undeclared identifier is reported only once for each function it appears in
> bench/numa.c: In function 'bind_to_memnode':
> bench/numa.c:342:14: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>   if (node == NUMA_NO_NODE)
>               ^~~~~~~~~~~~
>               NUMA_NUM_NODES
> bench/numa.c: In function 'init_thread_data':
> bench/numa.c:1366:19: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>    td->bind_node = NUMA_NO_NODE;
>                    ^~~~~~~~~~~~
>                    NUMA_NUM_NODES
> 
> Caused by patch
> 
>   "mm: replace all open encodings for NUMA_NO_NODE"
> 
> I applied the following partial revert for today:

I had skipped this particular file because it includes 'numa.h'. But that does not
seem to pull in <linux/numa.h> though. Could we please add <linux/numa.h> instead
of reverting the actual changes from the patch. I can send out another version of
the patch if required.

- Anshuman
