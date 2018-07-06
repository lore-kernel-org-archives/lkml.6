Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A96C20020
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A96C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeGFOxY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932413AbeGFOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:53:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66EmwB6088310
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 10:53:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k292sm1aq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:53:22 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 10:53:21 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 10:53:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66ErGkD6619428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 14:53:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DF9DB2066;
        Fri,  6 Jul 2018 10:52:56 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC0AB205F;
        Fri,  6 Jul 2018 10:52:56 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 10:52:56 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7212816CA5DE; Fri,  6 Jul 2018 07:55:32 -0700 (PDT)
Date:   Fri, 6 Jul 2018 07:55:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com, davem@davemloft.net
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
 <20180628165111.GA4013@andrea>
 <20180702185415.GR3593@linux.vnet.ibm.com>
 <20180703101241.GA29602@andrea>
 <20180703155303.GA3593@linux.vnet.ibm.com>
 <20180703172342.GA3601@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703172342.GA3601@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070614-0064-0000-0000-000003263655
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009319; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057423; UDB=6.00542521; IPR=6.00835344;
 MB=3.00022027; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 14:53:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070614-0065-0000-0000-000039D7A095
Message-Id: <20180706145532.GG3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 07:23:42PM +0200, Andrea Parri wrote:
> > commit 33a58ee5eadadfb1f4850eabd4fac332984881d5
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Tue Jul 3 08:48:09 2018 -0700
> > 
> >     tools/memory-model: Add informal LKMM documentation to MAINTAINERS
> >     
> >     The Linux-kernel memory model has been informal, with a number of
> >     text files documenting it.  It would be good to make sure that these
> >     informal descriptions are kept up to date and/or pruned appropriately.
> >     This commit therefore brings more of those text files into the LKMM
> >     MAINTAINERS file entry.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     Cc: Alan Stern <stern@rowland.harvard.edu>
> >     Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> >     Cc: Will Deacon <will.deacon@arm.com>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Boqun Feng <boqun.feng@gmail.com>
> >     Cc: Nicholas Piggin <npiggin@gmail.com>
> >     Cc: David Howells <dhowells@redhat.com>
> >     Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> >     Cc: Luc Maranget <luc.maranget@inria.fr>
> >     Cc: Akira Yokosawa <akiyks@gmail.com>
> >     Cc: Daniel Lustig <dlustig@nvidia.com>
> >     Cc: "David S. Miller" <davem@davemloft.net>
> 
> With the disclaimer that I'm not (yet) familiar with reST,
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> Adding the linux-arch ML, as you suggested, would also make sense to me.

Very good, thank you!  I have a --squash commit in -rcu to add your ack
and also linux-arch@vger.kernel.org.

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f2903b818671..2ba947fc9a2f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8321,6 +8321,10 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >  F:	tools/memory-model/
> > +F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/atomic_t.txt
> > +F:	Documentation/core-api/atomic_ops.rst
> > +F:	Documentation/core-api/refcount-vs-atomic.rst
> >  F:	Documentation/memory-barriers.txt
> >  
> >  LINUX SECURITY MODULE (LSM) FRAMEWORK
> > 
> 

