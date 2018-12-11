Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91624C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6088A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6088A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeLKT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:28:08 -0500
Received: from sauhun.de ([88.99.104.3]:44954 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeLKT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:28:08 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 2CE544C0E8F;
        Tue, 11 Dec 2018 20:28:06 +0100 (CET)
Date:   Tue, 11 Dec 2018 20:28:05 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Message-ID: <20181211192805.qsxptzkmczmm5vlz@ninjato>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3px5u5ztkeyr3oy"
Content-Disposition: inline
In-Reply-To: <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3px5u5ztkeyr3oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ludovic,

> > >  - fix checkpatch errors
> > >  - tests:
> > >    - hangs with a SAMA5D4 (master and slave on different busses) afte=
r about
> > >    100 transfers. It's the firs time I do this test.
> > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > >    I don't know if it's a regression. I don't remember having seen th=
is
> > >    behavior previously.
> > >    I think it's worth taking those patches even if there are some pos=
sible
> > >    bugs. It'll allow to get more people using it and so to consolidat=
e the
> > >    slave mode support.
> >=20
> > I really want to see those patches go upstream, too. But I am also not a
> > big fan of delivering the user something with known issues. Especially
> > not when they affect the main feature to be added. My rationale here is
> > that someone who is able to fix the issues remaining will also be able
> > to pick up and apply patches.
> >=20
> > Maybe, maybe if it was to be enabled by a special
> > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > think twice about that, though.
> >=20
>=20
> I understand your point. The experimental mentionning could be a good
> trade-off. Let me know once you make up your mind.
>=20
> > Speaking of Kconfig, I think this series needs to place a
> >=20
> > 	select I2C_SLAVE
> >=20
> > somewhere.
> >=20
>=20
> Ok I'll update it if we go further with this set of patches.

Ok, I give in. If you:

* add 'select I2C_SLAVE'
* make slave support selectable by I2C_AT91_SLAVE_STAGING or
  _EXPERIMENTAL or something alike (default n)
* and add to the help text of that symbol the above known issues
  and 'not for production' and 'help wanted' and where to get more
  info and all that

then I'll apply this series soonish. Promised!

Thanks,

   Wolfram


--u3px5u5ztkeyr3oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQD8UACgkQFA3kzBSg
Kbbv5A//XSrxh8si+e3AU5T8HE/y/l3i9dreOYqcMS6joBcoIIFocbC8PSVpOWRR
jk7BxI87bfpTe2kDxpmHq37jvjy886tXJ8fcAx8YGvaWgnF5FjMrcZGJ0GYoIOQ4
04nEXdFgGb1NACMZGyT3Q4C0ov4HBy62T9K/sN99AznxLQkfDRB0kCE/TdQhtpcC
F8XCfSUjrEhfs04ey2poggUHjne2zVmOjATnip7X3CZF4LTE2ktGtOY8lZHeqWjl
falbb/xTGMNIrTr6keXzwiBN5pvy3ijwzZbFtF7MThLWIPMsPPK/Y3RbltauT4SQ
/AilFdJIeheddTPPTFpMw6tC1FA7VwJAEM87M5uEk7TUlc97LBl25uUH8cEHaYKg
HNlOACMkg1U94lJWPk4dWvTHT4e4PTHCQK2fIegaeZnTKWw+FluJEqUPr9cAANEj
8z++hdKxsWK4MLNBvziTu7yfrw9/k6/sMbDd8bB/PoPak9YoGTlKX+ogdJtsSyPK
/uUZlVkIptK/sGaCIKMbCjmrxbAuhuoPSjSi5kEkX558T6tjCXRK8hDkqvqQbW/Y
wLKRfQpqeOHmfAECHG1/jPISVcZA5Pp4DjMTOvuyiZbFEKFLQ7p3lkmMoZ6zuR23
p0mpNpPYww/rQL8rUm6+Ej9yUrmzmlfyDlEZxdVVFTBw66BXCZA=
=Mkqk
-----END PGP SIGNATURE-----

--u3px5u5ztkeyr3oy--
