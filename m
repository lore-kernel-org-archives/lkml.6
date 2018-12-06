Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2A52146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2A52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeLFBGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:06:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbeLFBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:06:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB613X6d008769
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 20:06:23 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p6q9jw9fq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 20:06:22 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Dec 2018 01:06:21 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Dec 2018 01:06:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB616HIm18088096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 01:06:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9095CB2064;
        Thu,  6 Dec 2018 01:06:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 732C7B205F;
        Thu,  6 Dec 2018 01:06:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Dec 2018 01:06:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 186F816C36A1; Wed,  5 Dec 2018 17:06:18 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:06:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Reply-To: paulmck@linux.ibm.com
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
 <20181204222412.GA6874@localhost>
 <20181204230423.GP4170@linux.ibm.com>
 <20181205222523.GA14609@localhost>
 <20181206000809.GX4170@linux.ibm.com>
 <20181206005147.GA3300@andrea>
 <20181206005827.GA24891@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206005827.GA24891@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120601-2213-0000-0000-0000032565F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010178; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127572; UDB=6.00585688; IPR=6.00907706;
 MB=3.00024466; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-06 01:06:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120601-2214-0000-0000-00005C805E5D
Message-Id: <20181206010618.GA4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:58:27PM -0800, Josh Triplett wrote:
> On Thu, Dec 06, 2018 at 01:51:47AM +0100, Andrea Parri wrote:
> > > commit 4f8f751961b536f77c8f82394963e8e2d26efd84
> > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Date:   Tue Dec 4 14:59:12 2018 -0800
> > > 
> > >     torture: Explain and simplify odd "for" loop in mkinitrd.sh
> > >     
> > >     Why a Bourne-shell "for" loop?  And why 192 instances of "a"?  This commit
> > >     adds a shell comment to present the answer to these mysteries.  It also
> > >     uses a series of factor-of-four Bourne-shell assignments to make it
> > >     easy to see how many instances there are, replacing the earlier wall of
> > >     'a' characters.
> > >     
> > >     Reported-by: Josh Triplett <josh@joshtriplett.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > 
> > > diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > index da298394daa2..ff69190604ea 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > @@ -40,17 +40,24 @@ mkdir $T
> > >  cat > $T/init << '__EOF___'
> > >  #!/bin/sh
> > >  # Run in userspace a few milliseconds every second.  This helps to
> > > -# exercise the NO_HZ_FULL portions of RCU.
> > > +# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
> > > +# empirically shown to give a nice multi-millisecond burst of user-mode
> > > +# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
> > > +# couple of milliseconds up to perhaps 100 milliseconds, which is an
> > > +# acceptable range.
> > > +#
> > > +# Why not calibrate an exact delay?  Because within this initrd, we
> > > +# are restricted to Bourne-shell builtins, which as far as I know do not
> > > +# provide any means of obtaining a fine-grained timestamp.
> > > +
> > > +a4="a a a a"
> > > +a16="$a4 $a4 $a4 $a4"
> > > +a64="$a8 $a8 $a8 $a8"
> > 
> > Mmh, are you sure you don't want s/a8/a16/ here? ;-)
> 
> ... *facepalm*

Yeah, me as well...

> Good catch.

Thank you both!!!

							Thanx, Paul

