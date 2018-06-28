Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23192271EB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="x1DAg56b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23192271EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeF1KPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:15:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeF1KPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aa4qwUiv3esOVAGdDdFaKGqPlwhUXrZ1lunwlOo7UEE=; b=x1DAg56bbFNtB0gnDlWbqmNYA
        FJeCBZBVC0M0qDbBdb3uSDBsUHC65lRXbT6qUl++j9HfQ+jONI0HwlC+MLW8RTA79mSjlOOM7cMmA
        /GXtFAs25nidjkOuSHHR6iCy8yPqLg6wmK3x/vBpjdKHyGNxQtfxnJOooXS9MCHmo12v4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTx1-0005D2-JP; Thu, 28 Jun 2018 10:14:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYTx1-0003kc-5F; Thu, 28 Jun 2018 11:14:55 +0100
Date:   Thu, 28 Jun 2018 11:14:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
Message-ID: <20180628101455.GB14040@sirena.org.uk>
References: <20180627220656.19298-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
X-Cookie: Money is the root of all wealth.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.

Reviewed-by: Mark Brown <broonie@kernel.org>

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0tR4ACgkQJNaLcl1U
h9Cffgf/WuxvBn/2QvtxbJTBIp3fi/YUW+3qr2j0Og7aJ1Zjnx4+DY3fs0wXXxrn
mPjnsdRJftX7zEOIcVEXFgjVQjd3FnV5vLrrs5YPao+rqv7BJKrgKcKjsrVuES1K
3aGxhbhBVJKAWxTBIftshkjlWKj9KXkJnFNcH2Gjxi76hCpqN5fPvyWW9f6bqFrf
0Y9s8vN4TwgisbqZ09nX1Qr5IKJxU2VpcB6GPegXf+AVWYnqfLnZaeOd4p43rEAR
50Ym91b+8BaBpZ+o0qYNt8BnPwCGOg2O9TnJpmvGwUUUBrGIFapmvGsYw3xgJfRm
ti8FTCwm/EDfBKmwVRdyN9CgYyJ+tg==
=gQJA
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
