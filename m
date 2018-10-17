Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671DEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239FE2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239FE2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJQXdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:33:49 -0400
Received: from anholt.net ([50.246.234.109]:54632 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeJQXdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:33:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 520B010A0F9D;
        Wed, 17 Oct 2018 08:37:34 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gNaLyCrloPqb; Wed, 17 Oct 2018 08:37:33 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E2FEC10A0826;
        Wed, 17 Oct 2018 08:37:32 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6D30D2FE1BEE; Wed, 17 Oct 2018 08:37:32 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, phil@raspberrypi.org,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
In-Reply-To: <20181017101831.b5kvh5jw3sqqhbat@mwanda>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi> <1715113043.52878.1538821118324@email.1und1.de> <20181017101831.b5kvh5jw3sqqhbat@mwanda>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 17 Oct 2018 08:37:32 -0700
Message-ID: <87bm7stwhv.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Sat, Oct 06, 2018 at 12:18:38PM +0200, Stefan Wahren wrote:
>> Hi Tuomas,
>>=20
>> > Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 1=
1:37 geschrieben:
>> >=20
>> >=20
>> > Drop various pieces of dead code from here and there to get rid of
>> > the remaining users of VCHI_CONNECTION_T. After that we get to drop
>> > entire header files worth of unused code.
>> >=20
>> > I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
>> > snd-bcm2835 can still play analog audio just fine.
>> >=20
>>=20
>> thanks and i'm fine with your patch series:
>>=20
>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>=20
>> Unfortunately this would break compilation of the downstream vchi
>> drivers like vcsm [1]. Personally i don't want to maintain another
>> one, because i cannot see the gain of the resulting effort.
>>=20
>> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/=
broadcom/vc_sm
>
>
> I feel like everyone else already knows the answer but why don't we just
> merge that code into staging?

Dave's been working on a new VCSM service where the firmware can call
back into Linux to allocate (instead of just having a permanent carveout
of system memory that the firmware allocates from), and lets us make
dma-bufs out of those buffers.  That driver makes a no-copies v4l2 media
decode driver possible, which would then let Kodi and similar projects
switch from downstream kernels with closed graphics to upstream kernels
with open graphics.

Given that the new VCSM service is a rewrite, it's not clear to me that
importing the old VCSM driver is a win.  But maybe we should go raid
https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2a and grab
the new drivers.  Upstreaming the VCHI audio driver to staging has
clearly been a win for it, so maybe other eyes on the new v4l2 codec
could help Dave along in stabilizing it.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvHVzwACgkQtdYpNtH8
nuhK3A//f9GO+h+0BU+AZYWAEyoJ12NUn7Gso5Bser2gUjV352+gWL78sAdM8zhJ
7UTVcgv0PHym6v0TX9N1F64jBHGKF/yKlacUAhi3h8fJ7+dwJ9QBPLVqUSIcG7Nu
S/Xpj7gVZaXqonCCSU2hT6aUgxTNb/YfhjuA1/qbRoYffipxUp2j0Ix2+dRgU/AO
fTX9ka51mOfyIGWEXLFFfkNdt5VjyPmgHlvybNwh3bv1cvC4YG8fG8HI/YGcAyEx
fj7CA4Xi95V3wW2Q50rpfdGXa4MyOjDBM7UxBlglBMOJyvb+e5wICByWZWmrRlcf
0FCr/wJImHxpgJ2E7J7ZQ/dJO+FEfhkUuPe5gQRZ80/g6cranOnKlo/A6J9lxD2c
cM6rKQvLSEtIeo4GbEirWjkJQKUp6nUYQfm6y8KBkcL/E51jaIogzd5+u1SHPK3o
mDhEZhCmewH2GXPPOfrSqMk1+x12fuchjU8EcFTY4J5fUzYMfyicLXxqTlIbjkPq
Vuonee5gEO8IL3fSYmcq8EBqrII69J9iCWWxufPx0U7xHleKN5wo9fMioiRmobka
ahoItmmhPBqYRJrxT5wa6wTFu+4vEWz5cA+4NKct1xQ0o4xoqfSHDkLtffL3fd7o
UbFA8m2UV0hy6wC9Ujvjr3a6GXbdXE14Xz0TKaJhesOlkV0IiVA=
=Pemg
-----END PGP SIGNATURE-----
--=-=-=--
