Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F9420672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544455763;
	bh=nxKVj9Rsps2sEpBzqibFOhdD7q8DnETGeirehKuw6cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KmZtx7OgVSXhQx3eXxFGTYRy3Db8Oxb7yMCWk9lKj8MCk3hRt56fOHsUtevvTQsoJ
	 ZBLJQ907cSYdYeMhNxiLCuXaNmMuCIPhhYlxHKVBK3GLoMqrLEHwDnpvsLBlsASQHz
	 jXsZn7ZR+dyUwb+L+e34eyHsXU/IyLRDqwuDioow=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F9420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeLJP3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:29:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S3P1rzjEHzopKJKawzqo7mNTjG1qvyh+5iyk1P4l6+g=; b=WsGzhX1ECGdcYtJpYPyKheUYT
        JCqs4cHR+OHDHRoIj9r4tVqZixtGNN7NUyULBov8wV8I1ZogVzv5s3Fp4GYOO6FZMM55/hASGgzkG
        ZVpEgxbsqVWgAa70Ueb/CQapDYqg4nV1X7rUMEugJ1PgXwiRcTPv0EwvX2RL5L7RDTqEc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWNUd-0005B6-9u; Mon, 10 Dec 2018 15:29:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C0E1411254C5; Mon, 10 Dec 2018 15:29:10 +0000 (GMT)
Date:   Mon, 10 Dec 2018 15:29:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181210152910.GD6307@sirena.org.uk>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206202956.GG3084@sirena.org.uk>
 <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Cookie: Do not cut switchbacks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 04:13:28AM +0000, Yogesh Narayan Gaur wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Patch has been resend [1], this patch is depends on the series of patch[2] and this series has been applied by Boris already.

> [1] https://patchwork.ozlabs.org/patch/1010253/

This appears to be an MTD patch?  The subject is "mtd: m25p80: add
support of octal mode I/O transfer".  MTD patches normally go via the
MTD tree which is maintained by a group of people including Boris but
not me.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwOhkYACgkQJNaLcl1U
h9DaAggAgMIj2uA8VF9Qi0kkEVSIw7B37/YFo61hD2F7zvfEngJRLcXPAj7gXTTf
j/1X087Iwy6uvnV/XIPsTeweEo5owcyM3Jy8yrxCPu6fAnnTjoxUfj2oO54kCF3x
btBB54tpee+QdVruBpoVU1JmiMKcA6iH74ZwWCk4BQ2KyqNuBStbmWn7pEccma0u
W8QGy1OVb0q+5awlZX7bcbOiGJJr83fehVF9eYluel8DMI1rBbYrBRnaDAZwKSp/
kqSrcAoV51pWSJVViPrTF0LF4gUuqvKu+p6yfj12Aou2+/HwNhiP9N2R7BFUoiB0
0xvXGFSlSL32blPB5L3m51UqYogIBQ==
=/KqO
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
