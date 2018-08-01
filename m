Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD0520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="v4oXWOPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeHALKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:10:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbeHALKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tuvA9/tIcmjF4vEv/ty5hOsRxvI+zAjncrMUP3/c/oM=; b=v4oXWOPH7sxXEjSb50U1SqRVq
        fwmmHkDqw6CIiegvc/iP83WBz8oUsW910FvK2Zmg3dYD8JZ//BIOlemxUbTFUVHR9q+LOFZ09iY8A
        Us7nFXfRxjtFUUxwVnsXCPpiF3BOMzLAvmRoFpF9LEtT+KIvbJlpLWTLeuMV0ITOOVALQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fknNY-0000hb-Kj; Wed, 01 Aug 2018 09:25:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2523F1124216; Wed,  1 Aug 2018 10:25:12 +0100 (BST)
Date:   Wed, 1 Aug 2018 10:25:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 2/5] regulator: rk808: add RK809 and RK817 support.
Message-ID: <20180801092512.GA5509@sirena.org.uk>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1533023850-29004-3-git-send-email-tony.xie@rock-chips.com>
X-Cookie: You are as I am with You.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:57:27PM +0800, Tony Xie wrote:

> +	default:
> +		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
> +			rdev->desc->name, ramp_delay);
> +	}

This looks mostly good but I notice that most of the prints in the
driver are pr_ rather than dev_ ones - using dev_ is better as it allows
people to see which device was affected.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthfHcACgkQJNaLcl1U
h9C8Igf/dgHh7kVnRuWvWyT7b/+8mMS+HNtVuTBMtiUf5textB9vCDqH+oOZoZE/
2PEPQccsJdhF2tkxfuArUQtY8lxO7BQFu3HFxD70ROweX9CfuvfnJBVDAw094Wx6
Z4G8HLLp0WqLiqSdGvASehN8jspMmWRkV4ucf6ED/yUjGKZMUf3ow7cwgfg2e6S/
It4Yp/5Z4QrXpQchKhRWYvJZ6xAbtGevKaEvjBWegj7L9vFJTZn1uSJJeDrrnste
b0I0q4MUN6cfgQwYFK8JeBLvJWkmAC4bBQYv0ulDzboDtRB5VcP6WnjnDiWHBCnj
G39mcKBy/R9YlALxB1kxGxp2Aj3Y9g==
=3sW2
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
