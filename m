Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1A20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE1A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeIFEd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:33:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbeIFEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:33:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85NwfgS079418
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 20:01:24 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maqyeaj1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 20:01:24 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 20:01:22 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 20:01:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8601HuZ42598500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 00:01:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87CDCB206E;
        Wed,  5 Sep 2018 20:00:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 568BFB2066;
        Wed,  5 Sep 2018 20:00:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 20:00:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6875C16C29D3; Wed,  5 Sep 2018 17:01:17 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:01:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
 <20180529121107.GF3803@linux.vnet.ibm.com>
 <20180529201713.GD591@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529201713.GD591@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090600-0064-0000-0000-0000034791B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084114; UDB=6.00559527; IPR=6.00864114;
 MB=3.00023135; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 00:01:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090600-0065-0000-0000-00003A8BB783
Message-Id: <20180906000117.GG4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:17:13PM +0100, Will Deacon wrote:
> On Tue, May 29, 2018 at 05:11:07AM -0700, Paul E. McKenney wrote:
> > On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> > > Hi Paul,
> > > 
> > > On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > > > This commit documents the scheme used to generate the names for the
> > > > litmus tests.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > ---
> > > >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > 
> > > Whilst I think documentation like this is extremely important for users,
> > > this feels like it's documenting how to drive parts of diy and I'm not
> > > convinced that it belongs in the kernel source tree as long as the projects
> > > remain separate.
> > > 
> > > Why not contribute this to the herdtools7 documentation, then just reference
> > > that from here? That would also be helpful for other people interested in
> > > memory models, but perhaps not interested in Linux (assuming such people
> > > exist ;).
> > 
> > We would still need at least a pointer from the Linux kernel to that
> > documentation, but I am happy either way.  We probably need examples of
> > the common cases, but probably not a full exposition of all the available
> > herd7 edges.
> 
> Completely agreed.
> 
> > Should this be in the herdtools7 documentation, or as added detail
> > from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
> > command?  If the latter, I suppose that the ones coming from the .bell
> > file might simply be labelled as such.
> 
> Many of the edges aren't specific to the Linux kernel, so I think they
> should be part of the diyone7 documentation. We could then describe only
> the additional edges added by the kernel memory model (e.g. "Once") in
> the kernel documentation.

And there are a -lot- of them, and they are likely to change going
forward, both in herd7 and in linux-kernel.bell.  How about if I give
examples and say where they are from and how to get a list, as in the
following --squash commit to be merged with the orginal?

							Thanx, Paul

------------------------------------------------------------------------

commit e366b8cd832535894c55265c112355c4de9a3247
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Sep 5 15:38:00 2018 -0700

    squash! EXP tools/memory-model: Add litmus-test naming scheme
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Apply feedback from Will Deacon. ]

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 08c1116c0314..5ee08f129094 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -243,56 +243,11 @@ produce the name:
 
 Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
 
+The descriptors that describe connections between consecutive accesses
+within the cycle through a given litmus test can be provided by the herd
+tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
+Release, Acquire, and so on).
 
-=======================
-LITMUS TEST DESCRIPTORS
-=======================
-
-These descriptors cover connections between consecutive accesses within
-the cycle through a given litmus test:
-
-Fre: From-read external.  The current process wrote a variable that
-	the previous process read.  Example: The SB (store buffering) test.
-Fri: From-read internal.  This process read a variable and then
-	immediately wrote to it.  Example: ???
-PodRR: Program-order different variable, read followed by read.
-	This process read a variable and again read a different variable.
-	Example: The read-side process in the MP (message-passing) test.
-PodRW: Program-order different variable, read followed by write.
-	This process read a variable and then wrote a different variable.
-	Example: The LB (load buffering) test.
-PodWR: Program-order different variable, write followed by read.
-	This process wrote a variable and then read a different variable.
-	Example: The SB (store buffering) test.
-PodWW: Program-order different variable, write followed by write.
-	This process wrote a variable and again wrote a different variable.
-	Example: The write-side process in the MP (message-passing) test.
-PosRR: Program-order same variable, read followed by read.
-	This process read a variable and again read that same variable.
-	Example: ???
-PosRW: Program-order same variable, read followed by write.
-	This process read a variable and then wrote that same variable.
-	Example: ???
-PosWR: Program-order same variable, write followed by read.
-	This process wrote a variable and then read that same variable.
-	Example: ???
-PosWW: Program-order same variable, write followed by write.
-	This process wrote a variable and again wrote that same variable.
-	Example: ???
-Rfe: Read-from external.  The current process read a variable written
-	by the previous process.  Example: The MP (message passing) test.
-Rfi: Read-from internal.  The current process wrote a variable and then
-	immediately read the value back from it.  For the purposes
-	of litmus-test code generation, Rfi acts identically to PosWR.
-	However, they differ for purposes of naming, and they also result
-	in different "exists" clauses.
-	Example:  ???
-Wse: Write same external.  The current process wrote to a variable that
-	was also written to by the previous process.  Example:  ???
-Wsi: Write same internal.  The current process wrote to a variable and
-	then immediately wrote to it again.  Example:  ???
-
-Please note that the above is a partial list.  To see the full list of
-descriptors, execute the following command:
+To see the full list of descriptors, execute the following command:
 
 	$ diyone7 -bell linux-kernel.bell -show edges

