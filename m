Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F262084A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfBARWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:22:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729009AbfBARWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:22:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11HJpqd001743
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 12:21:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qctbngbrf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:21:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 1 Feb 2019 17:21:56 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 17:21:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11HLr1U40960064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 17:21:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3464642047;
        Fri,  1 Feb 2019 17:21:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D824203F;
        Fri,  1 Feb 2019 17:21:51 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  1 Feb 2019 17:21:51 +0000 (GMT)
Date:   Fri, 1 Feb 2019 22:51:50 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     rostedt@goodmis.org, peterz@infradead.org, mingo@redhat.com,
        akpm@linux-foundation.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020117-0016-0000-0000-0000024F6448
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020117-0017-0000-0000-000032A968B1
Message-Id: <20190201172150.GA1853@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elena Reshetova <elena.reshetova@intel.com> [2019-01-16 13:20:27]:

> atomic_t variables are currently used to implement reference
> counters with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows
> and underflows. This is important since overflows and underflows
> can lead to use-after-free situation and be exploitable.
> 
> The variable uprobe.ref is used as pure reference counter.
> Convert it to refcount_t and fix up the operations.
> 
> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.
> The full comparison can be seen in
> https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> in state to be merged to the documentation tree.
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in
> some rare cases it might matter.
> Please double check that you don't have some undocumented
> memory guarantees for this variable usage.
> 
> For the uprobe.ref it might make a difference
> in following places:
>  - put_uprobe(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and control dependency on success
>    vs. fully ordered atomic counterpart
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  kernel/events/uprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

