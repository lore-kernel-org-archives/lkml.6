Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F13FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FB20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="acAVek8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0FB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIDLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:36:21 -0400
Received: from mx1.riseup.net ([198.252.153.129]:39676 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeIDLgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:36:21 -0400
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id B2D281A0408;
        Tue,  4 Sep 2018 00:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1536045153; bh=+2NHFRzh/IDWF8DM0D5KrZn3lR3yd+icDsOBf3ytjG4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=acAVek8cRDgmJY6/a9XY/RTk8NJn8oZHEdL+nbtykUg2sY4aHCEjIuBAyqYuozm9t
         T2nKzaX/kwyTkTm1fWZtb1lkfIRvUaSNBqMWKdCA5dukzaYz8jxhTqRA9QUSeQQsVC
         jsjl54lx9oS2I9zy17Q77nKQNYFktcyQeVKddYNI=
X-Riseup-User-ID: B19FC935D435E56854701FF91190886DBFEF1152A940AEC6CB8135DA1714FCED
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id 6A08567E15;
        Tue,  4 Sep 2018 00:12:31 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Eero Tamminen <eero.t.tamminen@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, ggherdovich@suse.cz,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
In-Reply-To: <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Date:   Mon, 03 Sep 2018 23:53:23 -0700
Message-ID: <8736upda8s.fsf@riseup.net>
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

Eero Tamminen <eero.t.tamminen@intel.com> writes:

> Hi,
>
> On 31.08.2018 20:28, Srinivas Pandruvada wrote:
> ...
>> As per testing Eero Tamminen, the results are comparable to the patchset
>> https://patchwork.kernel.org/patch/10312259/
>> But he has to watch results for several days to check trend.
>
> It's close, but there is some gap compared to Francisco's version.
>
> (Because of the large variance on TDP limited devices, and factors=20
> causing extra perf differences e.g. between boots, it's hard to give=20
> exact number without having trends from several days / weeks.  I would=20
> also need new version of Fransisco's patch set that applies to latest=20
> kernel like yours does.)
>
>
>> Since here boost is getting limited to turbo and non turbo, we need some
>> ways to adjust the fractions corresponding to max non turbo as well. It
>> is much easier to use the actual P-state limits for boost instead of
>> fractions. So here P-state io boost limit is applied on top of the
>> P-state limit calculated via current algorithm by removing current
>> io_wait boost calculation using fractions.
>>=20
>> Since we prefer to use common algorithm for all processor platforms, this
>> change was tested on other client and sever platforms as well. All resul=
ts
>> were within the margin of errors. Results:
>> https://bugzilla.kernel.org/attachment.cgi?id=3D278149
>
> Good.
>
> Francisco, how well the listed PTS tests cover latency bound cases you=20
> were concerned about?  [1]
>
>
> 	- Eero
>
> [1] Fransisco was concerned that the patch:
> * trade-off might regress latency bound cases (which I haven't tested, I=
=20
> tested only 3D throughput), and
> * that it addressed only other of the sources of energy inefficiencies=20
> he had identified (which could explain slightly better 3D results from=20
> his more complex patch set).

This patch causes a number of statistically significant regressions
(with significance of 1%) on the two systems I've tested it on.  On my
CHV N3050:

| phoronix/fs-mark/test=3D0:                                               =
        XXX =C2=B17.25% x34 -> XXX =C2=B17.00% x39  d=3D-36.85% =C2=B15.91%=
  p=3D0.00%
| phoronix/sqlite:                                                         =
      XXX =C2=B11.86% x34 -> XXX =C2=B11.88% x39  d=3D-21.73% =C2=B11.66%  =
p=3D0.00%
| warsow/benchsow:                                                         =
      XXX =C2=B11.25% x34 -> XXX =C2=B11.95% x39  d=3D-10.83% =C2=B11.53%  =
p=3D0.00%
| phoronix/iozone/record-size=3D4Kb/file-size=3D2GB/test=3DRead Performance=
:           XXX =C2=B11.70% x31 -> XXX =C2=B11.02% x34  d=3D-7.39% =C2=B11.=
36%   p=3D0.00%
| phoronix/gtkperf/gtk-test=3DGtkComboBox:                                 =
        XXX =C2=B11.15% x13 -> XXX =C2=B11.59% x14   d=3D-5.37% =C2=B11.35%=
  p=3D0.00%
| lightsmark:                                                              =
      XXX =C2=B11.45% x34 -> XXX =C2=B10.97% x41   d=3D-4.66% =C2=B11.19%  =
p=3D0.00%
| jxrendermark/rendering-test=3DTransformed Blit Bilinear/rendering-size=3D=
128x128:  XXX =C2=B11.04% x31 -> XXX =C2=B11.04% x39   d=3D-4.58% =C2=B11.0=
1%  p=3D0.00%
| jxrendermark/rendering-test=3DLinear Gradient Blend/rendering-size=3D128x=
128:      XXX =C2=B10.12% x31 -> XXX =C2=B10.19% x39   d=3D-3.60% =C2=B10.1=
6%  p=3D0.00%
| dbench/client-count=3D1:                                                 =
        XXX =C2=B10.50% x34 -> XXX =C2=B10.50% x39   d=3D-2.51% =C2=B10.49%=
  p=3D0.00%

On my BXT J3455:

| fs-mark/test=3D0:                                                        =
        XXX =C2=B13.04% x6 ->   XXX =C2=B13.05% x9  d=3D-15.96% =C2=B12.76%=
  p=3D0.00%
| sqlite:                                                                  =
      XXX =C2=B12.54% x6 ->   XXX =C2=B12.72% x9  d=3D-12.42% =C2=B12.44%  =
p=3D0.00%
| dbench/client-count=3D1:                                                 =
        XXX =C2=B10.42% x6 ->   XXX =C2=B10.36% x9   d=3D-6.52% =C2=B10.37%=
  p=3D0.00%
| dbench/client-count=3D2:                                                 =
        XXX =C2=B10.26% x6 ->   XXX =C2=B10.33% x9   d=3D-5.22% =C2=B10.29%=
  p=3D0.00%
| dbench/client-count=3D3:                                                 =
        XXX =C2=B10.34% x6 ->   XXX =C2=B10.53% x9   d=3D-2.92% =C2=B10.45%=
  p=3D0.00%
| x11perf/test=3D500px Compositing From Pixmap To Window:                  =
        XXX =C2=B12.29% x16 ->  XXX =C2=B12.11% x19  d=3D-2.69% =C2=B12.16%=
  p=3D0.09%
| lightsmark:                                                              =
      XXX =C2=B10.44% x6 ->   XXX =C2=B10.33% x9   d=3D-1.76% =C2=B10.37%  =
p=3D0.00%
| j2dbench/rendering-test=3DVector Graphics Rendering:                     =
        XXX =C2=B11.18% x16 ->  XXX =C2=B11.82% x19  d=3D-1.71% =C2=B11.54%=
  p=3D0.26%
| gtkperf/gtk-test=3DGtkComboBox:                                          =
        XXX =C2=B10.37% x6 ->   XXX =C2=B10.45% x9   d=3D-0.95% =C2=B10.42%=
  p=3D0.08%
| jxrendermark/rendering-test=3DTransformed Blit Bilinear/rendering-size=3D=
128x128:  XXX =C2=B10.21% x3 ->   XXX =C2=B10.23% x6   d=3D-0.87% =C2=B10.2=
2%  p=3D0.08%

This is not surprising given that the patch is making a hard trade-off
between latency and energy efficiency without considering whether the
workload is IO- or latency-bound, which is the reason why the series I
submitted earlier [1] to address this problem implemented an IO
utilization statistic in order to determine whether the workload is
IO-bound, in which case the latency trade-off wouldn't impact
performance negatively.

Aside from that the improvement in graphics throughput seems like a
small fraction of the series [1] while TDP-bound.  E.g. with this patch
on my BXT J3455:

| unigine/heaven:           XXX =C2=B10.21% x3 -> XXX =C2=B10.19% x6  d=3D1=
.18% =C2=B10.19%  p=3D0.01%
| unigine/valley:           XXX =C2=B10.52% x3 -> XXX =C2=B10.28% x6  d=3D1=
.56% =C2=B10.37%  p=3D0.06%
| gfxbench/gl_manhattan31:  XXX =C2=B10.12% x3 -> XXX =C2=B10.21% x6  d=3D1=
.64% =C2=B10.19%  p=3D0.00%
| gfxbench/gl_trex:         XXX =C2=B10.56% x3 -> XXX =C2=B10.36% x6  d=3D7=
.07% =C2=B10.44%  p=3D0.00%

vs. my series on the same system:

| gfxbench/gl_manhattan31:  XXX =C2=B10.37% x3 -> XXX =C2=B10.08% x3  d=3D7=
.30% =C2=B10.27%  p=3D0.00%
| unigine/heaven:           XXX =C2=B10.47% x3 -> XXX =C2=B10.40% x3  d=3D7=
.99% =C2=B10.45%  p=3D0.00%
| unigine/valley:           XXX =C2=B10.35% x3 -> XXX =C2=B10.50% x3  d=3D8=
.24% =C2=B10.45%  p=3D0.00%
| gfxbench/gl_trex:         XXX =C2=B10.15% x3 -> XXX =C2=B10.26% x3  d=3D9=
.12% =C2=B10.23%  p=3D0.00%

That's not surprising either considering that this patch is only
addressing one of the two reasons the current non-HWP intel_pstate
governor behaves inefficiently (see [1] for more details on the other
reason).  And even that is only partially addressed since the heuristic
implemented in this patch in order to decide the degree of IOWAIT
boosting to apply can and will frequently trigger in heavily GPU-bound
cases, which will cause the task to IOWAIT on the GPU frequently,
causing the P-state controller to waste shared TDP for no benefit.

[1] https://lists.freedesktop.org/archives/intel-gfx/2018-March/160532.html

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW44r4wAKCRCDmTidfVK/
W0yGAQCQyGymyLUIesu+T+7DMPBz3B1NYxrkOkr6WciPqeXIewD+PSPgfGfwQuy1
JFVU+fTAitT6jPBDsZ9Xnn9tSbzlMo4=
=cLSp
-----END PGP SIGNATURE-----
--==-=-=--
