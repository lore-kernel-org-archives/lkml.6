Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96686C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3575720873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3575720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbeG1Xe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:34:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:6847 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbeG1Xe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:34:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 15:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,415,1526367600"; 
   d="p7s'?scan'208";a="75388674"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2018 15:06:29 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 28 Jul 2018 15:06:28 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.113]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.59]) with mapi id 14.03.0319.002;
 Sat, 28 Jul 2018 15:06:28 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "currojerez@riseup.net" <currojerez@riseup.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "Tamminen, Eero T" <eero.t.tamminen@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ggherdovich@suse.cz" <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Thread-Topic: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake
 Xeon
Thread-Index: AQHUJpv4nibys3lMgk60TBopXeYk0KSlieoAgAAcqwA=
Date:   Sat, 28 Jul 2018 22:06:28 +0000
Message-ID: <9fb2aaec3bea263a6be5eb031d70bffa250f7a0d.camel@intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
         <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
         <87bmarhqk4.fsf@riseup.net>
         <3afad4b13370fe0ba6ed5020f86ce1b8ff46c603.camel@linux.intel.com>
         <9828ba535fcdce8458593013fd1c67385a8fefb9.camel@intel.com>
         <87muubf6sp.fsf@riseup.net>
In-Reply-To: <87muubf6sp.fsf@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.133]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-13M6u5ZpB3TSBaajHeKt"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-13M6u5ZpB3TSBaajHeKt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-07-28 at 13:23 -0700, Francisco Jerez wrote:
> "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:
>=20
> > On Sat, 2018-07-28 at 07:14 -0700, Srinivas Pandruvada wrote:
> > > On Fri, 2018-07-27 at 22:34 -0700, Francisco Jerez wrote:
> > > > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > writes:
> > > >=20
> > > > > Enable HWP boost on Skylake server and workstations.
> > > > >=20
> > > >=20
> > > > Please revert this series, it led to significant energy usage
> > > > and
> > > > graphics performance regressions [1].=20
> > >=20
> > > Which SKX platform is targeted to graphics?
> >=20
> > There are some Xeon E3, which is using SKL desktop CPUID.
> > Do you have a SKL desktop with FADT pm profile=20
> > acpi_gbl_FADT.preferred_profile =3D=3D PM_DESKTOP? You can take
> > acpidump
> > and check.
> >=20
> > Also what is
> >  /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost
> >=20
>=20
> Eero is the one that reproduced the regressions -- Can you get
> Srinivas
> this information from your system?
I commented in the bug. Let's take there first.

Thanks,
Srinivas

