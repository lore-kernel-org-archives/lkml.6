Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-730741-1523271255-2-14930057518335524349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  T_TVD_MIME_EPI 0.01, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523271254; b=LtKsDZUiImkf7fHmUsi4977L6CtKJHN5GqsHnPTsA4bbUfzFFm
    D7yF7pjb/+NZ7YRGB52uJt/ymSa3/4gVPuU8qoJ2l1oaJzB9mzVH56fntevmI7a6
    fMBqknksKGDhTEXhFTutOK6oqbvVRHxebElphbqZpRHNhqlLF1uFQ2v9A5vFwdCX
    hfSFgyY4wreMqQMYTYSgtJK/SFxE86ry69wxmAYh533D9vqEFEB4XvovQb4Lz0Ju
    0NKPrCXqEt1jOMXjb9eJ7Z31kAkUCJakOIWPKybQSCDAOE2KncJyaZhUjgJVcjrC
    1t4FtV5w35lEQ2aGisAPjlxbvLrKaAdIgEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523271254; bh=vikl2QLUSPLqC1Q91hRUrDPPJFy31z
    JquF4G7tK/+/I=; b=FAzAE9w1iimGsp3YRBSa2WC1PQNIGewFT4Nuv+zVSf6kPV
    n5kZfVy8Dn9hUtSbHcpZScPhFSLm3+15mijOYrkPTkyqpySBFDwITR8l3Z2cqNlj
    FHHUT62lKdiOKx+yqESh4Dr6KsXm7DHChQuqNRu/dJMWpnNs9YQ/KwlCN8ldBeas
    stDDCxXQrR7l1NnQV5xLZGQxmEgqudLyZQx5+PcY77xj7Ba3ly4VW3BxZGjcHurh
    G6LIc4OtcAykg+j+ongHdDvn+IP8oZ+4ULdq1usT5IfPquHs3vOqYGkHoN1f2+Zv
    krfkR8wP5ApbwFxoaBGRU/xXwMLrgRBbSugyCMkg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFoeSOQPzptgYMbv3R1TxRmGV3Yhh+9q2P2Ly20QtQYU8vP7Onfzgpy2nO94ggXv+5hrJet6CCwQd8YkHE2etYG4Q/fqVxuULA3DX61WHuC8+hsfc1D/
    avMoE6aEb/HwbI98zk2MhffXjQQ4f80D70J2JUlta/PR1lhkQjoAUSnP91S/yyYVtGhDEJZTo398TIJ+9oswh/Mm2ERClUlOT6AbFCBaCN5zXW6Rpi286sUZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=GX42SddCDxXBuCEZ2gEA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=S5C1TVdV4R1bYMLGD_YA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeDIKyL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 06:54:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38758 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeDIKyL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Apr 2018 06:54:11 -0400
Date: Mon, 9 Apr 2018 12:54:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>,
        Dan Williams <dcbw@redhat.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Message-ID: <20180409105407.GA15315@amd>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20180408235740.GN5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Do you have a tool to use and a script?
> > >=20
> > > Yes I used the shell script I posted earlier, but forgot it also
> > > needs the ldattach done.
> > >=20
> > > Anyways, last night and today I wrote a quick test utility called
> > > droid4-ngsm that initializes things and I can use to do some
> > > experiments to get the ts27010 channel proxying to W3GLTE also
> > > going:
> > >=20
> > > http://github.com/tmlind/droid4-ngsm/
> >=20
> > Ok, now i'm confused. It wants to bind to ttyS0, but modem is on
> > ttyUSB4 AFAICT? Or is the modem connected to serial port, too? (Do I
> > need to enable some more drivers for that?)
> >=20
> > I do have ttyS0, but I don't think there's anything attached there. Or
> > is ttyS0 for the LTE modem?
>=20
> The ttyS0 is connected to mdm6600, and ttyUSB4 seems to be
> some buggy subset of ttyS0 n_gsm dlci1. You need need at least
> the following commits in current mainline kernel:
>=20
> 984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
> e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
>=20
> And then you need PHY_MAPPHONE_MDM6600 and CONFIG_N_GSM enabled.

Ok, I should have all that enabled. But droid4-ngsm still fails:

user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
Starting ngsm..
Testing ngsm..
Could not open /dev/gsmtty1: Level 2 halted
Trying to start ngsm again: Level 2 halted
Starting ngsm..

commit 984c7706ff180e33096c57183435d925cb644576 says:

    ARM: dts: omap4-droid4: Configure uart1 pins

    These are needed to use the n_gsm driver for TS 27.010 UART
        multiplexing. Note that support for the OOB wake gpio is still
	    missing so the UART is not yet usable for n_gsm.

=2E..am I still missing the OOB wake gpio support?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrLRk8ACgkQMOfwapXb+vKUMACdGCs9We6jp5SjvzBz23cZ2XiO
IgkAn3mi6W4S/ubHSvt/r2yNpMNHpTxQ
=ijUg
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
