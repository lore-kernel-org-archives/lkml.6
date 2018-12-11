Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB40C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B36220672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544489495;
	bh=0m1KS5Vc74LuPMPLBCXplzZJKpShr9X6akkQOv6gBOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PFTbObfLbaw9qFYY355SyMyqRR+F0FcRCuSaOJbdJURobsm17iWcWM6DymeI2JfXn
	 uXOq+buzOYxxJ71xdxEG5qlihrHuhWdTJi0rH1rBvZshM+ihu4DmxCTMLbaS79Ex0r
	 9DcVJhmRPP1vNpJbD67w4Ht39DQwJakwMc4QCBxk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B36220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeLKAvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:51:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeLKAvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jXA6Zpt3aXkThVJSMkEjs9vuz651TTO0wfKb99D1NPA=; b=UJ4Q/2QEyPW5x2iH6Nf2zVqAW
        oGryjCFVeMzB6TsR/8mYAUeaZn8vkTyhEBc9dupd1ER4cX6iEDvh/FpUZYX25mUmi1kqx0n3Dru7m
        ZajTm/9JlHBloyUWnipqkqkMZe4mLcf4GRSGb8oYxxhqZWG/SjC4Wp+zmgOoLr7FvGBbQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWGm-0000Fb-Nn; Tue, 11 Dec 2018 00:51:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3A26D11254C7; Tue, 11 Dec 2018 00:51:28 +0000 (GMT)
Date:   Tue, 11 Dec 2018 00:51:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Karol Herbst <kherbst@redhat.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: next/master boot bisection: Oops in nouveau driver on jetson-tk1
Message-ID: <20181211005128.GA3004@sirena.org.uk>
References: <89fa50d0-945f-d1ed-ae55-ee947187f209@collabora.com>
 <95255117123da3702da585491d2fdd74890937c0.camel@redhat.com>
 <16ca4f0f-6800-7204-6fc2-286caa7b850a@collabora.com>
 <20181210142559.GB6307@sirena.org.uk>
 <20181210162622.GB4789@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20181210162622.GB4789@ulmo>
X-Cookie: Now I am depressed ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 05:26:22PM +0100, Thierry Reding wrote:
> On Mon, Dec 10, 2018 at 02:25:59PM +0000, Mark Brown wrote:

> > This has been broken for a considerable time now with no response from
> > Ben - is there some other path we can use to get the fix merged?

> I suppose we could go directly via Dave. But Ben's usually pretty
> responsive, so he probably just missed it. Let me ping him on IRC, maybe
> that'll get his attention.

This is at least the third go at reporting this as a boot failure IIRC
so these clearly aren't doing the trick :/ .  Perhaps a resend as well?

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPCg0ACgkQJNaLcl1U
h9COzggAg0zNEhWVa+Iz0oQAKqj0KyMUg0Vf2WMO1tGdUfeMcT5QCmhGqrlN6nEh
NUKJT6A3b3uVnh9HzSrBjzfXM9wfS8DSdMYGoXzN5cQVnlN3u0Awe4mwlAjR4r0W
aEPrMlJS3iIZ74uGMKrB+LzmKF1h79fu5ssL0Bdvh3lvYm5asUA6I1zpy3GX4K04
LaupBTL92aPrV/Nxhu52li1N0sEWszq0Rkm6vlbHbUu5pSLuPrjSck1nn87H4K/g
aNyMm8GV9PMhij+OoAFti1Gr7MhLG/hxlkpXxw4iHtOwd8jmVsTRc/NzNiEAxj9+
x3Vhm9WafzqtTDnxv3/scLHx3iHmgw==
=/7qx
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