>=20
> Thank you.
>=20
> > Thanks,
> > Srinivas
> >=20
> > >=20
> > > >  The reasons are roughly the ones
> > > > we discussed by e-mail off-list last April: This causes the
> > > > intel_pstate
> > > > driver to decrease the EPP to zero=20
> > >=20
> > > No. You didn't check this series. We are not using EPP at all.
> > > The boost mechanism used here is not boost to max.
> > >=20
> > > Thanks,
> > > Srinivas
> > >=20
> > > > when the workload blocks on IO
> > > > frequently enough, which for the regressing benchmarks detailed
> > > > in
> > > > [1]
> > > > is a symptom of the workload being heavily IO-bound, which
> > > > means
> > > > they
> > > > won't benefit at all from the EPP boost since they aren't
> > > > significantly
> > > > CPU-bound, and they will suffer a decrease in parallelism due
> > > > to
> > > > the
> > > > active CPU core using a larger fraction of the TDP in order to
> > > > achieve
> > > > the same work, causing the GPU to have a lower power budget
> > > > available,
> > > > leading to a decrease in system performance.
> > > >=20
> > > > You may want to give a shot to my previous suggestion of using
> > > > [2]
> > > > in
> > > > order to detect whether the system is IO-bound, which you can
> > > > use
> > > > as
> > > > an
> > > > indicator that the optimization implemented in this series
> > > > cannot
> > > > possibly improve performance and can be expected to hurt energy
> > > > usage.
> > > >=20
> > > > Thanks.
> > > >=20
> > > > [1] https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
> > > > [2] https://patchwork.kernel.org/patch/10312259/
> > > >=20
> > > > > Reported-by: Mel Gorman <mgorman@techsingularity.net>
> > > > > Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux
> > > > > .int
> > > > > el
> > > > > .com>
> > > > > ---
> > > > >  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > index 70bf63bb4e0e..01c8da1f99db 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id
> > > > > intel_pstate_cpu_ee_disable_ids[] =3D {
> > > > >  	{}
> > > > >  };
> > > > > =20
> > > > > +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
> > > > > __initconst =3D {
> > > > > +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> > > > > +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> > > > > +	{}
> > > > > +};
> > > > > +
> > > > >  static int intel_pstate_init_cpu(unsigned int cpunum)
> > > > >  {
> > > > >  	struct cpudata *cpu;
> > > > > @@ -1824,6 +1830,10 @@ static int
> > > > > intel_pstate_init_cpu(unsigned
> > > > > int cpunum)
> > > > >  			intel_pstate_disable_ee(cpunum);
> > > > > =20
> > > > >  		intel_pstate_hwp_enable(cpu);
> > > > > +
> > > > > +		id =3D
> > > > > x86_match_cpu(intel_pstate_hwp_boost_ids);
> > > > > +		if (id)
> > > > > +			hwp_boost =3D true;
> > > > >  	}
> > > > > =20
> > > > >  	intel_pstate_get_cpu_pstates(cpu);
> > > > > --=20
> > > > > 2.13.6
--=-13M6u5ZpB3TSBaajHeKt
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
aQGEV8ArjHXcotL/yLNh30JyB9sygYzIQadqyFvtvhUyiHwAh7Pf6Gl7Gsz0i/QSq7MK49JvgbUM
F1TCZwc7AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUf6YLVqF1vjXfk2h4J2GzgJAOB/8wHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQDDpWcY9zqtG5P0e1FRJpG/RPQ6
p6sQJHZ5UwykMtYFqBJYOZn9B8koeLEhE4vOAh6v6fgVoCfOvwxJ57BUAdP3jvkbCaLz3r6nUHNr
6w6KwnT9rHykdDjZsRUGs2yP+139qVqoXRHTOLfqvnAzcirjgf4Fz3JRPJZraRWrICBehqhYVfFH
sxxBgOauQ+DTHjZARkomjmrATvlDpLMlN74L/BKZI4rl4R/BjSaLBzAKQnAN0nvWefpPzdeSYuxK
XaN1xDzINPDnmShXSbQzee0h2CvEnIMtPQDM9DJACUi14Cc9y4o7DqRky4r1+XnksN2lKnu83l4E
oSxCkDMhszkFMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAK0KIyEkTMbH5OYAAAAArQowCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDcy
ODIyMDYyNlowIwYJKoZIhvcNAQkEMRYEFLFbUG6Yfd6UpKKPbLhjNRP9QfKqMA0GCSqGSIb3DQEB
AQUABIIBAAesHOmXnF0lteXsfghFZi/ARcwjte37cNJnjiJ1hj+XIbzLHHan90+2Whe3jBHLZ4gH
BXK2XdO4cHc0GoRBfTf6T/m0Qa+6AVicPbXM7t9E/KO2BWfKg0TfD4uSe0pYwyscNS1CFbhefSCF
ZeaoIGp4dbgVZjpjocu1mAEOm3+7vaKxb/0Q6A6V4zo6JSx3rHcyNdNHU5pvgduxjee73dx8TMKl
qXoDQeaZUTZqU9ztlu9G/0slTXYmgQAPaT3VrA92qcE2H1BHDWnY303+9g4Uz9kl7EezDQo7of0J
vpgdmbDTQFv8GpobQnucZJ/XxrF0yp1X3FZ0ZLcSD/nNvNYAAAAAAAA=


--=-13M6u5ZpB3TSBaajHeKt--
