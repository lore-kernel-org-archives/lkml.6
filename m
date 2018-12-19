Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2611DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEC7218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeLSQdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:33:05 -0500
Received: from sauhun.de ([88.99.104.3]:55582 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbeLSQbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:31:21 -0500
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id D85332E3542;
        Wed, 19 Dec 2018 17:31:18 +0100 (CET)
Date:   Wed, 19 Dec 2018 17:31:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Rosin <peda@axentia.se>, Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Message-ID: <20181219163115.fdnl6kivywuxdgmu@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
 <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjxzn2xrzruodsqv"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjxzn2xrzruodsqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 10:39:05AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> > >
> > > When more stuff is added to this bit field (which always happens at
> > > some point) updates to all members of the bit field will have to use
> > > the same root-adapter-locking, or we will suffer from RMW-races. So
> > > this feels like an invitation for future disaster. Maybe a comment
> > > about that to remind our future selves? Or perhaps the bit field
> > > should be avoided altogether?
> >
> > Changed to bool. Thanks!
>=20
> Does that help, given bool is smaller than the CPUs word size?
> Is it Alpha that cannot do atomic operations on bytes?

Yup, I overestimated bools :( I guess good old

unsigned long locked_flags;
#define <PREFIX>_IS_SUSPENDED	0

set_bit(), clear_bit(), and test_bit() is it then.


--qjxzn2xrzruodsqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwack8ACgkQFA3kzBSg
KbY9JRAAhxm2Kip+tvnMls1hk+/Edk4mmwGCNgQoxQX2AhW3Lw0vyAffaBG7S+eG
UwNg372M5JC8Rva111oTpAVr8MhvAVuJnGFpG0UMJIDWXQGJ2UKcumx7DNHwYjiB
zkDtrdjilgbGSe9SVRco+BbBK6qy/mdNI+GBAnXB9bC+Xbawe+3KTlgGVlFpjS9r
Yb02KmVERIxeBYbzNw23S9Tx3raZVOnGSz2am/n9GGrM/kFtBK1Ge7W+Acq92VoF
9C3AOy0ZoyY8sgz5rR0TRuoVgkXC/8AKsWqS3dVCpR0iZPVG9ZYth5ta7rRojjeJ
C/s1Hgq6oR2zxXLiM/NG7SbdIiVMekYbEDrRx2zsBwg18aynLRuygwnqHkT6WE8A
lfZKa/LEVvP9p5Xw4Lwak0jxtqAJzGIv6ebJRN5tLmcRP9vYRuKk/D5RbWq4U6bZ
fuI6Z589b4nZkWgx52G8RCu3NImmLFxbhJd9RjOm9buE5b3nz4aatviQbno2uJ6s
gC3SMz9p0nG7A0cdEYcXXG2/FrKXl3lQtIU028DFRkkfGARRX5bj6+I7bp/s4Vby
0wsdtXwezh9SQPBiJBbtilD9j6oDZGep3/tLVWacvbn3T819oEfVltn26YHQbuz2
VDmUUE5YtgAdUqjUJ2YM0BOZ+bHAGEzGDY2DJLMSwWs7Clu79FE=
=KkzT
-----END PGP SIGNATURE-----

--qjxzn2xrzruodsqv--
