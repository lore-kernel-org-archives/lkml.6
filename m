Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E862C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E372190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfBLTYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:24:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729466AbfBLTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:24:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CJEHRq023246
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:24:11 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qm3bfac94-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:24:10 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Feb 2019 19:24:10 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 19:24:06 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CJO56p14024856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 19:24:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC52B2066;
        Tue, 12 Feb 2019 19:24:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4006BB2064;
        Tue, 12 Feb 2019 19:24:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Feb 2019 19:24:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8C2B816C63F0; Tue, 12 Feb 2019 11:24:05 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:24:05 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Reply-To: paulmck@linux.ibm.com
References: <20190211172948.3322-1-will.deacon@arm.com>
 <20190211202218.GQ4240@linux.ibm.com>
 <20190212184354.GC20961@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212184354.GC20961@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19021219-0072-0000-0000-000003F8F097
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010584; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160107; UDB=6.00605458; IPR=6.00940657;
 MB=3.00025549; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-12 19:24:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021219-0073-0000-0000-00004B28F309
Message-Id: <20190212192405.GU4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:43:54PM +0000, Will Deacon wrote:
> On Mon, Feb 11, 2019 at 12:22:18PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 11, 2019 at 05:29:48PM +0000, Will Deacon wrote:
> > > The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
> > > x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
> > > This is largely because I/O ordering is a horrible can of worms, but also
> > > because the document has stagnated as our understanding has evolved.
> > > 
> > > Attempt to address some of that, by rewriting the section based on
> > > recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
> > > find a way to formalise this stuff, but for now let's at least try to
> > > make the English easier to understand.
> > > 
> > > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > Cc: Daniel Lustig <dlustig@nvidia.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > Hello, Will,
> > 
> > The intent is to replace commit 3f305018dcf3 ("docs/memory-barriers.txt:
> > Enforce heavy ordering for port I/O accesses"), correct?  Either way is
> > fine, just guessing based on the conflicts when applying this one.  ;-)
> 
> Yup, I decided to abandon the old patch:
> 
> http://lkml.kernel.org/r/20190211153043.GC32385@fuggles.cambridge.arm.com

Got it, and thank you for the reminder!

							Thanx, Paul

