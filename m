Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68172ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D8620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D8620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbeGWQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:11:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387831AbeGWQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:11:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NF9Rvd020258
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:10:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdhc187ja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:10:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 16:10:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 16:09:57 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NF9uCV38404348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 15:09:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A50AE11C04A;
        Mon, 23 Jul 2018 18:10:11 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8213211C050;
        Mon, 23 Jul 2018 18:10:10 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 23 Jul 2018 18:10:10 +0100 (BST)
Date:   Mon, 23 Jul 2018 08:09:55 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/19]  Fixes for sched/numa_balancing
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180723135700.GX2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180723135700.GX2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072315-0008-0000-0000-000002568C25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072315-0009-0000-0000-000021BCFADE
Message-Id: <20180723150954.GI30345@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-07-23 15:57:00]:

> On Wed, Jun 20, 2018 at 10:32:41PM +0530, Srikar Dronamraju wrote:
> > Srikar Dronamraju (19):
> >   sched/numa: Remove redundant field.
> >   sched/numa: Evaluate move once per node
> >   sched/numa: Simplify load_too_imbalanced
> >   sched/numa: Set preferred_node based on best_cpu
> >   sched/numa: Use task faults only if numa_group is not yet setup
> >   sched/debug: Reverse the order of printing faults
> >   sched/numa: Skip nodes that are at hoplimit
> >   sched/numa: Remove unused task_capacity from numa_stats
> >   sched/numa: Modify migrate_swap to accept additional params
> >   sched/numa: Restrict migrating in parallel to the same node.
> >   sched/numa: Remove numa_has_capacity
> >   sched/numa: Use group_weights to identify if migration degrades locality
> >   sched/numa: Move task_placement closer to numa_migrate_preferred
>
> I took the above, but left the below for next time.


>
> >   sched/numa: Stop multiple tasks from moving to the cpu at the same time

This patch has go-ahead from Mel and Rik and no outstanding comments.

In my analysis, I did find a lot of cases where the same cpu ended up
being the target. + I am not sure you can apply "sched/numa: Restrict
migrating in parallel to the same node" cleanly without this patch.

So I am a bit confused. If possible, please clarify.

> >   mm/migrate: Use xchg instead of spinlock

Will try with spin_trylock and get back.

> >   sched/numa: Updation of scan period need not be in lock

I didnt see any comments for this apart from an ack from Rik.
+ It thought it was trivial and shouldnt have any side-effect.

> >   sched/numa: Detect if node actively handling migration
> >   sched/numa: Pass destination cpu as a parameter to migrate_task_rq
> >   sched/numa: Reset scan rate whenever task moves across nodes
>

