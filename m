Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A1223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5A1223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbeKPQyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:54:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727353AbeKPQyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:54:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAG6dZl6014369
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:43:17 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nsqc03j3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:43:17 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 16 Nov 2018 06:43:17 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Nov 2018 06:43:12 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAG6hB5P19136628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 06:43:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EAC4B2065;
        Fri, 16 Nov 2018 06:43:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED131B2064;
        Fri, 16 Nov 2018 06:43:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.196.200])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Nov 2018 06:43:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 750AA16C357C; Thu, 15 Nov 2018 22:43:10 -0800 (PST)
Date:   Thu, 15 Nov 2018 22:43:10 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111606-0072-0000-0000-000003C9D8E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010059; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118148; UDB=6.00577118; IPR=6.00898257;
 MB=3.00024188; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 06:43:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111606-0073-0000-0000-00004A1FF863
Message-Id: <20181116064310.GU4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:19:24AM -0500, Alan Stern wrote:
> Paul and other LKMM maintainers:
> 
> The following series of patches adds support for SRCU to the Linux
> Kernel Memory Model.  That is, it adds the srcu_read_lock(),
> srcu_read_unlock(), and synchronize_srcu() primitives to the model.
> 
> 	Patch 1/3 does some renaming of the RCU parts of the
> 	memory model's existing CAT code, to help distinguish them
> 	from the upcoming SRCU parts.
> 
> 	Patch 2/3 refactors the definitions of some RCU relations
> 	in the CAT code, in a way that the SRCU portions will need.
> 
> 	Patch 3/3 actually adds the SRCU support.
> 
> This new code requires herd7 version 7.51+4(dev) or later (now 
> available in the herdtools7 github repository) to run.  Thanks to Luc 
> for making the necessary changes to support SRCU.

These patches pass the tests that I have constructed, and also regression
tests, very nice!  Applied and pushed, thank you.

> The code does not check that the index argument passed to 
> srcu_read_unlock() is the same as the value returned by the 
> corresponding srcu_read_lock() call.  This is deemed to be a semantic 
> issue, not directly relevant to the memory model.

Agreed.

If I understand correctly, there are in theory some use cases that these
patches do not support, for example:

	r1 = srcu_read_lock(a);
	do_1();
	r2 = srcu_read_lock(a);
	do_2();
	srcu_read_unlock(a, r1);
	do_3();
	srcu_read_unlock(a, r2);

In practice, I would be more worried about this had I ever managed to
find a non-bogus use case for this pattern.  ;-)

							Thanx, Paul

