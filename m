Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23919C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F520C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3F520C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHTM2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:28:30 -0400
Received: from sauhun.de ([88.99.104.3]:57662 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeHTM2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:28:30 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id F0B752D4159;
        Mon, 20 Aug 2018 11:13:38 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:13:38 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] i2c: imx: Fix race condition in dma read
Message-ID: <20180820091338.x2nofnytf7z27omk@ninjato>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
 <20180816084315.7857-2-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvvcsehlikqqjmfp"
Content-Disposition: inline
In-Reply-To: <20180816084315.7857-2-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hvvcsehlikqqjmfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 10:43:12AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
>=20
> This fixes a race condition, where the DMAEN bit ends up being set after
> I2C slave has transmitted a byte following the dummy read.  When that
> happens, an interrupt is generated instead, and no DMA request is generat=
ed
> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec=
).
>=20
> Fixed by setting the DMAEN bit before the dummy read.
>=20
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next and added stable, thanks!


--hvvcsehlikqqjmfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6hkIACgkQFA3kzBSg
Kbbgzg/9HmVo7UbvwKyXyXtOJl92ABXip9+uOSHVXFSrklNmT1s7d/pR6GtWdNTY
RnoyO/81TQ0RWRIIdsaaSr7QMYg/VZ6mg/xiNWEYPQrKuJivnaNvRoX72GDRHMfO
9J2SwseayGtoLxJWGOg/UZUrIQCS8ZW32XfhmEoOhNfXjcLXRf8moi/BGQJhVMfO
jqwdyCqWzRMl5JOnOuQsY8OKjEH6A5kKcgH+D5D9oUEUN7xXty9sgDff98CnQbpe
GeZkxxcVWNr2EWWn8fVv7opGRxul4m94mmUaNOm+qdOWnz5tQGRcdeK/nhKn7DPU
CAU5+H9MQ4sfb9gVLVZJAI1mUQisl1uYI9fCHeQanCh21Lv9R478JRWd0E9TziDe
avqYzLKFA9XQxdYqpMpCHtXFhIyXr9pDfNG3FaSrKlB3zoI+6QLb1AaXZ4/MKNjC
N/NsqcqsLN8Sojwt0Aw6H9tfJHHoViGH2ZGYztKtRgmrNWUy3FoAkfGXtMwiAPmk
oRv7tLKbpXMrUx1D5R43dmzNHc/1FtWJkydjzyseIzt9T1EcCZCA3O8pXE14VShE
WIOLY1fEwOPgSPoZXHEaMuROe59oTRcjTzC0NgpNZ3S6wXjn7ov+TowUtIuazYkh
WYbAjivh2qBNO8Pmr7ulQb8xYI6wDOFWPEyWTMbhT0/cckYFLXQ=
=n16k
-----END PGP SIGNATURE-----

--hvvcsehlikqqjmfp--
