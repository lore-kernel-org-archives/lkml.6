Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5392086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djhb29cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5392086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeJLTvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:51:17 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38877 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeJLTvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:51:16 -0400
Received: by mail-wm1-f46.google.com with SMTP id 193-v6so12690301wme.3;
        Fri, 12 Oct 2018 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4YEmNeaJPTZsfHlT4s9L1owEjxeP8f54L46fjaJ8YQ=;
        b=djhb29cP6DJayvx/3s0gP47wBJsTFVpsYDFrkIg7pRg3NgSZyQix7b5hRH0AAQXkqU
         fK9LG8YV1imIy1ZGd0YrD0XwlghgMh4656tXfZhhV7D9J/yQCH9pQsmqimESts7rMpaY
         eX87Y3E4X1c6EhAHFs4yzp2EW59wHQNBc07CkSnqu+em41gHAvlJx+lBfzEED4p9T4aJ
         pUb4XUpRlgbQacn1SEQFSD0uAHVJDEQ4WBbHkjkZ8O8h0zXHiqz83mDroOFXXY8IqkUW
         RvrALmoGSWN34kAlzzmrJWKtuuFIgifIJ0JJhjmfjK9Dxy2e2ldrQLhA3YkAKMN2r/bX
         /wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4YEmNeaJPTZsfHlT4s9L1owEjxeP8f54L46fjaJ8YQ=;
        b=NE6PRYaW5uZTUAtHjvxrYHRsBSVQjElw3BuPfGPKMlQ5EMDbo/K4trm+ACdzt6acKL
         /fSJoONb0gtiIo4EBxrauf1i0eAL8SB38lX1QNFXxVfMP/dX4YpxPSwXNPSDIpA6SY7q
         uVgEmnfm63cho8EUZIPET905HFppwUmem1H5ZrVouCjeN/V3VkufsU6G3Tc0+fuL/P4X
         NkCllVirv2S3zws22LZDr0gxg3U7azbTRaU5NTAE+kcZkd3Oci4f38Hp5AzYZYO91eb3
         T8fSj+se6nAGNNGMiHkiaH23l5pNHTT6ebxQM1V+8mPQvwTJCylNQQFl3VrM4QKceFWA
         VNLw==
X-Gm-Message-State: ABuFfojBU4tatE/p0UQ/9ektngV1TIJKzTmngNb41iQZJIuQO6CxPukQ
        NhuZDV3kexxy2U+eR4RsY1s=
X-Google-Smtp-Source: ACcGV63rD1MQbN9g39nJYn0S8na+heWHkVaM/8uXB5PHHWDNkQtASg/eftbOuspk49Qs4KyH4DbtxA==
X-Received: by 2002:a1c:e386:: with SMTP id a128-v6mr5416308wmh.106.1539346742759;
        Fri, 12 Oct 2018 05:19:02 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id n11-v6sm1308144wra.26.2018.10.12.05.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:19:01 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:19:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774a1 support
Message-ID: <20181012121900.GF31561@ulmo>
References: <1534867426-25533-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <1534867426-25533-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:03:46PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAkTQACgkQ3SOs138+
s6EHTA//Td9pEzzC8bBXI3QYUS/pkqDa7ZKcUux2oi0N/is4x1hiWJoCS5lc2RaW
BX8LbUhxThEvYUO69XLtxO5ciU35u0nPXzPbtQtTchhDsjztWclZLmZ1WK8RVLFQ
tijE8EYx78kErkpz0K6i9xI7aZJonkvS0T1jSUEbSoM1OyMpvSiuDj1Fk4xd8Oel
iIkzSt7SNEK2gM/DYoaEvXERU07o34NFJMUF9NYt73T0BLQSZCYyJNHYEOpB/ijb
XvtdIe265gzSFQZrnHaSg10UKRWNkEdijlTI7CnxMAqaX76wK5i/zoOG9PtkO33X
u/NIXwx725HSUo6kvK6WGkyNtZtCHnwLpiYcQuNo7x2yXCQ4bBBqBEO9qXGSwFNT
bB2AelcUEIrfqBefKQ6yb3APbT4V847grrhNKwuiqiK7GKmWF1mfpO88Em+AceZc
OyMWW5f320Aies9/HkMm4LjGLKPSIs5tsBo2JnKAD+ujmi16AoJVrWTc6zFrkuWF
D47kx96Vi5Efjsehu8ZJLUG8RCEXff89vf0Utt4F4Ej4NzkkzL44HnlquGcupTYI
1+miMk15kyZrt/4a00LxdYZIshKKWY892Hlq18vHhv5lTrKuwWhSodUzNbjyFDzB
MWFbnDApXrVYx1ncXj3hqdOYfKFffv70rjHCBkrRDvzBQueQ0nY=
=QlMq
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
