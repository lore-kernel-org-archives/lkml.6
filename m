Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB73C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EAC21477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EAC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeIXFxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbeIXFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:53:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8NNsDJM060073
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 19:54:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mpkpw1p9y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 19:54:18 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 23 Sep 2018 19:54:17 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Sep 2018 19:54:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8NNsDh157737426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 23:54:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8C3B205F;
        Sun, 23 Sep 2018 19:52:37 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1970B2064;
        Sun, 23 Sep 2018 19:52:36 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.154.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 23 Sep 2018 19:52:36 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 59EE416C1971; Sun, 23 Sep 2018 16:54:13 -0700 (PDT)
Date:   Sun, 23 Sep 2018 16:54:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about ->head field of rcu_segcblist
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092323-0064-0000-0000-00000352F62F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009760; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092701; UDB=6.00564700; IPR=6.00872736;
 MB=3.00023472; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-23 23:54:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092323-0065-0000-0000-00003ABEFA5C
Message-Id: <20180923235413.GA4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809230253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 07:30:30PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> I was parsing the Data-Structures document and had a question about
> the following "Important note" text.
> 
> Could it be clarified in the below text better why "remaining
> callbacks are placed back on the RCU_DONE_TAIL segment", is a reason
> for not depending on ->head for determining if no callbacks are
> associated with the rcu_segcblist? If callbacks are added back to the
> DONE_TAIL segment, then I would think rcu_head should be != NULL.
> Infact the "rsclp->head = *rsclp->tails[RCU_DONE_TAIL];" in
> rcu_segcblist_extract_done_cbs should set the ->head to  NULL if I
> understand correctly.

The rcu_segcblist_extract_done_cbs() function will set rsclp->head
to NULL only if there were no non-done callbacks on the rsclp list.
Otherwise, if there are non-done callbacks, then rsclp->head will
be set to the first non-done callback.

Either way, the problem is that the done callbacks can be removed
and re-added, but the count is not adjusted until the re-add.  So
you have to look at the count to see if there are callbacks.

Testing rsclp->head fails because it can be temporarily NULL, even
though there are callbacks hanging off of a pointer in rcu_do_batch()'s
stack frame.

Or am I misunderstanding your question?

							Thanx, Paul

> Important note: It is the ->len field that determines whether or not
> there are callbacks associated with this rcu_segcblist structure, not
> the ->head pointer. The reason for this is that all the
> ready-to-invoke callbacks (that is, those in the RCU_DONE_TAIL
> segment) are extracted all at once at callback-invocation time. If
> callback invocation must be postponed, for example, because a
> high-priority process just woke up on this CPU, then the remaining
> callbacks are placed back on the RCU_DONE_TAIL segment. Either way,
> the ->len and ->len_lazy counts are adjusted after the corresponding
> callbacks have been invoked, and so again it is the ->lencount that
> accurately reflects whether or not there are callbacks associated with
> this rcu_segcblist structure. Of course, off-CPU sampling of the ->len
> count requires the use of appropriate synchronization, for example,
> memory barriers. This synchronization can be a bit subtle,
> particularly in the case of rcu_barrier().
> 
> Thanks!
> 
>  - Joel
> 

