Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4075C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A097820660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvq0xeTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A097820660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeK1VNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:13:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38949 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1VNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:13:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so21568263edt.6;
        Wed, 28 Nov 2018 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1spqK6BlS22Uk4cQCXGPgErd0xgXVAQoQYf8lPT5RYI=;
        b=lvq0xeTocLV8cHyburM5kTLqFY2qX9LJxL5ze774FFU1e1b/MeNYbLm9rZ9vWtXZhF
         lHPcQZ3JpnkWZImPExwEkOvD4QOUONexQ/btscBcguzhPkwVjdMiL5+RRN1b2ha7HhhZ
         RTa23hPbwGSVH4liqWNXBl5e6jqg54DrWSxaR9628UroXfXd3oTsUK9QP1Pso9IH+LWm
         G5iizEWo18uNjgIvEGvGJblErBzqVAxJjZOS79bNCFhbZBcwdWAzaGKHKW1E5A00R6WK
         VlOGihXlYeZg3xy1jImJMnGTbZHdMDRD01vyRl2aG61p2Bu/58fGoVRNK45rExpouXtt
         Xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1spqK6BlS22Uk4cQCXGPgErd0xgXVAQoQYf8lPT5RYI=;
        b=rq7slmnz70oO/9Ix9gaBeQJd0zeq+vsMwd4qwqMI8cFQebDtosY7uKX4Sed0FLU5TH
         wY8/IQf/o0ZkDP8eK30boH9Gryl+2Y7V5PZQt1oo661AJVRKODIdEiG/OaH04rKgX6Dz
         IvCx8Qj/sY9xzCZbRj0jc5rczYHj/TZo0tFJ1SsoPDNvUizBLXsJuSd1z6/LrhbKXgpc
         zi6O63uLkEYnHpaSgU9WcXtCzm1lY7LKxnMUdF8rUwlyq7osq6DXwHt9PJlD8dZnCPG5
         uisIKJXksm1yfkD2Z/t08S3LFeH1Cy+4xI+6t3SgzF3cY/QMxxJq924PfWW5cvCat8RY
         QATA==
X-Gm-Message-State: AA+aEWatRTYSMDUuV/3I/ZTvAYT78NFYw2ruTC5idhtbtoggV1jOTtrR
        VsKTdDGHJ4D8DUYQwK5LQmA=
X-Google-Smtp-Source: AFSGD/WngkFQ8cr9JmaEc0DnuEZIbxGSGIqcneF8RNNkZ0VH2ZVgPhlT0zjJ0mUYYwaMs88gsQexmg==
X-Received: by 2002:aa7:d0c5:: with SMTP id u5mr28754155edo.158.1543399949257;
        Wed, 28 Nov 2018 02:12:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a13-v6sm990889ejt.69.2018.11.28.02.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:12:28 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:12:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] thermal: tegra: remove unnecessary warnings
Message-ID: <20181128101227.GB20723@ulmo>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <1543383877-20555-2-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:44:35PM +0800, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

If these are all optional anyway, why even keep the informational
messages? While those may not show up as warnings in the log, they will
still be unconditional noise in the kernel log. Do we really want that,
or should we just trust that the DT is correct and shut up if optional
thresholds and sensors are not present?

Thierry

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+agsACgkQ3SOs138+
s6ESDQ//Ze1+ZFdOHnDlT9nhm9ABrC0HbFBZsMso1CGMvjVW0QrDgKweNRZ7/i91
yV4tnx7tZO+uVUAxq7aNbkc5F4iKqw7YRZmspoGeLLa3JW2QSirupUQAFZ+8vavJ
K8hH3xJli0ratf1G6D9tamiVeCAT0bt7m5+3vEakb9oP/VW5szFeNBWWsOKeW44o
oritFGI3aenXRZzcD8dSduZlNz5mu7/iDamvcydw+s0haGbP5UzDKEcciym+tVH0
w1WQzKLBlPnLG9K23pMU9sv01nHIXM8wpsg3S6Um9k4AtDZslH2pMgKAiXdL8hpf
HL8u2HUFTgou/fKPSaLElU7/TNYtCczLvN+QyqSsfUOOBakj7vfJ1LbirReYUxiH
fHF2Bb04MwBAs2brFAQUlXRA8eIGISZS0Tyuk5Se6rmNcpt1/TRE3i7ckquTuBpU
R5++c34lzGYBUi9U9TWVhN2rHvw/g0/u6XJB+6h9wB4EnkS5C8a9FuvBFd08zeYo
vutg113fNbAeBKGzYAeQYQIZqLR/XRzgfKVoTXk1nafJP9sFhf98qeorlSN4NBS2
aC8dJpDWmu+JYZ6rkM3WvSXcp64VJd/UBj/njVkbI3QT+y3I6ZcTE1JYJONRh0UW
gkOZQl3Vs0XvCHazbbVUhqadWO2aaQRYM2FW5wrl5x9/TjpJZkc=
=mRFi
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
