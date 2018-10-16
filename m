Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC8F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MPiW+ydO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC8F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeJPRPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:15:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gQzTgNwonnE2BgYAb/eqjvVAa1rT4OYhHFeFhe6JftM=; b=MPiW+ydO98+HUl3wsUIiseV9o
        LUuFv2lImmBCXxRIs+kvjEgAf5ecdea8fU+uIFRsthrOWCw4sWboYgK0joE49mBwd+7PN8YlvYsQr
        Lp6oUrM43OFSsNEhIisuEELARB8hzZuh/fdVn8YUZmtpMdCWsKnvVLm+Uo7pFW64d/P84=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCLbe-0004l9-6K; Tue, 16 Oct 2018 09:25:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D90CB11223A4; Tue, 16 Oct 2018 10:25:37 +0100 (BST)
Date:   Tue, 16 Oct 2018 10:25:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/3] driver core: add deferring probe reason to
 devices_deferred property
Message-ID: <20181016092537.GC7449@sirena.org.uk>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
 <20181016072244.1216-3-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20181016072244.1216-3-a.hajda@samsung.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 09:22:43AM +0200, Andrzej Hajda wrote:
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.

Nice!

Reviewed-by: Mark Brown <broonie@kernel.org>

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvFrpEACgkQJNaLcl1U
h9CbIgf9Fqzk0pxepYySE69XTPCrVnmprj6birPABbDFD553PCZsbvhoGdZTFpE+
18+Wu8KAzkLSWAE7Ll5zstpSaEIXm/9KRsjkhWDxst5T/F9Q7yB6Yd3vGNzbBiwn
1B9eUfXYMPYlGogVNrT+T3hViBEBzeQ2V1QaAAR1fAK/xgREdo5l8EQsMgUzOAua
TyZ6mNeCElrNo5XuLcT3JQpE75vxeZ+1QShCCP7S/jXYpJRhUs2IrL4nBH9T0M1N
ChIrKHq7YEE6nena7vbce8chBQXhV6Pb7R6qZvuY1x8cUYxUquLzuxt4XCjhHQ9k
2k5a+byuBeXD0+SYrha4EBXe2pH0FQ==
=vgHN
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
