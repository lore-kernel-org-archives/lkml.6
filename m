Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OtYZFPRnHlugHQAAmS7hNA
	; Mon, 11 Jun 2018 12:16:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3296607BB; Mon, 11 Jun 2018 12:16:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Hn1h5L/P"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E03A6074D;
	Mon, 11 Jun 2018 12:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E03A6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeFKMP6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:15:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbeFKMP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LCADaG+nC4JXwBsI3231lLkfKbwhb0Pxpr6HNVjodBc=; b=Hn1h5L/PO3Pim1fGIhz6GEbsL
        qCRbstRLCCV6U1/jfLYHhNGCgb/cAT9rBf4sjAVpg1OaJRxVTcgvU3A7BBMbInONH7l6bNBrwTc9J
        dJGu2vnpiBWdOtPgGCvlf143atv0TEzcmaBJbErvXD85sG16i9GL9OQF0DkRSguLAfXHs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSLjh-0000tj-Ib; Mon, 11 Jun 2018 12:15:49 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSLjh-000688-0f; Mon, 11 Jun 2018 13:15:49 +0100
Date: Mon, 11 Jun 2018 13:15:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Message-ID: <20180611121548.GB11580@sirena.org.uk>
References: <20180611102529.GA1272@amd>
 <20180611111011.GA11580@sirena.org.uk>
 <20180611120158.GA21745@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20180611120158.GA21745@amd>
X-Cookie: Sell by date stamped on bottom.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2018 at 02:01:58PM +0200, Pavel Machek wrote:

> With setup like that, how does userland tell kernel that the baseband
> <-> microphone/speaker connection should be activated?

Audio routing should be done as normal, and ideally the driver for the
modem will be able to figure out if there's an active call or not.  If
userspace has to enable the input and output manually then you can set
up SOC_DAPM_PIN_SWITCH()es as normal.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlseZ/QACgkQJNaLcl1U
h9BWCAf+LfKjwzLUVvOhcbxLYboqZYnFlFCooMmWX2b09RJ3uwQ7PLbyseWWD2Cw
zTFAji62KlZDfX5Wb/MHpUd+ojkBSKL0TkBWLKtCF52cVaQFFmLdsle44FRjABEb
yzcFQ9RN8s4fQPW3rl12gNjsBD10njZA38OEvePT0mpEy7Iq8zZue/sejMwWyXlC
vr3tiMFqguBGiCugS9leBEGT844muxf+SE9x2eEiVzD7Ga++fSD9JtxgEwta20/N
XzzpY+3rA/Vr9DJj0OYYDZ3M+iGh6x1gcHCVfenoWrgy7/nFY43yFbDrR4JKaVbq
rt74olPQuK/c1jj3xKgIN43f12hhqw==
=87wS
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
