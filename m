Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124EF2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124EF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeIDPCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:02:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbeIDPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:02:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w84AY63h043014
        for <linux-kernel@vger.kernel.org>; Tue, 4 Sep 2018 06:37:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m9qnfj6v9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 06:37:49 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 4 Sep 2018 11:37:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Sep 2018 11:37:45 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w84AbiZ034013414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Sep 2018 10:37:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8044642042;
        Tue,  4 Sep 2018 13:37:39 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AD8342041;
        Tue,  4 Sep 2018 13:37:38 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Sep 2018 13:37:38 +0100 (BST)
Date:   Tue, 4 Sep 2018 03:37:42 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <20180904082424.GA2090@linux.vnet.ibm.com>
 <20180904093626.GA23936@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904093626.GA23936@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090410-0020-0000-0000-000002C0EA6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090410-0021-0000-0000-0000210E0FF8
Message-Id: <20180904103742.GC61288@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809040112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2018-09-04 11:36:26]:

> Hi Srikar,
> 
> Le Tuesday 04 Sep 2018 à 01:24:24 (-0700), Srikar Dronamraju a écrit :
> > However after this change, capacity_orig of each SMT thread would be
> > 1024. For example SMT 8 core capacity_orig would now be 8192.
> > 
> > smt_gain was suppose to make a multi threaded core was slightly more
> > powerful than a single threaded core. I suspect if that sometimes hurt
> 
> Is there system with both single threaded and multi threaded core ?
> That was the main open point for me (and for Qais too)
> 

I dont know of any systems that have come with single threaded and
multithreaded. However some user can still offline few threads in a core
while leaving other cores untouched. I dont really know why somebody
would want to do it.  For example, some customer was toying with SMT 3
mode in a SMT 8 power8 box.

> 
> > us when doing load balance between 2 cores i.e at MC or DIE sched
> > domain. Even with 2 threads running on a core, the core might look
> > lightly loaded 2048/8192. Hence might dissuade movement to a idle core.
> 
> Then, there is the sibling flag at SMT level that normally ensures 1 task per
> core for such UC
> 

Agree.

> > 
> > I always wonder why arch_scale_cpu_capacity() is called with NULL
> > sched_domain, in scale_rt_capacity(). This way capacity might actually
> 
> Probably because until this v4.19-rcxx version, the rt scaling was done
> relatively to local cpu capacity:
>   capacity  = arch_scale_cpu() * scale_rt_capacity / SCHED_CAPACITY_SCALE
> 
> Whereas now, it directly returns the remaining capacity
> 
> > be more than the capacity_orig. I am always under an impression that
> > capacity_orig > capacity.  Or am I misunderstanding that?
> 
> You are right, there is a bug for SMT and the patch below should fix it.
> Nevertheless, we still have the problem in some other places in the code.
> 
> Subject: [PATCH] sched/fair: fix scale_rt_capacity() for SMT
> 
> Since commit:
>   commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
> scale_rt_capacity() returns the remaining capacity and not a scale factor
> to apply on cpu_capacity_orig. arch_scale_cpu() is directly called by
> scale_rt_capacity() so we must take the sched_domain argument
> 
> Fixes: 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

