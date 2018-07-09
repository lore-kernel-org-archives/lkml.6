Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97E12084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqoJTz+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97E12084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbeGIIcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:32:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52789 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:32:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so20147235wmc.2;
        Mon, 09 Jul 2018 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HOWrIrQoGLxiptTlYBLQW5JwGUcfodME02rW6dHMepQ=;
        b=DqoJTz+3BtdfgMmFW9eBBJJKsEauL1VZb3CQtqo+wbm1Bm9sVBWFudPJV+mb63DQJo
         eaSoudNQFDXDUbMyLOHghfY77dSPDm5TwMmQvv+40mv5ITk8AX1JQEn7ULcriFyCNjrZ
         rkava6G7jcUhDLEzY5Yragd6/aWxBIndjOZitsHHIjg6sIJrOynoMiPRjx2Lg9mD4EF9
         B7WkoRCcActZ0rMWziJfr5N4ZvgLQCwCTi9S9XNpL26Vh6CcaOSrAmC3J50Yam09TUtl
         lSEhg82R+QprQbcJOZrPyKzYlwvx//30TCc7vZq0sraxeNBQ7fNPl8UAUjp5SOdtCZCY
         PbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOWrIrQoGLxiptTlYBLQW5JwGUcfodME02rW6dHMepQ=;
        b=IJ0JPW36Ru1Bje3ULUM05IesbPnohYZPwLVkyJPS2wsiGurQfEreH6fPkHZmfCvICn
         8qrVAiDcYFogZpzyNZqDabPx025Clt37oFW5SSIO4nIz0b1qu7m07NGsLQxN/jEsXhIk
         d/KiUJnTIe5iw/cXjswTI7fyygJ+hHOBa669XhABxZfTJrEdgysLh6N32l2sMi7oZULa
         JER0JqX8RKA+vP7gZ/34xsASgAL0VoWzHtvhumrJi+NPHWnbCEKJh06z4jCe4pDVYodx
         RQO7f4sM0PHFHaK7KllmAmmamx1UByh6uM03VBBczwsl3MZqroN8CLtQZyHDda9xd31M
         MNsg==
X-Gm-Message-State: APt69E1KIoUKduU3XTNLF5DJvahcBsWhYr6B+hMMh1/jvq4PWxCK/uXj
        4sBQORq2iVYul6gnyMvW2Xziyg==
X-Google-Smtp-Source: AAOMgpdGboUDblEMcmSPEQVMOOAlZROSb50RSbXV6M3UOlOfaJbYMeK9zJeBL032BWncjHMYByWTOQ==
X-Received: by 2002:a1c:2396:: with SMTP id j144-v6mr11229591wmj.26.1531125162983;
        Mon, 09 Jul 2018 01:32:42 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id g4-v6sm12296732wrq.32.2018.07.09.01.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 01:32:41 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:32:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Skip IOMMU initialization if firewall is
 enabled
Message-ID: <20180709083241.GB13963@ulmo>
References: <20180519010710.11693-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20180519010710.11693-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 04:07:10AM +0300, Dmitry Osipenko wrote:
> Host1x's CDMA can't access the command buffers if IOMMU and Host1x
> firewall are enabled in the kernels config because firewall doesn't map
> the copied buffer into IOVA space. Fix this by skipping IOMMU
> initialization if firewall is enabled as firewall merges sparse cmdbufs
> into a single contiguous buffer and hence IOMMU isn't needed in this case.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/dev.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to drm/tegra/fixes, thanks.

Thierry

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDHakACgkQ3SOs138+
s6FwVhAAjre/WY/Ok/bDtwsnpcIu2To5xzRs8sTVaEYyecBce+YXqdiPDBoLSwd9
OkIXKJCmGkk7gTNxndGi4yTlG1F6BpvLvc3YFAtKLnJTR/DsZyXvLvxl91TO17fN
HSdfr0uU7eouwlj6btk3TNXDUeePFSByoCMdnrvjGM53w4LzVPovnt7/qha3Lxzq
yNevta4oPpA6Jw86lICIgVrgEfvM1Z5V7ea/r2MB03TbUt9IuyZD2PRYYBaBOSFk
H4ABykLhpkXEfmGCKCgFco21ckPxP5FvHzzp0VDAVIoNDpPN1eYYrMGtDN9zBQ1z
TVPzT70PPbKGeh/Pa3Z2RnxY318RkVwD17AdmlVocEKJnLkC/wa/pA5q6COW202F
P+G4nxqhFuAaolobxpgemTdVrQTvxspVmFGqBtSBBj05iFv17syuTYfsKsK0Cuzl
J8fnhWyE6T++0nfFL2eZLvZKbb6SconzvdHDAnjrIjAbB+yN12YJzkrZ0aDU9bRN
abxy1PmF8kJA9prwgSG3b31b5cvb0GkABNBmFzNUs75KNVyWQgkVgA2U/ADcitWA
EcOz4XB6zgGPsbcI3Bw5gN8p/oah2/n+0hlu3diC7ZdcMfDF+wshMcQ9YBlwScgR
KFULIFDBgKunGQgSCONDBPC/G8g2FAt4R0GYW5aAgygdkhKESPk=
=bDX6
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
