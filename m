Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DE42082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EidZGXQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DE42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeLEMgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:36:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46477 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:36:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so16842377edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrtMh2jYTpv83rVG5A1QYng8vN5RmiJeEXK7511FJH4=;
        b=EidZGXQClmZJRKgORRKQ2z2JfBQuXzu4/XxBc3E+vzeqS19JbW0mm56hkaACtKJIeo
         /rCoHX0L5LiZfXDY2WX5cJRZxa8msNVo9aWJf5Hh1Hyky7YjwcOmKLMM6qLEcKiRPBzT
         MBUMVseU81Xk3QztKaGGeILfZUG2oV68ZKhDMyJcAFupi2z4wtiecu0Pd2B7csQFLxNW
         XY48Pv5Otaw7YS+7LoZmbF9ImSHrrpXzTF0H/m/PjtffMtI3rR++F7/Tu3yI3cLAOvde
         o4GKE08/YqkGNMlioJP/XHjq7CpCuyBNYCW1cpnH/ft6Xl8/GJ8SN76DMZjrG8gpUiGi
         Yk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrtMh2jYTpv83rVG5A1QYng8vN5RmiJeEXK7511FJH4=;
        b=or4wIAVMQNSAJvM6LH7zc8LDtf1WTbcmUniV3YXueebOdnAsPrcvhBXdBHSk1TTNWo
         2UGwfHZkbIftKD9xHPLfC4P/7YbXffQ5Q1+kCf1ecGknFEdDHB5ct7Wsvdhmp005X7H9
         xhcrpLVT5iK9j+RaHIEmA3O/TbTvGlJNQCvzl1eD+HoCwOmzxAokH6av1cpweeOPFAtx
         ggai+c5kGS19UWMXFMRgxuD48LawezE3YV4ibDfx3Su3wrwZvLa/bqJm/j76hrtfqpii
         Rb0BGmHUIZ1QcSpuEfQ7Gw4jxsLeDth1zaxg2UeHH3k4Dz840Ywq5LK4bnRFsFYTrP+4
         fhMw==
X-Gm-Message-State: AA+aEWbB/YuQAKihfC2WrgpGq+MyI3xuY19JwAbqG3qWAwGNCSZyTRLi
        zHv0JCn//GcvxZMVIbwNuVY=
X-Google-Smtp-Source: AFSGD/UbaJgplGgnh0sSK8r8lCqy6Xr6JmtwNzdUixkP06w1u2ecj++UaxQlSQ2R+bE+lD/K0rqrrw==
X-Received: by 2002:a50:9e43:: with SMTP id z61mr21449735ede.90.1544013359613;
        Wed, 05 Dec 2018 04:35:59 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c12sm5220873edi.52.2018.12.05.04.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:35:58 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:35:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dma-mapping: fix lack of DMA address assignment in
 generic remap allocator
Message-ID: <20181205123557.GA28929@ulmo>
References: <20181204142304.GC2618@lst.de>
 <CGME20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9@eucas1p2.samsung.com>
 <20181205101401.3561-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20181205101401.3561-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 11:14:01AM +0100, Marek Szyprowski wrote:
> Commit bfd56cd60521 ("dma-mapping: support highmem in the generic remap
> allocator") replaced dma_direct_alloc_pages() with __dma_direct_alloc_pag=
es(),
> which doesn't set dma_handle and zero allocated memory. Fix it by doing t=
his
> directly in the caller function.
>=20
> Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap a=
llocator")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/remap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Thierry Reding <treding@nvidia.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwHxioACgkQ3SOs138+
s6FrEQ/+JDxH1WopBJG6bpMeKByiWYJdObpk1wWcMYzSme2BnvWsUJW1OM7ctUOT
AZKVxbWFbaDJdLs9xlkIkVAOMe9i9eGkwFJB0IugR7NlhH3HV1VPbd99K4VvmV1q
hAtBq8UEod1YXBD7X836sJLRsYwzEb6TP6E2en5EPMDgrOS5N1rhcCyslorrXoqs
h+n3wZllTQxBr3liY3FFwawKDYuSj8PRqsn8AKXh5KXJS6F718lpPxL4PmnhWPUB
76YA6uqe5mYPvdxAS7lEhM+BjuNBRSO7rGSOJpBVkcXbDxb3BJCGMnhUbmnjRDCH
0zyIyaKQa926YoZIhSOcWCIgQdPpXUWf67BOaX7phmL0fIUwfjJKsMQY80Wcqxxu
YzqE36DCHj46h29PbhXbBcy+/bCBZ7YgDCQsHBk6+gYGJbYLj77ouN2L8OrmcDBt
+yXpoyQoRDiGhDQ4UBEvK4bAKvBPG77G5Z/he3XvKIwty/ErnKC7aVWpa+a2sn+x
mnOz+E7M6eVM/nSkdXRn/wWfAxXYZbwJ5+oLMyKERHEyvl6/acKAoTmH7vNNVmjt
TKdXUoEQr1rTzGD05Zlm0wC5sB8+PnCIJQV/g779HpYLNtFJq/YyAF2d2NoVXkcg
EDMdZsy7f/vWd0+4oKpR18RvDdKzBuzHUJdiVC/P9rt7FDvI5YQ=
=TbI5
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
