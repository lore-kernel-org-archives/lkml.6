Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3E219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD3E219CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeHFKON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:14:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57967 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeHFKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:14:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 43CBD8062C; Mon,  6 Aug 2018 10:06:19 +0200 (CEST)
Date:   Mon, 6 Aug 2018 10:06:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180806080617.GA19523@amd>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com>
 <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
 <20180806070958.GA5231@amd>
 <CAMz4kuKdtFDfvc4Lrx6yG5yu=qYRPj8MS5phxcLBkdKAPwXZyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKdtFDfvc4Lrx6yG5yu=qYRPj8MS5phxcLBkdKAPwXZyQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-08-06 15:33:12, Baolin Wang wrote:
> Hi Pavel,
>=20
> On 6 August 2018 at 15:09, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > In current implementation this file on read returns the number
> >> > of remaining repeat intervals. I'd add that to this description.
> >>
> >> I saw Pavel's comments that he did not suggest do this. So I will keep
> >> the original description?
> >
> > If that is accepted, the code should return originally written number.
>=20
> But I think it is more reasonable if user can know how many
> repetitions were left. So for your hardware case, can we add
> pattern_get() interface back to get the repetition number?

Well, I'd say that we are mostly seeing "infinite" repetitions, or one
repetition.

Yes, interface could be added to the lowlever driver -- but I'm not
sure hardware really supports getting that information; could be
tricky on N900 for example.

I'd keep it simple for now.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltoAXkACgkQMOfwapXb+vINPgCeM8R1YrNqeXKoGB7to5s9Nodi
OcAAn18cPCIZ2NWLtPWT8uiTGpwE2jlz
=F074
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
