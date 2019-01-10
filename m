Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35764C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F278E21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAJEUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:20:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfAJEUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:20:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0A4JiCT035502
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 23:20:36 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwxaq19dk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:20:35 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 04:20:34 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 04:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0A4KSvg11600094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 04:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C83B2065;
        Thu, 10 Jan 2019 04:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0F5BB2068;
        Thu, 10 Jan 2019 04:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.186.123])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 04:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A5C1A16C641B; Wed,  9 Jan 2019 20:20:27 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:20:27 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
 <20190109234043.GD1215@linux.ibm.com>
 <20190110003952.GA4354@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110003952.GA4354@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011004-0052-0000-0000-0000037618C9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010376; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144277; UDB=6.00595791; IPR=6.00924543;
 MB=3.00025059; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 04:20:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011004-0053-0000-0000-00005F68BBD6
Message-Id: <20190110042027.GG1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:39:52AM +0100, Andrea Parri wrote:
> On Wed, Jan 09, 2019 at 03:40:43PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> > > On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > This series contains updates for the Linux-kernel memory model:
> > > > 
> > > > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > > > 
> > > > 4.	Update README for adding of SRCU support.
> > > > 
> > > > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > > > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > > > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > > > 	posted some feedback from an Intel manual here, which might
> > > > 	be considered to be a close substitute, but...  ;-)
> > > > 
> > > > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > > > 
> > > > 6.	Update Documentation/explanation.txt to include SRCU support,
> > > > 	courtesy of Alan Stern.
> > > > 
> > > > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > > > 	Luc Maranget.  This needs an ack.
> > > 
> > > It seems that
> > > 
> > >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > >   
> > > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > > considered that, IIRC, you introduced the primitive and RCU is currently
> > > its only user.)
> > 
> > That commit is in -tip:
> > 
> > 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > 
> > So it has already left my -rcu tree.  ;-)
> 
> Oh, you're right: now I see the commit (e.g., with "git show"), but I
> don't see the corresponding changes applied to the tree.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core
> 
> Is this expected?

Are you asking why it is in -tip but not in mainline?  I am not sure,
but given that the merge window was over the holiday season and that
the length of the merge window proved to be shorter than many people
expected it to be, I am not too surprised.  ;-)

							Thanx, Paul

