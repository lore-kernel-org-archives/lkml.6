Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40ADC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12FC20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12FC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJBShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:37:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbeJBShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:37:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92Bru1x031054
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 07:54:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv7w30nf4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:54:21 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 12:54:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 12:54:16 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92BsFX162980242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 11:54:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF660AE056;
        Tue,  2 Oct 2018 14:53:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176BBAE045;
        Tue,  2 Oct 2018 14:53:07 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.102.1.150])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Oct 2018 14:53:06 +0100 (BST)
Date:   Tue, 2 Oct 2018 17:24:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm, numa: Remove rate-limiting of automatic numa
 balancing migration
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181001100525.29789-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18100211-4275-0000-0000-000002C3C107
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100211-4276-0000-0000-000037CED08F
Message-Id: <20181002115412.GA4593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-10-01 11:05:24]:

> Rate limiting of page migrations due to automatic NUMA balancing was
> introduced to mitigate the worst-case scenario of migrating at high
> frequency due to false sharing or slowly ping-ponging between nodes.
> Since then, a lot of effort was spent on correctly identifying these
> pages and avoiding unnecessary migrations and the safety net may no longer
> be required.
> 
> Jirka Hladky reported a regression in 4.17 due to a scheduler patch that
> avoids spreading STREAM tasks wide prematurely. However, once the task
> was properly placed, it delayed migrating the memory due to rate limiting.
> Increasing the limit fixed the problem for him.
> 
> Currently, the limit is hard-coded and does not account for the real
> capabilities of the hardware. Even if an estimate was attempted, it would
> not properly account for the number of memory controllers and it could
> not account for the amount of bandwidth used for normal accesses. Rather
> than fudging, this patch simply eliminates the rate limiting.
> 
> However, Jirka reports that a STREAM configuration using multiple
> processes achieved similar performance to 4.16. In local tests, this patch
> improved performance of STREAM relative to the baseline but it is somewhat
> machine-dependent. Most workloads show little or not performance difference
> implying that there is not a heavily reliance on the throttling mechanism
> and it is safe to remove.
> 
> STREAM on 2-socket machine
>                          4.19.0-rc5             4.19.0-rc5
>                          numab-v1r1       noratelimit-v1r1
> MB/sec copy     43298.52 (   0.00%)    44673.38 (   3.18%)
> MB/sec scale    30115.06 (   0.00%)    31293.06 (   3.91%)
> MB/sec add      32825.12 (   0.00%)    34883.62 (   6.27%)
> MB/sec triad    32549.52 (   0.00%)    34906.60 (   7.24%
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

