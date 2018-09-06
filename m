Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB43C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC09206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EnTn8+hK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC09206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIFP30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:29:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeIFP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W/I06th6YvDkgLmeUl8yN0cOTZng2tYVJ39bvjVZ0iU=; b=EnTn8+hKvnDVpsc5anJlTbH+J
        Ey4tyizHJpTTFwrR0Pfnv8QW1h0F7Gn5FLzW04cQzjEB9XefMVswQK3QCONm9rE0OoFivDEHrmbE+
        v5On282+52AJPHP1/gdSS3qz0gTOfciRQcVu9+P/uBsm/KS2y/gB0L7Cbg3yVa8O67FxQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxrvd-00049T-Ht; Thu, 06 Sep 2018 10:54:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 409491122A1F; Thu,  6 Sep 2018 11:54:25 +0100 (BST)
Date:   Thu, 6 Sep 2018 11:54:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, bgoswami@codeaurora.org
Subject: Re: [PATCH] ASoC: core: add support to card rebind
Message-ID: <20180906105425.GE5360@sirena.org.uk>
References: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
X-Cookie: You will lose an important disk file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 10:37:08AM +0100, Srinivas Kandagatla wrote:
> Current behaviour of ASoC core w.r.t to component removal is that it
> unregisters dependent sound card totally. There is no support to
> rebind the card if the component comes back.
> Typical use case is DSP restart or kernel modules itself.

This looks OK but needs rebasing against current code.

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluRB2AACgkQJNaLcl1U
h9A8Cwf9G6hpkdHnQwsmGfH2s5rENsm0BYYZ/JhSMetKbDBXHNMXJ54GCY2cLyl5
7amwYyqqeeqRS+Db+o60kHDT88TZI2lmEt1wSh/zUvdmZWWWE+1QkYeQWVdIr7Et
FNURDaLlRODnSTMXnmIEYWUPLid+10DYOrAMTRtDJJoTusCAZLYZS4q6MJKVbCb1
LdBDumZigcTVuMPeIYu4NpOVlH0sd6sU6HX6ADNiZRrvcx2laxU5NQAKE25vkyhL
hScv6PByaYu7EZ4Nu6Zc+MsqBoOWNfD9hNL0DCgEp07ioAdPen48C+av7czAH0OC
OoG/pElugXqWZC+2omOlrTGumoFY7Q==
=JhVK
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
