Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34462C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC2520664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC2520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJaIjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:39:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727683AbeJaIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:39:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UNYUqB006875
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 19:43:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nex1jpsh3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 19:43:40 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Oct 2018 23:43:40 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 23:43:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UNhbJG3932574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 23:43:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05F2EB2065;
        Tue, 30 Oct 2018 23:43:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B74B2064;
        Tue, 30 Oct 2018 23:43:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Oct 2018 23:43:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D748B16C0276; Tue, 30 Oct 2018 16:43:36 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:43:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Reply-To: paulmck@linux.ibm.com
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030222649.GA105735@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103023-2213-0000-0000-0000030E1900
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009956; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110353; UDB=6.00575327; IPR=6.00890445;
 MB=3.00023971; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-30 23:43:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103023-2214-0000-0000-00005C157F16
Message-Id: <20181030234336.GW4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> Hi Paul,
> 
> On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > "So the smp_mb() that I was trying to add doesn't need to be there."
> > 
> > So let us remove this part from the memory ordering documentation.
> > 
> > [1] https://lkml.org/lkml/2017/10/6/707
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I was just checking about this patch. Do you feel it is correct to remove
> this part from the docs? Are you satisified that a barrier isn't needed there
> now? Or did I miss something?

Apologies, it got lost in the shuffle.  I have now applied it with a
bit of rework to the commit log, thank you!

							Thanx, Paul

> thanks,
> 
> - Joel
> 
> 
> > ---
> >  .../Tree-RCU-Memory-Ordering.html             | 32 +------------------
> >  1 file changed, 1 insertion(+), 31 deletions(-)
> > 
> > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> > index a346ce0116eb..0fb1511763d4 100644
> > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> > @@ -77,7 +77,7 @@ The key point is that the lock-acquisition functions, including
> >  <tt>smp_mb__after_unlock_lock()</tt> immediately after successful
> >  acquisition of the lock.
> >  
> > -<p>Therefore, for any given <tt>rcu_node</tt> struction, any access
> > +<p>Therefore, for any given <tt>rcu_node</tt> structure, any access
> >  happening before one of the above lock-release functions will be seen
> >  by all CPUs as happening before any access happening after a later
> >  one of the above lock-acquisition functions.
> > @@ -162,36 +162,6 @@ an <tt>atomic_add_return()</tt> of zero) to detect idle CPUs.
> >  <tr><td>&nbsp;</td></tr>
> >  </table>
> >  
> > -<p>The approach must be extended to handle one final case, that
> > -of waking a task blocked in <tt>synchronize_rcu()</tt>.
> > -This task might be affinitied to a CPU that is not yet aware that
> > -the grace period has ended, and thus might not yet be subject to
> > -the grace period's memory ordering.
> > -Therefore, there is an <tt>smp_mb()</tt> after the return from
> > -<tt>wait_for_completion()</tt> in the <tt>synchronize_rcu()</tt>
> > -code path.
> > -
> > -<table>
> > -<tr><th>&nbsp;</th></tr>
> > -<tr><th align="left">Quick Quiz:</th></tr>
> > -<tr><td>
> > -	What?  Where???
> > -	I don't see any <tt>smp_mb()</tt> after the return from
> > -	<tt>wait_for_completion()</tt>!!!
> > -</td></tr>
> > -<tr><th align="left">Answer:</th></tr>
> > -<tr><td bgcolor="#ffffff"><font color="ffffff">
> > -	That would be because I spotted the need for that
> > -	<tt>smp_mb()</tt> during the creation of this documentation,
> > -	and it is therefore unlikely to hit mainline before v4.14.
> > -	Kudos to Lance Roy, Will Deacon, Peter Zijlstra, and
> > -	Jonathan Cameron for asking questions that sensitized me
> > -	to the rather elaborate sequence of events that demonstrate
> > -	the need for this memory barrier.
> > -</font></td></tr>
> > -<tr><td>&nbsp;</td></tr>
> > -</table>
> > -
> >  <p>Tree RCU's grace--period memory-ordering guarantees rely most
> >  heavily on the <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>
> >  field, so much so that it is necessary to abbreviate this pattern
> > -- 
> > 2.19.1.568.g152ad8e336-goog
> > 
> 

