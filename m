Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeC2Tin (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:38:43 -0400
Received: from mx1.riseup.net ([198.252.153.129]:32888 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeC2Tim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:38:42 -0400
X-Riseup-User-ID: 3780616662E890B2D718A54AFD63E9B0018A4E6E0955F48ED345B1E748139578
From: Francisco Jerez <currojerez@riseup.net>
To: Fabio Estevam <festevam@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        0day robot <fengguang.wu@intel.com>, Len Brown <lenb@kernel.org>
Subject: Re: [kbuild-all] [PATCH] OPTIONAL: cpufreq/intel_pstate: fix debugfs_simple_attr.cocci warnings
In-Reply-To: <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
References: <alpine.DEB.2.20.1803292109180.2750@hadrien> <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
Date: Thu, 29 Mar 2018 12:23:10 -0700
Message-ID: <87a7uqofdt.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Fabio Estevam <festevam@gmail.com> writes:

> Hi Julia,
>
> On Thu, Mar 29, 2018 at 4:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
>>  for debugfs files.
>>
>> Semantic patch information:
>>  Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
>>  imposes some significant overhead as compared to
>>  DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
>
> Just curious: could you please expand on what "imposes some
> significant overhead" means?
>

Probably negligible given that this code will only be run once at system
boot and then never used again in production systems.  But I guess the
micro-optimization doesn't hurt either.

> Thanks

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWr09HgAKCRCDmTidfVK/
W156AP9KZh/1SG7KxnlAfAXBy4IFoLtoupi3W4fh4IIxGcK1YwD7BIGdIlJON3UW
/gQFirlZ4u8XIdHmrxC+uOk+gj14SRQ=
=/l9F
-----END PGP SIGNATURE-----
--==-=-=--
