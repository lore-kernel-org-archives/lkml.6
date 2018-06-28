Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFCD27755
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFCD27755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935963AbeF1Rkn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:40:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933815AbeF1Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:40:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SHd1UV132224
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:40:42 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw2ehdeek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:40:42 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 13:40:40 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 13:40:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SHeY8c38142052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 17:40:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65A0B206B;
        Thu, 28 Jun 2018 13:40:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97293B206A;
        Thu, 28 Jun 2018 13:40:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 13:40:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B534A16CA2C2; Thu, 28 Jun 2018 10:42:40 -0700 (PDT)
Date:   Thu, 28 Jun 2018 10:42:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, kernel-team@android.com
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
 <20180627043913.GA177710@joelaf.mtv.corp.google.com>
 <20180627175436.GC3593@linux.vnet.ibm.com>
 <20180627182726.GA79165@joelaf.mtv.corp.google.com>
 <20180628051028.GB79165@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628051028.GB79165@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062817-2213-0000-0000-000002C16A83
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009272; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053639; UDB=6.00540251; IPR=6.00831561;
 MB=3.00021910; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 17:40:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062817-2214-0000-0000-00005AA3EAAC
Message-Id: <20180628174240.GM3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:10:28PM -0700, Joel Fernandes wrote:
> On Wed, Jun 27, 2018 at 11:27:26AM -0700, Joel Fernandes wrote:
> [..]
> > > > > 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> > > > > 
> > > > 
> > > > I agree with Peter's suggestions for both the verbiage reduction in the
> > > > comments in the header, as the new code he is proposing is more
> > > > self-documenting. I believe I proposed a big comment just because the code
> > > > wasn't self-documenting or obvious previously so needed an explanation.
> > > > 
> > > > How would you like to proceed? Let me know what you guys decide, I am really
> > > > Ok with anything. If you guys agree, should I write a follow-up patch with
> > > > Peter's suggestion that applies on top of this one?  Or do we want to drop
> > > > this one in favor of Peter's suggestion?
> > > 
> > > Shortening the comment would be good, so please do that.
> 
> Paul,
> 
> Do you want to fold the below patch into the original one? Or do you prefer I
> resent the original patch fixed up?
> 
> Following is the patch ontop of current 'dev' branch in your tree, with the
> excessive comments removed.
> 
> Thanks to Peter for suggesting!

I merged this into the current commit, with the result shown below.

Thank you both!

							Thanx, Paul

-----------------------------------------------------------------------

commit c9a6ed70aad9f4571afba3e12e869f5fccc26a40
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Tue May 22 23:38:13 2018 -0700

    rcu: Add comment documenting how rcu_seq_snap works
    
    rcu_seq_snap may be tricky to decipher. Lets document how it works with
    an example to make it easier.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Shrink comment as suggested by Peter Zijlstra. ]

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index aa215d6355f8..89f13fffac73 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -91,7 +91,17 @@ static inline void rcu_seq_end(unsigned long *sp)
 	WRITE_ONCE(*sp, rcu_seq_endval(sp));
 }
 
-/* Take a snapshot of the update side's sequence number. */
+/*
+ * rcu_seq_snap - Take a snapshot of the update side's sequence number.
+ *
+ * This function returns the earliest value of the grace-period sequence number
+ * that will indicate that a full grace period has elapsed since the current
+ * time.  Once the grace-period sequence number has reached this value, it will
+ * be safe to invoke all callbacks that have been registered prior to the
+ * current time. This value is the current grace-period number plus two to the
+ * power of the number of low-order bits reserved for state, then rounded up to
+ * the next value in which the state bits are all zero.
+ */
 static inline unsigned long rcu_seq_snap(unsigned long *sp)
 {
 	unsigned long s;

