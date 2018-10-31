Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE2820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeKADRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:17:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729206AbeKADRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:17:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VIFIpx124879
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:17:51 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nffw0vrqp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:17:51 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Oct 2018 18:17:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 18:17:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VIHlFU43188356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 18:17:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A46B2073;
        Wed, 31 Oct 2018 18:17:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B2C5B2067;
        Wed, 31 Oct 2018 18:17:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 18:17:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 39BBA16C06E6; Wed, 31 Oct 2018 11:17:48 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:17:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Reply-To: paulmck@linux.ibm.com
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031011119.GF224709@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103118-0060-0000-0000-000002CAA289
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009961; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110724; UDB=6.00575550; IPR=6.00890816;
 MB=3.00023982; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 18:17:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103118-0061-0000-0000-0000470AC112
Message-Id: <20181031181748.GG4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 06:11:19PM -0700, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > > 
> > > > So let us remove this part from the memory ordering documentation.
> > > > 
> > > > [1] https://lkml.org/lkml/2017/10/6/707
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > I was just checking about this patch. Do you feel it is correct to remove
> > > this part from the docs? Are you satisified that a barrier isn't needed there
> > > now? Or did I miss something?
> > 
> > Apologies, it got lost in the shuffle.  I have now applied it with a
> > bit of rework to the commit log, thank you!
> 
> No worries, thanks for taking it!
> 
> Just wanted to update you on my progress reading/correcting the docs. The
> 'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
> on finishing all the other low hanging fruit. This activity is mostly during
> night hours after the baby is asleep but some times I also manage to sneak it
> into the day job ;-)

If there is anything I can do to make this a more sustainable task for
you, please do not keep it a secret!!!

> BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> had time, even though we are removing it from the documentation. I thought
> about it a few times, and I was not able to fully appreciate the need for the
> barrier (that is even assuming that complete() etc did not do the right
> thing).  Specifically I was wondering same thing Peter said in the above
> thread I think that - if that rcu_read_unlock() triggered all the spin
> locking up the tree of nodes, then why is that locking not sufficient to
> prevent reads from the read-side section from bleeding out? That would
> prevent the reader that just unlocked from seeing anything that happens
> _after_ the synchronize_rcu.

Actually, I recall an smp_mb() being added, but am not seeing it anywhere
relevant to wait_for_completion().  So I might need to add the smp_mb()
to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/

The short form answer is that anything before a grace period on any CPU
must be seen by any CPU as being before anything on any CPU after that
same grace period.  This guarantee requires a rather big hammer.

But yes, let's talk at LPC!

> Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> me that the RCU reader-sections are virtually extended both forward and
> backward and whereever it ends, those paths do heavy-weight synchronization
> that should be sufficient to prevent memory ordering issues (such as those
> you mentioned in the Requierments document). That is exactly why we don't
> need explicit barriers during rcu_read_unlock. If I recall I asked you why
> those are not needed. So that answer made sense, but then now on going
> through the 'Memory Ordering' document, I see that you mentioned there is
> reliance on the locking. Is that reliance on locking necessary to maintain
> ordering then?

There is a "network" of locking augmented by smp_mb__after_unlock_lock()
that implements the all-to-all memory ordering mentioned above.  But it
also needs to handle all the possible complete()/wait_for_completion()
races, even those assisted by hypervisor vCPU preemption.

> Or did I miss the points completely? :(

A question for the ages for both of us!  ;-)

> ----------------------
> TODO list of the index file marking which ones I have finished perusing:
> 
> arrayRCU.txt			DONE
> checklist.txt			DONE
> listRCU.txt			DONE
> lockdep.txt			DONE
> lockdep-splat.txt		DONE
> NMI-RCU.txt
> rcu_dereference.txt
> rcubarrier.txt
> rculist_nulls.txt
> rcuref.txt
> rcu.txt
> RTFP.txt			DONE
> stallwarn.txt			DONE
> torture.txt
> UP.txt
> whatisRCU.txt			DONE
> 
> Design
>  - Data-Structures		DONE
>  - Requirements			DONE
>  - Expedited-Grace-Periods
>  - Memory Ordering		next

Great progress, and again, thank you!!!

							Thanx, Paul

