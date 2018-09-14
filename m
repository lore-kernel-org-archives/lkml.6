Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B410ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB00720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeINVwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:52:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727866AbeINVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:52:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EGYY8Z083326
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 12:36:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mgghcrb7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 12:36:57 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 12:36:56 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 12:36:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8EGanQw19791998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 16:36:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B14B2066;
        Fri, 14 Sep 2018 12:35:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9186B2065;
        Fri, 14 Sep 2018 12:35:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Sep 2018 12:35:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E48316C3727; Fri, 14 Sep 2018 09:36:49 -0700 (PDT)
Date:   Fri, 14 Sep 2018 09:36:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Reply-To: paulmck@linux.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091416-2213-0000-0000-000002EEB2F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009720; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01088265; UDB=6.00562026; IPR=6.00868277;
 MB=3.00023293; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-14 16:36:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091416-2214-0000-0000-00005B8DFD3F
Message-Id: <20180914163649.GA13942@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 02:10:18PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains memory-model updates, not yet ready for inclusion:

Summarizing my current state for the week after next's planned
for-inclusion series:

	ccc8b5139f65 tools/memory-model: Add litmus-test naming scheme
	c8c5779c854f tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
	a5109023cf9e tools/memory-model: Fix a README typo
	abdb4ce79ba3 tools/memory-model: Add more LKMM limitations

		I have these queued for the next merge window.	There has
		been some discussion of c8c5779c854f, and it would be
		good to resolve issues.  However, the patch is supported
		by Peter Zijlstra (x86) and Will Deacon (ARM), so I
		am OK sending it as-is if needed.  We always have the
		opportunity of adding other patches as needed.

		The latest email from Andrea indicated some concerns about
		the commit log, which cannot be changed after acceptance,
		so resolving those concerns is the highest priority.

	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()

		Small change, needs an ack.  Looks to me like is is
		just aligning the documentation with the code, so
		should not be controversial (famous last words).

		Please take a look and consider giving feedback
		and/or a review/ack.

	f3625642c96d EXP tools/memory-model: Add scripts to check github litmus tests
	eaaac2854b75 EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"

		These add regression-test capability and need a review
		and/or ack before they can be submitted.  I do not
		consider them to be particularly urgent.

							Thanx, Paul

