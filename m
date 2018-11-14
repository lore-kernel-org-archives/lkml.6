Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9946722419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YCC1kISI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9946722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeKOIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:55:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeKOIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F8RtN3HoQPny4cTPFpRqfEsApn+Tsu34i3IPAozZvH0=; b=YCC1kISI5P1tjHa1OhEjv6/JT
        I44S8zJBNMb97WHIFZSkDkUDaj5P7CNkF/A/3CQIcM3KHpXopwo91uJuYnwZIYF/23bja5t/m6upq
        5YcDw63W4xfFvb/qqAJuK+xICjrbnisvq2WdD1dLgpTq5hqdthgv2HCHQxNt/Q6DvJeLE=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gN3YD-0004aF-Bw; Wed, 14 Nov 2018 22:22:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 501D1440078; Wed, 14 Nov 2018 22:22:15 +0000 (GMT)
Date:   Wed, 14 Nov 2018 14:22:15 -0800
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
Subject: Re: [PATCH v6 1/6] regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id,
 _reg_bits)
Message-ID: <20181114222215.GD2089@sirena.org.uk>
References: <1540894081-31270-1-git-send-email-tony.xie@rock-chips.com>
 <1540894081-31270-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zokm/imjT5TjLIDZ"
Content-Disposition: inline
In-Reply-To: <1540894081-31270-2-git-send-email-tony.xie@rock-chips.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zokm/imjT5TjLIDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2018 at 06:07:56PM +0800, Tony Xie wrote:
> if there are lots of irqs for a device and the register addresses for these
> irqs is continuous, we can use this macro to initialize regmap_irq value.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-irq-line

for you to fetch changes up to 43fac3238c1d9363b2a93d8d56c2be0c29c64e6c:

  regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits) (2018-11-14 14:20:45 -0800)

----------------------------------------------------------------
regmap: Add an IRQ_LINE macro to help defining regmap-irq tables

----------------------------------------------------------------
Tony Xie (1):
      regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)

 include/linux/regmap.h | 6 ++++++
 1 file changed, 6 insertions(+)

--zokm/imjT5TjLIDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsoBYACgkQJNaLcl1U
h9AohQf8DKOpuLYQeprG6Yd0xJvtsXz1Ktv2508YsUJgX45xIZTt1Svw88D8+xhB
9t2feqe8HSskGnQ2PU9ecDAGYMcUqzfaAp+3EvVynZme+tENOZRT5oAJpQjOw3mI
6rZadavHxlGyLoVuCXJC3hdpu1dsjoclMWX0aYVLTGun631DCHya8ubJSX7Qu+4Y
5AZNvT4GPCEUaHNmEi6Dr8eZH4oxlIec2NqmV1CsHUTsOf+XCKwpIVlzP7eEKNj0
WPZ4ZYO0TVbqfXgXlV2/hajafjF3q3GabrJwreD8T/+ZbnrwuHGqSsXGblK37IGp
Qm8ZZIpLs4N3BxadCAl/7jMJYHsQMw==
=KajA
-----END PGP SIGNATURE-----

--zokm/imjT5TjLIDZ--
