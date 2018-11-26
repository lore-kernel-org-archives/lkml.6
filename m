Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6968FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D38021104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeK0Jaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:30:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbeK0Jav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:30:51 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQMYKQ3074979
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:35:13 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p0q72e7m9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:35:13 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 26 Nov 2018 22:35:11 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 22:35:07 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQMZ6lx18874546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 22:35:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D91B2065;
        Mon, 26 Nov 2018 22:35:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4965EB2067;
        Mon, 26 Nov 2018 22:35:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Nov 2018 22:35:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0FE7316C356B; Mon, 26 Nov 2018 14:35:09 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:35:09 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
 <20181119120120.GA5092@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119120120.GA5092@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112622-0040-0000-0000-00000498A2D3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010126; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123208; UDB=6.00577119; IPR=6.00903337;
 MB=3.00024343; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 22:35:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112622-0041-0000-0000-000008A1B7D3
Message-Id: <20181126223509.GM4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:01:20PM +0100, Andrea Parri wrote:
> On Thu, Nov 15, 2018 at 11:19:24AM -0500, Alan Stern wrote:
> > Paul and other LKMM maintainers:
> > 
> > The following series of patches adds support for SRCU to the Linux
> > Kernel Memory Model.  That is, it adds the srcu_read_lock(),
> > srcu_read_unlock(), and synchronize_srcu() primitives to the model.
> > 
> > 	Patch 1/3 does some renaming of the RCU parts of the
> > 	memory model's existing CAT code, to help distinguish them
> > 	from the upcoming SRCU parts.
> > 
> > 	Patch 2/3 refactors the definitions of some RCU relations
> > 	in the CAT code, in a way that the SRCU portions will need.
> > 
> > 	Patch 3/3 actually adds the SRCU support.
> > 
> > This new code requires herd7 version 7.51+4(dev) or later (now 
> > available in the herdtools7 github repository) to run.  Thanks to Luc 
> > for making the necessary changes to support SRCU.
> 
> Thank you Alan, Luc.
> 
> My only suggestion is to integrate changes to explanation.txt (in part.,
> Sect. 22), which the above renaming and refactoring make out-of-date.

Also tools/memory-model/README, but please see below.

> For this version,
> 
> Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied to all three, thank you!

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > The code does not check that the index argument passed to 
> > srcu_read_unlock() is the same as the value returned by the 
> > corresponding srcu_read_lock() call.  This is deemed to be a semantic 
> > issue, not directly relevant to the memory model.
> > 
> > Alan

------------------------------------------------------------------------

commit 72f61917f12236514a70017d1ebafb9b8d34a9b6
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Nov 26 14:26:43 2018 -0800

    tools/memory-model: Update README for addition of SRCU
    
    This commit updates the section on LKMM limitations to no longer say
    that SRCU is not modeled, but instead describe how LKMM's modeling of
    SRCU departs from the Linux-kernel implementation.
    
    TL;DR:  There is no known valid use case that cares about the Linux
    kernel's ability to have partially overlapping SRCU read-side critical
    sections.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 0f2c366518c6..9d7d4f23503f 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Sleepable RCU (SRCU) is not modeled.  It can be
-		emulated, but perhaps not simply.
+	e.	Although sleepable RCU (SRCU) is now modeled, there
+		are some subtle differences between its semantics and
+		those in the Linux kernel.  For example, the kernel
+		might interpret the following sequence as two partially
+		overlapping SRCU read-side critical sections:
+
+			 1  r1 = srcu_read_lock(&my_srcu);
+			 2  do_something_1();
+			 3  r2 = srcu_read_lock(&my_srcu);
+			 4  do_something_2();
+			 5  srcu_read_unlock(&my_srcu, r1);
+			 6  do_something_3();
+			 7  srcu_read_unlock(&my_srcu, r2);
+
+		In contrast, LKMM will interpret this as a nested pair of
+		SRCU read-side critical sections, with the outer critical
+		section spanning lines 1-7 and the inner critical section
+		spanning lines 3-5.
+
+		This difference would be more of a concern had anyone
+		identified a reasonable use case for partially overlapping
+		SRCU read-side critical sections.  For more information,
+		please see: https://paulmck.livejournal.com/40593.html
 
 	f.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write

