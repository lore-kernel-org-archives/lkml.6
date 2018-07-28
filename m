Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E73DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05C20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="dk5k/v/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD05C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeG1WI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:08:26 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44967 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbeG1WI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:08:26 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 6EA331A01B2;
        Sat, 28 Jul 2018 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1532810442; bh=+nc69tJSeKSq7KzgL0zxFYZP4rISaSUtjxvj9HslUoc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dk5k/v/6gHuVcoIdwUMmgOCJUIE80lfHdkE+WfHaK9inW32WIiMkhJpvR08sw+76j
         Ud/zf4rbVQagh3M/jZGRL53vAbi0MwZ0HZI1KzC7buREln7f2vYIV08KqkL5ws17G1
         QTuG6jQfUSv524vEQ/+6fSIjf0GM2jC9UV+NbI/k=
X-Riseup-User-ID: 708251F26A5C74A6743C45BF14D30318BE8697A55FDFE7E9B74D8F5881BF2309
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id B322F45712;
        Sat, 28 Jul 2018 13:40:41 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        "lenb\@kernel.org" <lenb@kernel.org>,
        "mgorman\@techsingularity.net" <mgorman@techsingularity.net>,
        "rjw\@rjwysocki.net" <rjw@rjwysocki.net>,
        "Tamminen\, Eero T" <eero.t.tamminen@intel.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "ggherdovich\@suse.cz" <ggherdovich@suse.cz>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "viresh.kumar\@linaro.org" <viresh.kumar@linaro.org>,
        "joonas.lahtinen\@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "tvrtko.ursulin\@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "chris\@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
In-Reply-To: <9828ba535fcdce8458593013fd1c67385a8fefb9.camel@intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com> <87bmarhqk4.fsf@riseup.net> <3afad4b13370fe0ba6ed5020f86ce1b8ff46c603.camel@linux.intel.com> <9828ba535fcdce8458593013fd1c67385a8fefb9.camel@intel.com>
Date:   Sat, 28 Jul 2018 13:23:50 -0700
Message-ID: <87muubf6sp.fsf@riseup.net>
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

"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:

> On Sat, 2018-07-28 at 07:14 -0700, Srinivas Pandruvada wrote:
>> On Fri, 2018-07-27 at 22:34 -0700, Francisco Jerez wrote:
>> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>> >=20
>> > > Enable HWP boost on Skylake server and workstations.
>> > >=20
>> >=20
>> > Please revert this series, it led to significant energy usage and
>> > graphics performance regressions [1].=20
>>=20
>> Which SKX platform is targeted to graphics?
> There are some Xeon E3, which is using SKL desktop CPUID.
> Do you have a SKL desktop with FADT pm profile=20
> acpi_gbl_FADT.preferred_profile =3D=3D PM_DESKTOP? You can take acpidump
> and check.
>
> Also what is
>  /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
>

Eero is the one that reproduced the regressions -- Can you get Srinivas
this information from your system?

Thank you.

> Thanks,
> Srinivas
>
>>=20
>> >  The reasons are roughly the ones
>> > we discussed by e-mail off-list last April: This causes the
>> > intel_pstate
>> > driver to decrease the EPP to zero=20
>>=20
>> No. You didn't check this series. We are not using EPP at all.
>> The boost mechanism used here is not boost to max.
>>=20
>> Thanks,
>> Srinivas
>>=20
>> > when the workload blocks on IO
>> > frequently enough, which for the regressing benchmarks detailed in
>> > [1]
>> > is a symptom of the workload being heavily IO-bound, which means
>> > they
>> > won't benefit at all from the EPP boost since they aren't
>> > significantly
>> > CPU-bound, and they will suffer a decrease in parallelism due to
>> > the
>> > active CPU core using a larger fraction of the TDP in order to
>> > achieve
>> > the same work, causing the GPU to have a lower power budget
>> > available,
>> > leading to a decrease in system performance.
>> >=20
>> > You may want to give a shot to my previous suggestion of using [2]
>> > in
>> > order to detect whether the system is IO-bound, which you can use
>> > as
>> > an
>> > indicator that the optimization implemented in this series cannot
>> > possibly improve performance and can be expected to hurt energy
>> > usage.
>> >=20
>> > Thanks.
>> >=20
>> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
>> > [2] https://patchwork.kernel.org/patch/10312259/
>> >=20
>> > > Reported-by: Mel Gorman <mgorman@techsingularity.net>
>> > > Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
>> > > el
>> > > .com>
>> > > ---
>> > >  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>> > >  1 file changed, 10 insertions(+)
>> > >=20
>> > > diff --git a/drivers/cpufreq/intel_pstate.c
>> > > b/drivers/cpufreq/intel_pstate.c
>> > > index 70bf63bb4e0e..01c8da1f99db 100644
>> > > --- a/drivers/cpufreq/intel_pstate.c
>> > > +++ b/drivers/cpufreq/intel_pstate.c
>> > > @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id
>> > > intel_pstate_cpu_ee_disable_ids[] =3D {
>> > >  	{}
>> > >  };
>> > >=20=20
>> > > +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
>> > > __initconst =3D {
>> > > +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
>> > > +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
>> > > +	{}
>> > > +};
>> > > +
>> > >  static int intel_pstate_init_cpu(unsigned int cpunum)
>> > >  {
>> > >  	struct cpudata *cpu;
>> > > @@ -1824,6 +1830,10 @@ static int intel_pstate_init_cpu(unsigned
>> > > int cpunum)
>> > >  			intel_pstate_disable_ee(cpunum);
>> > >=20=20
>> > >  		intel_pstate_hwp_enable(cpu);
>> > > +
>> > > +		id =3D x86_match_cpu(intel_pstate_hwp_boost_ids);
>> > > +		if (id)
>> > > +			hwp_boost =3D true;
>> > >  	}
>> > >=20=20
>> > >  	intel_pstate_get_cpu_pstates(cpu);
>> > > --=20
>> > > 2.13.6

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1zQ1gAKCRCDmTidfVK/
W2sCAP0d78328P9VrLs7stSaojcOxzy6M9e5dGzKty9yJ6ayEAD/QNqeTmpLM/D1
KSxbznmfTb2Qck9N6GFxDPiO+ZO8XzE=
=7Mbl
-----END PGP SIGNATURE-----
--==-=-=--
