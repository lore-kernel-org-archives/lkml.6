Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD99120875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD99120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeGWKrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:47:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbeGWKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:47:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1fhXQu-0003hw-15; Mon, 23 Jul 2018 11:47:12 +0200
Received: from [IPv6:2001:470:7eea:1122:6c91:b8f:4e84:18d1] (unknown [IPv6:2001:470:7eea:1122:6c91:b8f:4e84:18d1])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EB0CC342816;
        Mon, 23 Jul 2018 08:14:52 +0000 (UTC)
Subject: Re: [PATCH] can: peak_usb: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180628174142.GA17081@embeddedor.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
 g2ejS9SYusxFnJozyQ==
Message-ID: <f6f0bf83-84b1-0cf0-3c78-828b56694b92@pengutronix.de>
Date:   Mon, 23 Jul 2018 10:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628174142.GA17081@embeddedor.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0
Content-Type: multipart/mixed; boundary="xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <f6f0bf83-84b1-0cf0-3c78-828b56694b92@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: mark expected switch fall-throughs
References: <20180628174142.GA17081@embeddedor.com>
In-Reply-To: <20180628174142.GA17081@embeddedor.com>

--xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 06/28/2018 07:41 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

applied to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G--

--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVjnoACgkQk9IU1zQo
ZfGelAf5AfQeNzehZW/bovXlJpiWRLU8epG4YOmZG+2xHcsMtidTq7jpJQNhfp3M
qYJ/7alelstX5GAWT6RYlONZo8IqJ4ps3efKvKidd+D8fQfTAjVDeC7jkRzqt9na
9+FUF9BSwI7Z0G8bdAcErsre2CJFR5DDABEbrqe3Sn1APeKnDm4S5soMR1EHw3TG
Z4Cb/N4Lo5nApLTmOcDFSWCAGxHvD8DiPF4QPSsG5MHcjcs8Mv9rfmsxSPqYIlaO
xtB+iUpqqfuySeBXFusLFDBki+6K+RHqK3bo3Kp+eb3ZAG6xuep2I0PLbN3I5aXo
8gThfUTp11Te4xKxc7PFh2O3qu+xgQ==
=R8kB
-----END PGP SIGNATURE-----

--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0--
