Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36A02087A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0Bo/AeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36A02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeGBXN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:13:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35513 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeGBXNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:13:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id z9-v6so38518pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAO7ttzhlwhyp+bc6fP/UGcYf4a/9KDX1683O5Azc30=;
        b=n0Bo/AeF5seWfhAS7Aro4/Msml73iBkWJQnVnzTzV20PBmpT1miwdYG/uCqqsITi5b
         BzQqti4HgBbXu8kcKyHZf/MDPECn+V3dVwlQ0YtlbzDNJdIe6TWqp8qjLQEm5ICr9ghk
         NwycrRyFYeMUDpXCe25zYMEm+U5SWtVoFOblfN4aRGBx4TGPGBRGoFMuOd8UjJ1Zp5cV
         +arYjgcObdA6u8H/yCbovXLHO9eVxd5aCroks5jKu5oE9cTzTJTeb6d/U0AdErWEKBeB
         zjFhxxPv+S6Ibd35aTviu1rDRQetq+l53C3Ujw5Gc9g5zIOjfuM1E2m75UiUFQkcUz8U
         5/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAO7ttzhlwhyp+bc6fP/UGcYf4a/9KDX1683O5Azc30=;
        b=bcJHRcyuuCTvJavagewoZX8GkHb7uYKtxWX5SX/BB4awDehVX3k/4NmOPEwPD4JNr8
         G9WIG4auz9Y7XXOxMGMa4Mwvaktik6dgaJsEcNZxxV9dN3TH2ypxuugt4HP8L8tnocfx
         +XKffygV/LEK4rKpKV4qmykrK9cusZFtLy4jCtltfny5sbdTLrsf/d3a5jzOLePAAUnU
         Dt/JiB3sLJp2MD0fSWnEve4lk4nYWGzLqd1BGOefVBLGdyFDG6F65W1uEwvVkiaj9kGv
         ROjFf7G4NHtvBuEsMNuExjuHRFTsAfMLDjxqi/BOVZ4BG9pHWRtVclauIMN+rhnrUP0g
         ckqQ==
X-Gm-Message-State: APt69E08DiDaDJSv54Wj2HGF6IekjZ+RXAhH4ADoeDBxIjQBNaXeIHWW
        Mvj6v/Y4yR4RF/E43zwniUc+8w==
X-Google-Smtp-Source: AAOMgpdJ41MFEdeehS57zU55o9NOrkKn92eaVSdSzOCH98bkmTTxprZ9RXOOVnUcA4aGELIA09N5xw==
X-Received: by 2002:a62:3687:: with SMTP id d129-v6mr27148623pfa.137.1530573202098;
        Mon, 02 Jul 2018 16:13:22 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:0:1000:1501:e4e8:e3c6:19f1:ae51])
        by smtp.gmail.com with ESMTPSA id c128-v6sm346184pfb.18.2018.07.02.16.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 16:13:21 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:13:18 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers
 to drivers/platform
Message-ID: <20180702231318.GB86110@decatoncale.mtv.corp.google.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Mon, Jul 02, 2018 at 12:21:58PM +0200, Enric Balletbo i Serra wrote:
> Hi,
>=20
> The cros-ec transport drivers are placed in two subsystems, in MFD and
> in platform/chrome. As far as I know there is no reason for this, so,
> move the I2C and the SPI cros-ec transport driver from the MFD subsystem
> to the platform/chrome. The series also removes the MFD_ prefix for the
> Kconfig symbols, modifies the defconfigs that used these symbols and
> fixes the KEYBOARD_CROS_EC Kconfig help.
>=20

Thanks for putting this together.

I can create an IB with this for the others to pull. What do you all think?

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAls6sY4ACgkQHwn1ewov
5lhKfw/+NbPs75nFdsTi5TrAwbTlCSmm2IIvVCOTmde47Qo3vxt4ZFn+DmK745Ok
IxzVgFy8k6X8vaHQ69likV0Twk25z9ncZIAEKLQQLjP20Wr9qGOec+r+DsXwQXeO
gE1NI3AzC3HxmjZN0wqaSJrId8+QU+zh78H6uyo8OXl4/OWniZZVVdNnKaosA7iM
W/yEGZP6N5KFwkjl9OKXwE19e9YAUk2KB6WoVgMpAjyWoPrsI1yTyFcAgD6ciUPJ
+XUeNTYrX9kHhqeb2uSXfyJAg7uoApqwqtDp8FcG2fy/eux4Ig6vV73/pCsEU+ps
iE7LlhfEX59a0k6hMbE/Rlul8Qwo10DUQ0GS1Cr1umRqYfFtYYIhKaLorYxBr7Or
Ob5kUDS1kg20JhwVanszE0QI1iD4mNPZasjDNDVHMbiCbvVvaZo7WZ+6mV5CfCzL
0qCqZN4+shfvy//xNYbi6l4BTRpILwou4vMMB9eToVrzT4VODa0wK28X0FaY32vU
UHFGtSPadkj/QmwZUoog+Fm1voLd9EZMLmECpjvZ3vBnqG81LU1begMEEe9t0yJD
6uC7osHWgjtg98caXqvBjoA27KGFwJCcWQBqoI6e0/sDICDK5fgkxsHNlX/02ntx
WEqZCNuEToe5EYYSGUZauCYmcW8vMVnD0EV7NwtYf2SOCm17BOU=
=Bei6
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
