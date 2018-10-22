Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF34C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJWAP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728201AbeJWAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:15:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MFntrG094063
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:56:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n9ete981h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:56:48 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Oct 2018 11:56:47 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Oct 2018 11:56:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9MFui4T19005566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Oct 2018 15:56:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C91B205F;
        Mon, 22 Oct 2018 15:56:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85BF7B2065;
        Mon, 22 Oct 2018 15:56:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.169.161])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Oct 2018 15:56:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 35EF316C3006; Mon, 22 Oct 2018 08:56:44 -0700 (PDT)
Date:   Mon, 22 Oct 2018 08:56:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Reply-To: paulmck@linux.ibm.com
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022152406.GA7257@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102215-0068-0000-0000-000003517A1C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106394; UDB=6.00572948; IPR=6.00886479;
 MB=3.00023859; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 15:56:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102215-0069-0000-0000-000046292BFA
Message-Id: <20181022155644.GG4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 05:24:07PM +0200, Oleg Nesterov wrote:
> On 10/22, Paul E. McKenney wrote:
> >
> > The sync.c file has a number of calls to BUG_ON(), which panics the
> > kernel, which is not a good
> 
> Agreed.
> 
> I added these BUG_ON's for documentation when I was prototyping this code,
> perhaps we can simply remove them.

I do like this approach.  ;-)

> > @@ -125,12 +125,12 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> >  		rsp->gp_state = GP_PENDING;
> >  	spin_unlock_irq(&rsp->rss_lock);
> >  
> > -	BUG_ON(need_wait && need_sync);
> > -
> >  	if (need_sync) {
> >  		gp_ops[rsp->gp_type].sync();
> >  		rsp->gp_state = GP_PASSED;
> >  		wake_up_all(&rsp->gp_wait);
> > +		if (WARN_ON_ONCE(need_wait))
> > +			wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
> 
> This wait_event(gp_state == GP_PASSED) is pointless, note that this branch
> does gp_state = GP_PASSED 2 lines above.

OK, I have removed this one.

> And if we add WARN_ON_ONCE(need_wait), then we should probably also add
> WARN_ON_ONCE(need_sync) into the next "if (need_wait)" branch just for
> symmetry.

But in that case, the earlier "if" prevents "need_sync" from ever getting
there, unless I lost the thread here.

> So I'd suggest to either turn that BUG_ON(need_wait && need_sync) above
> into WARN_ON_ONCE(wait && sync) or simply remove it.

I chose WARN_ON_ONCE() for this one.

> Again, the only purpose of this BUG_ON() is to explain to the reader that
> it is not (must not be) possible that, say, gp_state == GP_IDLE while
> gp_count != 0.

Good point!

Should I remove the others?

> ----------------------------------------------------------------------------
> Damn.
> 
> This suddenly reminds me that I rewrote this code completely, and you even
> reviewed the new implementation and (iirc) acked it!
> 
> However, I failed to force myself to rewrite the comments, and that is why
> I didn't send the "official" patch :/
> 
> May be some time...

Could you please point me at the last email thread?  Yes, I should be
able to find it, but I would probably get the wrong one.  :-/

							Thanx, Paul

