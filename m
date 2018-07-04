Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3B21570
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE3B21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGDT46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:56:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42020 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeGDT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:56:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D4BE68059B; Wed,  4 Jul 2018 21:56:55 +0200 (CEST)
Date:   Wed, 4 Jul 2018 21:56:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Charge counter on droid 4
Message-ID: <20180704195655.GB13932@amd>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
 <20180618074023.GA16955@amd>
 <20180618082858.GO112168@atomide.com>
 <20180618093459.GA21391@amd>
 <20180618114832.GR112168@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20180618114832.GR112168@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-18 04:48:32, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180618 09:37]:
> > On Mon 2018-06-18 01:28:58, Tony Lindgren wrote:
> > > * Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> > > >=20
> > > > So... there are mA, mAh values. Those come from hardware, and I
> > > > believe we should keep them.
> > > >=20
> > > > But there are also mW, mWh values, which are synthetic. Userland can
> > > > compute them from mV, mA values... and it is confusing that kernel
> > > > provides them. (My tendency was to start computing these synthetic
> > > > values in userland, to compare them with "real hardware" values from
> > > > kernel. But then I looked at kernel implementation, and realized th=
ey
> > > > are synthetic, tooo...)
> > >=20
> > > Hmm mWh value is based on the hardware sampled shunt
> > > values and number of samples gathered between the
> > > two readings. I'd rather call the calculated values
> > > based on userland reading mV and mA values "synthetic" :)
> >=20
> > As far as I know, shunt resistors provide you with current (mA) not
> > power (mW) measurement... and cpcap-battery computes power_now as
> > voltage * current. I'd rather have kernel tell me "hardware can't
> > measure power" and do "voltage*current" computation in userspace.
>=20
> Yup you are correct the hardware samples mA and we still need
> to calculate mW based on the voltage.
>=20
> But considering it works and seems to match the power supply
> provided average power consumption numbers pretty well and at
> least I'm using it.. What is your reasoning for removing such
> a usable interface?

Well, it is confusing for the userland, because it has no way of
knowing data is synthetic.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9JocACgkQMOfwapXb+vIGQQCfVo8PLeNzql0sU6UaOa1Bn70h
XOQAoJzlibYJgs2fYkJuqGs+ejn4//lQ
=OTdz
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
