Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58157208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mi52uYGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58157208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGNXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:05:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbeGNXFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nr9PhOvv0K5O3jEXGOONp3PF/hZffLVzYtKsYJAHVgw=; b=mi52uYGWd4ykdv3IYmfgM9LiP
        H05FNXKHS8UBb/QQiwOl9fWz5o82vFYctc9Z/7cjedrLB5FoK5Yfe+ityfHIbTWU7ohAlJth+/hVT
        LOf3fGG4CQklZKD7Bs3u6V9aXKsouEODG9+fXLRHMjEJIfWjJ4srWDIRe6LoDffKC4NpY=;
Received: from host86-174-189-173.range86-174.btcentralplus.com ([86.174.189.173] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1feTH5-0006hz-LP; Sat, 14 Jul 2018 22:44:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 83DFB440078; Fri, 13 Jul 2018 16:03:14 +0100 (BST)
Date:   Fri, 13 Jul 2018 16:03:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180713150314.GD16228@sirena.org.uk>
References: <20180713125002.24331-1-m.felsch@pengutronix.de>
 <20180713125002.24331-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <20180713125002.24331-2-m.felsch@pengutronix.de>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 02:50:01PM +0200, Marco Felsch wrote:

> +Optional properties:
> +- fsl,pfuze-support-disable: Boolean, if present disable all unused switch
> +  regulators to save power consumption. Attention, till 4.18 these regulators

The property name sounds like it affects all the regulators but really
it's just the sw ones - how about adding -sw at the end?  Bit of a
bikeshed but it does end up in an ABI.

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltIvzEACgkQJNaLcl1U
h9DQzQgAg4+A2buzEZeWVLozK89w3p8isr1qmFeTm9xW9OW/UT+i7waDOYhOaRbo
UKqpmjMfgZOhDcMV3JSxUy3Ji8EbhnqeuBzAXWO8lz221sYGgzgveIatwnM0t5VH
McjsglbkOBr8rxRAc55b64CL4Yj7A/oyxCJmN4fiQPnzTDYUYQpj92dy2l3na08l
XQI8XNbeu/FO9y+Wg5WeHrAHuUuOFtpC4hK89n8AHvI8XFhg8L4MmR2/j4Jm4Nt4
fXNIoy+tjgujza7xhgvfimD/g984Biv20c2tri7YhZBURF/IUXPC+a0sjJFHlwcD
40ISgJQT6r8Y+tprxtd6QsGQe2B1Pw==
=In62
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
