Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C16ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD62083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzQN1b2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbeJYXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:02:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeJYXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:02:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so1746130wme.5;
        Thu, 25 Oct 2018 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dimqwly2VbTS9LWCPKDZJRS2Dz/xOSE+EtdDGpWFtrQ=;
        b=jzQN1b2BBckaRpljTs5dAd2LEZdd5k6LjrvU9WnMmQKuGpFYkikR4MZjOByG2EH0Q0
         mvTHHMnpR/CXVkgp+yUkUl/7x5dXTW4VolTbcr6e4KvIaW9WnYA+jVhTv0RyZK/JhvPW
         P4tF2eZftx7qkTxJ0o97kjR344RmBnPOtV6Uon90i0wr24ZA0Gx4Acx2DqVRNvdhcS1T
         IYKnKcaK5dnRaGCrcZr8USxMLGa2U1p7rb3L3Q0atXroTJsH+DCMUuPnXUyFeZmFZPkA
         DuC1geXMUGg7YlCnx4KpP2K8BwCtv0wWPUjYnzp9yPJTyac0avm1hgLMQ49xFkGW/6VH
         e/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dimqwly2VbTS9LWCPKDZJRS2Dz/xOSE+EtdDGpWFtrQ=;
        b=MxEv5zzWxqyc3KEz0PaqqF8H9Gcv9AMhYS9/zK4hbllNBxRLBAk90Como0sFeCAaYq
         Ybs1EkE8R144oVL5C2sBP5Ei/hINzP8tpdiXKnMKvgfb4j9CdoxX+NTlwL0ve55o7lcG
         SN71LX1vxsk8LUB0vIONxYhht3lc2DbbnR5uAGzI+lGTE3vGXTGdx//HLhVI3DGi6LvT
         DTXiJ2/fXN9G5E0KWrLgw2gVkNNZA9QhOF5yOUgGmVVa9iHYqaV0xPJRs+j56y4WbMee
         IKKOmljOyP1aRayccphRIyMy9QPf40Bt0a+BDpXFRqzToud1pG2p74x3SgBSj9HBXiBq
         n/Dg==
X-Gm-Message-State: AGRZ1gJZr1+tKqumlQkpy4GBp47C4EfQ8E7+dhnVoJH2mNb4sv2XP9Rd
        sQBrWKt3bUWbLL+ALth1vis=
X-Google-Smtp-Source: AJdET5e8aVLPOSoariSE4QXGk2M77WsZvznu7bP+2XBPTu01DUyYC3pWpkoOY+a6E1TAZXHJgC95rA==
X-Received: by 2002:a1c:8fcc:: with SMTP id r195-v6mr2232759wmd.44.1540477781774;
        Thu, 25 Oct 2018 07:29:41 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id x3-v6sm5704516wrp.27.2018.10.25.07.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:29:41 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:29:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/8] ARM: dts: tegra20: Add clock entry to External
 Memory Controller
Message-ID: <20181025142940.GI21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:49PM +0300, Dmitry Osipenko wrote:
> Add clock entry into the EMC DT node.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.21/arm/dt, thanks.

Thierry

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR01QACgkQ3SOs138+
s6FUiRAAvpc81LLj0px2mgpDGg2rV4oVXDTtBUJ7t0K6JPKsd38NIuQVVlHpRSPe
HbckwG/anIthCOV3rF/mzspz6d/w9Kf8tbewszz42rENn3jQ2GOoZXU1i8lX/Avf
0IJvd3YBPLZMXMa8WG87n/uzQIVKorHXxWNf4eMBNwkjEpRKz5tBZR5eQbcakDqh
46fgZc74WuphT9A0lcPZULNYrCAaoRBCAB3LYcspTFeVWovjATGg4i9dJeX8Wx2i
Wh0R5Mq+/6DVG+qAt5dqNvGf0BTAcSXzHSsAA5OoI8HIaJiek/V7fBozsWmvqkGS
s+h0m4Y4Zw1NpjDFeJx5EokXxhXZ0vHppN8mxRH+n89V8qMfbBXozmN0fLWs48UH
Zi9UHN7B2EVdezbQSGMyOa54HUz9s+5KTYRiAa0ys1GGHRaZ3O0T+JKS0JeDmpFB
+W3/HbNGLoOVCSixNglz1tNxokkdJN7sgbBEjsMFV0HK3tnjZdie3njrEQ7B2EG5
kekn7T1O5bXSZranf7OZBQxadQG4gYBU/MiikZp2cYF/tLSIvGoKHC5TmMZgRjR7
pvxe4qyS7caUj0Sj7TwKo68cYhIWEQdXSzalw0DuauB5LZNcqlQpovSTlgfvIZp5
2dDrru99qT29XFDNX590/LeYAN9cGj26uQEM98YRehbDQFtT0qE=
=i15n
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--
