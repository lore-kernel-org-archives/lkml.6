Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7BEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE502075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeIGRhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729467AbeIGRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:37:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87CtWGo170230
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 08:56:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mbrd63knw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:56:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 7 Sep 2018 13:56:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 13:56:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w87Cuphq58654928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 12:56:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D74A4C046;
        Fri,  7 Sep 2018 15:56:45 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0F04C040;
        Fri,  7 Sep 2018 15:56:43 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.46.141])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  7 Sep 2018 15:56:43 +0100 (BST)
Date:   Fri, 7 Sep 2018 18:26:49 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Jakub Ra??ek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090712-4275-0000-0000-000002B6C423
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090712-4276-0000-0000-000037BFE7D2
Message-Id: <20180907125649.GA3995@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jirka Hladky <jhladky@redhat.com> [2018-09-07 11:34:49]:

Hi Jirka,

> 
> We have detected a significant performance drop (20% and more) with
> 4.19rc1 relatively to 4.18 vanilla. We see the regression on different
> 2 NUMA and 4 NUMA boxes with pretty much all the benchmarks we use -
> NAS, Stream, SPECjbb2005, SPECjvm2008.
> 

Do you run single instance of these benchmarks?
I generally run specjbb2005 (single and multi instance). I should be able to
run stream.  I have tried running NAS but I couldnt set it up properly.

I also run a set of perf bench scripts but thats not a real workload.
However perf bench gives me a visual perspective of how things are
converging. I also run an internal benchmark that mimics a trading
application.

> Mel Gorman has suggested checking
> 2d4056fafa196e1ab4e7161bae4df76f9602d56d commit - with it reverted we
> got some performance back but not entirely:
> 
>  * Compared to 4.18, there is still performance regression -
> especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
> systems, regression is around 10-15%
>   * Compared to 4.19rc1 there is a clear gain across all benchmarks, up to 20%.
> 
> We are investigating the issue further, Mel has suggested to check
> 305c1fac3225dfa7eeb89bfe91b7335a6edd5172 as next.

Can you please pick


1. 69bb3230297e881c797bbc4b3dbf73514078bc9d sched/numa: Stop multiple tasks
from moving to the cpu at the same time
2. dc62cfdac5e5b7a61cd8a2bd4190e80b9bb408fc sched/numa: Avoid task migration
for small numa improvement
3. 76e18a67cdd9e3609716c8a074c03168734736f9 sched/numa: Pass destination cpu as
a parameter to migrate_task_rq
4.  489c19b440ebdbabffe530b9a41389d0a8b315d9 sched/numa: Reset scan rate
whenever task moves across nodes
5.  b7e9ae1ae3825f35cd0f38f1f0c8e91ea145bc30 sched/numa: Limit the
conditions where scan period is reset

from https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched


You may also want to try with reverting
f03bb6760b8e5e2bcecc88d2a2ef41c09adcab39 sched/numa: Use task faults only if
numa_group is not yet set

> I want to discuss with you how can we collaborate on performance
> testing for the upstream kernel. Does your testing show as well
> performance drop in 4.19? If so, do you have any plans for the fix? If
> no, can we send you some more information about our tests so that you
> can try to reproduce it?

While I have not kept record of the performance numbers on the upstream
kernel, I have some rough patches on scheduler from a performance point of
view. I will try to clean up and send them out soon. (Will copy you when
sending them out).

> 
> We would also be more than happy to test the new patches for the
> performance - please let us know if you are interested.  We have a
> pool of 1 NUMA up to 8 NUMA boxes for that, both AMD and Intel,
> covering different CPU generations from Sandy Bridge till Skylake.
> 

I generally test on Power8 (4 node, 16 node), 2 node Power 9, 2 node skylake
and 4 node Power 7.  Surely I will keep you informed and eager to know the
results of your experiments.

-- 
Thanks and Regards
Srikar Dronamraju

