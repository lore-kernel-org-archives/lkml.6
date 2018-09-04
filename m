Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145872077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bYqTmw+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145872077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIDUOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:14:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bATRe524EFUiNaxBLR9yeItXec0ebCeqnzahgUg4bys=; b=bYqTmw+Gcv0aYqxzcN5JSY4XF
        B9qLdwP+XRY4ToeFPC7efLwZ7f0ate5r/bGehllY6nZLoSEEuB5vHclMw7xQemcd+OGpvZRuazVX8
        FJzzoMrsxPYipXZeQZWxeCKAAxwoT+5e5qtIv9h8n5FyxqHq5WHJ+twqXLLyFn62ZNlxw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxDZh-0001Sp-Rj; Tue, 04 Sep 2018 15:49:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8F35A11227D8; Tue,  4 Sep 2018 16:49:05 +0100 (BST)
Date:   Tue, 4 Sep 2018 16:49:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Message-ID: <20180904154905.GH12993@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
 <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:03:40AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:57 AM, Mark Brown wrote:

> > It's there to save us having to rewrite the register cache if we asked
> > for the device to be powered down but that didn't actually happen due to
> > other constraints, we know all the registers are still as we left them.

> I don't see that happening for any other user of this, we will still
> have to re-write the cache when the device goes from OFF->STANDBY, and

You will?  All the power_off() code seems to do is mark the regmap as
cache only and turn off the regulators.

> if it stays in standby and never went off, then we are still broken as
> we switched to using the register cache only, but never turned on real
> writes again.

regmap can remember which registers were written to while in cache only
mode and only sync the ones that are actually dirty, or you can
invalidate the entire cache.

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOqXAACgkQJNaLcl1U
h9C86Qf/VEcpg19JspKkljuF1/FCg29JFROV6OQUtf/6HaeuG7hewgbSgCKqHH7r
1h50yfxMwwkXqRBNVr4cSY6ArCYRSCPowM+DL9pOON8dc5B3UVSf+cMa38cm6byJ
4gmOhyqsvnBhz9eNSHV8OZCryegnTr9+05JEQu0i3vuDnHSYcmDkynMLgtzv6Ugi
UsDgX/q49B4Giu+qgDU8erqhFEawnKFiz5sIes5V2gVXJf8KfSYaA13rXks2b2qh
b8iMTRCqki1nq6eRguNcO4tCskBk1IAF+2uSpqPx214HnCCoC18M1JhVZHp0tpgs
upvSuKVMnGskkgkp+E5BsWUMEDSEUQ==
=fEj5
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
