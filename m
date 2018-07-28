Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A7720842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="W9ZaZ+Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A7720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeG1WH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:07:56 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44921 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbeG1WHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:07:55 -0400
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id F21EB1A04AD;
        Sat, 28 Jul 2018 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1532810412; bh=bQp/RcKShGqJ4ql+Hkc2uRpXn8A48T+3DnZfDAk8RgA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W9ZaZ+Wc/8pN+cFFvfbbgz2eeNULOQbl01YdWfEOkOrI8SKXdsMf8B6cGxFcA75Sg
         ya7JznTjzrjE9ZEwwaWycCkYfYp8nfe2MpzdqzYpa/A+9oyGLP1TD4K8JkAB8guhOx
         YseweaJHFKpOGyaUOYDYnNszs42waZ2cVq9HyxUc=
X-Riseup-User-ID: CA270DB0169681846D0943012EC035105BA6D10C82BA66BD29550BF281AA134B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id ADB52CDEAC;
        Sat, 28 Jul 2018 13:40:10 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc:     peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, ggherdovich@suse.cz,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
In-Reply-To: <3afad4b13370fe0ba6ed5020f86ce1b8ff46c603.camel@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com> <87bmarhqk4.fsf@riseup.net> <3afad4b13370fe0ba6ed5020f86ce1b8ff46c603.camel@linux.intel.com>
Date:   Sat, 28 Jul 2018 13:23:18 -0700
Message-ID: <87pnz7f6tl.fsf@riseup.net>
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

> On Fri, 2018-07-27 at 22:34 -0700, Francisco Jerez wrote:
>> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>=20
>> > Enable HWP boost on Skylake server and workstations.
>> >=20
>>=20
>> Please revert this series, it led to significant energy usage and
>> graphics performance regressions [1].=20
> Which SKX platform is targeted to graphics?
>

See the bug report, it's a regular desktop SKL.

>>  The reasons are roughly the ones
>> we discussed by e-mail off-list last April: This causes the
>> intel_pstate
>> driver to decrease the EPP to zero=20
> No. You didn't check this series. We are not using EPP at all.
> The boost mechanism used here is not boost to max.
>

I see you've changed the mechanism to obtain a latency boost since our
last discussion, but that doesn't address my concerns in any way: This
series causes the intel_pstate driver to clamp the CPU frequency above
the optimal frequency to run the workload at, as a response to the
application waiting on IO frequently, even though that's only a sign of
the application being IO-bound and *not* a sign of it being
latency-sensitive, since the application's IO and CPU work are properly
pipelined.  This leads to a decrease in parallelism due to the active
CPU core using a larger fraction of the package TDP in order to achieve
the same work, leading to a decrease in system performance.

> Thanks,
> Srinivas
>
>> when the workload blocks on IO
>> frequently enough, which for the regressing benchmarks detailed in
>> [1]
>> is a symptom of the workload being heavily IO-bound, which means they
>> won't benefit at all from the EPP boost since they aren't
>> significantly
>> CPU-bound, and they will suffer a decrease in parallelism due to the
>> active CPU core using a larger fraction of the TDP in order to
>> achieve
>> the same work, causing the GPU to have a lower power budget
>> available,
>> leading to a decrease in system performance.
>>=20
>> You may want to give a shot to my previous suggestion of using [2] in
>> order to detect whether the system is IO-bound, which you can use as
>> an
>> indicator that the optimization implemented in this series cannot
>> possibly improve performance and can be expected to hurt energy
>> usage.
>>=20
>> Thanks.
>>=20
>> [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
>> [2] https://patchwork.kernel.org/patch/10312259/
>>=20
>> > Reported-by: Mel Gorman <mgorman@techsingularity.net>
>> > Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
>> > .com>
>> > ---
>> >  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >=20
>> > diff --git a/drivers/cpufreq/intel_pstate.c
>> > b/drivers/cpufreq/intel_pstate.c
>> > index 70bf63bb4e0e..01c8da1f99db 100644
>> > --- a/drivers/cpufreq/intel_pstate.c
>> > +++ b/drivers/cpufreq/intel_pstate.c
>> > @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id
>> > intel_pstate_cpu_ee_disable_ids[] =3D {
>> >  	{}
>> >  };
>> >=20=20
>> > +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
>> > __initconst =3D {
>> > +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
>> > +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
>> > +	{}
>> > +};
>> > +
>> >  static int intel_pstate_init_cpu(unsigned int cpunum)
>> >  {
>> >  	struct cpudata *cpu;
>> > @@ -1824,6 +1830,10 @@ static int intel_pstate_init_cpu(unsigned
>> > int cpunum)
>> >  			intel_pstate_disable_ee(cpunum);
>> >=20=20
>> >  		intel_pstate_hwp_enable(cpu);
>> > +
>> > +		id =3D x86_match_cpu(intel_pstate_hwp_boost_ids);
>> > +		if (id)
>> > +			hwp_boost =3D true;
>> >  	}
>> >=20=20
>> >  	intel_pstate_get_cpu_pstates(cpu);
>> > --=20
>> > 2.13.6

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1zQtgAKCRCDmTidfVK/
W2G8AP9Bvum9wiRaKvxFv1U0cyD+G6Vgj3C47w9cBneGLBTJFQD+IZv3C3gaHBTc
xDE4pDFJHViO2m5JOCohFvaFELiNyH8=
=zka7
-----END PGP SIGNATURE-----
--==-=-=--
