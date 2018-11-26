Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C633C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0499720862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WOubOMcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0499720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeKZW1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:27:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKZW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dmxFwWPnMDckwt7Sd7UAoK+mhkXQF11jqeAqZMv03sA=; b=WOubOMczU3ZweTWam+9J7o3rL
        +3blhPJwJRkrQxcE6jvpp5y5MiYR5yh4DmkTa0cs4CtUjJwrfJ7PfbjUsPMyCGu1KtfFb89I4ilmT
        0K4E6vZeOECZtY4x/ncf2axPYOuBKO/NzsHlXmMSIxRjmVQ+/jUGkf6FzM80unNwy02Ig=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRF8t-0003i5-26; Mon, 26 Nov 2018 11:33:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B74EB112519F; Mon, 26 Nov 2018 11:33:30 +0000 (GMT)
Date:   Mon, 26 Nov 2018 11:33:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
Message-ID: <20181126113330.GB4871@sirena.org.uk>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123135807.GA14964@e107155-lin>
 <9cea4556-15f8-9377-305a-b629ba7e811f@linaro.org>
 <20181123162040.GB27793@e107155-lin>
 <1e013fee-e218-c489-9cd6-a384950d304f@linaro.org>
 <20181126082702.GA18469@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20181126082702.GA18469@localhost.localdomain>
X-Cookie: In the next world, you're on your own.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 09:27:02AM +0100, Juri Lelli wrote:

> is highly debatable). I also seem to remember that there might also be
> cases where DT values cannot be changed at all for a (new?) platform
> that happens to be using DTs shipped with an old revision; something
> along these lines was mentioned (by Mark?) during the review process,
> but exact details escape my mind ATM, apologies.

Yeah, DTs might be in firmware which is either non-updatable or which
people are reluctant to update due to it not being recoverable if the
update goes wrong.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv72gkACgkQJNaLcl1U
h9CGYgf8Dh/pE712kwWEa17wo5LqzkNIBLtGbfDovc2+UPFjYEGf527IZOJFf6I+
iawerRZGUtTVhTB20rtqVIkjSChjMidwcGl+ThYtw3EPJYZD3natG5mxPkrxk5Kn
U6o4qnnrNbUmuUJnlKRWxo1fGGC1Anl6/3Vaz/LuCNKZazAffJN5femDd1e229/t
iuu9ozJ+EAQsF3P59q6toiTJzrVkGeRBSxFY5PLDnp5ReJ++IdNvJfj7gGYJwOUr
D+6EyufzNeKwBI3yMNROAieIXHETPOULXbBuSTaLUAOG5vxwd4u1Lb8hk8G+Z278
WC183uYC61XBkQSuX4VYyYpP4ezRKQ==
=TT65
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
