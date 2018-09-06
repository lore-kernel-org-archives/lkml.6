Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E5CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D22075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Mjc9cG5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3D22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeIFJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:12:52 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48249 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeIFJMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:12:52 -0400
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 030BE1A05BA;
        Wed,  5 Sep 2018 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1536208760; bh=O7iRf9O+l+sSKrjm7g6rZMouwoxRaA0sRfPCepdB0Ng=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mjc9cG5wnKrl/n/6TWbeS+HuyWX45u5bFUKn3RPTghdsjfTcp8UJ8WlZAA4FQv999
         S9XjjVc7WmrezvIQHjwBmAnxcd1uuGlRtZTUKp2d8sZi3PF6uNIcUyQ6JLlHUqRrIY
         sC+mZXOe7a25dUGkmXbhaQLVXzcvTl8AElIVoMTg=
X-Riseup-User-ID: 32C2A5A71ACD2318D421CA0E2258C168FC02FFF1CCDAC30804A60671984D3951
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id D28A168564;
        Wed,  5 Sep 2018 21:39:17 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, ggherdovich@suse.cz,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
In-Reply-To: <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com> <8736upda8s.fsf@riseup.net> <b48340f59011bc3d7402b6a811bce4fa861fab7b.camel@linux.intel.com> <8736uobu7w.fsf@riseup.net> <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com>
Date:   Wed, 05 Sep 2018 21:20:08 -0700
Message-ID: <87in3j9s07.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> [...]
>
>> > >=20
>> > > This patch causes a number of statistically significant
>> > > regressions
>> > > (with significance of 1%) on the two systems I've tested it
>> > > on.  On
>> > > my
>> >=20
>> > Sure. These patches are targeted to Atom clients where some of
>> > these
>> > server like workload may have some minor regression on few watts
>> > TDP
>> > parts.
>>=20
>> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
>> nor
>> the 10% regression of warsaw qualify as small.  And most of the test
>> cases on the list of regressions aren't exclusively server-like, if
>> at
>> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
>> benchmarks -- Latency is as important if not more for interactive
>> workloads than it is for server workloads.  In the case of a conflict
>> like the one we're dealing with right now between optimizing for
>> throughput (e.g. for the maximum number of requests per second) and
>> optimizing for latency (e.g. for the minimum request duration), you
>> are
>> more likely to be concerned about the former than about the latter in
>> a
>> server setup.
>
> Eero,
> Please add your test results here.
>
> No matter which algorithm you do, there will be variations. So you have
> to look at the platforms which you are targeting. For this platform=20
> number one item is use of less turbo and hope you know why?

Unfortunately the current controller uses turbo frequently on Atoms for
TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
boosting simply exacerbated the pre-existing energy efficiency problem.

> On this platform GFX patch caused this issue as it was submitted after
> io boost patchset. So rather that should be reverted first before
> optimizing anything.
>
>
>
>>=20
>> > But weighing against reduced TURBO usage (which is enough trigger)
>> > and
>> > improvement in tests done by Eero (which was primary complaint to
>> > us).
>> >=20
>> > It is trivial patch. Yes, the patch is not perfect and doesn't
>> > close
>> > doors for any improvements.
>> >=20
>>=20
>> It's sort of self-contained because it's awfully incomplete.Don't
>> agtr
>
>>=20
>> > I see your idea, but how to implement in acceptable way is a
>> > challenge.
>>=20
>> Main challenge was getting the code to work without regressions in
>> latency-sensitive workloads, which I did, because you told me that it
>> wasn't acceptable for it to cause any regressions on the Phoronix
>> daily-system-tracker, whether latency-bound or not.
> Yes, because your intention was to have a global change not a low power
> Atom specific,
>

My intention was to target low-power Atoms only since the first day we
discussed this problem.  The cover letter of the series I sent and the
commit messages make this fairly clear.

>>   What is left in
>> order to address Peter's concerns is for the most part plumbing,
>> that's
>> guaranteed not to have any functional impact on the heuristic.  The
>> fact
>> that we don't expect it to change the performance of the system makes
>> it
>> substantially less time-consuming to validate than altering the
>> performance trade-offs of the heuristic dynamically in order to avoid
>> regressions (which is what has kept my systems busy most of the time
>> lately).  Seems like my series, even in its current state without the
>> changes requested by Peter is closer to being ready for production
>> than
>> this patch is.
>
> Sorry, Not at all. We call such patches as experimental series.

The numbers speak otherwise.

> You caused 100% regression to idle power. There is no version 2 after
> that, even if you fixed locally even to look.
>

I did post a link to a v2 that fixed the idle power issue on the v1
thread, but I didn't intend to send it for review yet.  I'll send it out
once I've fully taken into account Peter's feedback.

> Thanks,
> Srinivas

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW5Cq+AAKCRCDmTidfVK/
W6sIAP9TnWh8OPsd2tgmocKMDN8Thrf71op/SrvzRsNvSqoa5gEAjs/8de3OOxYh
CettM1Ncc4usc8Wh11kvS3PfSAsu+A8=
=GW9w
-----END PGP SIGNATURE-----
--==-=-=--
