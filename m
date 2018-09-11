Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0081C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A6A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="doa6zKpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A6A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIKWyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:54:55 -0400
Received: from mx1.riseup.net ([198.252.153.129]:57006 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeIKWyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:54:54 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id B5F831A097F;
        Tue, 11 Sep 2018 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1536688469; bh=93byFT7Ef5DOIpoUni+UlCdxVE/pXwXWHXg/C3cI0dY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=doa6zKpnX/DyuzIVNJtiWX6XwjrzwMU3loZPprwnXIdTht+1V+TvP1JlbVSkvqJhC
         EF2aqOesPCvRTnL1Cjqzl2jAWWV0zo2Tfdj4bTajQNSNW1QbZR/ZLAPG6i2vcyIkVB
         wAe5X13RliDjTk3yLl3A9MtKdAD44hwiYBgwZJd4=
X-Riseup-User-ID: ABEFF1DB06A6F8CA728205A75CB722FFD56136513F50D304E8126F67C211FCA0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id 9FDDC4CC61;
        Tue, 11 Sep 2018 10:54:27 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        viresh.kumar@linaro.org, mgorman@techsingularity.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
In-Reply-To: <23293649.J1qzPCXian@aspire.rjw.lan>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com> <87in3j9s07.fsf@riseup.net> <23293649.J1qzPCXian@aspire.rjw.lan>
Date:   Tue, 11 Sep 2018 10:35:15 -0700
Message-ID: <87in3c7x9o.fsf@riseup.net>
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

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
>>=20
>> --=3D=3D-=3D-=3D
>> Content-Type: multipart/mixed; boundary=3D"=3D-=3D-=3D"
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>=20
>> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>=20
>> > [...]
>> >
>> >> > >=3D20
>> >> > > This patch causes a number of statistically significant
>> >> > > regressions
>> >> > > (with significance of 1%) on the two systems I've tested it
>> >> > > on.  On
>> >> > > my
>> >> >=3D20
>> >> > Sure. These patches are targeted to Atom clients where some of
>> >> > these
>> >> > server like workload may have some minor regression on few watts
>> >> > TDP
>> >> > parts.
>> >>=3D20
>> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
>> >> nor
>> >> the 10% regression of warsaw qualify as small.  And most of the test
>> >> cases on the list of regressions aren't exclusively server-like, if
>> >> at
>> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
>> >> benchmarks -- Latency is as important if not more for interactive
>> >> workloads than it is for server workloads.  In the case of a conflict
>> >> like the one we're dealing with right now between optimizing for
>> >> throughput (e.g. for the maximum number of requests per second) and
>> >> optimizing for latency (e.g. for the minimum request duration), you
>> >> are
>> >> more likely to be concerned about the former than about the latter in
>> >> a
>> >> server setup.
>> >
>> > Eero,
>> > Please add your test results here.
>> >
>> > No matter which algorithm you do, there will be variations. So you have
>> > to look at the platforms which you are targeting. For this platform=3D=
20
>> > number one item is use of less turbo and hope you know why?
>>=20
>> Unfortunately the current controller uses turbo frequently on Atoms for
>> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
>> boosting simply exacerbated the pre-existing energy efficiency problem.
>
> My current understanding of the issue at hand is that using IOWAIT boosti=
ng
> on Atoms is a regression relative to the previous behavior.

Not universally.  IOWAIT boosting helps under roughly the same
conditions on Atom as it does on big core, so applying this patch will
necessarily cause regressions too (see my reply from Sep. 3 for some
numbers), and won't completely restore the previous behavior since it
simply decreases the degree of IOWAIT boosting applied without being
able to avoid it (c.f. the series I'm working on that does something
similar to IOWAIT boosting when it's able to determine it's actually
CPU-bound, which prevents energy inefficient behavior for non-CPU-bound
workloads that don't benefit from a higher CPU clock frequency anyway).

> That is what Srinivas is trying to address here AFAICS.
>
> Now, you seem to be saying that the overall behavior is suboptimal and the
> IOWAIT boosting doesn't matter that much,

I was just saying that IOWAIT boosting is less than half of the energy
efficiency problem, and this patch only partially addresses that half of
the problem.

> so some deeper changes are needed anyway.  That may be the case, but
> if there is a meaningful regression, we should first get back to the
> point where it is not present and then to take care of the more
> general problems.
>
> So, I'd like to understand how much of a problem the IOWAIT boosting real=
ly is
> in the first place.  If it is significant enough, let's address it first,=
 this
> way or another, and move on to the other problems subsequently.
>

See the Unigine and Gfxbench numbers I provided in my reply from Sep. 3
to get an idea of the magnitude of the IOWAIT boosting problem vs. the
overall energy efficiency problem addressed by my series.

> Thanks,
> Rafael

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW5f80wAKCRCDmTidfVK/
W8S4AP0cnxEpgO73ANrB1TmDP62h0lKLBOPwKFBvHNZfawNlRAD+KZvQAzXBlHCI
bMismxrY5c/lDO5IqBHRQ7fssIcRLkk=
=HDCK
-----END PGP SIGNATURE-----
--==-=-=--
