Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01435C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ECB20848
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ECB20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJ2GyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 02:54:03 -0400
Received: from sauhun.de ([88.99.104.3]:57962 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJ2GyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 02:54:02 -0400
Received: from localhost (unknown [87.113.172.131])
        by pokefinder.org (Postfix) with ESMTPSA id 648344A1CCD;
        Sun, 28 Oct 2018 23:08:04 +0100 (CET)
Date:   Sun, 28 Oct 2018 22:08:03 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] i2c: uniphier-f: fix race condition when IRQ is
 cleared
Message-ID: <20181028220803.GD1882@kunai>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 12:01:49PM +0900, Masahiro Yamada wrote:
> The current IRQ handler clears all the IRQ status bits when it bails
> out. This is dangerous because it might clear away the status bits
> that have just been set while processing the current handler. If this
> happens, the IRQ event for the latest transfer is lost forever.
>=20
> The IRQ status bits must be cleared *before* the next transfer is
> kicked.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWM0MACgkQFA3kzBSg
KbYaZw/8D196rBzyuYFWIH6vzaZIogMkHLhq1FZmHdwcJmP3efMuSF17XlfKcWI8
YOP425jIvNf3xNQnmRWlONVzNoI2kACVH+tINdqL4sn1QM+sOJ3Fze+tFJqxk9oP
kBHtZeATi+2/M6sh0UaYxL3vE0ntm3jcv1afdrl5rstqa92/vOpax5jG5gpP7evc
UYgKAJyf3SJLV4NpndGnMve7jQZAqK4Xf9vtokPiKSF9gEmE7Ma05Rsf1a25P4u6
qNRwvOrFU+6lUleQfJqidc2rjwNB0kQRLvyj7x1vE0nQ+KEzuUXhddi6o6qcZt9B
9/BxL3dQJPNccFsc7O4xFljX0qzChQc+0iquRdIcpN5eSZtNivg0aDFXszNaCLOQ
uzEnE7mkk9gY0+BVoLGT8l5UIzkY+sg33EAHozPkdBJeECzMWBKH8Q+4POAd1GlF
p6Odi7xUDvy8e1k7uhImfpAmrGJtwDCVIygXzPN0wJy8PDxeBeb7i4OdNUblz6yr
SWV33UR3gJSevo358ZApF42Oc7hURvfdBzzOF9n9PM2vn7grFJNV14QLycRH/Wh0
DCgAmS7W5mj+Nr1WkVw0aqkd901if7rxEsp/zfx358jL2nzbYa8GYi5rC0QfWZEm
RJK1s8suh1B7xw0cliLbdxpogcfhVWrmBAlqgWryWEX0hE1ijoE=
=o6bX
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
