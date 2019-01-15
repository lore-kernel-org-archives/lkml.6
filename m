Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB991C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B534D204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAOPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:23:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728798AbfAOPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:23:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FFJHSQ029213
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:23:46 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1h5buqtq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:23:46 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 15 Jan 2019 15:23:45 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 15:23:41 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FFNef712058790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 15:23:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 650ABB2068;
        Tue, 15 Jan 2019 15:23:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DB5B2065;
        Tue, 15 Jan 2019 15:23:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jan 2019 15:23:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B45CA16C6108; Tue, 15 Jan 2019 07:23:40 -0800 (PST)
Date:   Tue, 15 Jan 2019 07:23:40 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Reply-To: paulmck@linux.ibm.com
References: <CACT4Y+bYKPeyURX9K8i_ySEhqJ5OnFP1_=+u9=Y_Y+fYOo_jGQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1901151002040.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901151002040.1408-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011515-0068-0000-0000-000003830479
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010411; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146867; UDB=6.00597360; IPR=6.00927159;
 MB=3.00025137; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-15 15:23:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011515-0069-0000-0000-000047247109
Message-Id: <20190115152340.GX1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:03:26AM -0500, Alan Stern wrote:
> On Tue, 15 Jan 2019, Dmitry Vyukov wrote:
> 
> > On Tue, Jan 15, 2019 at 12:54 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Mon, Jan 14, 2019 at 02:41:49PM -0500, Alan Stern wrote:
> > > > The patch below is my first attempt at adapting the Linux Kernel
> > > > Memory Model to handle plain accesses (i.e., those which aren't
> > > > specially marked as READ_ONCE, WRITE_ONCE, acquire, release,
> > > > read-modify-write, or lock accesses).  This work is based on an
> > > > initial proposal created by Andrea Parri back in December 2017,
> > > > although it has grown a lot since then.
> > >
> > > Hello, Alan,
> > >
> > > Good stuff!!!
> > >
> > > I tried applying this in order to test it against the various litmus
> > > tests, but no joy.  Could you please tell me what commit is this patch
> > > based on?
> > >
> > >                                                         Thanx, Paul
> > >
> > > > The adaptation involves two main aspects: recognizing the ordering
> > > > induced by plain accesses and detecting data races.  They are handled
> > > > separately.  In fact, the code for figuring out the ordering assumes
> > > > there are no data races (the idea being that if a data race is
> > > > present then pretty much anything could happen, so there's no point
> > > > worrying about it -- obviously this will have to be changed if we want
> > > > to cover seqlocks).
> > 
> > Hi Alan,
> > 
> > Is there a mailing list dedicated to this effort? Private messages
> > tend to lost over time, no archive, not possible to send a link or
> > show full history to anybody, etc.
> 
> No specific mailing list.  We've been relying on LKML.
> 
> > Re seqlocks, strictly saying defining races for seqlocks is not
> > necessary. Seqlocks can be expressed without races in C by using
> > relaxed atomic loads within the read critical section. We may consider
> > this option as well.
> 
> That seems like a reasonable approach.

What Alan said!  ;-)

							Thanx, Paul

