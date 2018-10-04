Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D23C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1252420645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FfzQM3Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1252420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:12:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=igoCYCRQTg0FafoeboqLmgsaNIPF0NwtxFPgJJqm6lw=; b=FfzQM3YlryuAhvYeop12Pz7sY
        WKAY0bCkuHOh8GEtCDUCHHD6v7MyGboRnkcAvh2Vh6OICKYlHNa39DsoOfwn0Z0xJUygEyGbeB9Ek
        rdK+pZxEEnhtaKhHznFHe49L9rOdQhJgr48UJ0EYGASv7Xmd7dko31+bS/qFOi4EP4bQY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g80jt-0008Gx-E2; Thu, 04 Oct 2018 10:20:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E675D1122286; Thu,  4 Oct 2018 11:20:12 +0100 (BST)
Date:   Thu, 4 Oct 2018 11:20:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
Message-ID: <20181004102012.GB6412@sirena.org.uk>
References: <20181001204346.4655-1-linus.walleij@linaro.org>
 <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com>
 <20181003121002.GA7132@sirena.org.uk>
 <c2ace38e09344d325271498fe8133c888470b5f6.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <c2ace38e09344d325271498fe8133c888470b5f6.camel@nxp.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 06:08:09PM +0000, Leonard Crestez wrote:
> On Wed, 2018-10-03 at 13:10 +0100, Mark Brown wrote:

> > No, that's definitely not desired.  We don't want to change the state of
> > the regulator at all if we can avoid it unless the user explicitly asked
> > for it.

> That also makes sense, for a top level perspective. But
> reg_fixed_voltage_probe contains the following snippet:

...

> In theory it might be possible to request the GPIO while asking to keep
> the value from the bootloader? Maybe I'm confused but I don't see an
> easy way to do this through the GPIO api; functions for requesting in
> output mode all seem to also ask for the initial value.

There isn't one.  You're not supposed to read back an output GPIO at all
unfortunately, it makes this sort of handover stuff a problem.

> GPIOD_ASIS looks close but it doesn't even adjust the direction.

That's new - it's probably closest to what we want but we need to be
able to read back the state as well and will want to make it output if
it isn't already.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu16VwACgkQJNaLcl1U
h9AXtgf8CLj4MoHaShDENVRVrMhiytEHU9qh+BpvA7Na96mpdqGkNwtCWlSKwLpm
nqf51ObRrpGYJco0RafiocXvtwS3aVHoXPOf3S/3aRRegxWh6ileRp7vqTifFrcc
214fwVuok5HEgz3RGduj3hsG2WrhmxELYNufn5FOQNfxWRZf0ElLkq/rPwhmpXGP
yaUl72jQV+K17vzOBuLXm+jT+wmQA/H0XUT31gEtfSRhBskaJLn73TPBxusMXNup
QBJo/REEzovmUiE43nVPXvo9GOtPCpM+cpH6P90d8hD4+lKr+iEsu5EF97v0Di7X
q9eOWS+t5novPSdqVN6Y87iItHFIcQ==
=F6cU
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
