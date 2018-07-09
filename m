Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3021B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aimGGwCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3021B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeGILOw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:14:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44168 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeGILOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W+WhS8LD6ZIrqfogJxkdkcMfWYyJfeJBjfeN/o5+ru8=; b=aimGGwCEDoPtTXysNn8oM6zYx
        yra+7Ckv/0xntzu/CkCc+lFUNoZEClMi8pFUk44qIdX1LkStq38upQXZF+YkiRCqry6oiTv4bDY4v
        tNyjN2up+Kp+mkfWPxs/mQ+ulXxGnkvwEtkqCoxEi94cisYOOELI4NK4Hi9lEEPQK0oDQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcU7q-0003hM-JC; Mon, 09 Jul 2018 11:14:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcU7p-0005S6-UA; Mon, 09 Jul 2018 12:14:37 +0100
Date:   Mon, 9 Jul 2018 12:14:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180709111437.GB16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2018 at 03:13:13PM +0530, Rohit kumar wrote:

> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

Please make the entire comment block a C++ comment, it makes it look
more intentional.

> +static const struct component_master_ops sdm845_ops = {
> +	.bind = sdm845_bind,
> +	.unbind = sdm845_unbind,
> +};

Why is this using the component stuff rather than the normal support for
finding the components of audio cards?

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDQ50ACgkQJNaLcl1U
h9C5OAf+JveqZrxXpoXe/VjhXg8RPbyzezTyG8ZWYflQEQpM1UzQpr4pSbyc7ozz
CicbBkK5P6StaY1SUURd9NNmiQXay51izpf20Gne+nhDXxeIsi98J0eDtzypAgVX
aOiAfKkFlsySKOJf79Cq1Co1BpS1HOe9ve7mauaFP6lmI8qiAtc3fuhD03WAB3ku
FYNNCHSn2bV0A3EA3q1EX1j0xyO5PA8Kt0fTHqyCkDguA+DBhvoSGHD/HXYgibcH
210gSXCQ4LwKNmHQ/QS0m2MCoS0HNgBM4xO3/PU/EbSQ/hvoS987B+xrNv/JE9SZ
ZaluCT8Yre/yyA3YicLCSF48vWYuvA==
=bYhV
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
