Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F73C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134B82557E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHJnRQzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134B82557E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeGBMh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:37:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39230 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeGBMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:37:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so8530525wmc.4;
        Mon, 02 Jul 2018 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVDJeENmdY8RuSqsBQHZy6vIBqudZt/ljxHNfFxCFj8=;
        b=UHJnRQzm3KYb5gxXhzW3WtKTkCTogm1xMrBTEUD0fyCwda8wxW7NIEb5ZXHyeexqxB
         PPV0Lq/ZbWOJ9cPnPMHXROi7Rx1t942j3WTNBJVLOSq9mb7R/q1UASr2RC+G36C65sna
         6Qivtc18mkgLMvJkR/7geKWf+yucwBiSVxqj6roq6/0bK65MwUro7C8TgodmWmHiUmSs
         eIzvfHEWCYRk7C7NVDRLf0zhzwAZpGyV/mdl40eH72EB0WfmYvoGSlTco/qPXxqWGK38
         oXOuxoitL5VEKg963Gbzvr22GFDLlwUAOwmiVOM26OLhjWrD/tUx6yJpd+I4lx7958z5
         /uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVDJeENmdY8RuSqsBQHZy6vIBqudZt/ljxHNfFxCFj8=;
        b=uD4EFB/otk1awgkdejNqN6Iw1CKJzcLGlvFNAZMHpIGBWSaS26M3cj8yAcFGVVrQmZ
         dyn+5sNKx4yyVD0HwfCGGSFPSKJ7vooz2G04jP3kz6FdykqkerNgUlmQO4YdRaN8+eRb
         Q7MMMNnI6HpSgUB+isV3HB/352eG+OHBlQWIFl55Ox1iA24oECJOoSbUm/5Ly+sUaMaX
         /9w/VEQxykfy5uKSRFkKFehyIMFb2FJi3XheMSrN+HHvi3Hwo5n7euv32mLFs8lbpZmV
         6/mDhJgDLmbJF7qIYiBUqQa3EwOnM4jPQ0tHhZrsWmuVsvJ3Ov4u+Vs+Ky7jrhfksLt5
         5GoQ==
X-Gm-Message-State: APt69E1y6KFgrwLQnmMckH8DblHl4x9X061MFeRbGa5nT+wdJjKSwdUP
        +xGKi3Sq7+uIuNJdoPPQfCw=
X-Google-Smtp-Source: AAOMgpeKCNKeKf0j2fVh3faOzz8hW8Dmnds7euznzL2oGyVQIQ5u8WA510c8hgHYNNrhwMkl7B1iow==
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr7807622wmd.116.1530535070377;
        Mon, 02 Jul 2018 05:37:50 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id r2-v6sm11858923wmb.39.2018.07.02.05.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 05:37:49 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:37:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Message-ID: <20180702123748.GA13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-2-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-2-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:26PM +0300, Mikko Perttunen wrote:
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
>    =20
>     v3:
>     - Added Jon's A-b and Rob's R-b
>=20
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6HJoACgkQ3SOs138+
s6Hn+A/+Odk5wqDMnlfiw/LHOl8gKOTI9dFik4nUtwIonK5a3l4mflfBpDcyEKmk
1I3Tz93choYczev+mmnh0DWDFWEFmXdKFUgU7mzGw2ZLvtlmYjpSTdigERg3MN9j
p8qFpHDf9Mg6FQJuba1znZbOwaTe6PAA6sOOUzaqSQ0AXqLBT4iWuxJioVDhis3/
ppyQXe2OcnukmDlTxzBK9rP/AZbnOkRgzQKyWKP8GMwNW72H5zuTI1T+BfMTsqni
DRck2GPEBM59j10XW9XR3FAizasV03z+AyZ+D2pASpAo1iwtnVIuh2JkxzCAu3RD
ep7aYVi+BP/AsJr/T1J2B6/50hJHu6ovwDtRaUQgSkINwqItv4aFbeaxy55HzE83
gPIYIoolgj5q/7B9hAUApkVH6UPKlrKGfbCBQN/6BilWHhZnQrqPSg3Ry+EusCma
6n/sIPHg5ZF8zV/nuu4DHcRlmmuUSEBNyb6VPuJuyabMMUWZ0p+hKymn4POvwpxR
xxO9I9dUvHFG2Q2YZ7QtFL533KTwWcrx8oQBg2LIv4g+FVGWUnEysqSfUpjIbpDi
YDfI+Xq0ckNrmft8rcOKfYmKOY8SGg8QFO2V6XA+lOIlRUv2Mke/z5qtXa9+ez28
YJsRgwMggua/pG4Yk9WxdT6sexZGdYFmUi6GhJB08K/CpAzHIPk=
=RaT6
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
