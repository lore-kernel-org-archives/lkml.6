Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425B2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BpCTUkU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425B2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeK2XBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:01:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59266 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeK2XBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xT3ZaQb9HyLOUo86y3XpFDE7WiNkgBuo4XQyvK1NmiM=; b=BpCTUkU6LIftoPIPfagLaYaB1
        qOigeWrggZC4crCKren8kvD7qBuIB4pITA2tN9pSF4UGtRpg20GT2yck1kL53T1H7CwYngj+W+MEh
        OBWE1wDrAW5ywOQoDuIZS4EFu9WVQWICQzKUDLZePcD7omvP9I79PvXYK6BUkWSGcTwuQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gSKv4-0001uJ-6S; Thu, 29 Nov 2018 11:55:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CCCE111251C0; Thu, 29 Nov 2018 11:55:45 +0000 (GMT)
Date:   Thu, 29 Nov 2018 11:55:45 +0000
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
Subject: Re: [PATCH] ASoC: stm32: sai: Fix unsigned comparison with less than
 zero
Message-ID: <20181129115545.GD10570@sirena.org.uk>
References: <20181129020611.8436-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20181129020611.8436-1-wen.yang99@zte.com.cn>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 29, 2018 at 10:06:11AM +0800, Wen Yang wrote:
> The return from the call to stm32_sai_get_clk_div can be a negative error
> code however this is being assigned to an unsigned variable 'div'
> hence the check is always false. Fix this by making 'div' an
> int.

This doesn't apply against current code, please check and resend.

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv/08EACgkQJNaLcl1U
h9D6owf/ZAGPOaZbgJ954R5eM3mAg1pvrpz3Gkl62gS5IX8pd7MpbmwEcYOu5cTE
4DSr0HfhkgIHrugf0WRjd/PhGrAWQhFPzNvKmGiTZLY/wCU8abKnLm/JCgIzuzPa
qOF782HXChtzSVrlcfrAzw+hjGEu0XsoAmsjYZhOjN+sLx7Rv7cdZfQR3077GW3v
Abg8h4vPxvK6Ez7EhPWMejltTJzjiNsZPcKHWsPsA1M9mBuws+HSm2e+JnYsojiB
NOEdBocvprpYpHCaHjsRjtRmjRdg8X8z3KSRH46X9hFLal3xMCGFdPGMwyzQTUMK
ds+YA6ysjXLYIGIMDYSSr7/kSrbhaA==
=Soai
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
