Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406C12156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406C12156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbeIVHGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 03:06:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbeIVHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 03:06:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8M19I1Y051457
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 21:14:35 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mnabxjnxb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 21:14:35 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 21:14:34 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 21:14:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8M1ETq429229100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Sep 2018 01:14:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF817B2067;
        Fri, 21 Sep 2018 21:12:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC63B2065;
        Fri, 21 Sep 2018 21:12:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.169.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 21:12:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 89A8E16C1EA9; Fri, 21 Sep 2018 18:14:28 -0700 (PDT)
Date:   Fri, 21 Sep 2018 18:14:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] Documentation: RCU: Clarify comment about fanout
Reply-To: paulmck@linux.ibm.com
References: <20180921223153.114728-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921223153.114728-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092201-0068-0000-0000-00000340360A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009749; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091778; UDB=6.00564141; IPR=6.00871803;
 MB=3.00023443; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-22 01:14:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092201-0069-0000-0000-000045D11C34
Message-Id: <20180922011428.GU4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809220010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:31:53PM -0400, Joel Fernandes (Google) wrote:
> RCU Data-Structures document describes a trick to test RCU with small
> number of CPUs but with a larger tree. It wasn't immediately clear how
> the document arrived at 16 CPUs which also requires setting the
> FANOUT_LEAF to 2 instead of the default of 16. Clarify that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, applied, thank you!  You know, those two Kconfig options
are so closely linked in my mind that I doubt if I would ever have
noticed this issue.  So good show!

I of course could not resist doing a bit of editing.  Could you please
check the following to make sure that I didn't mess something up?

							Thanx, Paul

------------------------------------------------------------------------

commit 9870c5b0f7b41a7b6085c20c22b320681800dabc
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Fri Sep 21 18:31:53 2018 -0400

    doc: Clarify RCU data-structure comment about rcu_tree fanout
    
    RCU Data-Structures document describes a trick to test RCU with small
    number of CPUs but with a taller tree. It wasn't immediately clear how
    the document arrived at 16 CPUs which also requires setting the
    FANOUT_LEAF to 2 instead of the default of 16.  This commit therefore
    provides the needed clarification.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 1d2051c0c3fc..476b1ac38e4c 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -127,9 +127,11 @@ CPUs, RCU would configure the <tt>rcu_node</tt> tree as follows:
 </p><p>RCU currently permits up to a four-level tree, which on a 64-bit system
 accommodates up to 4,194,304 CPUs, though only a mere 524,288 CPUs for
 32-bit systems.
-On the other hand, you can set <tt>CONFIG_RCU_FANOUT</tt> to be
-as small as 2 if you wish, which would permit only 16 CPUs, which
-is useful for testing.
+On the other hand, you can set both <tt>CONFIG_RCU_FANOUT</tt> and
+<tt>CONFIG_RCU_FANOUT_LEAF</tt> to be as small as 2, which would result
+in a 16-CPU test using a 4-level tree.
+This can be useful for testing large-system capabilities on small test
+machines.
 
 </p><p>This multi-level combining tree allows us to get most of the
 performance and scalability

