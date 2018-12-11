Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25040C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2162082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538563;
	bh=ktqVvGBZiKeRkHXf8gaVlAJEysO7FRLivHJkl40VbKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fQ4/aIO7Y0FQ14aQmYrRAWy9RS5eluDWR1mqxf1bpxEq0KdgkX60BXLTjHBP7WKsR
	 JhUx6JKE/FSLM0+lCBcQ9jUvgSCqIbTc1qrjivLC0dYpRQ6xZK4D/44b4Cp5A+IPlq
	 s8UTYOFpRzIPIzaeVzAYG5hdV9WyQcIGwKzRZjhs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2162082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLKO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:29:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ktqVvGBZiKeRkHXf8gaVlAJEysO7FRLivHJkl40VbKY=; b=MtpncsoWXF4YOdBdTJmbEB5vl
        IsTy1qi+dgzwpjR4Z+T2lU/coLJeOmQ3gn5ZVbL8gPNnKyAolZ4wDEW71cZR428/vAXntd2fPVa1j
        3NRYLz0+Qx42euM+g8Z7WQtBjVu8Esy2QwEFOrcv3tPfEcorI6g7INQKkY3by6mj3vrBw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWj2F-00017R-Ed; Tue, 11 Dec 2018 14:29:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 27077112540E; Tue, 11 Dec 2018 14:29:19 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:29:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Improve the stability of lpspi data
 transmission
Message-ID: <20181211142919.GI6686@sirena.org.uk>
References: <20181204062122.28745-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <20181204062122.28745-1-xiaoning.wang@nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:22:15AM +0000, Clark Wang wrote:
> Use SR_TDF to judge if need to send data, and SR_FCF is to judge if
> transmission end and to replace the waiting after transmission end.
> This waiting has no actual meaning, for module will set the FCF
> flag at the real end.

This doesn't apply against current code, please check and resend.

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyb4ACgkQJNaLcl1U
h9CHXAf9FzW3QYoHquCa9xNOaHc8+L8/4d8c8CsaMHI/hjWw2TNzTKR15YFgmJZf
68l/M19BJNklr7pLcp+Vp0C39N5GM8FXxZXrOJqRQ7c8Vxp5tBajb4oxNaoag9xc
Gc7nq55WTK4zyp3A2d4K7aATEuo4eEYCaZGKbIFgowKstKYAJ6JMGFWrUTi7DoPx
KN+odSPJxxRB0HqLmNYRLsPB5S07e4cI7cVd8Kr79YvIbwJgMsmqFEzSpY40x1//
+la+hkQ09O39H0MCZkBnt17T1PWJLwj/vozapy6ElTnoVEMs+0aLMpt5zwtY21O2
2ZtYP2FphHoJT1vnvKkz7IEBKkojag==
=iClv
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
