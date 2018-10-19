Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E82ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2052145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="n8N0BH6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2052145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJSTcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:32:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bYycFRvrZvxBQxR30VMW4UwgNSTrypt7K4a4UMUm7gs=; b=n8N0BH6gK36WJehNLv+dVf9Jm
        ueXLVDCoj4KC0wqEdQz7wWMP3j8e7CG8cNHtvnejuXN5jBeXznsN0jKz5mlcIOPbErwxwz6CNzaGD
        BSBiFh43wLxBqzU6Z3xVYUPvVCjF8QDOBVVQVNYpkItKytTvKsQCxv7VLGr/p4iD9TpCI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDSv9-0008PM-A3; Fri, 19 Oct 2018 11:26:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CF27E1122547; Fri, 19 Oct 2018 12:26:22 +0100 (BST)
Date:   Fri, 19 Oct 2018 12:26:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181019112622.GB5895@sirena.org.uk>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 10:50:02AM +0100, Charles Keepax wrote:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

> +++ b/drivers/regulator/lochnagar-regulator.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lochnagar regulator driver

Please don't mix C and C++ comments like this in the same block, just
have it be a C++ block so it looks consistent.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJv14ACgkQJNaLcl1U
h9CEHQf+PHqc2tgv1Kfy2yfK7QJ0WcQGfD+cYkoRa+izvWVAHfElb/sZmJouxUkb
NYZDF51pizrkjR7p+/0Y4HaXJAYwygYO0GGdk6sWUASW10yobyHyCeZsJQWU2eyo
2GHUsm2RB/5dgLV8azPhazUNdI1UNmWYsvMkoh07cj1I/9BQdS/XoYPzx/ePFtf0
IMWE+mhP4nfGAY5GuS8JlGVHLZaMQU6L38J/J4/RgK3+H4+7eB8N4I0EFsGYcSfU
IXxNZsGvmObRQ2bSWs+tJV8IfcufGj+f/kv66ooh5Y1AIVhrksO6kauugASyIs4u
WQ4G2lPTapbOAOAysu0V2JZlQyFQPA==
=devJ
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
