Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EBECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5402086E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JESULyJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5402086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:21:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeGMNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EtbJ7wwwNXd18Z2WLGbB9RsHhJS/4QO61nAfiiK331c=; b=JESULyJzNXMyq342xek/7Rku+
        eZVSrRJO1lV0G3xuJHTRkE+0ZeMuxf0VKCdIVfm1ukRJnTtM/CoNw2bB+4z8qZ9XqDvm8HYJjZqwG
        YzP33mRT/FwUSBUOhqosFFIF2k7+Q/D2Wq1YGF3JaZ5MMjpDMQEKDX0xV+omg39KKBUTQ=;
Received: from 94.197.120.189.threembb.co.uk ([94.197.120.189] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdxn2-0005R5-PF; Fri, 13 Jul 2018 13:07:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 489F0440078; Fri, 13 Jul 2018 14:07:15 +0100 (BST)
Date:   Fri, 13 Jul 2018 14:07:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, m.purski@samsung.com, p.paillet@st.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] regulator: core: fix _regulator_do_disable return value
Message-ID: <20180713130715.GC16228@sirena.org.uk>
References: <20180713125624.13783-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20180713125624.13783-1-m.felsch@pengutronix.de>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 02:56:24PM +0200, Marco Felsch wrote:

> Currently _regulator_do_disable returns 0 if either the ena_pin nor the
> ops.disbale() isn't present. This assumes that the call was successful
> but it wasn't because disbaling isn't supported at all.

> The last case of the if-chain should return -EINVAL, because disabling
> isn't supported by the driver as it is done already by
> _regulator_do_enable.

This is fine - consumers shouldn't expect that a disable will cause
anything to actually get powered off, constraints or other consumers
might mean that the disable doesn't actually happen.  It's just the same
as a consumer with an always on flag.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltIpAIACgkQJNaLcl1U
h9B9mQf/ax9GM8TSDGqtJxZefWQsqlxrr+W7rvgFTQZGIl7VXnsUAsodkUTGU58F
A2h920f73/Wuqz6j3aZgTna2XU/8gHF2CVsMlwp7t21TrEwdlvYFAsJ6stO//SgC
EvGJauF/8YemoWMDG/4IB/DWZgTiGsgjPOsda+jExjKOkDxiEgBWHIscWA7cvqyx
RtpcNlIV39S1eV9584OFV97D61XqSRayBcoPpUvfQAzBUM5VmqAq81ckNbIFIr8A
LbarhKL6+xonXHK6WZI2QyVNg0LfpaJLBeOosQwJp5mZKfQrRrk+DbWkdzqs4xps
glBNqM2BPIiSnSlTE1Z8oCsj1m144Q==
=QqU9
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
