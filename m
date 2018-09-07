Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF2FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20D2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IjoyoPsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC20D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeIGQwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:52:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49826 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeIGQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8NGCb3pGqEispZowrIUMCvxbMfKQRUw/ZFewx9Lt7Bc=; b=IjoyoPsCpYAjy9Hc7bNU+lY1X
        2T6RBkelwwF8CYS1LcWcgveCJyiPJNIUgCF1egui7WiQQB68BICbXhBTlzckM80KPi4/m/RHK93EP
        xP3lH4zoE4WsVnnvG2AjuA1bHLjesNMQ86GavHzHq1eiGkyl2F11UnbGxEZTj6s26bO4E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyFbk-0005P4-U3; Fri, 07 Sep 2018 12:11:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A458D1122A6D; Fri,  7 Sep 2018 13:11:28 +0100 (BST)
Date:   Fri, 7 Sep 2018 13:11:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Ryan Lee <ryans.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Message-ID: <20180907121128.GH17459@sirena.org.uk>
References: <20180907002728.112770-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <20180907002728.112770-1-grundler@chromium.org>
X-Cookie: Do not fold, spindle or mutilate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
> Commit ca917f9fe1a0fab added use of usleep_range() but not
> the corresponding "include <linux/delay.h>". The result is
> with Chrome OS won't build because warnings are forced
> to be errors:
> mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
>         usleep_range(10000, 11000);
>         ^

Note that this isn't causing a warning upstream, presumably due to an
implicit inclusion that isn't present in the v4.4 kernel that you appear
to be using, or gets missed due to config differences.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSau8ACgkQJNaLcl1U
h9AIfgf/eBKyahPC3KprtZfUSebDBqPYW/eaxZhAHW8tyHkAW2csHeATrxoxVXJl
rov2bCkWYqeFZ3yrVS8snqsBcB/43VYbceDgxt9o8c99dQUc5LUpcu6h9H48B3GF
7T4sw8aiLrTcW9jVGoArcIBeEW1LeX8wajm3As5PDzRLqbMrYUfcHVeCPgETQhXN
GOlcuzoideXQWyn5saBIZywJCida2WsJJmvKPbW4YlgJ+NdXJQl6MlobnrJg6J94
iShfA+D93hEd1GW8PFAAw1i9r9cs6OKa4AwiUpuJN0gZbIPvFEoMHwjgYI/v9JzY
QcFxIze87XrhoQSyjKunUc8cZT+hyw==
=jeZ+
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
