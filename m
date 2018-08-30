Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF4DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeH3HWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:22:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbeH3HWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:22:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7U3IiF2084613
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 23:22:23 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m637ysxvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 23:22:23 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 23:22:21 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 23:22:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7U3MG9W26148876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 03:22:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B45B2068;
        Wed, 29 Aug 2018 23:21:12 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0CCB205F;
        Wed, 29 Aug 2018 23:21:12 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.196.106])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 23:21:12 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0ECBE16C8DED; Wed, 29 Aug 2018 20:22:16 -0700 (PDT)
Date:   Wed, 29 Aug 2018 20:22:16 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829220026.3579e9a1@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083003-0064-0000-0000-0000034440B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009637; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080838; UDB=6.00557554; IPR=6.00860822;
 MB=3.00023004; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 03:22:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083003-0065-0000-0000-00003A78F99B
Message-Id: <20180830032216.GF4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:00:26PM -0400, Steven Rostedt wrote:
> On Wed, 29 Aug 2018 15:38:30 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Hello!
> > 
> > This commit does RCU-consolidation cleanups that get rid of pointers to
> > the sole remaining rcu_state structure:
> > 
> > 1-40:	Remove the "rsp" parameter from numerous functions, given that
> > 	the corresponding argument will always be &rcu_state.
> 
> Hmm, couldn't 1-40 have been made into a single patch?

They could.  I separated them to make finding the inevitable typos easier.
But at this point, it is easy enough to squash them together, though.

							Thanx, Paul

> -- Steve
> 
> > 
> > 41.	Remove rcu_data structure's ->rsp field, now that it always
> > 	contains a pointer to rcu_state.
> > 
> > 42.	Remove non-flavor-traversal rsp local variable from tree_plugin.h.
> > 
> > 43.	Remove the for_each_rcu_flavor() flavor-traversal macro, given
> > 	that there is now only ever one flavor to traverse.
> > 
> > 44.	Simplify rcutorture_get_gp_data() based on there now being only
> > 	one rcu_state structure.
> > 
> > 45.	Restructure rcu_check_gp_kthread_starvation() based on there
> > 	now being only one rcu_state structure.
> > 
> > 46.	Restructure RCU CPU stall warnings based on there now being only
> > 	one rcu_state structure.
> > 
> > 47.	Restructure grace-period management code based on there now being
> > 	only one rcu_state structure.
> > 
> > 48.	Restructure callback registration/invocation code based on there
> > 	now being only one rcu_state structure.
> > 
> > 49.	Restructure quiescent-state and grace-period-nonstart code based
> > 	on there now being only one rcu_state structure.
> > 
> > 50.	Restructure rcu_barrier() based on there now being only one
> > 	rcu_state structure.
> > 
> > 51.	Restructure initialization code based on there now being only
> > 	one rcu_state structure.
> > 
> > 52.	Fix typo in force_qs_rnp()'s parameter's parameter, which was
> > 	located by searching for "rsp".
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  Documentation/RCU/Design/Data-Structures/Data-Structures.html |   23 
> >  kernel/rcu/rcu.h                                              |   28 
> >  kernel/rcu/srcutree.c                                         |    4 
> >  kernel/rcu/tree.c                                             | 1261 ++++------
> >  kernel/rcu/tree.h                                             |   29 
> >  kernel/rcu/tree_exp.h                                         |  209 -
> >  kernel/rcu/tree_plugin.h                                      |  203 -
> >  7 files changed, 784 insertions(+), 973 deletions(-)
> 

