Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A57C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87B52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702047;
	bh=Xb1XfEkkahnXpUJiEaxbMf3PIn8a0JyY+t3yBmfKwZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=imKV2ZSztBaQ0BCtp62h+yfC3sIHCcZYgdq7Iw50SsR8uLnE+qCY9lNQ2YNOGGHVW
	 mIYFDf9u5cjskycLYFGW7v3DaAMEztnR2+O5HiWMfAmkNoKGehbBgokpJw9NjiFhh+
	 kqdkyhadker99ZJH7/EGpMiblDGB7C1Tc1BaSrng=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87B52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeLMLyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:54:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeLMLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OmHTCqfoyO9+watM0IFjxiGdHi/Bg5TdaP0AHUfJAFA=; b=wnlOm/lGhouxwLcAu7EnNVOKe
        aOZwsZuiMEvKoCzzfgZU2BsePFiyIrXqzsq4LjysDhSWM4ZIuXMnOPrmfGTWzWyoTlr2bEKMXNEym
        qhor9xA/qZbDPeBylD965G6QPMTJByxwjPU0mm3wh73BITiPH5Y7POsUgZAKUP599r8S0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPYo-0000vZ-7r; Thu, 13 Dec 2018 11:53:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CD13711254D1; Thu, 13 Dec 2018 11:53:45 +0000 (GMT)
Date:   Thu, 13 Dec 2018 11:53:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Sunny Luo <sunny.luo@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Message-ID: <20181213115345.GC10669@sirena.org.uk>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 10:04:56AM +0100, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:

> > =20
> >  	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
> > =20
> > +	meson_spicc_oen_enable(spicc);
> > +

> Any specific reason for doing this in prepare_message() ? It looks like
> something that could/should be done during the probe ?

If it's for power management then there should be a matching disable in
unprepare_message() (or this should just be in the runtime PM code,
though it's possible there's stuff that's only needed while actually
doing transfers in which case this could make sense).

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSSEkACgkQJNaLcl1U
h9CHGwf8CNMeR7WV+TrBE53uFRRrhrKajnV4JWbLuA67Kua7X2ESoTqkgJ8tc9T/
8RQ7EfxtVkGspy1ZkjpiGBrWgY0YGk6/R+N/OkMmuCDJmk5cQNdZtRy5WGIEm1ZI
I751ssIVt3EZCSE/GcpV4bJ8O7x2fGTWRbnjczwnypYeWwBqfnCxta5+N2DS7T8V
jis/mZjM8VmLv+qtryIqyfrRGlDaXB47AgQeXBCZcQh68/ab8QoUIdh4Dn/Zecl1
OBpuTheeAmfkjbLiHQNFi/XWclWK7RGACX/Xlmr+9BVmcl6CAFekXKImBoNMj8jv
kTkvW7/4I1wvzOJIkaRS0DGZFqF7Yg==
=Aegn
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
