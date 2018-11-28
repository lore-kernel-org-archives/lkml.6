Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FA32081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WZMCDSO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FA32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeK1Xku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:40:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeK1Xku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UrIxGUJQB6g6Rb5Lz4OeRCrjfxTsI/LtRbM1jsTcZ1I=; b=WZMCDSO2oHGB7XovduuYqy0xN
        n29MyiR9H+rTSj/T4vvGPiaGRw6pgmLbqes284o5cB1g4xFW7Dnp2BroMgxO248PAecukZ3/AV6u1
        I3V6X/FzjiZrVbjiu4J/sKMRFAxR97VOnZBeBUHJuUW/iDtXYL5+6XFdqQdQILgw7V9bk=;
Received: from 92.40.248.202.threembb.co.uk ([92.40.248.202] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRz6u-0005CR-8L; Wed, 28 Nov 2018 12:38:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 48898440078; Wed, 28 Nov 2018 12:38:28 +0000 (GMT)
Date:   Wed, 28 Nov 2018 12:38:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     olivier.moysan@st.com, arnaud.pouliquen@st.com, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] Fix invalid use of sizeof in
 stm32_sai_add_mclk_provider()
Message-ID: <20181128123828.GJ2089@sirena.org.uk>
References: <20181127123520.44940-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndbNBr9ZfQRJt18g"
Content-Disposition: inline
In-Reply-To: <20181127123520.44940-1-wen.yang99@zte.com.cn>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ndbNBr9ZfQRJt18g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2018 at 08:35:20PM +0800, Wen Yang wrote:
> sizeof(mclk) is 4 or 8 as it is the size of a pointer,
> but we want to reserve space for the pointed data.
> This issue was detected by using the Coccinelle software.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--ndbNBr9ZfQRJt18g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+jEMACgkQJNaLcl1U
h9C4CAf+N+daz0ORT0zdZ4t36wXYLbz8q2NQUeQKrw5FHqc9Tx1kqq6Uxz3xt+Jo
r/CiC7sqvhHZJDOkGtd8NhXQe5Ua8fzVUjzHHmC+F0oiI2nGTzUpd3BH2yqsNsBV
g4Eqptjo75kQryzob9e5sNYlSb29ejCTr1V/myuzbzzHS+MzDwB5oysnoZ9XWWYV
JJdjOJPJkPffIFLCx0HnXC2OUdE4chbFf0N95l+4ZaqpAELCIkUDuLn2qhjF15v0
yuoR4NvxkLfGcubeCi0vFCBYF3ysfbgakOpyCUnCRMbqXD/w2Vt2IqabRCEFCjDT
JzETbBwEr8qwiUEIqMV3LbUWrwpUjw==
=WB9+
-----END PGP SIGNATURE-----

--ndbNBr9ZfQRJt18g--
