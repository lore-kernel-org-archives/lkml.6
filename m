Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC97C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A8020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP4gDaiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A8020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeLLKFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:05:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35906 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:05:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so15054218edb.3;
        Wed, 12 Dec 2018 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eLnIAFoXhUbuJffHrleymUmcM/WLko97nWnZAQWWFw=;
        b=iP4gDaiJoiPyeXw6YtndwHM96DsT85bKQyaegw6OaeTs30IyNhJGlLKEAkI3yRiWYo
         IeVZnzpSlU4BrMANe1UVo1KAHk8Ebo88KZ6HFghDKKn1YPoSxWfIIM5l2hvBtcfgVrj1
         +gpnzM61f8hX6gcQnkdRK/MJrVZ/1PYj0jQjqlItR3+6nW/APvKqTFm/4jP3e2sv5HLz
         3dv7pR0Hzr4lLIh38IFgsUVEuexWOOCZtGANVHBqvwsKBftP3tOXBjMa15zyLdc8xLtb
         lQy5OEJhDyfNx7+cyCa2PRwuOJMlyeRelO5N1VCBGE/VFz8jpKrcRFJSdUsoUsVM0GEn
         iJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eLnIAFoXhUbuJffHrleymUmcM/WLko97nWnZAQWWFw=;
        b=pTYgoeU0MkE+eaYBv9Jb9YjxxPVxepcr+FvVaITdC53XZ+uJXnOYiztmG9ASp/2gYz
         MfWNaBsIZek6h2VCUHRSyV10VdBoMQrz/mlX/ldwkOVFOXTIxcWFlADcqsF7lvEGLEDS
         0LaafWpFupS7mYguttg3RWmkyvLUL9p0HiltKF6st65VY2ez66HpDo7yOLxrtEQeHUP+
         CK99W3BMRsqNnLFvZ1kXiBNPhmq0T4fgQ0HgA9ZYnjXOUEGzroBrCl6kZEgtlkUWJYSI
         4V5JskavIDigow3xaLC+YSOihj/Tw8vMV0bvwOVJk0kH681MhqTVC4B107/4CktUV96V
         Dw6A==
X-Gm-Message-State: AA+aEWZR0YceshmMVa0cXus/e2C1usGf2EbOh0stIg7xl7AyJHQpEPcX
        EQEitr5hlGlXHpsvCzUB4R8=
X-Google-Smtp-Source: AFSGD/XGggKIlvoYZhDi/rDnNIOjRsSHVR9/ARqbYbPDdbpl8Oge5sF1oGWYyu5oerHAqdQSce7YfQ==
X-Received: by 2002:a50:86c2:: with SMTP id 2mr18359861edu.34.1544609142949;
        Wed, 12 Dec 2018 02:05:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id m5-v6sm2558742ejq.21.2018.12.12.02.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:05:42 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:05:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/21] memory: tegra: Use of_device_get_match_data()
Message-ID: <20181212100541.GH15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-12-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:40PM +0300, Dmitry Osipenko wrote:
> There is no need to match device with the DT node since it was already
> matched, use of_device_get_match_data() helper to get the match-data.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3XUACgkQ3SOs138+
s6EA6A/+LN4VgCT6U19hE/FW6BtGw/WnhMEUJrK+K+kpLpvTKxAdVpOivRaIi7HX
aP7k/gWj4HGq1UTTJrdF9FVh0zomseB5D96qcT/d82st/Aju1RtiIfl2qhzYvMTD
jjiXF/Sgo/kkF9CQjLMQ4A+Oqke4IhNgRo9PbQCFzitlTKDdtO24IM8+fUNjn0SS
9BC3klMphcXvFSyjX5EgLSlNrm3r5pBSl4PENWMOmleHJWrAPFzNt8n8h5iOA5T3
X0XjxJAqLhsKJpGzLyrSC2kw4PmmPZE5pFiG6m90Cw0s7mI4pez+YJdk5SH2Cn1Z
CUxWBExGI8BYWYcscz9jjvMWx4kCWUcHTZQ4u2DVuSMRyYecdjg4eJ+g0+g59v7w
//58PPpBjAcJD2TYHg9sxfKIowdQOlwgW2hJaxrayGrq063XHJUHADSq9fPsyFMg
c8+gmp04yehftEhz2hDd3Dk/9lU05veWF3QVgSXbO5D0dr+ua6JWTAjC089xnqvN
5Lx//AJXw+bG7nQHL54KqJwU756VLG4ZsD22AG7fxuHVMieJry6t/1ocFkCI91gG
/qZEjwl71TvlSq39mmyAdMyhqpwpIqWnHnIEasGqM/Z1ch0VTFfyE4jgEJsitjop
gDQpHu7nPf3LafgcG0aRwKCeLFuf1N2PnNasgd19BxibZ0lufm4=
=XSwA
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
