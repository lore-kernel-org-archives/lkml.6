Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360E6206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lKSUKPZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360E6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeIEEDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:03:51 -0400
Received: from ozlabs.org ([203.11.71.1]:58631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeIEEDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:03:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 424js03B2Jz9s5c;
        Wed,  5 Sep 2018 09:36:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536104184;
        bh=WmhTEmN0eWe4Ui45FDbS8hV28y8sDlhzeUbeSXSd2qA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lKSUKPZ14E1e+/tLvFdO5prLHr6Od2LyID7w4zqiZxN2YEUWZJ2/Bm9GobbNDnrGg
         hVj7A31a5p2Yid6sJVlf410zujm/AN3IgHchI7Gwtucl97mFdy4D1uTuwldMCe/hxP
         n4Ze6rIpvKTNECgqmZ7DpbzvVNsYWDk4ywj3kDure6ze3ORoLYhbwjs9RLQjdxlq/O
         VLufwgPBsElTpst1//6yi7HYDRvQzhYJCBqlS4ccRc1l9iTtqjJ/hMtGVvIt1dA53B
         6aukn3l4kpDgf2/ORQiYaCfPYNHIeXGwFPzGRhMKyFxg9vmiW4VyqnYLiKpy2f85ib
         jieVrEU8Dgcjg==
Date:   Wed, 5 Sep 2018 09:36:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v9 0/8] Introduce on-chip interconnect API
Message-ID: <20180905093620.6d9162ca@canb.auug.org.au>
In-Reply-To: <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
        <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=t3Ckflr7nTyHhTekgg8jUB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=t3Ckflr7nTyHhTekgg8jUB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Sep 2018 15:54:27 +0530 Amit Kucheria <amit.kucheria@linaro.org> =
wrote:
>
> I'm currently reviewing this patchset (long overdue), but considering
> that we haven't added any major new features to the framework for the
> last couple of revisions, can you get this patchset merged into
> linux-next to see how things shake out there? We've had this merged
> branch merged into a CI build on kernelci for a while now w/o any
> major incident so we should increase its exposure.
>=20
> You could ask Stephen Rothwell if he'll accept the a branch directly
> from you or he needs an upstream maintainer (GregKH?) to carry it.

Since it appears to have been well reviewed and tested, I can take it
if you send me a git URL and the names of contacts in case of issues
with the branch.  Once Greg has merged it, I will try to drop it again
(unless you think there will be an ongoing reason to keep it in
linux-next separately), but a prompting email would also be nice in
case I forget.
--=20
Cheers,
Stephen Rothwell

--Sig_/=t3Ckflr7nTyHhTekgg8jUB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluPFvQACgkQAVBC80lX
0Gxn4ggAgxqb5TVFn2+jl3s9fpEEFIlsoN7E8DJBp0ITdp2Eew7vGhicleD6YMg+
dBefTyw3AzyxamsW04KDqI/7z28vPNySy27SHYLB+wjfrW2QHhCTByl86kBRmNhA
K+Vc3T9qnaoAXN0tHLJpEm56HWI7/hR2r7UOJYlhsW/6ztXN6ul2ZGp4UQgFsKwv
1TaiRH1civVVuL6Po153iPiuJcoixSjwgpdRk1rM9aW0so4sXO1LF044HSECKu1q
ygklVH2mXEgH5nhSxFXnxLaxvdQaPFWJBy7nzxJi4qoEhKglohpYXEHjS0v66+Jq
I3EJyAvfSR49Z9jB3DFEXyAW6ZCvaQ==
=X8VW
-----END PGP SIGNATURE-----

--Sig_/=t3Ckflr7nTyHhTekgg8jUB--
