Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B0520867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NuF3r6UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B0520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeICSBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:01:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VcmsvjUX6RjZwhdHhZjAyukXGN7pccDVuPVR16yNWM4=; b=NuF3r6UL74fKz/VrN7wwV5no6
        k6x09KwJBggdw9yiv3XzY2WafQnAOkmYzkV52OGtrTXWxN+P27XssoG0yQ4oTKXmDGea76C5fZRON
        k2WJUVect2Zs4fLdsBn5kAkPOhxFEB9lX9c0X/wdVU0RCWUV7kblEOo5hjGytRPGZK6o8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwp6D-0000G6-OS; Mon, 03 Sep 2018 13:41:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 787FC11227AE; Mon,  3 Sep 2018 14:41:01 +0100 (BST)
Date:   Mon, 3 Sep 2018 14:41:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v4 2/5] regulator: rk808: add RK809 and RK817 support.
Message-ID: <20180903134101.GK10302@sirena.org.uk>
References: <1535968829-19418-1-git-send-email-tony.xie@rock-chips.com>
 <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
In-Reply-To: <1535968829-19418-3-git-send-email-tony.xie@rock-chips.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 06:00:26PM +0800, Tony Xie wrote:

>     Add support for the rk809 and rk817 regulator driver.
>     Their specifications are as follows=EF=BC=9A
>     1. The RK809 and RK809 consist of 5 DCDCs, 9 LDOs
>        and have the same registers for these components except dcdc5.
>     2. The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>     3. The RK817 has one switch but The Rk809 has two.
>=20
>     The output voltages are configurable and are meant to supply power
>     to the main processor and other components.

Acked-by: Mark Brown <broonie@kernel.org>

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNOewACgkQJNaLcl1U
h9ADqAf/ZUW93wVRWWiEtL3ZAFgbG3LHT8YSwyDBGPd7zduqbrKn2VqLjdPMXVy/
aYXWD9347vawBVYwgds0Gu9/tHUNjZSfcyGDc0PVffN8Qy2iXFJmw8jK7skkchwx
KbgUcTUz0fD1489R6VPhsUvFxLIdayLi+Qcvy8w0Tthf+8BGoM90QRirGGoLq9Tv
z23z31c4TtsIrn9dMKRi8boRrTYRR+XXJqY+nNxg/Ft/Jr6aUUrjDKb8zT6G/wt5
gzoCGbQHitXeTLubD9X+9FSFG+6/i2skIt6Wlo6TS7KDRGhwU4woQYjsmEJVtCtV
R9ioVbUHtpfsp0dAS97EDfhC1uttig==
=xh3s
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
