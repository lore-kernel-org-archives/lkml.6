Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D844DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974702089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQuLy/f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974702089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeKPU1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:27:10 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38178 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeKPU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:27:10 -0500
Received: by mail-ed1-f49.google.com with SMTP id a2-v6so19184052edi.5;
        Fri, 16 Nov 2018 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+rTaZoBRm17fzVlHCB+hgQ5B5t1jv/EsUeAOqz6Hnf8=;
        b=KQuLy/f2lttwUUqraS+nljSz9qM63jgm0PT5mghp0r2XntqBdDEJQtAyYgkMMBVUbX
         pgIOZqXi4tTlA6T9BTzYX+1vSpgHiBgUFMKTaCTxWuTOYQVW3CkjOZhFW7TZLWIAxohb
         UAg5lXtYHztwcgBZUaFLWH+IiekVqcLj5PhtzgxZXIuJX+iR7ULNQmuLhZD72fTnmb+F
         dwUEsKysrnh6cSoWE7sun17dN13xiUR9c/c1kpP1cNkLCo2kCVUY6VoBHcpwl7yefAK5
         YwvsW84QVxhz492HZ1yU9BSDvw5YRWnSO1M0qMKgZJDHmZo4Anm3KAOcvI2gUp1rQZ6X
         XRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rTaZoBRm17fzVlHCB+hgQ5B5t1jv/EsUeAOqz6Hnf8=;
        b=Sv73Tv2P/Ik/Iz64MfD5IkkHuZXqcpHbtbiXoTVZGH8Z+rf36NkXDsWliJyYh23HT7
         UKB3ZMtc221IfX3ALi+sZ/hYdxiEP7RONQ0YkE/iklsROM0KHTguOTae6CdlphdHOxdZ
         bbQX6ZuVgTcRr8yX9A3SSuNVUudDc4pc+PdvXtvY/MAJwgPi5fFQJW7nXXyZfcNDtcxr
         W4IKKiQOqlSrEB6u3JBY5Qlc6PX8M/9Qm8MXt89SBNMUQM6c6xsF6YW+Qoea1SNsKUoI
         0Zp3It1+zk2DaZqTJ5MbzPBrBWkCIASA7We5TU601SvveT4M6gqa4bj44oNawqQ7mMcJ
         SxpQ==
X-Gm-Message-State: AGRZ1gI86vP88pyb9UCtSXWzYqxUM9rBrkENBaAQit3iB8+wKVavRBJ8
        Vrp7TU0yYSKnulrCoUMzaF0=
X-Google-Smtp-Source: AJdET5es4CDAUrjGNiXr2mDF1wuLw12AHDwbtcZLXnHclTrdnl95qbNzaDO5ZwRduOC6vizp0uwy1A==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr1103362edq.170.1542363327931;
        Fri, 16 Nov 2018 02:15:27 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id l6-v6sm8791634edl.60.2018.11.16.02.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:15:27 -0800 (PST)
Date:   Fri, 16 Nov 2018 11:15:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion
 of <asm/smp_twd.h>
Message-ID: <20181116101526.GA14769@ulmo>
References: <20181115100037.17706-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20181115100037.17706-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 11:00:37AM +0100, Geert Uytterhoeven wrote:
> As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
> init"), this header file is no longer used.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clocksource/tegra20_timer.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvumLsACgkQ3SOs138+
s6GHAxAAsY3Bc+7/MuN5iilPwhrsewh4i5YkA9An79ObK7T/WVY+XTqotgwZ6l5r
DnSspjbtg4RFXrhppGk8G5fduX33K6URBRpT6Vy8fZpz8oe7G+gorebb81fyX+mo
nIZ636RFiab2LkhQ6E3kcYJtAIwWXsgO8UM3+wi+qRDk6kv6I1ptREwkT6SbdEPh
cdmW2uv1iTTnlffZKMvF5Zb5jw+byD6TjioTm8Rq511Ql2YmMI8vD8ytWfi2gZGl
CgeODVtLdhjzSJ0Ffj86g0vOETKI7YhvWFpInH5En6auN7Hbx976qfI60nmVgcLU
9M1PW9uRhWkZ8acwhie1uQAnpmnjPcf9bW8KVmDY3os4AdnyrWug0Zf50GGix/vW
NO9dyjP+G+/u6+I/2uBuBAxShHx130vDh0zCsxyR0l3YFlvpjkprYhDT1aMN+mKk
kZSN2J3SsmbT0LTJv8sPuk1vwgMS6lRoy0IaJ8rH51KgtHMDkMpB//+FzwSnyD6v
tAGxiANdtZ/D/rHeOw51B4E6va8lMZxvUMkRuDesSY9o3BxPHFgAMpJVFqPouPVP
oT1cA+t6HoApyblPtrrZPRWE9zYL8C4jLbkX7Wn7yJx1hGfD3bAQJ2sdF8C9N5lY
OgtBgVSmQUmDHDq4lRygVmHxw68ORg8bB2WKqr0UJoejwa/b9wI=
=cJ92
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
