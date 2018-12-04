Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D2206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31D2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLDXEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:04:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbeLDXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:04:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB4N3fUO127165
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 18:04:29 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p5yh4reee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 18:04:27 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 4 Dec 2018 23:04:27 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Dec 2018 23:04:24 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB4N4N9j17825978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 23:04:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE82B2067;
        Tue,  4 Dec 2018 23:04:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D60E3B2066;
        Tue,  4 Dec 2018 23:04:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Dec 2018 23:04:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C8EF716C1DFC; Tue,  4 Dec 2018 15:04:23 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:04:23 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Reply-To: paulmck@linux.ibm.com
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
 <20181204222412.GA6874@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204222412.GA6874@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120423-0068-0000-0000-0000036C159D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010172; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127051; UDB=6.00585376; IPR=6.00907185;
 MB=3.00024448; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-04 23:04:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120423-0069-0000-0000-000046A75993
Message-Id: <20181204230423.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:24:13PM -0800, Josh Triplett wrote:
> On Tue, Dec 04, 2018 at 02:09:42PM -0800, tip-bot for Paul E. McKenney wrote:
> > --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > @@ -39,9 +39,22 @@ mkdir $T
> >  
> >  cat > $T/init << '__EOF___'
> >  #!/bin/sh
> > +# Run in userspace a few milliseconds every second.  This helps to
> > +# exercise the NO_HZ_FULL portions of RCU.
> >  while :
> >  do
> > -	sleep 1000000
> > +	q=
> > +	for i in \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
> 
> Ow. If there's no better way to do this, please do at least comment how many 'a's
> this is. (And why 186, exactly?)

Yeah, that is admittedly a bit strange.  The reason for 186 occurrences of
"a" to one-time calibration, measuring a few millisecond's worth of delay.

> Please also consider calibrating the delay loop as you do in the C code.

Good point.  And a quick web search finds me "date '+%s%N'", which gives
me nanoseconds since the epoch.  I probably don't want to do a 2038 to
myself (after all, I might still be alive then), so I should probably try
to make something work with "date '+%N'".  Or use something like this:

	$ date '+%4N'; date '+%4N';date '+%4N'; date '+%4N'
	6660
	6685
	6697
	6710

Ah, but that means I need to add the "date" command to my initrd, doesn't
it?  And calculation requires either bash or the "test" command.  And it
would be quite good to restrict this to what can be done with Bourne shell
built-in commands, since a big point of this is to maintain a small-sized
initrd.  :-/

So how about the following patch, which attempts to explain the situation?

							Thanx, Paul

------------------------------------------------------------------------

commit 23c304cbeda435acd4096ab3213502d6ae9720f3
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Tue Dec 4 14:59:12 2018 -0800

    torture: Explain odd "for" loop in mkinitrd.sh
    
    Why a Bourne-shell "for" loop?  And why 186 instances of "a"?  This commit
    adds a shell comment to present the answer to these mysteries.
    
    Reported-by: Josh Triplett <josh@joshtriplett.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index da298394daa2..1df0bbbfde7c 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -40,7 +40,15 @@ mkdir $T
 cat > $T/init << '__EOF___'
 #!/bin/sh
 # Run in userspace a few milliseconds every second.  This helps to
-# exercise the NO_HZ_FULL portions of RCU.
+# exercise the NO_HZ_FULL portions of RCU.  Yes, there are 186 instances
+# of "a", which was empirically shown to give a nice multi-millisecond
+# burst of user-mode execution on a 2GHz CPU, as desired.  Modern CPUs
+# will vary from a couple of milliseconds up to perhaps 100 milliseconds,
+# which is an acceptable range.
+#
+# Why not calibrate an exact delay?  Because within this initrd, we
+# are restricted to Bourne-shell builtins, which as far as I know do not
+# provide any means of obtaining a fine-grained timestamp.
 while :
 do
 	q=

