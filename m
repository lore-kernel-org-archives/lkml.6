Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFF420894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ev9QSJAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFF420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeG3RGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:06:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3RGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q7ZOYiuQcI/LUrXaZxxC5+oowpzSk6W5ncn5RlliZjE=; b=Ev9QSJAwgWCEfz7b1vnOdZQe9
        w7QI/n96U1q5ClZ04ukRnhYkWbmvq0MkiRtB4IDgu/B1PSBoyWaVRP8iLtQsKewPEY7pCavX6RH9b
        MmMttiy/wleEwdYayN8xkyN62LpevA6VuR81P1SYMZIRne3mYa2VcZ6bdjQ1jsNzNNypQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkA83-0005Wt-18; Mon, 30 Jul 2018 15:30:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9FC8C1124216; Mon, 30 Jul 2018 16:30:34 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:30:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 10/15] spi: img-spfi: Implement dual and quad mode
Message-ID: <20180730153034.GM5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-11-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-11-afaerber@suse.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:05PM +0200, Andreas F=E4rber wrote:

>  #define SPFI_CONTROL_GET_DMA			BIT(9)
> -#define SPFI_CONTROL_SE			BIT(8)
> +#define SPFI_CONTROL_SE				BIT(8)
> +#define SPFI_CONTROL_TX_RX			BIT(1)

Random reindent of _SE there?

> +			/*
> +			 * Disable SPFI for it not to interfere with
> +			 * pending transactions
> +			 */
> +			spfi_writel(spfi, spfi_readl(spfi, SPFI_CONTROL)
> +			& ~SPFI_CONTROL_SPFI_EN, SPFI_CONTROL);
>  			return 0;

The indentation on the second line of the write is very confusing, it
should be indented relative to the first line.

> +	if (!list_is_last(&xfer->transfer_list, &master->cur_msg->transfers) &&
> +		/*
> +		 * For duplex mode (both the tx and rx buffers are !NULL) the
> +		 * CMD, ADDR, and DUMMY byte parts of the transaction register
> +		 * should always be 0 and therefore the pending transfer
> +		 * technique cannot be used.
> +		 */
> +		(xfer->tx_buf) && (!xfer->rx_buf) &&
> +		(xfer->len <=3D SPFI_DATA_REQUEST_MAX_SIZE) && !is_pending) {
> +		transact =3D (1 & SPFI_TRANSACTION_CMD_MASK) <<

This is again *really* hard to read - having the comment in the middle
of the condidional for the if statement, then indenting the code within
the if statement to the same depth is just super confusing. =20

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfLxkACgkQJNaLcl1U
h9CRZAf+LLcEEOfRSAY1EH5vz7zDOEnw4gK30aibUvhN9OgRdg3m5MfBShffYGNq
M7zScjBY9bHhcsyEYdyU8NCPHYEq/VvmpLf+59mekYYcxZ/LxUs92fKF8XV+yMZ2
b4F0Mczv2DL08wsoeYGoTWioZ+of4nuDgiCm4KAUTHcrZqtUIvj1l5YDDJuyMPQb
kObK5Ek6i+FZRkq+71IT82fHZbHt01BhGca7CfQWIgxuHvbyCudAyYjMMpPLmcxs
JVebbmM9Bas6Eqp3FtVLVu5d3Oy1Ut/sq7OqDgWv0QmLMirZ9e31Wkzcl5cfoUQl
Z65uarkrVQVcxYQt2IHLluaik6StCQ==
=o2Zn
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
