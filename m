Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A7CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C262081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C262081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeKIFmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:42:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725199AbeKIFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:42:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8JsTlw116002
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 15:05:17 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmrq9gkdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:05:17 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 20:05:16 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 20:05:10 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8K59mS27721832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 20:05:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1441BB2067;
        Thu,  8 Nov 2018 20:05:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFBFBB205F;
        Thu,  8 Nov 2018 20:05:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.215.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 20:05:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8BBE216C341E; Thu,  8 Nov 2018 12:05:08 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:05:08 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, John Stultz <john.stultz@linaro.org>,
        acme@redhat.com, frederic@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Reply-To: paulmck@linux.ibm.com
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108174006.GP4170@linux.ibm.com>
 <alpine.DEB.2.21.1811082042001.1640@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811082042001.1640@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110820-0060-0000-0000-000002CFB2D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114590; UDB=6.00577875; IPR=6.00894689;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 20:05:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110820-0061-0000-0000-000047225211
Message-Id: <20181108200508.GB4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 08:58:32PM +0100, Thomas Gleixner wrote:
> On Thu, 8 Nov 2018, Paul E. McKenney wrote:
> > On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> > > On Thu, Nov 8, 2018 at 1:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > > > > > + - Cc: ``cc-ed-person <person@mail>``
> > > > > > +
> > > > > > +   If the patch should be backported to stable, then please add a '``Cc:
> > > > > > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > > > > > +   mail.
> > > > >
> > > > > Can I suggest a more canonical form:
> > > > >
> > > > >       Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> > > > >
> > > > > It would be nice if people adding Cc: stable lines would actually try to
> > > > > figure out which exact kernel versions are affected.
> > > 
> > > I know at least StGit mail does not grok that "#"notation. I've
> > > stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> > > preferred over "# <KVER>" if only because it can be used to track
> > > fixes to commits that have been backported to stable. Is there any
> > > reason for "# <KVER>" to continue in a world where we have "Fixes:"?
> > 
> > I sometimes have fixes that need to be different for different past
> > releases.  And there have been cases where RCU patches would apply and
> > build cleanly against releases for which it was not appropriate, but
> > would have some low-probability failure.  Which meant that it could be
> > expected to pass light testing.  :-/
> > 
> > So I sometimes need a way of saying which versions a given patch applies
> > to, independent of the version into which the bug was introduced.
> 
> I can understand that you want to limit the scope of automatic backports.
> 
> But we really should try to always use of the Fixes: tag. In most cases the
> SHA1 of the commit in the fixes tag defines the backport scope. 
> 
> For the rare cases where the buggy commit is really old, but you want to
> limit the backport scope for a reason then I really like to avoid to
> overload the Cc stable tag and have a dedicated tag instead. Something
> like:
> 
>     Fixes: 1234567890AB ("subsys/comp: Short summary")
>     Backport-to: 4.14
> 
> and have that backport tag right under the Fixes tag. If the Backport-to
> tag is ommitted, the SHA1 defines the scope, but I'm fine with making it
> mandatory.
> 
> If there is really the special RCU case where each and every stable version
> needs some special treatment then say:
> 
>     Backport-to: Manual
> 
> or whatever sensible word would express it correctly.
> 
> The Fixes tag is really valuable when you need to make connections and I
> know that the people who are looking into safety-critical Linux value the
> tag because it can be used for tracking and for metrics.

Indeed, I do need to get my act together with the Fixes tag.  And I am
happy with whatever format would limit backports appropriately.

							Thanx, Paul

