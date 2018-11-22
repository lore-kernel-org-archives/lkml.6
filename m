Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF01C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2A120663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8EdCanI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2A120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393261AbeKVT24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:28:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39214 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeKVT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:28:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so7032013edt.6;
        Thu, 22 Nov 2018 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Mr2z+mx3+243jhdmDVcxkQagbNfYjGMv4aJF14fv+o=;
        b=D8EdCanIu+KuQjmfCu1WqJbIv/MISrMOwlgJF2dBd5YgZh+fZMHdlPoidgzrRReGcn
         Ih2SeSX23Bk5q1Q1svUqIO88FjyM/x53fscjg5zzROnIbRcOueMs2xABZvQ9b00btXjB
         Khpk9/nqfiWBHom6vTemRQmTCv4MaP803FtoThJqhpMDvv7guryiiZ3LfpCYOOJF2GJj
         WpAeMWZa+oPri+qbx3S5aNSMq3WVuNoDorPe8fqqQjfuotOQcNj6qm/0x9vAmTZIksOA
         haigmW1Sz1iDXt6GO/jSnieaRuq0YK2Ps5wiaKRQsgynsTl+ePbpvlOE+1yD6vzsEveb
         oxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Mr2z+mx3+243jhdmDVcxkQagbNfYjGMv4aJF14fv+o=;
        b=YxknlX1mT/rWYHGaB9dXGRMBlo/4fGpEkQ8IbrA7gY5jYvcWOg2GRgOvmMmlg5MUss
         PDdAHfr3lU1guolZ0SPuYK8Nh9nbwDB0hl8wUBbLRJ0b8Qs9NM8DWvT8VF05UNQO1LCW
         Ov6vd03SYAHgOlI6/0nPcYx8HZiIsK8ZAINHUq/D4CJ8rmBWwF+Wje7HUP3OPBOVGnO8
         b+8ysZYebZJVIDTaIZjD1IHRKwiTKAuOsVpldA+4aI7FzegRC2XyzqyEUVtMzCE/bYmh
         3NthQBLxw8cuthwJdHPJJxdiMTw7bA90ahpO9M4LoSaILi37aSY8tLf7caZFr5g5Qgto
         1IpQ==
X-Gm-Message-State: AA+aEWbbgQ25gUG0VMLkRUv66rMcxDh3AswTzIUcbQ0Dv9G+GUxS0wSP
        WFj+ckVwTNqGEfSIfJunJKw=
X-Google-Smtp-Source: AFSGD/XmCUhb8a7qWcqQx7WxCh7H1GBMoDk483KYODEvbKPgkOxg8+gyz9d8S/39/gQd+DWgVC9sJg==
X-Received: by 2002:a50:ac47:: with SMTP id w7mr8834885edc.260.1542876624265;
        Thu, 22 Nov 2018 00:50:24 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j8sm10662545ede.55.2018.11.22.00.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 00:50:23 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:50:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] soc/tegra: Fix terminating condition
Message-ID: <20181122085022.GB5741@ulmo>
References: <20181122075244.3909-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20181122075244.3909-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 12:52:44AM -0700, Nathan Chancellor wrote:
> Clang warns:
>=20
> drivers/soc/tegra/common.c:27:16: error: address of array
> 'match->compatible' will always evaluate to 'true'
> [-Werror,-Wpointer-bool-conversion]
>         while (match->compatible) {
>         ~~~~~  ~~~~~~~^~~~~~~~~~
> 1 error generated.
>=20
> Whoops, we have an infinite loop and QEMU no longer boots...
>=20
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/1602429=
18
>=20
> Check that the first character of the string isn't null so that the loop
> properly terminates.
>=20
> Fixes: c57eff9503a5 ("soc/tegra: refactor soc_is_tegra()")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wow... that's what I get from not testing this properly. Apologies for
the inconvenience.

Applied, thanks.

Thierry

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv2bc4ACgkQ3SOs138+
s6Fs7A/9G98aM8hd7heybEQYYqFxrRFU4eyO5SOqizrIZ528yHH5GfdiJhvd5vHq
VxOIB3w0W4A1KWOQ63VALeOTELxI6DTM6c551jJe3z4JK4zTx2KMEn2uxcUQ41Ns
4ZXZOrIIflBeWtSuob9AQQVpyNquyOS+FtHl7QrBSz844Dh+J2mpnnEKHBQDqo9Y
/79qXZaYkl8y/YV8/xMMTPRwHMwZpgqCRrQ5NxzvNV2mq/IjGBXEdL1QpXaAHOAz
FW+nnuSJEezPLoYxz7Ww9j1Ay9ilZ1VrB2a5Y03FyZPVOPmR3fpdUXjHGHon/6rH
gkr56kUePeclMCOTlnxBP52di7Ceh+NNOWmoYab3Dagy147c10zfGVId0rKd6SrL
RDQxZYGDYTu2EMv/x9uS5kd2RwldQwnCH7p5vqbFMGvm6cMMBpapNeg+WCUgdJed
SwuoQAhHYoMyes63YGGhpmR4R/YdYYfNaHJ2CdeJvLQJDQQ+eqD9skoAOKkAULRI
LaCNZ9n4x2bmXpZVOsidTGkeqYE8vMQyGxw3/eH7dCAdWHkXqlUhc+sSC6BPs6Ph
KgAhj1Im6uGzv+4EMHakNlFIEbePB2baBW0iRf2NEZYR+R3S7K8M5WYyBUfH7oWl
hS80sV+atlPEMMof+gVOMOszH2afuBXD0tJcCS5NwBhJ3IURd3o=
=7BpT
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
