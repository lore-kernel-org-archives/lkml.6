Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3787AC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834524;
	bh=irYJR1SjX9jaZdaI5onewmn+ZOm/jOlHqR6eK7d235s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g27DG3bdDLhu99cgah7N+iEBcq3TYuv7g8qyeAv9kM9F5oDcBXipnGRg3Nbx2Ag8x
	 /NZYXbsy6K+tSKK8Y1h0KQ+7uTefyF9jiZN85RclsKuZ/Xa3T9ZL9du1RK8HlZ2AoO
	 uh5SgVOOQBCrEmTLLTE4VtL3DMZjhxI9tD/qQ058=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfARSCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:02:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfARSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cCPxtpPH/GNx+3hiECt6H8tSf8ODyN7ZvSBEXXuV5q4=; b=f5XIqw8D9eKwZjy2dItVoNSu6
        ENuPQWyyodC3KLIXNPfzc168s+7eXv7ytSkRiG/LCdTFC0qJGsG8pAOnkomosQCrG/uPW4GgH5miA
        uu71KbgaaVuiFO/3Ciwc/aVT1nitshVCpu63986vsLmbE/X8LvfvW/6r5YRoFUvAamMiQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkYSj-0005Ik-4W; Fri, 18 Jan 2019 18:01:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 36D1B11276E7; Fri, 18 Jan 2019 18:01:48 +0000 (GMT)
Date:   Fri, 18 Jan 2019 18:01:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
Message-ID: <20190118180148.GD6260@sirena.org.uk>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20190118134244.22253-9-brgl@bgdev.pl>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 02:42:39PM +0100, Bartosz Golaszewski wrote:

> Add regulator support for max77650. We support all four variants of this
> PMIC including non-linear voltage table for max77651 SBB1 rail.

Looks good, the ramping stuff might be a candidate for core (TBH I was
sure we'd got that implemented already but we don't seem to) but that
can be done later and the more complex one with non-linear steps does
feel like it might have to stay in the driver anyway.

A couple of small nits:

> +++ b/drivers/regulator/max77650-regulator.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Please make the entire header C++ style so it looks more intentional.

> +		for_each_child_of_node(dev->of_node, child) {
> +			if (!of_node_name_eq(child, rdesc->desc.name))
> +				continue;
> +
> +			init_data = of_get_regulator_init_data(dev, child,
> +							       &rdesc->desc);
> +			if (!init_data)
> +				return -ENOMEM;
> +
> +			config.of_node = child;
> +			config.init_data = init_data;
> +		}

You don't need to do this, the core will do it for you (it will actually
still do it even with the above, it'll only fall back to using
config->init_data if it's own lookup fails).

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCFIsACgkQJNaLcl1U
h9DaJQf9Ee2yWoCC92HHYenJAWkagKDlUOWo5MUoKpYE2BrcBcgKQAw3XMUz45Y9
eb1/I4MoT9vqo5JKBSHlTUKCH+HE4gTo433lFQW2y46e8qf6I6vt1abn/pScmrlI
7IudxGE9c4BJsIbAfvLI9rtLvfdOSxBUdjYMs3hMDnn0U4Oh4qc4q0lHkiYR/wSU
Mp+PnFpDxVAMzWNnao55zS1vkkELoMy++tO50+aGuFxLRIXHvCBf8LZ5LkAOZo9Q
gm3SDThdid8VaNnA/YlHiFRCdLsNrWDH9qfYoyVZ2XCNUW3cnXFmH8shroh0fBYy
nuJZQHDLj3lAl8LsLmRwwzG2KdQlFw==
=f48Z
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
