Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73991C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6E420652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tguOTfT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJHUtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:49:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33900 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJHUtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KRLGvdgV7yJaJM/2A9dS7h4FdA9IzgGl5Wq7tpW7wrg=; b=tguOTfT15qwDR5m1OXvNTcrKP
        HvfZod27X83TsuIRDoDZzZuU7sXk3MI5O+r5/3/ND/JGi0ZZYWxf3mmXh9XHcVwcbJFZbtmrmNo6N
        74khElosi4CFRVp/AS5XnWhwI5tF4r1tWOU1AOOs6T/ov0GuYp+hSuF8jLMtOnIsozz8Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9VjN-0002ek-CP; Mon, 08 Oct 2018 13:37:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F100E1122339; Mon,  8 Oct 2018 14:37:52 +0100 (BST)
Date:   Mon, 8 Oct 2018 14:37:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     masonccyang@mxic.com.tw, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v4 1/2] spi: Add MXIC controller driver
Message-ID: <20181008133752.GF5684@sirena.org.uk>
References: <1538965532-8908-1-git-send-email-masonccyang@mxic.com.tw>
 <1538965532-8908-2-git-send-email-masonccyang@mxic.com.tw>
 <20181008103812.106389c1@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20181008103812.106389c1@bbrezillon>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 10:38:12AM +0200, Boris Brezillon wrote:

> This is wrong, ->cur_speed_hz should be updated in
> mxic_prepare_transfer_hardware() or mxic_spi_clk_check(), not when
> ->setup() is called. Also, you seem to ignore the xfer->speed_hz value,
> which might be different from spi->max_speed_hz. Maybe the
> ->prepare_transfer() hook is not the right place to do this
> ->cur_speed_hz selection in the end.

xfer->speed_hz should always be filled in so it's the only one you need
to pay attention to (as the code Boris proposed does).

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7XbAACgkQJNaLcl1U
h9Azggf+KEqx8zCV97yIui9BQiy+hHtNztRjvGmyBDUh20puENxqOTeWCYwoat8g
tnlAllUGejF3B1Dfv3sgGinOrXrvfpLexIL59YZp76X9DN+sEliRyR98dvvgKp2L
38b5xMG1+gzHS0Agv+8cGVuWocAVCyr2jH++siOVJZ/liJEatZl/jtvGNsAztDeg
/sHLWbdckRtd/63c43o6sXbn3jAA06lyto1EFauYt4V63beRC3p8OXasmPU/fwn5
i0N7MX1Zs3xx4hJENMgGAMF/e8Vrj7bD5cVH4YEd+sRAAd2/njTBdf1AVrk5/7dj
/V8SPMbNr4Y+RwHIodVt8hs2KvUY5w==
=XY4n
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
