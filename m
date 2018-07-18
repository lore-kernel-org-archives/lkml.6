Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F608ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978E4206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vByV2Z8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978E4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGRM2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:28:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeGRM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=leV5L3NuGYVDpmxm5a7WRqFRVlZj2MiCPyw8QvXM2So=; b=vByV2Z8f9oFK+Hs2HrrsKZ5rl
        pMoDRMBzJnb3XGvwV+NYt9X7+onLzDY0KxSK6nTkITcU/o7J5R6BdXeydkWkjcSp8sBQ5S5bTStN0
        9+si55jWzBPe+XkgsfHmD9lmBBrr85gSNKumNdIeKw05AGhOhRtV113SJqT+0c381E+Z8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffkyt-0003TO-2N; Wed, 18 Jul 2018 11:50:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffkys-0005Oi-Fg; Wed, 18 Jul 2018 12:50:54 +0100
Date:   Wed, 18 Jul 2018 12:50:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RESEND 02/15] ASoC: meson: add axg fifo base driver
Message-ID: <20180718115054.GI5700@sirena.org.uk>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
 <20180717154304.9973-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20180717154304.9973-3-jbrunet@baylibre.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 05:42:51PM +0200, Jerome Brunet wrote:

> +	return !status ? IRQ_NONE : IRQ_HANDLED;

Please just write normal conditional statements, it makes things a lot
easier to read (the ! isn't helping either here).

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPKZ0ACgkQJNaLcl1U
h9A0+gf/VsQEQ3Eh3LFVvVOE4q/C6dHPik7B1mL+EauJ5ivAVTQbE/MpoHy/rAF0
sVXGt+XVVsef/OLGmglJ3QM+k3z4QagK7r0eH4S4DjiDsBTW2h8OO1kR/Yrdnwee
BULhCJqV5IBuTRIIlxAMvSYPe07SEs3KNzPbFjVbfTH6w44XdCDEnR+rKBkAcCOA
c/NWQke0nlQe5LZC4GVQEPtXD3m4SlHyXyYc6Hiuf9f6+9GWEXMvh6lJU9mvo3VY
ZUNXZjkzBc20K9ekCWVtOZwPC59rbsgoGYhhkXQhIGi0buyv+EjoYqn4QM/lDcOV
WfA/uW/+EQukr9SjnXLNlMKcVCeexA==
=WYYV
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
