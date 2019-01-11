Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC35C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6889121783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfAKVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:45:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbfAKVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:45:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BLiiCA051072
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:45:02 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxy72wdta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:45:00 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 11 Jan 2019 21:44:52 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 21:44:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BLilgU22872300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 21:44:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F20CDB2068;
        Fri, 11 Jan 2019 21:44:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0BFDB205F;
        Fri, 11 Jan 2019 21:44:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 21:44:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D3B5F16C648C; Fri, 11 Jan 2019 13:44:46 -0800 (PST)
Date:   Fri, 11 Jan 2019 13:44:46 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-7-paulmck@linux.ibm.com>
 <20190110094131.GA11647@andrea>
 <20190110144049.GK1215@linux.ibm.com>
 <20190110232045.GA3908@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110232045.GA3908@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011121-0040-0000-0000-000004B090E8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010387; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01145097; UDB=6.00593882; IPR=6.00925367;
 MB=3.00025090; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-11 21:44:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011121-0041-0000-0000-000008BB9760
Message-Id: <20190111214446.GL1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:20:45AM +0100, Andrea Parri wrote:
> > > I'm not all that exited about spreading version requirements in the
> > > source: we report this requirement in our README, and apparently we
> > > already struggle to keep this information up-to-date.  So what about
> > > squashing something like the below (assume that 7.52 will be released
> > > by the time this patch hit mainline; if this won't be the case, we
> > > may consider using the development version 7.51+6)? notice that this
> > > also removes an (obsolete, at this point) comment from lock.cat.
> > 
> > Sounds like a very good point to me!
> > 
> > Should have pointers in the various files to the README file?  Or maybe
> > get people used to using scripting that checks versions?  Or maybe
> > after answering questions for some time, people will get used to
> > checking versions?
> 
> As discussed off-list: I have no strong opinion on this regard, well,
> except that I think we ought to fix the README, somehow (consider my
> diff below as a first proposal).  Akira actually preceded me on this
> and suggested another solution [1].
> 
>   Andrea
> 
> [1] http://lkml.kernel.org/r/04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com

My concern with this approach is that it seems to me to implicitly promise
that herd will provide backwards compatibility, which is a real pain to
test, let alone to provide.  Yes, the latest version of herd probably
supports latest mainline, but will five-years-from-now herd work correctly
on the .bell, .cat, and .def files from current mainline?

							Thanx, Paul

> > >   Andrea
> > > 
> > > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > > index 9d7d4f23503fd..b362a41358fa1 100644
> > > --- a/tools/memory-model/README
> > > +++ b/tools/memory-model/README
> > > @@ -20,8 +20,8 @@ that litmus test to be exercised within the Linux kernel.
> > >  REQUIREMENTS
> > >  ============
> > >  
> > > -Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
> > > -separately:
> > > +Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> > > +downloaded separately:
> > >  
> > >    https://github.com/herd/herdtools7
> > >  
> > > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > > index 95bf45f1215fc..8dcb37835b613 100644
> > > --- a/tools/memory-model/linux-kernel.cat
> > > +++ b/tools/memory-model/linux-kernel.cat
> > > @@ -1,7 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0+
> > >  (*
> > > - * Requires herd version 7.51+6 or higher.
> > > - *
> > >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> > >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> > >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > > index 305ded17e7411..a059d1a6d8a29 100644
> > > --- a/tools/memory-model/lock.cat
> > > +++ b/tools/memory-model/lock.cat
> > > @@ -6,9 +6,6 @@
> > >  
> > >  (*
> > >   * Generate coherence orders and handle lock operations
> > > - *
> > > - * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
> > > - * spin_is_locked() is functional from herd7 version 7.49.
> > >   *)
> > >  
> > >  include "cross.cat"
> > > 
> > > 
> > > 
> > > > + *
> > > >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> > > >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> > > >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > > > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > > > index 1d6a120cde14..0c3f0ef486f4 100644
> > > > --- a/tools/memory-model/linux-kernel.def
> > > > +++ b/tools/memory-model/linux-kernel.def
> > > > @@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > > >  
> > > >  // SRCU
> > > >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
> > > > +srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > > >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > > >  
> > > >  // Atomic
> > > > -- 
> > > > 2.17.1
> > > > 
> > > 
> > 
> 

