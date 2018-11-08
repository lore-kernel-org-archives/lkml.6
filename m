Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19AAC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E3E2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwSq3kaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E3E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKHWWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:22:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36837 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:22:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so18737468wrs.3;
        Thu, 08 Nov 2018 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6e6JTJfYbvVvTCgYcXQOqSWG8onmnXif/hxW247uhY=;
        b=DwSq3kaWysfDUh2TRnvNFtB56RwUo7O+4AHvF5A2NaN1/pFC1OyAfSfWz2w20+HRZQ
         0J5wHH2OrEauk3tv/RZSaM5E9JG3KnAcGDDlhRzCKYJZZizsMl1LyZIYC0gaDU8KEy6x
         fU/MbG0VL4vZjunvWWbiokmB2timCA4RsIg7z0PflEx0gQekO2a5WxYHB0j0D4Ka4aS3
         5hI6iuEXYt6Is8i4QVUkcbmr4D0MnhdpFdBBy1v/qLwp2u/TugwffF/YG6YvoDpRoTNQ
         YyPLuVc2JlYHfzC3rhmmjdtBu1Vk5iZZN/T9B3N07Qnq/8GRnHnudpQEUGFckEQe8wxd
         ImgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6e6JTJfYbvVvTCgYcXQOqSWG8onmnXif/hxW247uhY=;
        b=ngeyQ7wy+3nQtmWwaiZ43u60UDwfn4AJxFH/qScG8xmeKtrVYokHZar+I1hBOjrgnO
         P8X0OyZaTLZG5m0CPhQCYRAo+E4910I7aI8ZAUJlENio9SIQYQ7v0Bhjedtn9KjZeASD
         eMlF4bkEKyLlqnUoqPTXBqEG48yVbS9q63GwNoYaIlbLyT1gg8Nz2HywlBRtHhCujv8b
         0RrqYNYNhOMalgMZtiDFsPhpZoXSq8ubSacvEeqLXlNOIXOYGN6BLXfk5O/lJpY9g0D9
         dIA+bc8RrNwot8/WanXyM5zNjQoL6uidD70yw18xgHJ0H/ZYUzagNyytDJUDYK3VqFSE
         5vDQ==
X-Gm-Message-State: AGRZ1gI9n+i+T6vU1q90Sz3O8O7w4weAa4vaSUOaHu57DQ7v62bBpsNu
        7ZKMseLFlASW2uBBHaQBxZAg7b1q
X-Google-Smtp-Source: AJdET5fKsk7xVYJ6XoMgYZJgR+FlKrK42WPkfCt0Q4HfYiK+JhJ25PwdxeG+i3rNomxv3+QGpwk9hQ==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr4003104wrw.226.1541681237815;
        Thu, 08 Nov 2018 04:47:17 -0800 (PST)
Received: from localhost (p200300E41F201D007494A3C25E2F6EAF.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:7494:a3c2:5e2f:6eaf])
        by smtp.gmail.com with ESMTPSA id r3-v6sm5497224wmd.25.2018.11.08.04.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:47:17 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:47:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] thermal: tegra: remove unnecessary warnings
Message-ID: <20181108124716.GE1340@ulmo>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-3-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <1541410354-19090-3-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 05:32:32PM +0800, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This seems overly generalized to me. Shouldn't we be checking in a more
fine-grained way for the absence of thresholds and/or sensors?

Otherwise, how are going to make the difference between the sensor not
being enabled or the device tree just missing the information?

Thierry

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkMFQACgkQ3SOs138+
s6F4jg//eykG4e686ZgdA9mjgaTVyiWazRPnNRZltx4cwNrs88mrv6otJIpB0Zja
r0OfWP0r4Qrd5VU65jTCBar82zcwd0KCfji/tUuHUjuTJY8qDSTLYZgVOQlC6g4b
bKbyllgzM9SHm4QbPtntAst5FFXaTncS8Kcf9yypj7GNKV6N/BSYdjl1w8uDUlLf
ZIYCQSEhpBTgKNZLz6RFsYRpwO2VDMVZyanU4YiqyEx+Lb/QTyKsgiT1RQguYmZb
mgZM8TmDjtsr9gPQ756ukKScsHBZIef6ZwI4DnTjDHok3CSZ6Gwmf7SuspZMd95e
FK1ZIH4bjvxLuSy2i3sXVS6flkk/+wJfTcqN0Bn6fR7oIO2LojdNaqFS2ZGEBzQP
B/G58yGG1x7+oRXT9WD0pm/bmGO1kHIuyyGdXsiQYonbN+qBS0neUVEDuqpFC4MW
PUzOCTeBk+mdtjXlpFwWhszBOdpksEKO6gRPqtCg9ntL78PwV60of9GP2ke3/L/N
B/IM+42p17PajGduP2j5md8zUtdOxunZaOSUeTzv+tIz/dKuhMglSv2VIpdQJ+w8
bAkSICsj6wMGn2+VEuoFqv0VD8jZh+7JWdJ1uSIPnleBM/t677BWEcvB+4idVY9J
E2gLQzXto0uNx6k0w+V6NhTBmpHzw152KouCrLHjMjiA74jFG78=
=R2u5
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
