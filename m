Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F08C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeIJK5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:57:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44049 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:57:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6A65A805F0; Mon, 10 Sep 2018 08:05:32 +0200 (CEST)
Date:   Mon, 10 Sep 2018 08:05:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: linux-next: 0907 fails to boot on thinkpad x60 (32bit machine)
Message-ID: <20180910060533.GA26941@amd>
References: <20180909214632.GA26303@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20180909214632.GA26303@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-09-09 23:46:32, Pavel Machek wrote:
> Hi!
>=20
> I do have some oopses, but they seem to be different on each
> boot. IIRC message was "scheduling?...on offline CPU?".
>=20
> Any ideas? Does it work for you?

Seems that error is different on each try.

Now it is:

FS: Cannot open root device "sda4" or unknown-block(8,4): error -2
(followed by panic, but it listed sda4 as avialbe partition)

Next try:

sched: Unexpected reschedule of offline CPU#0!
WARNING: CPU: 1 PID: 1 at ...smp.c:128 native_smp_send_reschedule
(Aha, that's what I seen before)

Next try:

sched: Unexpected reschedule of offline CPU#0!

Next try: I added "nosmp" on command line, and got

FS: Cannot open root device "sda4" or unknown-block(8,4): error -2
(followed by panic, but it listed sda4 as avialbe partition)

Next try: with "l1tf=3Doff nospectre_v2 nospec_store_bypass_disable"

FS: Cannot open root device "sda4" or unknown-block(8,4): error -2
(followed by panic, but it listed sda4 as avialbe partition)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluWCa0ACgkQMOfwapXb+vI1kACeK1QBa2Z7/9R3X7fX+E+luDBY
CfEAn1OOqmg47/FsAp5ioNQ4HeQRyK56
=yqKK
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
