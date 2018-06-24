Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA0C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A333A24D82
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A333A24D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeFXDe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 23:34:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751203AbeFXDeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 23:34:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5O3YFwK014307
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 23:34:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jt3frr1p7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 23:34:25 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 23 Jun 2018 23:34:23 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Jun 2018 23:34:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5O3YIsv8978688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 24 Jun 2018 03:34:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC21B2067;
        Sat, 23 Jun 2018 23:34:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3F29B2064;
        Sat, 23 Jun 2018 23:34:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jun 2018 23:34:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 60DCC16C9E59; Sat, 23 Jun 2018 20:36:21 -0700 (PDT)
Date:   Sat, 23 Jun 2018 20:36:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     andrea.parri@amarulasolutions.com,
        Daniel Lustig <dlustig@nvidia.com>, stern@rowland.harvard.edu,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180623164645.GB3593@linux.vnet.ibm.com>
 <mhng-ab979604-6177-4acf-802a-c615f7c5afc7@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-ab979604-6177-4acf-802a-c615f7c5afc7@palmer-si-x1c4>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062403-0064-0000-0000-0000031F65DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009249; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01051446; UDB=6.00538933; IPR=6.00829908;
 MB=3.00021830; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-24 03:34:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062403-0065-0000-0000-000039B22F21
Message-Id: <20180624033621.GJ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806240042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 09:53:41AM -0700, Palmer Dabbelt wrote:
> On Sat, 23 Jun 2018 09:46:45 PDT (-0700), paulmck@linux.vnet.ibm.com wrote:
> >On Sat, Jun 23, 2018 at 03:10:17AM +0200, Andrea Parri wrote:
> >>> > Thanks.  Unless anyone has any opposition I'll submit the fixed
> >>> > patch as part of my next pull request.
> >>>
> >>> Works for me, especially if this means that Daniel is RISC-V's official
> >>> representative.  ;-)
> >>
> >>I'd rather the "fixed patch" go through the LKMM's tree.  If not for
> >>other, we tend to use get_maintainer.pl on your (TBD ;/) development
> >>branch...
> >
> >True, but that is only an issue for a few weeks until it goes upstream.
> >
> >I am OK either way.
> 
> I'm happy to have the patch go through the LKMM tree.  The fixed patch is here
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/patch/?id=778c83c0bf1e1dcc6054c40945ed05b42b71c97c

Very good, I have queued it and pushed it out on branch lkmm-dev in
my -rcu tree.

							Thanx, Paul

> >>> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >>>
> >>> > commit 9d01337e4724be4d34bfe848a7c64d14bfdb89ea
> >>> > gpg: Signature made Fri 22 Jun 2018 03:35:24 PM PDT
> >>> > gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
> >>> > gpg:                issuer "palmer@dabbelt.com"
> >>> > gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> >>> > gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
> >>> > Author: Palmer Dabbelt <palmer@sifive.com>
> >>> > Date:   Fri Jun 22 14:04:42 2018 -0700
> >>> >
> >>> >    MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
> >>
> >>Nit: an LKMM
> >>
> >>
> >>> >
> >>> >    Dan runs the RISC-V memory model working group.  I've been forwarding
> >>> >    him LKMM emails that end up in my inbox, but I'm far from an expert in
> >>> >    this stuff.  He requested to be added as a reviewer, which seem sane to
> >>
> >>Nit: which seems
> >>
> >>
> >>> >    me as it'll take a human out of the loop.
> >>> >
> >>> >    CC: Daniel Lustig <dlustig@nvidia.com>
> >>> >    Acked-by: Daniel Lustig <dlustig@nvidia.com>
> >>> >    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >>
> >>Glad to read this!  Please feel free to add:
> >>
> >>Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> >>
> >>  Andrea
> >>
> >>
> >>> >
> >>> > diff --git a/MAINTAINERS b/MAINTAINERS
> >>> > index 9d5eeff51b5f..ac8ed55dbe9b 100644
> >>> > --- a/MAINTAINERS
> >>> > +++ b/MAINTAINERS
> >>> > @@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
> >>> > M:	Luc Maranget <luc.maranget@inria.fr>
> >>> > M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> >>> > R:	Akira Yokosawa <akiyks@gmail.com>
> >>> > +R:	Daniel Lustig <dlustig@nvidia.com>
> >>> > L:	linux-kernel@vger.kernel.org
> >>> > S:	Supported
> >>> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >>
> 

