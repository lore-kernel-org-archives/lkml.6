Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC8C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773AA208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773AA208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHUPVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbeHUPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:21:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LC0Fpq105724
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 08:01:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0gp84nvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 08:01:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 21 Aug 2018 13:01:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 13:01:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LC1q3d46203020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 12:01:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F8A11C06C;
        Tue, 21 Aug 2018 15:01:52 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B48EB11C04C;
        Tue, 21 Aug 2018 15:01:51 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 21 Aug 2018 15:01:51 +0100 (BST)
Date:   Tue, 21 Aug 2018 05:01:50 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] numa-balancing patches
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082112-0008-0000-0000-00000264A123
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082112-0009-0000-0000-000021CCDF34
Message-Id: <20180821120150.GB2080@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-08-03 11:43:55]:

> This patchset based on current tip/sched/core, provides left out patches
> from the previous series. This version handles the comments given to some of
> the patches. It drops "sched/numa: Restrict migrating in parallel to the same
> node." It adds an additional patch from Mel Gorman.
> It also provides specjbb2005 /dbench/ perf bench numa numbers on a patch
> basis on 4 node and 2 node systems.
> 
> v2: http://lkml.kernel.org/r/1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com
> v1: http://lkml.kernel.org/r/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com
> 

Hi Peter, Ingo

Can you please respond with your comments suggestions.

Mel and Rik have acked most of the patches.

-- 
Thanks and Regards
Srikar Dronamraju

