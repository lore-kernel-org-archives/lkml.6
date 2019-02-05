Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD419C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70A2184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eUChhfNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfBEXwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:52:32 -0500
Received: from ozlabs.org ([203.11.71.1]:43567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfBEXwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:52:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vLwX5ZJxz9s3l;
        Wed,  6 Feb 2019 10:52:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549410749;
        bh=Qpv/QsDawur+RP0nUHn/Z14LVgsHiNt8LPK19aU+lwo=;
        h=Date:From:To:Cc:Subject:From;
        b=eUChhfNsjyieaqCUXL5kqxDvO2pmiLRpF+p0/d6QxjmXKubHKFlHLzX5RRuwP6q2J
         21x4LjBjqITSkdNRneo/kz7k0+IFlQwwo+PbmEUXqQo7Lc9TzfdoOjFnJ1Hmqvu5v+
         OWSeSmbZezKl0z9qM21VbI8SHf92rikanhiY7zBd2bfxjB1FnU65LBqiiZNnyLrJkw
         i1qmWBPPrA+RqCd1FAWU/3Y6NlZpZro7wvEjmTFrgD0kV8lYgooEuot+pr9AEfYDF5
         8bFTtGk+yUsMv+LfWqL/pXi0J020WG0CyHrCYsh2wfsEBtqT5oKXmgYXIYy5Dz0DP5
         8d1uaJyxiXIUw==
Date:   Wed, 6 Feb 2019 10:52:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: linux-next: manual merge of the opp tree with the pm tree
Message-ID: <20190206105228.42f7568c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fPxxs.qTiMFREPlX5SvVanf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fPxxs.qTiMFREPlX5SvVanf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

Today's linux-next merge of the opp tree got a conflict in:

  drivers/cpufreq/scmi-cpufreq.c

between commit:

  5da7af9a94a7 ("cpufreq: scmi: Use auto-registration of thermal cooling de=
vice")

from the pm tree and commit:

  d7194c939ea3 ("cpufreq: scmi: Register an Energy Model")

from the opp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/cpufreq/scmi-cpufreq.c
index 66b633b48eb1,44449ff8ad47..000000000000
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@@ -11,6 -11,8 +11,7 @@@
  #include <linux/cpu.h>
  #include <linux/cpufreq.h>
  #include <linux/cpumask.h>
 -#include <linux/cpu_cooling.h>
+ #include <linux/energy_model.h>
  #include <linux/export.h>
  #include <linux/module.h>
  #include <linux/pm_opp.h>

--Sig_/fPxxs.qTiMFREPlX5SvVanf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxaIbwACgkQAVBC80lX
0GxXTAf+Mk4usPSHntcGU7c9TGd4/0fOgG+Nu89UrAnBixkkNvc/AJFV54BwUp4R
wSBypXHeBHPI668tEwAaY5FdzaqQPmOA5SjA/zmBEToDI85Jon3tQwQRQhcra1nh
GQwn+Y5JnIl4NVb410MEhbLM+/PKHpPg8P1sqKkQCkMUXLKNSx26dao9MnzccDu5
RiKFk8EQzQCiMhS+8bivWwP36fK2HGTIyGO8gbb34yBEyMI2bkBUmDEwByRldfJH
PgoUHwbsocDfXBmteI+DkeKVN23y9Qq/+eK9/g9Q+DzZkP5J7dHQ4ebvw2oXok0Z
6xIYXNal0XZsWfS9pzQJR3uvjrWTiw==
=lb1C
-----END PGP SIGNATURE-----

--Sig_/fPxxs.qTiMFREPlX5SvVanf--
