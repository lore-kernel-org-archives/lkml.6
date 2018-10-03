Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B23C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9982089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hmSAio8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9982089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJCWMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:12:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ukh4h2pcN2v/h7FlsGd54FCFK4BEd7uhwbvVoO1B4nA=; b=hmSAio8zQR6NNC/EeFj6QONDW
        IZuDbS7Md6Qz1voZZ3zMXhoBBoiG9usHbEb+/cGKmo37PHYSlMgcWG0jcczADjlbnaxpKkDzjRiWA
        TP88/MOfmT3dZ8o1FcBRIZPCNAFKp0FZ3usGgQ/F8CQtKtHEwTY8NQT5m77Wt/4OFDZvo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7izH-00065w-Hx; Wed, 03 Oct 2018 15:22:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1E65C1122286; Wed,  3 Oct 2018 16:22:55 +0100 (BST)
Date:   Wed, 3 Oct 2018 16:22:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Mark expected switch fall-through
Message-ID: <20181003152255.GE7132@sirena.org.uk>
References: <20181003121211.GA28108@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20181003121211.GA28108@embeddedor.com>
X-Cookie: The time is right to make new friends.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 02:12:11PM +0200, Gustavo A. R. Silva wrote:

>  			switch (drv_data->n_bytes) {
>  			case 4:
>  				bytes_left >>= 1;
> +				/* Fall through */
>  			case 2:
>  				bytes_left >>= 1;
>  			}

I think this code is just being too cute and it'd be better to just
rewrite it to directly do the expected number of shifts directly in each
case and have break statements; your fix is good but still not ideal for
readability I think.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu03s4ACgkQJNaLcl1U
h9BzTAf9GdSvoAIZoKPwAu9TkxBbtZF9kfEGoENWDZsf6o/QUHVRh6cDaCm08nO3
HAqK9wt7fN2SPSNxAXPRN2/XS020aV4Vvlbq6UvMK9zGfhjMEMtkTNTTOd9D4q0x
eHQrUGANKN0h8wPn/MISL1DxROeUmOjl5bl2sp28LJ40RadQQoHi9ICrKkXRR69k
k+8+lQOliYMTP6C68YpJcFR6uo8lslvcA0XoGazLaYZkTbH+YE+Hq5Jfneng+ZRQ
HdkOdIB7QoNB4y3hnP69D8DCZKuQUSKvmx+3lTLbqRLidDerScZy1iHJlfY3QTAl
fl+f6NHqsI20KHJ8eI5IKkC2b207oQ==
=BYK9
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
