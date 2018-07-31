Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF442C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8101820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8101820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeGaWr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:47:27 -0400
Received: from sauhun.de ([88.99.104.3]:57206 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeGaWr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:47:27 -0400
Received: from localhost (p54B3343C.dip0.t-ipconnect.de [84.179.52.60])
        by pokefinder.org (Postfix) with ESMTPSA id 925E264012A;
        Tue, 31 Jul 2018 23:05:14 +0200 (CEST)
Date:   Tue, 31 Jul 2018 23:05:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     George Cherian <george.cherian@cavium.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        jglauber@cavium.com
Subject: Re: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
Message-ID: <20180731210513.izqbzpvvqq5lq4uh@ninjato>
References: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nt3kfhluwrtxt5wh"
Content-Disposition: inline
In-Reply-To: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nt3kfhluwrtxt5wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
>  	if (priv->len_recv) {
>  		/* read length byte */
>  		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
> +		len--;

I don't know the HW and assume the above line is correct because of
merging two interrupts into one. However, the line looks a bit stray,
and I wonder if we shouldn't add a comment somewhere explaining the
situation similar to the second paragraph of the commit message?


--nt3kfhluwrtxt5wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltgzwUACgkQFA3kzBSg
Kbbmig/+JiAwv3RFIsTmwQQXLznqylgQBPxO6YN4ojCac7DTAhvObGUAMRNeD1AV
3WGPZn54UFkbgiBWFcLqzea6HZEQJXcYLjbk1OrKmi1A6MQXgVEKcGos0HZRco6p
B9HEb1+APeBN/VMCDFDerup5agLOmwg+5h2qGxjL6sWy0N9jBOIrhvdA+c5ML9rp
9DVVehQ19l5r9Ui8p4fQww2A6F49VdGf+5oyaJLWTNcvhzc/bnt0Utk/7kD2VR1Q
S1NlFXzG7WE2yTNYiUjDkt8d/V4x9oMfmheD7UaLZeJCp0Z9vWSpG/opuX5e1PPK
P4wnu/EEy/Ioc3u07tWh8+QT8xmmkJaM4T8ot6MazADPr5J+XhRC0yKWjyiMrvoC
CeV1gqSJbRcidhD5ix4KCtBs+7QWABNQ9F6SAAQzCbd6YVHmfHfKajRTSh7nkgfI
cIUoOc1RtOSA+r1SXpOtbWW1/1LKb8ao2wUG77TviuqunkBd0n86SqOUdRoGq6vi
RmXjgv0S2OwZU4R4T+gfBBjzkJWqaPZJq8XxyLpkN7FRGHRa0he7lnSeid/r3JRO
T+Ychssq/c2/G2ztZRz31ymPw+W7Mclqy2s65t+1wsekthe07t4P8+ftPiqV79xD
lYA3SKqlWIe/V/Zcvoh0rGRAdOEUJCzJHSX8HGYS2Sfz9G1WbZY=
=79Yu
-----END PGP SIGNATURE-----

--nt3kfhluwrtxt5wh--
