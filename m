Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5775C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66272084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ7eq0Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbfA1QsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:48:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37415 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbfA1QVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so14544036wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UW80mZDtxQJprjaotGtqJ5mdZ9XANHpLvFODbrlHVy0=;
        b=VZ7eq0Nhy+LLZGNwrv2/eOI6fs1LBgjnD18DNcANObETtZ6EJeBNuEOewuXrLE8Nnk
         LQs1L46M6NqrSUaT8qI9Fose7NJQiJyeN/ILSSq0ZvMAP+B74IqTAdNd7qeBVaNRYbXE
         VLfNutDSEYDb/yhFOz6LpoNcIDFuyA4dAlpMaqAyAZEtdqX5FZeCkVjRVoAIN2tnwwwy
         eZKtgovp5q64o9FJKDAtGOHyS1+bHYEF2x8sBsEiLZll/8LBScxv15AdB0syRFYHfSXf
         HYaHOV3y96oalV0y6cCtoe6ZgQrvUzZlqcMnOglll9rAnBTLhx6wQOegBWtJPmTjx+un
         kpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UW80mZDtxQJprjaotGtqJ5mdZ9XANHpLvFODbrlHVy0=;
        b=oMctbx5iR26aCCKqzcl7WjP1/5jYoS23pUh1r+EfF+8lNoHB0xSwUoqAlF+yr0M3Wc
         FCcN+1TAchMG0Oxfk6B25wTCluZUDvDtBHMZnPAbHBMHnk6Z4oEDBaIQBiIbH0bQ/msQ
         v4Y3u5arwviG96RvFS8PAxw/vEtuIlFEGHzgvQhpegunMCwNx2Yq9zL6aoTRUC44RWJN
         eqqud3f6BqzOsSdl4IQBro7SqU+tONwM6JX6rDrmPc61+Gjx+tT/Am6X+xmPlfMFlzeU
         lJVdZ/M7SNUOEJrjlFdlO8ooWaX0ONbrdb034kUNEuApa4HzKcN2t/piAFAcec7MBrpx
         qSXA==
X-Gm-Message-State: AJcUukex9LXiCLz+lTXB2gCV6s1sR6igZV4q31BL2KtkYPKrMdeHoUs6
        OY3CDsGJv2dm09NRtUMAahk=
X-Google-Smtp-Source: ALg8bN6GTD4uYNxRc1GFHhdfJn5y1cfuj7Bdoxtu+XdS8RGf0UOnxr6gQwCuRlHwzjdoEelGTVOjwA==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr17992107wmi.10.1548692512744;
        Mon, 28 Jan 2019 08:21:52 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b12sm88713231wrt.17.2019.01.28.08.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:21:52 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:21:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v9 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190128162151.GA27710@ulmo>
References: <20190124215131.17452-1-jagan@amarulasolutions.com>
 <20190124215131.17452-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20190124215131.17452-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 03:21:31AM +0530, Jagan Teki wrote:
[...]
> +static const struct of_device_id st7701_of_match[] = {
> +	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },

checkpatch flags techstar as being an undocumented vendor prefix. Can
you please send a patch that adds it?

Thanks,
Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPLB4ACgkQ3SOs138+
s6Frvw/+KttwgbDodDfRtWgy3uCrT0Uli1TLEgb5K2kDMZjXJSn45x0KtaM1QC3G
V0sC29ariH6br2MRu/JMdR4BfrjAPJiDEK3VmuJosU0QzPpAdwrCUncowE6rneiq
NnF4kwIfQUO6VAlS25EBjHTqO7uZT3dvcyE3JmIczKY+Gwb/QFN0bXA1y3TxIx2w
+AKL9PuXwmUHuUr4LnA2uQhLG2tWvDvcjVuZ8G591GE3BP6nkk5VN7fKZb3b4JiL
v5+8yNnm73puPCz0apyUQkmFFtAod5S14TM8bR2y20Ks54RGdAMv6Kf41pCF44Dn
BS0l4rP25d4BnBWFad5NS808mVf+h47RKXFvVmV2X0pWY0Vrf1jvc5VaFaeG+CLm
Gy0ULWJjYPcuaCYFDl8ngvC1FYAzXtdkVkHJRdPty3dm21FDogO2+Chh16TIG9+K
Vjzk+/PWkwi/WP0unc3Z8sbygZWjfrxVA32Tl+BsZQhJD+jsiTQXlj0/WYkwjzZF
ZcoBsLBhL7WspYpxUlOzXAEmu2gHkPnlmHHVHq1fOOa9Glzadg15oZ1eWQMaVnwt
vtnPmk1TiHuIJ90+xR67weWKhuYvvt8Od1q/BCDFZ3or3rAHjuVehRdK+50bL40s
AxWigVPQDFau6QEBnp+nfx/xOw4rY8kQmFDvRiVXVxbXnZidqd8=
=GP/P
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
