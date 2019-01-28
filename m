Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B721C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8DD20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA4S29oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbfA1Q5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:57:00 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38775 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfA1QRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:24 -0500
Received: by mail-wm1-f54.google.com with SMTP id m22so14613401wml.3;
        Mon, 28 Jan 2019 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VwVsEA2njTY9kmtgz8zYxOdAC1khnlriZ3fSWEOj6Pg=;
        b=TA4S29oowlIuR/wSOjVAJWHABKVmbfGKaJHNGPpARmmLW1HpV79Cd38WlzYikFerQM
         gBGg3ah88sJEs43r4Fr5y8/HOH9b1gjNjP4SRnFFZToHUpM/OTfDVE6K8rz7ZGuMEAeN
         Tn6P2p0BmTVbEtZOeoTctsboBTHxSV//1ifbVzqyyGOOx6Q8dFa1N45VEarWt+idixu0
         bWc+n8LK+SyHjjoE7zedtsqgbHqT+kY5jRUZNTb2P2+FLjflcCMnreLSRQDEDUkAR8K/
         WOoW69hCYH3lENT7MyWXQSgUWCcElxlDxRL3fB9AJ+XlGlpj9rodqhnX0/Jf+oCpFTop
         SZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VwVsEA2njTY9kmtgz8zYxOdAC1khnlriZ3fSWEOj6Pg=;
        b=CdQ+lL9CMmpy3KdxIrxkhtaJDG6l1mxce0AVP5GkosrP21h2MR02NXrAXlPxBWY0t2
         Gd/4yoNXsRs2uEyw5SKUGrgGNqjKzFOKgEyT119UWqwGGg8D6DQlo2gxQJLvb1pfzbjw
         4+Er+6VT33ESl3FTq3BLjjN6ibMkbvS4ZuC22SbdfQ6baOx3Dh1lzFaSc98NePecJ4oZ
         akYuhRSojIkEvVFbtaIUZsgtgH5RE0UOtkZaYzzcqhv696X3uTQ8ua/2nO4p3jlrzix/
         /Lp+4acv94XwOH3GkuEK/XUGb18kUFJyA8a+qLTiSTuertlrZCNM+9DY77IX/d46Hq0A
         RNJw==
X-Gm-Message-State: AJcUukdA6mMLeUeHbNmgdNCO0N8PVrAL4Ycl9aDwV7eWtumwTGZn/wYx
        4b0TUagv/zT6lU7IsJHR4OE=
X-Google-Smtp-Source: ALg8bN7BdFLsNlp1vWslEpMOoUN7x9MyLbXxytcmeKWEDcfRrsi4TerWrgUtvSOQqwVQpTEXmbjcVQ==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr16903037wmf.123.1548692242563;
        Mon, 28 Jan 2019 08:17:22 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f14sm96752343wrv.56.2019.01.28.08.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:17:21 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:17:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Message-ID: <20190128161720.GG26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <1547458584-29548-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:26AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Precision Design Associates, Inc. (PDA) manufactures standard and custom
> capacitive touch screens, LCD's embedded controllers and custom embedded
> software. They specialize in industrial, rugged and outdoor applications.
> Website: http://www.pdaatl.com/
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to drm-misc-next, thanks.

Thierry

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKw0ACgkQ3SOs138+
s6FjaQ/8Dz8ooo1Sw+gdDzpk+oaeVdeilOjCttAtRJpGhZkCnA12MCjqsVPrpn3M
kjEAYf+3mz4cK3Dbe1A4Cvjuog8kKvbpnVePdxky/A/QtIO6rsMlwvo9gX5kZJ54
IbmmYWO2szqXYa25QjqUCpUtRa7sdZQ/sOaaLHh60orWq7e5zavuuxUQNHr2+UGT
Mp5erO+18P1SdRyAKrf80Fzq4CYTbtLyvDt0hZiHoddC8fYy17L8i8a0VmdRMIcI
NXEwC7XA0XlRJsiqYXJZqizxKALkFfqzkHbFK22rdyLlb6bKkC/hHwTVk4Pua6BC
P0RYSH7ZHd3oyHJco8pTIvwWrHRwCgHjvzo1Bgun1uJZpFuIGRcUhWxVlyUG95i9
NuWJxkEXQA7mjXNmJOyvPB9CTGlXPF+UQ9WJ5/dTqHuZdIhYWGrtoCHlqlscuWws
Ewmjd1axA53lQQoL/WDJxNWIU8p8s7XIZqgGHv1WFDZwJCioKTlEcUPfnq2MixPR
QAo6WjFy1LGOlpZJW5ixf3OiftbD9Dup8S4/ZryDnC2mSB3AtzXZ/XuPo+MSrqhs
UuNSFSTo5NYB0TmaE3oq+d8ZnshuwH2qN3RZSNCgzELkiEmHdrFza2+nhIX3eLNP
v0lkzln3ZyN31aXoDmOK02tx/bl6YCVQBoNU+zWkuIdwEF8DOk8=
=/+Y0
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
