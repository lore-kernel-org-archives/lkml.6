Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2BDC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27262083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27262083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIAREA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:04:00 -0400
Received: from sauhun.de ([88.99.104.3]:38724 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeIAREA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:04:00 -0400
Received: from localhost (mue-88-130-111-030.dsl.tropolys.de [88.130.111.30])
        by pokefinder.org (Postfix) with ESMTPSA id 5B30D3648A7;
        Sat,  1 Sep 2018 14:52:01 +0200 (CEST)
Date:   Sat, 1 Sep 2018 14:52:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: uniphier: issue STOP only for last message or
 I2C_M_STOP
Message-ID: <20180901125200.GD1196@kunai>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 11:30:47PM +0900, Masahiro Yamada wrote:
> This driver currently emits a STOP if the next message is not
> I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
> ioctl, where read/write transactions are combined without STOP
> between.
>=20
> Issue STOP only when the message is the last one _or_ flagged with
> I2C_M_STOP.
>=20
> Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-current, thanks!


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKi3AACgkQFA3kzBSg
KbYkwg//cixDikZbhlbmEg9se5SihXJiO3HwHbaE8rSoV3MyJoJLctJa9MpEMf1x
R+Dnn+td9aGhP9NTidHBZydrZBKqmqFnCHTsom9i9uYzWYI/Lf0Xk8B1SqpA+huI
wp4OP8OPIZS3b3fBmsR/u0IkRbNmzBQTwOhZ+sqE028O0zH2RkcJeAzQ/qZuQ6Ix
MdSBLe8jkTTIEBeBL7YQ3Ogz6nEE47lANwNQGow1zvPjl2lqYTbe0tEoY31IAO8I
JtrcsVixNSg7Nv6TvJKjfTNsrIzvhFPGSuW4NWPCi9lgOrrS5TJSGVhznEsXBHIO
TSJKlvDAnC6sjMMkqodUiRgStNcWiLrguJsejWx4YMQViqPMIQfcGWV/1aCp032D
Zzsh3K/ogWJIxwZzYXh0TtfSfCaL2SnhaVhkYklPa19yVmZIULI1PCFB73+oN/fF
y5gMgKTwomVTw9GwmLncNv/9mpg5M0DSse+cRMUwZQSngqkP/0eELE1DwxSi2diJ
GJeeEJ243eKnMhhM3oKlMdKWGzNHvFc1DW365y/ZVUidbQlMQ++Tj3TN9tDMy+ME
NQCkejoVz+T7jy/wPTt22wvgggcxNBJLyQecMi0sa4cHF0fziIIrqi2ImYXaTxb0
igjBBpjvxiRSibCugXFqhdfHb00oChDJWHTCL38Nvr9hZTyIewM=
=UZOe
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
