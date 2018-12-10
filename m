Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CFDC65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88572082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544456597;
	bh=uXCSvXY7wsin5X6pGL2TygTkbK1hSg7gM4eUVxTscF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BQlcuciEMOd/udrpwRF7BUSi6sk0EgPiLnN8Rhv4klKSKG/fTGgfUrScOcZAiCCh4
	 r+iv/499EBlrFiVzDPTjMf3zg16b12Ilxc/idYvUgH4GQ5QAuq8ZFG0uo79yzCD/m3
	 YZ36kYZo9f9xA5gnNsQbHKR2GAPrPGx0szy/klI0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88572082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeLJPnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:43:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeLJPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dMhU4WCRINU6YcFxlrsS3bZRSkDxWGVxuO/fYTc2RLY=; b=gUrVrtBT5/oqReENMwjWkTUqz
        auidvIURQvh9MqGnY6eIbNDA7STIA/gKk1kmEf9DNpDj5yLSJAzObYuwFiyizQtxzN5TP3IQ70aFF
        9JiKO7Rb9RcXqvLUatLkBV+dYr6t91UX/sHnsViaGm2JcErIy19GqVIqXI13eselywVEg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWNiC-0005CM-9d; Mon, 10 Dec 2018 15:43:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F24C811254C5; Mon, 10 Dec 2018 15:43:11 +0000 (GMT)
Date:   Mon, 10 Dec 2018 15:43:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        evgreen@chromium.org, Brian Masney <masneyb@onstation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
Message-ID: <20181210154311.GF6307@sirena.org.uk>
References: <20181206222318.240401-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <20181206222318.240401-1-dianders@chromium.org>
X-Cookie: Do not cut switchbacks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 02:23:18PM -0800, Douglas Anderson wrote:
> At the end of regulator_resolve_supply() we have historically turned
> on our supply in some cases.  This could be for one of two reasons:

This doesn't apply against current code, please check and resend.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwOiY8ACgkQJNaLcl1U
h9CslAf+PuHrIr1IQ7LNNqfOY9YsDks+jGOc+hjJ2RDJ3iJ3yOf2t8Gz9FjIUgnA
RAB9UYkB5zaN9BSTZMNbpbZLGbRgmji+Ob4nM5T54pnbBHRwXKpYr4tLDGm3ZyY4
mB6XW8E5RGFdMscZxrgVW3g594BetQaVKSRVt5y00wJv1kotD9aby4shVrtE0yz9
Uwne5VGZ8kuNyPXa0rO0DwNUfP/o454H3Gmwf8W4yGaWDKNvXukQGUPjo1d2WlJN
+pU67M1lA8Box0iHmUyqZYHwkYpF37FteJcjNOircN66X+qLdq0QeyTpjSJZ5Krd
WMMuHWcTTP0o+IzFgdZlLJgv5BiVnw==
=X6VO
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
