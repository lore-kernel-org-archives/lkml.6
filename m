Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E889C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F64206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jajEC4UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F64206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIETgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:36:23 -0400
Received: from ozlabs.org ([203.11.71.1]:46663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIETgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:36:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4256TK0vsCz9s5c;
        Thu,  6 Sep 2018 01:05:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536159945;
        bh=86e9HYPyicsxITm/6dtjUTTnIOh/ljYWcLSRjnT061g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jajEC4UYmkkyyurPg2hQ8MXH2/jSyMY2avGsUKG6F17NBsbpmxAkyBBy4eiAoACVu
         4x7N6b/cJAPTx2XPBASmYFjxaliAxkN64hy7Cb9lkcX6/XlOd4wKDlMs9Kv5VDGo/Q
         F+C82zEouxFusHw4SyuKrKEo8/fOF5ziDZdPnYO/zx2tJjjDGxjUVsyZDP3p8izxKv
         LJryzjIgVwnH3/BXezErIa1qTo1pZJ6Fo5OB6RIwVIes3VFwq7Mgel0E4xsGAUXgWC
         9SKlwEZpi5z6WvwzdmZ7CBGFeycM3AAzmVxvuUdyRM/JwwdE/PHY4rKfuHp1oYfrWz
         gQRjyHkBlaT5A==
Date:   Thu, 6 Sep 2018 01:05:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
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
Message-ID: <20180906010534.329d0fca@canb.auug.org.au>
In-Reply-To: <fe9f3e91-93f9-d7d5-1643-dc09543e2850@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
        <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
        <20180905093620.6d9162ca@canb.auug.org.au>
        <fe9f3e91-93f9-d7d5-1643-dc09543e2850@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ov_.S6vdszHnU9RnU1g=UU+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Georgi,

On Wed, 5 Sep 2018 17:50:28 +0300 Georgi Djakov <georgi.djakov@linaro.org> =
wrote:
>
> On 09/05/2018 02:36 AM, Stephen Rothwell wrote:
> >=20
> > On Tue, 4 Sep 2018 15:54:27 +0530 Amit Kucheria <amit.kucheria@linaro.o=
rg> wrote: =20
> >>
> >> I'm currently reviewing this patchset (long overdue), but considering
> >> that we haven't added any major new features to the framework for the
> >> last couple of revisions, can you get this patchset merged into
> >> linux-next to see how things shake out there? We've had this merged
> >> branch merged into a CI build on kernelci for a while now w/o any
> >> major incident so we should increase its exposure.
> >>
> >> You could ask Stephen Rothwell if he'll accept the a branch directly
> >> from you or he needs an upstream maintainer (GregKH?) to carry it. =20
> >=20
> > Since it appears to have been well reviewed and tested, I can take it
> > if you send me a git URL and the names of contacts in case of issues
> > with the branch.  Once Greg has merged it, I will try to drop it again
> > (unless you think there will be an ongoing reason to keep it in
> > linux-next separately), but a prompting email would also be nice in
> > case I forget. =20
>=20
> Thank you! Below is the git URL to pull from and you can use my e-mail
> as contact for any issues.
>=20
> git://git.linaro.org/people/georgi.djakov/linux.git#icc-next
>=20
> I expect this to be a continuing effort with some upcoming users of this
> API, so i plan to maintain this branch and occasionally put some
> reviewed/tested patches to get wider integration testing. But let's see
> what happens now.
>=20
> In any case, if this increases your burden, feel free to drop it.

Added from (later) today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluP8L4ACgkQAVBC80lX
0GyFTQf+OsZLutdzyWpL9/ua0OrFaZjWQLoQeo/YknRXDu5SO0JlHhQtsukHUSe/
cPCri2wHriSgRgrk48t17jA8p2MF9pkzblLrrmqJ4fYxdf3eSFsyZ6DKqGKSQzLs
rtEdSUs/+RFLyNF6p3cuv+vIPwkDrqI+TiXPJ4EAOjvrQMut5nCGv9TanC64eK8i
CnS7RJjcjM8fvwk+TeQGuFzmvJmyMvE3KUbPpachalE3bCFPDVrhHaHeFebp7yaa
wkPwFvhqKzp8NPiBEG+MikqsZLWvk+jkg3TqhE2+IadgeMXRJaSmeY1Ef8chq1xs
smB3W0PLpekjgxm8Tb33iIe22c351Q==
=6HXW
-----END PGP SIGNATURE-----

--Sig_/Ov_.S6vdszHnU9RnU1g=UU+--
