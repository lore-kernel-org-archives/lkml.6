Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC593C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A71220844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="oKpFC6bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeGYIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:31:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54593 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeGYIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:31:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so4904189wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=ideTkBCpoDNc8/AMEbACMTkCfOQT8d//CQTcLY9wGvQ=;
        b=oKpFC6blW1QQRRJEOTwluBc0B5IaTUd29cC8Zbsg4LOrAL8x4877s+4+yCWvm/F70P
         /vRwYgPKHK6z62kC6D4POuwVQlMUKZfZXPjKUfYAvyRlkp8CZkARpUY7YfWhdYVbTsgW
         oa+7J+fcsXsUYsKT0I1K2Wj7oBL754h2DvdTMrwPV74rFBG5sXuFdHJyQz4yTwoHmPvt
         y3ox0U44K7FaaQwi8PshZS/TR3vFSVBdj7XXru7TtIRwKM1jkVSJc7nT48t1fyJjvuCR
         k+gEIjm6FoDL9nIw+yy/rN9kzD55/zTH0HeIDD5l+htjTF402czaW9cAl6hLPL5JNRHQ
         OGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=ideTkBCpoDNc8/AMEbACMTkCfOQT8d//CQTcLY9wGvQ=;
        b=NwLO9UVLKsuHyEGrDHn+o1d3OFhNpN5J4oRL1MdjRJCaGirk12G4mDbwA+NQTtTvPW
         RBP+1mLDzSTTc8jtVXu2oBDlJxWPFd8lF8+T5XvbPRmw9URCD1yYsGuvrhBekW+waCyb
         z/rDTIIJEcYRnqKRvtcNjRD24LX/oaJ4UkB+bhu8654a0cNG4RDSrsxg46SZis+bbdyJ
         0DsY5ckTd8AvZ5+5hYmOsXP6VWEBN+Acy/MoHZRQpa8JQoBBn8vUmye7E+bqTmg+o+Cj
         K6qJRNq0puf+xKnU8DqKHkSYZILNZWRvEePnexlbx37gzyCDilNfJXhTMbgfndKnCjAQ
         ++Eg==
X-Gm-Message-State: AOUpUlFdT8+0sBi4KmBQEjXWEEuE9ZVpwkDLd5oKZQtMp5b7qT/LzlRJ
        KNjxLlJxQK1ekXT04uzLJgCxqv9xaTtq3A==
X-Google-Smtp-Source: AAOMgpetL6khCe2rk2c7uMsRJqjWnxb+QOd6MHNJDfdMjrGYrJGEYG0aHHNpMlwayzm8xCoxI9H0Dg==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr3629264wmd.18.1532503263482;
        Wed, 25 Jul 2018 00:21:03 -0700 (PDT)
Received: from [173.194.76.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1018433wru.93.2018.07.25.00.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 00:21:02 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <542827d9-38fe-b145-234b-764ab6b7f612@monstr.eu>
Date:   Wed, 25 Jul 2018 09:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w
Content-Type: multipart/mixed; boundary="URYShIJJvvPdHwILoi2Ar08YEf3Fni66X";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-arch <linux-arch@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <542827d9-38fe-b145-234b-764ab6b7f612@monstr.eu>
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>

--URYShIJJvvPdHwILoi2Ar08YEf3Fni66X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3.7.2018 03:22, Masahiro Yamada wrote:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
>=20
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..7333036 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=
) +=3D -mxl-pattern-compare
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  KBUILD_CFLAGS +=3D -mbig-endian
>  KBUILD_AFLAGS +=3D -mbig-endian
> -LD +=3D -EB
> +LDFLAGS +=3D -EB
>  else
>  KBUILD_CFLAGS +=3D -mlittle-endian
>  KBUILD_AFLAGS +=3D -mlittle-endian
> -LD +=3D -EL
> +LDFLAGS +=3D -EL
>  endif
> =20
>  CPUFLAGS-1 +=3D $(call cc-option,-mcpu=3Dv$(CPU_VER))
>=20

Applied to next.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--URYShIJJvvPdHwILoi2Ar08YEf3Fni66X--

--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltYJNYACgkQykllyylKDCExXwCfb/M/wFP3UNuWZh5i33DCMcSJ
k7gAoJRmsvI0sJl5abkcJf+2VuJw3gQi
=8EBp
-----END PGP SIGNATURE-----

--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w--
