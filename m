Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeERI51 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:57:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37008 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeERI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:57:17 -0400
X-Google-Smtp-Source: AB8JxZpWqG20yj2myhw+m//fCsklyOn2im00DH1crMn9OS5p3YzL/qNv6v1Q0HXa/JPP50ABI3IuXA==
Date: Fri, 18 May 2018 10:57:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 05/11] cpufreq: tegra20: Clean up included headers
Message-ID: <20180518085714.GE14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-6-digetx@gmail.com>
 <20180518015854.glj25krzacf7rnd7@vireshk-i7>
 <7c3a549b-ad84-5df6-c1d8-7683a3bc2f5d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <7c3a549b-ad84-5df6-c1d8-7683a3bc2f5d@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 11:05:58AM +0300, Dmitry Osipenko wrote:
> On 18.05.2018 04:58, Viresh Kumar wrote:
> > On 17-05-18, 21:00, Dmitry Osipenko wrote:
> >> Remove unused/unneeded headers and sort them in the alphabet order.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/cpufreq/tegra20-cpufreq.c | 11 ++---------
> >>  1 file changed, 2 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra=
20-cpufreq.c
> >> index 69f033d297e1..61f00d1cba26 100644
> >> --- a/drivers/cpufreq/tegra20-cpufreq.c
> >> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> >> @@ -16,16 +16,9 @@
> >>   *
> >>   */
> >> =20
> >> -#include <linux/kernel.h>
> >> -#include <linux/module.h>
> >> -#include <linux/types.h>
> >> -#include <linux/sched.h>
> >> -#include <linux/cpufreq.h>
> >> -#include <linux/delay.h>
> >> -#include <linux/init.h>
> >> -#include <linux/err.h>
> >>  #include <linux/clk.h>
> >> -#include <linux/io.h>
> >> +#include <linux/cpufreq.h>
> >> +#include <linux/module.h>
> >=20
> > Ideally you should keep all the headers whose declarations your code
> > is using directly. It may happen that removing above still compiles
> > because cpufreq.h has included the headers indirectly for you. But
> > that will break the day cpufreq.h doesn't need those headers anymore.
> >=20
> > So just make sure you aren't using any of them in your code. For
> > example you are using bool in your code and so you shouldn't remove
> > types.h ? Same for init.h as you are using __init and __exit.
>=20
> The preference on includes seems to vary among maintainers. I've seen oth=
er
> opinion that encouraged to minimize included headers and only add the hea=
ders
> when compilation breaks.

I think this probably depends on the type of include. For headers in
include/linux the reasoning is that they can change often as part of
some rework and this has in the past caused unrelated files to break
builds because suddenly a file no longer has all required definitions
available.

It's slightly different for header files that have a narrower exposure
because the chances of breaking things randomly are much lower.

> I'll revisit this patch and keep init.h and others in v2 since you prefer=
 that
> way. Thank you for the review.

With those changes, this is:

Acked-by: Thierry Reding <treding@nvidia.com>

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+lWcACgkQ3SOs138+
s6EJ8g//SKL8hoquB+U7SJKwvWWUBHUv0Mgh7cXWFLyrtd8VQOWWI0p0DT8Dk0ym
Hmpo4b8AE4vmhvTtFkLUWWq4zo5BCh35rgiWuFxaJEoBhGxpXqIh7RqjSxq1vPQw
Q/NVUhabtNdhV4ELS2bvNyioIJUqtfhjl06ubaDEQvkluLL0OJNvdAbxcd3yw5CU
y0EbSr6W6gfUKdpRB+QTJlHiSJ2FCXvTu4WjMAX8NfV0d2n/RijJoCZk2gGQ6lSz
zvVHkDvAJUpVJppqIVeB0EdHu0Eotn2qaB5Vgh3TUL8JEjnYL4y+mD+FGmYj5YZf
NhgT+2KPbzvMqHR2omIKZ50SmrLYvvSK2iO1dMRIoV/0bf96cI+cWyQ7BiUScRa2
9wmdwsfvs5vBC0wxl/YfDapHxBpD8irJE1opPfBrAhc/fEGkvscF/vU9BO/ogKR5
jIKgQ+HjGjYq75/nyxFvdgMDi2I6akqHnRi8OR7Z/fgVVl0y23nTSbQ63jmsoa7C
r0N2KFGm0FSDYgNTL+ytWXBk7VSOu68mBbCRGgeS7D7/SO/qrVD+taXNRHjbqV6Z
RlWo1OBtmEc4Ev1n8rwUl42dWDVPc6akTwlyZUygGVpSRBcy8kOQa9PUTRELYj2S
jJ6BMWIHRIYG7KCX+VyZvu7w9eCZ5PulLGRGvDM3Sx0+NARiqjo=
=s9lC
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
