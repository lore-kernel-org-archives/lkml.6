Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57263ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD592075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+UohoU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD592075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbeJYW7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:59:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42707 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJYW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:59:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so5169043wru.9;
        Thu, 25 Oct 2018 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkoloP6aWZS4H8ypDrag00XGSAY5ZftDT7yaMj3s334=;
        b=U+UohoU0OzIYPWBEFn02rR5kdnsm39nfjNKKSPCMS7kp7YgATT6c3lrdhRtDp8/kYd
         Hlajvu2W4eKZGFvJtvOwcSrLp+lNgbNr+8JkVIrun4lV1s12qgPcoAZapE2vKHgerdei
         5jOu4zKI+njK6JZ7WSC9crRD9efo4fxQQqfQ0C+vXbjAMGzyqfpjGPaxgnRa63g73A/T
         y00yw8hKB9C8/jFDo+EXZDH0grr14azlF2s1+6iP+QxJvJhmAHP/GO5DQF6BSWACG6Dg
         IE9dqwuzwznzOin/A0WkRmgrzsFF7I2NuU9HU1RPxh3fFACWEk7aKfgey0OjbgHXxZ4S
         Y0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkoloP6aWZS4H8ypDrag00XGSAY5ZftDT7yaMj3s334=;
        b=RXdT38s3oaPC/aTBjay3ra5/gFCudlPs73RjDuJvAtPke3SDAv1J3xd9cZB4vPMIrk
         NYqCL6pIdwt37+YXcfQnMGDiHJGYZ2G2uaIJTFylNNlM2KrdOwGsOHbgGvPOyZcFQT16
         0hu+yETbJvZy1vMJrLxz9oKw5M0/wxRApPkdaxNEYZ6CzGPfIfI6JUZtkMRp+7j5Ivnz
         8I3EJoQHYlXoE/nQmM9ahj95qRexkE85MP86W337CEIIvCTi3eCZbfPKLhEqpHwLrsvo
         H71XQX+WH/gH5KLurcvoH9NfOnD6Qt2dND4swVPdxl38vftD647QAXECinCVPOPVf20s
         R2uw==
X-Gm-Message-State: AGRZ1gJaIAzClYFQ+B38QCUrGhaxYyuQMpFKaVV0JKMMJRQdYmylBCYh
        5qUu1Io3+jcx6rVuDaSPINivlxVd
X-Google-Smtp-Source: AJdET5cYdJ0V3nbck880DAZr5dYPoGe2/RnHz8CK9N8mi6EC0y8GUj+jDS47jcHg7F8Y9wqQKA3qWg==
X-Received: by 2002:adf:ce86:: with SMTP id r6-v6mr2280611wrn.258.1540477594002;
        Thu, 25 Oct 2018 07:26:34 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id b143-v6sm2410838wma.28.2018.10.25.07.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:26:32 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:26:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] dt: bindings: tegra20-emc: Document clock property
Message-ID: <20181025142632.GE21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:46PM +0300, Dmitry Osipenko wrote:
> Embedded memory controller has a corresponding clock, document the clock
> property.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-4.21/dt-bindings, thanks.

Thierry

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0pcACgkQ3SOs138+
s6Ei9RAAvfBn/t7+INvtiegSrS9i4EZlzXkb89E/8k4Op6GUUQERvdHbuNHUsJg5
Du+IL5RgDV6iBalwIv2xx1IsbpDCJgBuTj3CteatugychWsuDkqzy8trQm19Jj6t
AwmFxC6bptd81og+rQl0FAMGiTSCLsi61OyhgXbQHXAp9zGjHz0v2d1iMZdUgJZS
79eAEeHfwuaEa8lzKILcZxIY/M3tMQPtG11iQGS0tlZcqTWwwHxR2m9SyDM3YzJj
5WnT6zImR16h3FmW9nE+ln4fNmfrn0J4VOvNcCTSKoJvCZcXg2SRnbcLLp2Zxefn
p9Kda72/lgI3XdZBSmk5dbkoZZu7mZx+JzxlTxjltAZuLfoNMcCAbJR5DecImvHl
w9gf7yLISLSJubZKiXxAmtnK974hTrDaB5QtS5ZUurGRR5cNz/4lw+HN4kKW3kyG
zQt1el0Ykzuqq/AGPokSrD1aaFz3qSp1b/yj6xWo1VopfMv3IdbHQ885e/0JXkMk
wHZfGfe7Hdq7xi+n/5cWVuOGvKglu0+IRs7zuDEWRbQ8ZgjrMLuIHlZWAJGKWW6M
VdzAniQ1IGww2hKODiMbOc8/ozGCSpliumjL21XBpw10f/p3z9HqK4oiwYV7LKg3
o6VKZh3pIqledZ0XigW/b4Hu1Z3ZRnb6sQyKb8s/UIGqQbNa0iw=
=R3Xu
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
