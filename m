Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F5D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCYddtSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfAORAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:00:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43492 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfAORAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:00:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so3087690eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L5jbi5ogEbyprZkCYKk9ssorFGaIcA9punOU4Tbe+14=;
        b=lCYddtSFTxVC40+M2iX60PtT2CYuKOtEIx0Ey9hhBpP6NTBU/N6+/5AW4SvXbRSWb6
         x/ly7GOe/TbWH9iyTIQ/eyGWw3NRjjHJ2uI34LfUL11g2rTdpTSQ6eIjeQ9HQu2otwD2
         lnmUaxKYMG0rOdCom3GIjSEegRLbiBe6dNGHSe7v9o5VQXy+Pk7DiRb6zf9uWXL3D/pq
         B/LUXeRQA/hqauChMOQ8/8MV4/u2K6B3lfQfZ9GlfICTOaQqnpEEMJ3ekFQz5RImhhPr
         HJfL/RL3aktxhjMj9IbrmGVrYNX7HUtNW1g3+KRcX6hmeKsmE7JLRQkD4PVcSaor8PgW
         Qrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=L5jbi5ogEbyprZkCYKk9ssorFGaIcA9punOU4Tbe+14=;
        b=rvJVsAhG3UaePLncnfdsMAyu8CkDKiokMX29ObUSgNj/GDJa45B9DKD6rEw6p7jdYd
         SLjC83ZJCpO5EIU9CTwaDSaDVYttLjURWSxtFb9AfmMZnscKyudc6Udke/9m8G/mrole
         OZOQ1lP/HHdg/WgVyOGeCPPdyaGEexN6OZVHA32O+FDqRt4CPJAEbpPh/5H2xpdPHtS/
         +g1ZAucbwuP9DL3koHfSW+KugZPU3l42X62LAZrZWnrGSilw0pn23a7bbkqS70Gh9YpO
         2eojHd2VKhJdFNPUAEV1BCX4Oln0T2I3tk583b1JXNh6zq9ohGzuvH6BN7BwoZlOkOew
         RZrg==
X-Gm-Message-State: AJcUuke1Vza+O/s4UaEO621WcW3ZSK3nmjtClv1Rkh1NDuoKAB1f7Osq
        +J25QgJ3hHphUteso++cDZKt7GeCAfk=
X-Google-Smtp-Source: ALg8bN5EpakxqcSnMjLxoDAHH7hVZbrdHfllb0NH9rNJ/RcbOCPAJDyXOGfOB8B9C6ThHgKcRW07Gw==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23-v6mr3729216ejr.79.1547571621111;
        Tue, 15 Jan 2019 09:00:21 -0800 (PST)
Received: from dumbo ([185.13.106.234])
        by smtp.gmail.com with ESMTPSA id p10-v6sm2723634ejn.39.2019.01.15.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:00:20 -0800 (PST)
Date:   Tue, 15 Jan 2019 18:00:17 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, 919356@bugs.debian.org
Subject: Licensing of include/linux/hash.h
Message-ID: <20190115170017.5gxarqxzfezgr5ld@dumbo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w6uktkxvq56pz7ur"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6uktkxvq56pz7ur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nadia,

  As part of the licensing assessment on pahole [0] that I am making for
Debian, I realized that file hash.h in both pahole [1] and the kernel
[2] comes without any licensing specification.

Could you please make an explicit choice and maybe provide patches?

Kind regards,
Domenico

[0] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/hash.h
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/linux/hash.h

--=20
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13

--w6uktkxvq56pz7ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEqwJ7wH2QqDPtVNX+Tg9k0miCQVoFAlw+EZsACgkQTg9k0miC
QVqdDw//Z3h0Os4F01PLcr1aUd37VRFUh073+Y4E1Oi9WatfVRsjLXExBKpuxcNa
l7l88B3Z4arU1cGwU1UkJwI9tMdA5KFNANk5PwawyMcP3AOv6W4vDB/6stgTe82Q
NphMIqbBAmm2Xhw671FyL+YYGRZHxDuF7H8UGf0ufNBirZ7tlzA8373PhOzxN1dv
q5ZOUIW57t1FIKpJS8StRsFECkCX3jvmR0AkjxolprLQL8VKs359AH0vM1a3riWB
A0D3/7GfPkbGtbTyhR/Y2Y8byUvhZVld7SL/ayoReeXF0Z1kcGkjH3Qtw1hKV5R/
RkFZt46F8JVZD3BMJrIpnUE17Kcik43JvXztxyJr5/yMt1iS+vT3RmnImraH5dIH
t0aLAMydOXub/bSOKJOCkoZUAXcu98uO5Lw4gJQKg9HWlZj0jehNLtxV9REO1JFT
25rt0nZGsixW46AA579gNinTabw0HgeMcAz8M5lc5KAB6FdX4uKNxG4HRbiiUTWi
B56sznKDiJWRaqysDEfHS0TcYyoFlruKcJD1y5NcOXLMnkTXKr4XuvBg+2t8JK11
sveDw+VkQ1ZAIWoNoCm1270IfeasYoOErDnpCGk3R2JC5CiEv+xmfySgEhHZ0adR
yowCryCpnE/wTYcTnqb5gmiw3ScXUOvhxVn28K1+4KqZToLHssE=
=AVo2
-----END PGP SIGNATURE-----

--w6uktkxvq56pz7ur--
