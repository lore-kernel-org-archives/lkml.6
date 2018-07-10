Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B47C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2C0208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C0208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeGJUD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:03:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732205AbeGJUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:03:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AJxNU6030546
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:03:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k50mxynbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:03:20 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 16:03:18 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 16:03:13 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AK3D247012718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 20:03:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12144B2064;
        Tue, 10 Jul 2018 16:02:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6B6DB2067;
        Tue, 10 Jul 2018 16:02:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 16:02:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 99B3916C37D8; Tue, 10 Jul 2018 13:05:31 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:05:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        npiggin@gmail.com, peterz@infradead.org, will.deacon@arm.com,
        dlustig@nvidia.com
Subject: Re: LKMM patch scorecard for v4.19 merge window
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180707001751.GA4336@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807091418022.2462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807091418022.2462-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071020-0040-0000-0000-0000044CBE28
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009346; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059447; UDB=6.00543735; IPR=6.00837367;
 MB=3.00022091; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 20:03:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071020-0041-0000-0000-00000852E1EE
Message-Id: <20180710200531.GD3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:18:53PM -0400, Alan Stern wrote:
> On Fri, 6 Jul 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > Here is the updated scorecard:
> > 
> > e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
> > c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
> > 2f5a1b9b74a2 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
> > e1c071fab8e1 locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
> > b95546bdac98 tools/memory-model: Remove ACCESS_ONCE() from recipes
> > a1e5fd06bb6b tools/memory-model: Remove ACCESS_ONCE() from model
> > a54df4f2be14 tools/memory-model: Make scripts executable
> > c6b04f78bf25 docs: atomic_ops: Describe atomic_set as a write operation
> > 36853a86cf04 tools/memory-model: Add informal LKMM documentation to MAINTAINERS
> > 950ba9d5bb8f sched: Use smp_mb() in wake_woken_function()
> > c7af75d2ba8b locking: Clarify requirements for smp_mb__after_spinlock()
> > bc8209732066 doc: Update wake_up() & co. memory-barrier guarantees
> > 
> > 	All of these are ready for the upcoming merge window,
> > 	thanks everyone!
> > 
> > 473fd6e42ddc tools/memory-model: Rename litmus tests to comply to norm7
> > 
> > 	This one still needs an ack.
> 
> I have audited this patch.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you very much!  I have added your ack and moved this to the group
to be submitted for the next merge window.  I plan to send them off early
next week.

							Thanx, Paul

