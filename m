Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886AB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qcS4GNuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886AB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbeGTNWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGTNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=euSAR+bRP7OCYWwwc/+ZIg0WbYHgukaJbpeJf/zoP5M=; b=qcS4GNuIayNnH4M+7BGw+nb5q
        ep6hv/VaesrU4/OYZ3HWZZIaruwfkRYddMp/aT7gDetZPGZ/vP92GGLK2Vdng8yElEmnN12P+VYv1
        OVTFRVTS+0TPg5/+N8absgakiuXsxz4pOtYFMrz3ZzrK5LQZo6m+uGC/J6OFf+EvveoT8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUcN-0008O4-Jg; Fri, 20 Jul 2018 12:34:43 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUcN-0006hv-5s; Fri, 20 Jul 2018 13:34:43 +0100
Date:   Fri, 20 Jul 2018 13:34:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH 4.9 11/66] spi/bcm63xx: make spi subsystem aware of
 message size limits
Message-ID: <20180720123443.GF10784@sirena.org.uk>
References: <20180720121407.228772286@linuxfoundation.org>
 <20180720121407.910738439@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20180720121407.910738439@linuxfoundation.org>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 02:13:28PM +0200, Greg Kroah-Hartman wrote:

> The bcm63xx SPI controller does not allow manual control of the CS
> lines and will toggle it automatically before and after sending data,
> so we are limited to messages that fit in the FIFO buffer. Since the CS
> lines aren't available as GPIOs either, we will need to make slave
> drivers aware of this limitation so they can handle them accordingly.

Same review comment as before: this will ask other code (which
presumably never worked?) to change how they use the hardware in order
to cope with the limiations which seems a bit risky to me given that
limits like this are fairly rare so that code isn't super well exercised
in general.

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR1uIACgkQJNaLcl1U
h9BUTQf/d9C242WURaroIWlDWbaqS4s4kDexU4sgw1nFDtCjcM+10kd56l4iHrNE
Zcm268MzVlXa938Bs4d9EkdOBhPyHFyl8Za0xehy9rXJTsTe5Io7VdzGoWwrhRHD
UZlmVLkEFx0XZouwODlGedGff8UY0CqswZKjyNHI7axhg6NmSyllI6CCRL1ELecL
JwT6VvAjfCkAMnfyYUgU64Kp4K91RIfuT+p5u4wrbKuqbuLbafO4tGPV4L2gebaR
Q+i+a6bem4Os2ellWkvsmHWeQW2kW1tNnz8UFK488aL+dx+ntQFzmEkF92egFq6S
UMpvLLhFGYhjykFVAY480YUnsmMRBg==
=f27K
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
