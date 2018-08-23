Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D12150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vIdobQvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D12150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHWNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:50:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHWNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fODfQuiHBLMcztzm+pp1axzpbGBMbaK/f1um0+yom84=; b=vIdobQvPAXdIZXqu36u0tcBbe
        XxA9RLRwVGXS9lnl7cca6XPT8/OUFmHoNZBnAW1V7MGO9fL5qgRmLaMm5gpyJxRE+4BgtxhWZcIj6
        S/FdYvf5WF29+nMfUJsEbY90/YRrOfsBlrXUAZT0hAtBLd204sT5olVMOLNm9UsKifwhg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fsmjx-0007IM-LD; Thu, 23 Aug 2018 10:21:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 527591124604; Thu, 23 Aug 2018 11:21:21 +0100 (BST)
Date:   Thu, 23 Aug 2018 11:21:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Message-ID: <20180823102121.GC5207@sirena.org.uk>
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
X-Cookie: Truth is free, but information costs.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2018 at 08:51:40PM +0300, Kirill Kapranov wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> I have to point at the following threat: a dynamically allocated ID may
> 'squat' a bus ID that intended for a device with statically allocated ID.
> This scenario is possible since module loading order is uncertain.
> This threat seems to be inevitable...

For DT systems the dynamically allocated IDs start at the maximum
positive ID and work down so in practice it is vanishingly unlikely that
there will be a collision as idiomatic static DT IDs would be low
integers.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt+iqAACgkQJNaLcl1U
h9DEYwf+PeNSBmBQJsoTnSeUanFKW3zKsRohegEb3DegJ5Rmq6PL5PLV7V6KhWTU
UGRz17Z0DB70xLyzs4sUPC/6L4xCw4fYMYLBulUIzFWKQlmGFKsGzfx4E8VY7pN5
Izw0MFPUnrKsT84C8m1k3PWaa4qprvBRKnAUKCBQZnzGz80ZLE1T7nsb05szBQKx
NRYobSv124dL9aomXEywmcSWk22T+8eRb6OEPPQ/DxHPZfdxHMkb4ehMhPUFz7wb
K2m9P5zaEKN1cTM8aNWoRSRmh92Y626DH6/WmmwtBfX3ppcDXoPImwnI4qeb12P2
dzP36/20rWtDmkVlLeaBPlZMSr7LcA==
=9h9Y
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
