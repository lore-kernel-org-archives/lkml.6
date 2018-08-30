Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6357C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D6620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D6620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH3VNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbeH3VNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:13:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UH9Lus139023
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:10:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6mcw8x3q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:10:13 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 13:10:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 13:10:06 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7UHA57F27328620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 17:10:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 090E4B2064;
        Thu, 30 Aug 2018 13:09:00 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC14AB205F;
        Thu, 30 Aug 2018 13:08:59 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 13:08:59 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C8DFC16C3063; Thu, 30 Aug 2018 10:10:06 -0700 (PDT)
Date:   Thu, 30 Aug 2018 10:10:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829223830.GA1800@linux.vnet.ibm.com>
 <20180829220026.3579e9a1@vmware.local.home>
 <20180830032216.GF4225@linux.vnet.ibm.com>
 <20180830041017.GA27378@linux.vnet.ibm.com>
 <20180830114452.309e104f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830114452.309e104f@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083017-0060-0000-0000-000002A6F98E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009639; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081113; UDB=6.00557719; IPR=6.00861098;
 MB=3.00023020; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 17:10:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083017-0061-0000-0000-000046580EE3
Message-Id: <20180830171006.GK4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:44:52AM -0400, Steven Rostedt wrote:
> On Wed, 29 Aug 2018 21:10:17 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Aug 29, 2018 at 08:22:16PM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 29, 2018 at 10:00:26PM -0400, Steven Rostedt wrote:  
> > > > On Wed, 29 Aug 2018 15:38:30 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >   
> > > > > Hello!
> > > > > 
> > > > > This commit does RCU-consolidation cleanups that get rid of pointers to
> > > > > the sole remaining rcu_state structure:
> > > > > 
> > > > > 1-40:	Remove the "rsp" parameter from numerous functions, given that
> > > > > 	the corresponding argument will always be &rcu_state.  
> > > > 
> > > > Hmm, couldn't 1-40 have been made into a single patch?  
> > > 
> > > They could.  I separated them to make finding the inevitable typos easier.
> > > But at this point, it is easy enough to squash them together, though.  
> > 
> > And please see below for what the resulting diff would look like.  Is
> > this an improvement?
> 
> Somewhat...
> 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> > index f5120a00f511..772c26a3865a 100644
> > --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> > +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
> 
> I would just keep the documentation patches separate.

Combining yours and Josh's feedback, I will split the documentation
updates out of 4ca0508f7870 ("rcu: Remove rsp parameter from rcu_node tree
accessor macros") and put them into the "doc" series.  Possibly combining
it with 2ea66b6fce61 ("doc: Update documentation for removal of RCU-bh
update machinery") and/or 3f38a4626202 ("doc: Update documentation for
removal of RCU-sched update machinery").  Left to myself, I would merge
it in to the merger of those two documentation commits.  Having them
together is probably more convenient anyway, as it would provide a
summary of the entire RCU-flavor-consolidation change.

Fair enough?

							Thanx, Paul

> -- Steve
> 
> 
> > @@ -1372,8 +1372,7 @@ that is, if the CPU is currently idle.
> >  Accessor Functions</a></h3>
> >  
> >  <p>The following listing shows the
> > -<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt>,
> > -<tt>rcu_for_each_nonleaf_node_breadth_first()</tt>, and
> > +<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
> >  <tt>rcu_for_each_leaf_node()</tt> function and macros:
> >  
> >  
> 

