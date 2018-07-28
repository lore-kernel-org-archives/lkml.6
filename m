Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B6AC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F9920842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="PCjVaMn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F9920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeG1WG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:06:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44806 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbeG1WG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:06:28 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id A4D591A0219;
        Sat, 28 Jul 2018 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1532810324; bh=+36/NZxDxjszU50lQ5n2IS0kpWKyYiLk/oI9cysc/hU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PCjVaMn8SoU5AX/IjuKTfCO+WayLaektSAYbxwvFLbQnEgJZfaIvMIqeOsT23nKNv
         Cr3MOe3A0O/u/2eLzd7k/olTLeQstm3eWsahHlXGXWmQ5/gLNxcwmdls8s0wqorKmJ
         wI5JzKQLH2qawTZ+oo+LmC+BBookY1p5bWJTdyqA=
X-Riseup-User-ID: 169AC4CC7830A49768313D13B868B213B2F5452B257CCED0AC9C305C8281028D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id 4CB8045712;
        Sat, 28 Jul 2018 13:38:43 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        ggherdovich@suse.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
In-Reply-To: <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com> <87bmarhqk4.fsf@riseup.net> <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
Date:   Sat, 28 Jul 2018 13:21:51 -0700
Message-ID: <87r2jnf6w0.fsf@riseup.net>
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

Mel Gorman <mgorman@techsingularity.net> writes:

> On Fri, Jul 27, 2018 at 10:34:03PM -0700, Francisco Jerez wrote:
>> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>=20
>> > Enable HWP boost on Skylake server and workstations.
>> >
>>=20
>> Please revert this series, it led to significant energy usage and
>> graphics performance regressions [1].  The reasons are roughly the ones
>> we discussed by e-mail off-list last April: This causes the intel_pstate
>> driver to decrease the EPP to zero when the workload blocks on IO
>> frequently enough, which for the regressing benchmarks detailed in [1]
>> is a symptom of the workload being heavily IO-bound, which means they
>> won't benefit at all from the EPP boost since they aren't significantly
>> CPU-bound, and they will suffer a decrease in parallelism due to the
>> active CPU core using a larger fraction of the TDP in order to achieve
>> the same work, causing the GPU to have a lower power budget available,
>> leading to a decrease in system performance.
>
> It slices both ways.

I don't think it's acceptable to land an optimization that trades
performance of one use-case for another, especially since one could make
both use-cases happy by avoiding the boost in cases where we know
beforehand that we aren't going to achieve any improvement in
performance, because an application waiting frequently on an IO device
which is 100% utilized isn't going to run faster just because we ramp up
the CPU frequency, since the IO device won't be able to process requests
from the application faster anyway, so we will only be pessimizing
energy efficiency (and potentially decreasing performance of the GPU
*and* of other CPU cores living on the same package for no benefit).

> With the series, there are large boosts to performance on other
> workloads where a slight increase in power usage is acceptable in
> exchange for performance. For example,
>
> Single socket skylake running sqlite
>                                  v4.17               41ab43c9
> Min       Trans     2580.85 (   0.00%)     5401.58 ( 109.29%)
> Hmean     Trans     2610.38 (   0.00%)     5518.36 ( 111.40%)
> Stddev    Trans       28.08 (   0.00%)      208.90 (-644.02%)
> CoeffVar  Trans        1.08 (   0.00%)        3.78 (-251.57%)
> Max       Trans     2648.02 (   0.00%)     5992.74 ( 126.31%)
> BHmean-50 Trans     2629.78 (   0.00%)     5643.81 ( 114.61%)
> BHmean-95 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
> BHmean-99 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
>
> That's over doubling the transactions per second for that workload.
>
> Two-socket skylake running dbench4
>                                 v4.17               41ab43c9
> Amean      1         40.85 (   0.00%)       14.97 (  63.36%)
> Amean      2         42.31 (   0.00%)       17.33 (  59.04%)
> Amean      4         53.77 (   0.00%)       27.85 (  48.20%)
> Amean      8         68.86 (   0.00%)       43.78 (  36.42%)
> Amean      16        82.62 (   0.00%)       56.51 (  31.60%)
> Amean      32       135.80 (   0.00%)      116.06 (  14.54%)
> Amean      64       737.51 (   0.00%)      701.00 (   4.95%)
> Amean      512    14996.60 (   0.00%)    14755.05 (   1.61%)
>
> This is reporting the average latency of operations running
> dbench. The series over halves the latencies. There are many examples
> of basic workloads that benefit heavily from the series and while I
> accept it may not be universal, such as the case where the graphics
> card needs the power and not the CPU, a straight revert is not the
> answer. Without the series, HWP cripplies the CPU.
>

That seems like a huge overstatement.  HWP doesn't "cripple" the CPU
without this series.  It will certainly set lower clocks than with this
series for workloads like you show above that utilize the CPU very
intermittently (i.e. they underutilize it).  But one could argue that
such workloads are inherently misdesigned and will perform suboptimally
regardless of the behavior of the CPUFREQ governor, for two different
reasons: On the one hand because they are unable to fully utilize their
CPU time (otherwise HWP would be giving them a CPU frequency close to
the maximum already), and on the other hand, because in order to achieve
maximum performance they will necessarily have to bounce back and forth
between the maximum P-state and idle at high frequency, which is
inherently energy-inefficient and will effectively *decrease* the
overall number of requests per second that an actual multi-threaded
server can process, even though the request throughput may seem to
increase in a single-threaded benchmark.

> --=20
> Mel Gorman
> SUSE Labs

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1zQXwAKCRCDmTidfVK/
W55QAP44DEFxdSkORtWOE2mHOpjjYK3L4nUTWH/AF+YjuM4koQEAhXi7O4klzaSj
V316IAihV9/kQf/Ap7zuCzB9EadnPRc=
=zy//
-----END PGP SIGNATURE-----
--==-=-=--
