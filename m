Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBFB20661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAIXkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:40:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbfAIXkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:40:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09NYBOE120046
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 18:40:50 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwsdvu52s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 18:40:50 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 23:40:49 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 23:40:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Nehxm22020320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 23:40:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45BF3B205F;
        Wed,  9 Jan 2019 23:40:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25E51B2067;
        Wed,  9 Jan 2019 23:40:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 23:40:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0D92B16C63FE; Wed,  9 Jan 2019 15:40:43 -0800 (PST)
Date:   Wed, 9 Jan 2019 15:40:43 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109231852.GA4494@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010923-0040-0000-0000-000004AF412E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144189; UDB=6.00593882; IPR=6.00924451;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 23:40:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010923-0041-0000-0000-000008BA45CF
Message-Id: <20190109234043.GD1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains updates for the Linux-kernel memory model:
> > 
> > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > 
> > 4.	Update README for adding of SRCU support.
> > 
> > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > 	posted some feedback from an Intel manual here, which might
> > 	be considered to be a close substitute, but...  ;-)
> > 
> > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > 
> > 6.	Update Documentation/explanation.txt to include SRCU support,
> > 	courtesy of Alan Stern.
> > 
> > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > 	Luc Maranget.  This needs an ack.
> 
> It seems that
> 
>   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
>   
> from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> considered that, IIRC, you introduced the primitive and RCU is currently
> its only user.)

That commit is in -tip:

4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")

So it has already left my -rcu tree.  ;-)

							Thanx, Paul

