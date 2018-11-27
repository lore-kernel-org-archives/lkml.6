Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CB72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CB72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbeK1FjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:39:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbeK1FjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:39:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARIYUcX066770
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:40:28 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p17j3b4rr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:40:27 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 27 Nov 2018 18:40:26 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 18:40:22 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARIeLB717629306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 18:40:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7AB9B205F;
        Tue, 27 Nov 2018 18:40:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73E0B2064;
        Tue, 27 Nov 2018 18:40:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 18:40:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7EC4916C32AD; Tue, 27 Nov 2018 10:40:21 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:40:21 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will.deacon@arm.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] docs/memory-barriers.txt: Enforce heavy ordering for
 port I/O accesses
Reply-To: paulmck@linux.ibm.com
References: <1543251134-29867-1-git-send-email-will.deacon@arm.com>
 <20181126193349.GA3509@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126193349.GA3509@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112718-0072-0000-0000-000003D00115
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010132; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123610; UDB=6.00582089; IPR=6.00903739;
 MB=3.00024357; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 18:40:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112718-0073-0000-0000-00004A3FC48D
Message-Id: <20181127184021.GS4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:33:49PM +0100, Andrea Parri wrote:
> On Mon, Nov 26, 2018 at 04:52:14PM +0000, Will Deacon wrote:
> > David Laight explains:
> > 
> >   | A long time ago there was a document from Intel that said that
> >   | inb/outb weren't necessarily synchronised wrt memory accesses.
> >   | (Might be P-pro era). However no processors actually behaved that
> >   | way and more recent docs say that inb/outb are fully ordered.
> 
> No intention to diminish David Laight's authority of course, but I would
> have really appreciated a reference to these "recent docs" (section, pg.
> or the like, especially if a reference manual...) here...

I would be inclined to cut Will a break given the research for his
recent talk on this topic, but it would be good to get an ack from
someone from Intel.  And memory-model patches require an ack or better
in any case.  ;-)

							Thanx, Paul

> > This also reflects the situation on other architectures, the the port
> > accessor macros tend to be implemented in terms of readX/writeX.
> > 
> > Update Documentation/memory-barriers.txt to reflect reality.
> 
> ..., IOW, what do you mean by "reality"?
> 
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: David Laight <David.Laight@ACULAB.COM>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Please Cc me on future patches to memory-barriers.txt (can not speak for
> my co-maintainers, but I'm inclined to say that get_maintainers.pl knows
> better...).
> 
>   Andrea
> 
> 
> > ---
> > 
> > Just remembered I had this patch kicking around in my tree...
> > 
> >  Documentation/memory-barriers.txt | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index c1d913944ad8..0c34c5dac138 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -2619,10 +2619,8 @@ functions:
> >       intermediary bridges (such as the PCI host bridge) may not fully honour
> >       that.
> >  
> > -     They are guaranteed to be fully ordered with respect to each other.
> > -
> > -     They are not guaranteed to be fully ordered with respect to other types of
> > -     memory and I/O operation.
> > +     They are guaranteed to be fully ordered with respect to each other and
> > +     also with respect to other types of memory and I/O operation.
> >  
> >   (*) readX(), writeX():
> >  
> > -- 
> > 2.1.4
> > 
> 

