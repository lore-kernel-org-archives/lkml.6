Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CE220870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urQ6wFpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CE220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLLKCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:02:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33489 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLLKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:02:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so15063924eds.0;
        Wed, 12 Dec 2018 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTzljiMqh5fDUMZqF678Ydz95eIFnvOh4gaCdnbw/yE=;
        b=urQ6wFpYdnb95zrH/Hu6ZdHQUXld8BG+Uav8/11rnFXdArnrIAHht9hnrFh4fs1C3z
         sKLXndh2J4aOe98cqt9sEtv6A7vkarnZqG5oO2iGWELWLVkW1aRLtbOf2bZkByhZd4wb
         xnCMOwfs/qK+M3AOedbbYD+BqChpYLADwn0QFt+kjuMTpGdIMQTNVr+oQY7aypEsIcWZ
         +m+bogyWCYhVbfNg0IpX9DXVmjEvtkzTujqKFFCr75R+G0TKu1GSd6O3LWQWuYVVahL8
         PvlW35CrjqBi4wv7X067d++fApkYURwCCsPiiLU4hD3FbT088Hu9ptmHXwaOeCgC+aLV
         hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTzljiMqh5fDUMZqF678Ydz95eIFnvOh4gaCdnbw/yE=;
        b=IDyoU9rSQhppIPLkDwHwJASGTfhzlMuD8MoUWB2p/m0kMcU9jwn+UCh5xfiL48JYnP
         SC8nusgkqFZmeElFMHhS4sGBqC4FHpAb/oXClhMqRPO14GhEHZmY1LRNlA4fVPey8JKd
         ShOa9IXL0yelU4kUKA85TAeRHi+ssc+rF9i9L1oF6SMBMQ5PyjrMGYvMVSCQupfDQEQb
         LJc8N1jfrbWnMITy2fq4wr5js/EjZ/VOXs8iXCp2CP4IPpkldmkJG2u788VmLgVsPQ5C
         L8/Qx8/5pc9VIPWg49QNeC2oHzw0LY37aERrlq4YPUGO7yXk9heESGyYFgHt00iW/K8w
         MVmw==
X-Gm-Message-State: AA+aEWb72fWjwcYXJYZN6ePbuwK6gycZ/FNk8+DPfoT4ExINDjwYyGAX
        xlNroSDjShLECJPCNYeIf00=
X-Google-Smtp-Source: AFSGD/WYkCY0qQ0QMP31e4IS5mf4DQSePed+vWBVAmgAGvCMtoL1Sd70wpRXtpEamAsfrY7NI0VG+Q==
X-Received: by 2002:a50:b623:: with SMTP id b32mr17634729ede.55.1544608935975;
        Wed, 12 Dec 2018 02:02:15 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w10sm4814905eda.77.2018.12.12.02.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:02:15 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:02:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/21] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20181212100214.GC15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:35PM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver wasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. As a result
> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT and not to break older kernels using
> newer DT, that is done by changing the 'compatible' of the node to
> 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> property also puts the tegra20-mc binding in line with the bindings of the
> later Tegra generations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
>  2 files changed, 19 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra2=
0-gart.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3KYACgkQ3SOs138+
s6FZRA//cB/CHkKjPsOF+E9nDI2hDiPmyB3xhsehRWwGC5Vt5DasCimC/0yT6qXd
aQrbl4QAlaTxxoGKRjPBOb09kTFto9ZPlKoxgFSNZSYN1eYg75l+i8uUHF6vLRwf
Mwgk7NSRHS5mhGlBzzuuUEgQgNTBDOnAmd3n7kmDTgKy67cHkER9t9oilMFXL9FV
3TacwTj6HjaO9Ec/V4K8lzi/Qi5wbjhTZpGyN/K+ojCM/T/5NAuUJjlOEyJHOIK6
gg9xcBnsp4ApUyjEXXAcaabRBROl2/oorX6UsrsGAt7OfbJlzo1Z+R1bof4BOyGy
kJHyrPYWxuHYegZTPPHm+p67uJBg5N8LC7mcWs+ZpypVgDjjUIjwZr7qDEkCtGrg
suPXqEHUi47SAdQ+MNm6ISEmJX7PnIUbQcCi0/aOJ5J9Bm+d7+l421CrvTGn/e70
mFnUwJCW6xWZLK/IpEvRBtY2fMnIssMrBLbXC76oNyA4dgEttHZitBc5Iei3sLsw
4PSE2lF03RU2FZ2FCln4vn/ORACLrTAofeieL4vPHGAljFDLgdP3nL9E+wvHGqgq
hWBRlptbxsyFyiK0nWO72mQslRYChirO0LYtxsJrVU42iQqSRYxibTqVNsdR3Tol
4aKnjZuuuafbRyZjZfmEHIiTPEoyJpT9JEPbj799ji70cm2mZ20=
=Qyix
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
