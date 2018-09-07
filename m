Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A801C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAD42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAD42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeIGRqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:46:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727644AbeIGRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:46:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87Cxs7o091818
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 09:06:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mbsa31qnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:06:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 7 Sep 2018 14:05:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 14:05:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w87D5tFA66257036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 13:05:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1463AAE051;
        Fri,  7 Sep 2018 16:05:16 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9F51AE04D;
        Fri,  7 Sep 2018 16:05:14 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.199.46.141])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  7 Sep 2018 16:05:14 +0100 (BST)
Date:   Fri, 7 Sep 2018 18:35:53 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Stop comparing tasks for NUMA placement
 after selecting an idle core
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180907101139.20760-4-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090713-0008-0000-0000-0000026DC396
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090713-0009-0000-0000-000021D5EC3A
Message-Id: <20180907130553.GB3995@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-09-07 11:11:38]:

> task_numa_migrate is responsible for finding a core on a preferred NUMA
> node for a task. As part of this, task_numa_find_cpu iterates through
> the CPUs of a node and evaulates CPUs, both idle and with running tasks,
> as placement candidates. Generally though, any idle CPU is equivalent in
> terms of improving imbalances and a search after finding one is pointless.
> This patch stops examining CPUs on a node if an idle CPU is considered
> suitable.
> 

However there can be a thread on the destination node that might benefit
from swapping with the current thread. Don't we loose that opportunity to
swap if skip checking for other threads?

To articulate.
Thread A currently running on node 0 wants to move to node 1.
Thread B currently running on node 1 is better of if it ran on node 0.

Thread A seems idle cpu before seeing Thread B; skips and looses
an opportunity to swap.

Eventually thread B will get an opportunity to move to node 0, when thread B
calls task_numa_placement but we are probably stopping it from achieving
earlier.

-- 
Thanks and Regards
Srikar Dronamraju

