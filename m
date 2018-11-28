Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19E42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACrD3cdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19E42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK1UOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:14:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36676 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1UOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:14:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so21464099edb.3;
        Wed, 28 Nov 2018 01:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCbFXYccDuhCJ8FMpxkeGHM8KnaxgNwj0zWTktHrX2E=;
        b=ACrD3cdXvQxeTa8LElQdkf1YGaUeG5TqJGC8Lb1C1cTJvjz//BzZF8W1Q7k3ygeKqE
         Nk1suyedeNNaCamM+AaQ+svC0GFjVWJB/mX9XMfe4oFuk/AvDlom42l3riKxCQhIJTyu
         C2JxZbB0iA/JDx+0iwahyuO9LgH5Tqxq3BNtdT0PbfBafGQlPdwR1IfZfVRxWP+krA3U
         UuxS4dqHdDM0KaQGooF8KOE2VDdBdtVDH12KETQR3vYgecl+PQdUxZ+gkpF9e4QTFU4S
         PcynBbEkWRjoe63Gn5cDamJ7BlPq9beGBJ74v1FCK80tJ2FaPv2rpfCE5e8I9FHxAWoU
         zcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCbFXYccDuhCJ8FMpxkeGHM8KnaxgNwj0zWTktHrX2E=;
        b=OmPPYjOw24bgSz64FIEomHjw4fWDWG2H/l0qsjY0/wy7HD3Jd97hpftDB0zS3TG0qs
         46AvkPzD+vG7tbu3UwcAFVSD28HTz5E5mx7DHzPZ/OWxYpEYWeSZKshffffkwieZFDPC
         Rgj2+B9liauwytRmYdyLm69vYg8By6lj6A4oNxjww407rU0vqnCx26gJ3Vfqfc677OVr
         YSscRHYdR3MZtImnFW+mWYcON552sj3V/Sfqb7f5ADAnnAlXp4ftHvBWBX3vrzayD5J1
         LS0U+Lf8PcbiDK20S+IKtLhxeh78ATv/UaNWuuTDZauQYpWpYjkOTvsRh2it4TQ6O4rf
         VfVA==
X-Gm-Message-State: AGRZ1gJlinW4RXef003KfI9vJ1xH7eU/olNp5Vm1cGduQdU/3tyYabty
        kXNbvQeRmW2oraxL9fWnhKk=
X-Google-Smtp-Source: AJdET5d5fQeuyxMHLI7WZ9V2hOTExLkDB9BK7A4ygyRMhbU1Y1XFhHMcQgn4WsbXUPTTC/NYlaJVKA==
X-Received: by 2002:a17:906:57d7:: with SMTP id u23-v6mr25673675ejr.238.1543396397154;
        Wed, 28 Nov 2018 01:13:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id by5-v6sm964242ejb.7.2018.11.28.01.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:13:16 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:13:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jun qian <hangdianqj@163.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-tegra: replace spin_lock_irqsave with spin_lock
 in ISR
Message-ID: <20181128091315.GA17419@ulmo>
References: <20180911145446.53621-1-hangdianqj@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20180911145446.53621-1-hangdianqj@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 07:54:46AM -0700, jun qian wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
>=20
> Signed-off-by: jun qian <hangdianqj@163.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XCgACgkQ3SOs138+
s6FpjRAAnZUyw+m+jt+YEVco0UNR5KOjPcSqzdhHi4TLI+3AJ9UE2zr0o2BNvxWz
pVvgaVX33+Qaok2yBQsHHZ5HjhIrk0xqjaoMe/glpv3rP0S0HPN91BB1dqehhGb/
/0lBcv6nU52kzqjNx0RUtiIxgSi81YCAfcRjg+ORT3crxPGr+hUunPegVryvHoTQ
vSaGwKZBKlBwt+iExxZQ/cXIwoio5YuIWyCWU/G5cNcLuVyTJ/lVDjU/RqX+f1PY
1BxXNIMQiDPAAnw9uKk36sZUduBpXjyxfcONQlhh4aHldLgZJytX/BoO5UkF8/CS
ebXAPQLpMyJylsVToqPWmVBybSTHlU9nuZVpMcufsBXjuQM34IY1uvZtJNHA7aZD
67BvzwL1YA0G4px5ihOAGSMYjF7NFtYkQq337bgD9AeEEZSxAYIPBkMrxASed4/J
W4D9flKbhIjUbI8d9ZhtGgCp6TOC0afnfijKNRQvPiCNBE3Q0NZW5RiTq4zHnzHZ
gIBBNrpXaZcCqGb3/PV6bstFIKCNDEoQiYVqM8M7kdDlPrn1jjkWRzC76fTmmYhi
8cmwZdyByXuXuXWs6QfR137P0nxjATq6/EervnL4v921fM+BWCtVtcKJCPLAnfDe
t98CG57KK89l6S37ZI5Z6kGp5gTdH4igRA3bEOVVHcv88I3kC9k=
=E9df
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
