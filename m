Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF3214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CI9Wbqr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF3214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJJRj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:39:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dxqELyW1VANa0moVVDTXQO/UpTTSKNyBzNR+lczCN4I=; b=CI9Wbqr2W04rOhvXYcUyouVmb
        YYwvBhakKKBJ4mDuEsYCqyC+zUcqWJofy3kI8l9rmLjYA+W8S47wjeVMVn08DuiN5JAVOWSmE05aM
        RLIwR5oBhaBbbSlFdreT+Vk5WsQfu8iD9/EX4w8m80B4ir5ev0zPeFGZOBctp6TKm/akg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gABZR-0007cY-HU; Wed, 10 Oct 2018 10:18:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 456081122394; Wed, 10 Oct 2018 11:18:25 +0100 (BST)
Date:   Wed, 10 Oct 2018 11:18:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Message-ID: <20181010101825.GA6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
X-Cookie: Phasers locked on target, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:

> The dw spi controller has an auto-deselect of Chip-Select, in case there is
> no data inside the Tx FIFO. While working on platforms with Alpine chips,

Why would we ever want to use this behaviour?  It will be broken for any
non-trivial SPI message such as those made with multiple transfers
anyway.  Why not just unconditionally control it manually?

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu90e4ACgkQJNaLcl1U
h9Bw6gf/QW1tmWlXcmNLTdpo0qIz7z7c3z3/ydzStF3ZHJLeoS6YHY0bu8R5MtlQ
FkYVdvvF7/Zfqlr8tkOHFjnBh+fiT2+6EKvDu8zyPMZJNxDWBkllWxkdVhHUc75u
4/l5n9vgzCiedfz1SXfqDmBeBoKZBLl+vmu1w2a3InRcLhKqsDGsnENKdrfGEttO
0Vc946hptVhHjOKQ3I/XBotjOhqogZ4cr8QwOwLEJK7iBcQq6qhq2zP4EaBf0irD
aTew8Rff3BJJjASRVpP9EUULMUuhlt93Zea9cFfp8ildUt2sYXVaupf5HTpv+azb
BNuY0SoMbROx7VARMhHTEfgL1qmK4w==
=VGYE
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
