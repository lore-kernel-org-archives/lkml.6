Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FDFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81142087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548937708;
	bh=1CzuTC+oxsxNowDmUlRiw6hLbwbK1k4xbfELaN4CbpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sDoPHIyu9JszQrn0w7RsV7nP1wHysxNyw/odU3hsV05e6X4QYvVuyabLh3OGbXrqa
	 Wv4uMAwsOj4tJWTLC9Ch6464XrrqJKe3NakpQGspkJvtHNbpDrAeJpIT3cKFfD7R1w
	 X6fnKibAKiVyzXc9mASTwQlB1JUUJ1zRblP0CZwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfAaM21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:28:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/I+BhyTuLJ6Ct4b2oN8wz1tfAGeA/5AsCtCpQIKpT4=; b=v3jgnF6AN0o7SoxGYAnyCqpfc
        XNi59PsEMN1e14pZZxkY3OqLXMIg5X/7qs/P9DptYVCQ5qJ9eF8BHh+9bN82iglBwzaH8oNc/VbvV
        WfOAoSeZ9W0aS+y99Z1pIXnDgt+5nPuWty2uIzKiCVQtumm1YXd2I2X/St2VCrEaAJWpQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpBS2-0004pG-ER; Thu, 31 Jan 2019 12:28:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AD996440082; Thu, 31 Jan 2019 12:28:13 +0000 (GMT)
Date:   Thu, 31 Jan 2019 12:28:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Message-ID: <20190131122813.GB20797@sirena.org.uk>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws>
 <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2019 at 09:15:01AM +0100, Bartosz Golaszewski wrote:

> I'm not sure what the policy is on merging MFD drivers, but I'm seeing
> that Mark Brown has already picked up the regulator part into his tree
> (including the binding document). I think you can just pick up the
> input patches and it will simply not show up in Kconfig until the core
> mfd module is upstream.

> @Mark: could you please confirm it?

Right, as it's a new MFD the Kconfig will stop it causing build breakage
until the MFD is merged.  I'm doing it partly just to cut down on the
amount of mail from resends while the rest of the series gets reviewed.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxS6dwACgkQJNaLcl1U
h9BBNAf/Yq7Uoem9cGciS63O6v97feMamBfser9PLXATQwLIfr7vuvbz8Ig1I/jt
1UQPV4xcX4J6Oj13T5hUuc6BgQ7eGEwwHE4fDLbSs5Ze2Hj1Brd9sM7ER/Ro3L3m
Xuz7lFta+tF8gWGtdX8bKyJEcIfWOtawyLhIsCZ7qSWE44x5yUmUmV9kxSpXyAnI
IfDJnfSW1E3XHt5WjfpIcDIxvup1fPxIstkHts7+OdsQcIcSUmrnFIvuzmbq94/z
zvyu2vj0Qm0DkkGQDYfVMdINpac608CdtXlAUQ1F4+ImRgSDNn32QZ9Jde+1190c
3HjaOajFH7egd9TFMTJxLaHaiEHaeA==
=y+sH
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
