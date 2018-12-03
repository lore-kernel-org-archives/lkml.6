Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF776C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAA206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGAOzhrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BAA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCWVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:21:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42839 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLCWVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:21:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so7081939pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FShRrE3TlhVT1FrEdNBkyXZ5pQaERBplFM6N/KF/21Y=;
        b=rGAOzhrSlLmziyIwgPEWdSBfHiVmbc3Vw3MS0h/lkNpgSyhFPd74xYIdhxIX2phbjW
         S0urWbuWhU12VRwj53/IygBra7bUhT5LCACUjWMFH4H1wcl5Pk4ppWLWTWwur9LHNCnW
         wcUR7VQOvT5tzqe1pdNLnZQDDWbS6aI1YqSVxs0n+AyGXaDvbsLwtrLapQ0smJo0rN3T
         wuHX1qwTkgxr26PiaGABYe2M7M3+31Uy6blCwMdvy2FBhMGqVOOsxfOPJP7Y1HxjnLoK
         HtOMEY5ztA721OBKCYQml2IiQ7xUMcGtAT+1IktuhRTy/fXWSRjQn/MYpiwPaX/mR9iA
         33hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FShRrE3TlhVT1FrEdNBkyXZ5pQaERBplFM6N/KF/21Y=;
        b=F365/va6yanuHc/MJNs/4XE1t1COwef7w2HJuR4nsMhVwoOsMqLbxM9Mtqc7SV0lGp
         URBql8n4UmuIUQ46JEzTH+WsAqu31cj23VqRTJtrRwkekaN2gR42lXhgR66xOjifrJVO
         /q6Q8pzRQ97VjgDaWrxEIdma0r3Q/NI+b2ZGoxnbjK2D9FCLFm//TZfKkuIrFPj7fXEt
         HVjwonAqKVRRCA79n+2maZDS2th3GXd/vF0hEBP8kj2vmV6cy2425xL65moEvMjYqaav
         FONZ/4rN83KG2+LDEjO9Meg9CMSLucO6MuB3mbBTHRV12TA2sKDXQsEYRe6Sl99A2Sg2
         cd2g==
X-Gm-Message-State: AA+aEWbpmRFU7iV5KF+gWUlaZzE06ZjfbINMbxYT+KIdVYuZ3+o2HCLc
        K46r8dQdfTgIckZLmqZtXnpcWxkpwhOxvA==
X-Google-Smtp-Source: AFSGD/WSxnJkqq4pA60oPflptU4+1rVjrjAgEMpuUmUVzNxeWlWuwxEDNWdMMN3szrdsTtW+thPkNQ==
X-Received: by 2002:a63:b218:: with SMTP id x24mr14278854pge.223.1543875666341;
        Mon, 03 Dec 2018 14:21:06 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id e123sm17768661pgc.58.2018.12.03.14.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:21:05 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:21:03 -0800
From:   Benson Leung <bleung@google.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Subject: Re: [PATCH] MAINTAINERS: platform/chrome: remove myself as maintainer
Message-ID: <20181203222103.GB128959@google.com>
References: <20181126194259.2026-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20181126194259.2026-1-olof@lixom.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,


On Mon, Nov 26, 2018 at 11:42:59AM -0800, Olof Johansson wrote:
> Benson has been maintaining this together with the rest of the kernel
> team for a while now, so remove myself from the entry.
>=20

It was a pleasure to work with you Olof. Good luck on your next things. :)
Enric at Collabora has expressed interest in helping maintain this and help
me institute an upstream-first policy for chrome-platform and the other sub
drivers.

> Signed-off-by: Olof Johansson <olof@lixom.net>

Applied for v4.21. :)


> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5a72848a3af..57764aa57437 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3547,7 +3547,6 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
> =20
>  CHROME HARDWARE PLATFORM SUPPORT
>  M:	Benson Leung <bleung@chromium.org>
> -M:	Olof Johansson <olof@lixom.net>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
>  F:	drivers/platform/chrome/
> --=20
> 2.11.0
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwFrE8ACgkQHwn1ewov
5lgJcA//eu8YBw6LT3aj4S5omHZE7+YF4k2wzrTcoOhKfUCR6cnukueffVJAjh5X
VNkmsPDuDLPMpbAJp8Tltlmhi2+Sd7uFPR1NEt1i8Bfa3RrPOF1hSpQIfMP2dCox
FQhZcudtvkDVE0fDD2eEtieMx1OrHYpGuUcighavxKHWwbdln1YlcNtmRkinVlAT
auYmOT8m3eUxuh0qXLstRlnp7Rd5jv+nBD3SYH4K54JPwEdbXfOdqd9HObAXNNOo
3GH11MmZkXE28tLsHq6yAC8umDaZ469b++rNZuO/MvNGcv5CjFDIpIoyUjo5hezC
WEXsf4KWQw+3mspSagFkTc/qoQyqAnXbd3nNbSaQgAQQQbJJoltSD8TxtTKMNH5P
HNamOLTYb77tHk4o/UNIf8UWIwFl+9tTam+WSW4AHxJsvS1snbf4+WDl5m2IJwJw
77w0++aMsBrxUTTQR3tsOZzqBiAqP6bHCej336T2kR9a6la9xCdYP9gMp/vx6azJ
bOgBkixQYzx4XTvho8aEBJtTNZw8eBofYty7hOdUiNsoD+ZfgTOmUqShu8uPnxmv
AUsnhM3mSW0t+ZVTLe6obuSax6sUcqwTg/w7lNsH9aBZS4h3xBoRPkbsqhB9yGhI
avfHNr8LrAKkhUDLl9pm1UbrFSSsChNBmtfr5dAwft2q2R9eYe8=
=WlYM
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
