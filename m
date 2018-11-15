Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44552087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44552087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeKPJG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:06:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbeKPJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:06:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAFMtODF008107
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:56:40 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nsfewyq7e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:56:39 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Nov 2018 22:56:37 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 22:56:32 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAFMuV9Z44171400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 22:56:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFAC3B206C;
        Thu, 15 Nov 2018 22:56:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEEC6B2064;
        Thu, 15 Nov 2018 22:56:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.168.9])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Nov 2018 22:56:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 40B0216C373E; Thu, 15 Nov 2018 14:56:30 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:56:30 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Q&A from "Concurrency with tools/memory-model"
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111522-0040-0000-0000-0000049333FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010057; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117993; UDB=6.00577119; IPR=6.00898102;
 MB=3.00024184; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-15 22:56:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111522-0041-0000-0000-0000089C3FE6
Message-Id: <20181115225630.GA30917@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=343 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Good turnout and some good questions here in Vancouver BC, please see
below for rough notes.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

"Concurrency with tools/memory-model"

Andrea Parri presenting.

Rough notes of Q&A.

o	Want atomic bit operation.

o	But smp_read_barrier_depends() not there, so how to note pairing?
	A:  Note the dependency as the other end of the pairing.

o	Speculation barriers, as in Spectre and Meltdown?  A: This would
	require adding timing, not in the immediate future.

o	What ordering does system calls provide?  A: None that we know of.
	Boqun: Userspace needs to explicitly provide the needed ordering
	when interacting with the kernel.  Some architectures do provide
	full barriers, but not to be counted on.

o	Why herd7?  A: Based on other formalizations -- note that herd7
	had a number of hardware models.  Paul: Plus the founder of the
	LKMM project is a co-author of herd, which might have had some
	effect.

o	Why not also model interrupts and NMIs?  Promela and spin have
	been used for this.  A: Cannot currently model them.  You can
	emulated them with additional threads and locks, if you wish.
	Vincent Nimal and Lihao Liang have done some academic work on
	these topics.

