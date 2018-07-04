Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1269C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42C21A31
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C42C21A31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeGDTwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:52:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41922 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeGDTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:52:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7637E80564; Wed,  4 Jul 2018 21:52:38 +0200 (CEST)
Date:   Wed, 4 Jul 2018 21:52:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: droid 4: connection refused from voltage_now
Message-ID: <20180704195238.GA13932@amd>
References: <20180704171156.GA3158@amd>
 <20180704194556.GA9189@lenoch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180704194556.GA9189@lenoch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-07-04 21:45:56, Ladislav Michl wrote:
> On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > I started to use droid 4 as my primary phone... so I have battery
> > monitor running for hours... Once every few days it dies with
> > "connection refused" error reading battery's "voltage_now". I restart
> > it and it continues working...
>=20
> Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111=
)?
> I have custom at91 based board here with few custom power supply drivers
> and it sometimes ends with voltage_now of my driver being unreadable.
> (I modified userspace code and waiting what's in errno in case
> reading fails)

It seems to be -110:
Jul  4 11:48:29 devuan kernel: [ 2908.602600] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:29 devuan kernel: [ 2908.608123] cpcap_battery
cpcap_battery.0: cpcap_battery_get_current failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.922576] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:30 devuan kernel: [ 2908.928100] cpcap_battery
cpcap_battery.0: cpcap_charger_battery_temperature failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.936340] power_supply battery:
driver failed to report `voltage_now' property: -110

> Adding linux-pm@vger.kernel.org as it seems to be subsytem, specific.

Good idea. Thanks!
									pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9JYYACgkQMOfwapXb+vIBdwCfbj4nu3YHaW3iY6DJSonTbMSi
eN4AoK8RudLJUGz1umI+ETLc1jelA/xn
=6BUt
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
