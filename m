Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B12C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C6223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcLHL6Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771C6223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeKNFYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:24:52 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35353 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:24:51 -0500
Received: by mail-ed1-f54.google.com with SMTP id x30so6800031edx.2;
        Tue, 13 Nov 2018 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KybYzXOdQGzTtyMCpWhmRJo3xxmyJ+R1nHx5DNMeFLU=;
        b=qcLHL6JgfJhngNVv3jzweRyUh5glofEBMnhhLcnMgTPEpFxQEBkP2Y47hOy1CHBPRJ
         mrH/gROvSgcnGelsoEtE7Hlhu4KjDjhMM2gGFDyOXaeQDi99VMY1JrcX1KEKq8uPLJt3
         vJupbyhi5mGnZE+7Ilz5g6GWtclKcI9/sZyAEU6HVt0/ZK0Zp5ujfUMPHkCHPNnXdGff
         e1/scK83gBhEtBJYQrDS+Hn47mn5utAmhctFA/MPu+Xrji0D2qzMJa3YsInCPvCVeQ7n
         0bKhHzy0aHP2Nsqcu9NLMqC6ekekDTDJFCza6FfKPkGAsByRQ3WhJ3RvK7NF6riQ6Sak
         Np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KybYzXOdQGzTtyMCpWhmRJo3xxmyJ+R1nHx5DNMeFLU=;
        b=APwcZZ0Q4Vx9b/BowaWM/BAFs0Or7fe2wAvE9Fy+FS3upEz8U493wj3PtsbfZ0AhAy
         iQ5moXRw7NYNvrq0HlVMB4HqqYd9H8IPJrmX5Y51BZvGrwj1frD7x2T3L/+RR3ADNd40
         V3AQnDf9wCAbucgw9dusK2RFtkrIcH5KBg/TPpkVLvcFkOuasp520vi0kq7we+LcuAh9
         rT4egctr9TpSCFIY7C+wGsQuNBOcu/xarqqimjyEhOnkUT0JLgKfSmBfnIjQLspBE3Kx
         npD3ocB3LTfDMdh7w/FE1WLrLZT0cXoQC0w6zztbW0/lAVjfDJsHmWujAj6OuXROabkH
         eRiw==
X-Gm-Message-State: AGRZ1gK0aWkkWsdnIZklw4ZA4LZq/wSeEWpURBnxWEhV8YFqM9sU4TYY
        3Q5ZE5XRgqLT2CWlcHebgJzpUDyI
X-Google-Smtp-Source: AJdET5coAVdnMTO+iut8C11ZUpkAsH6FXnyd6PW3LTnZhvJb1j7pxcWCLuClCe54orqDL+ab1nwqrg==
X-Received: by 2002:a17:906:81cc:: with SMTP id e12-v6mr13653611ejx.138.1542137119024;
        Tue, 13 Nov 2018 11:25:19 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id j8sm1538849ede.55.2018.11.13.11.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:25:18 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:25:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bo Yan <byan@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: remove duplicated function declaration
Message-ID: <20181113192516.GB2724@ulmo>
References: <1542131465-22773-1-git-send-email-byan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <1542131465-22773-1-git-send-email-byan@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 09:51:05AM -0800, Bo Yan wrote:
> The function tegra_read_chipid is declared twice in fuse.h. Remove
> the redundant declaration.
>=20
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
>  include/soc/tegra/fuse.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvrJRcACgkQ3SOs138+
s6GujBAAqlo9AHnhBhOdjSAXFFurCj4amejWmCL6OZFU8fel8rCrX6xS3ZxTKGTG
eleeAi/WUTujQJ7w7L531AStwvfCtyqu9e8xZzsl2Kgf5ml732Dvd3nbQRan637m
nVTHvdu5PxZZkWMG+GWiCqG3BJw21SMRNdIMCqkOoY9+pzETj3CO6tfZD2MIrU/5
wlXsicEJzzpKFce7Ccz/M1u7meChKj/3KosAOYbWrk/es7abnZvrOWjShVM/Qwtb
XN9YnNBrUPiVOJ3zB9OyEztIP2qxP4wab54zYNm0DME/bbD8W6NGcpdO9IaC3pIq
Xjw82W+y/F2g3b9rlyu4qFw9O1fiAeLYXcfgykpB9HgHCVy0jaa2N9TZPXWan2r4
teJz5Ozs+GDlY8epBZw4TwxCp3HFG5cMHec6O2tFR0GObnKhcuReha66vGoL3gCa
6qGEx3pQAUEOQvnYATbULf1JTju9cRKUgRQe9iWX0bwBeF7NsX3HWFlJHISpWFwI
Zz6Lwohtv0g9PQTNQdLxEGjS9aLaEMT0GuSzj6s35tlikwu4oyKZjkb8cCHNKDM+
J82r7X/WV8ywa5/vbW4tfBRCXI/oVZvx1NQvkiF8I0wV0hHjgqOWcsGiyZgve19K
3IbitNsyRm74hdjJsHWBVnPAIHOyr/mG4I1xMf7X1SDd1kMGvaA=
=Cd+V
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
