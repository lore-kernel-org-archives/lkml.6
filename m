Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A242081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLgaiVUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A242081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeK1UZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:25:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35780 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeK1UZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:25:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so21485978edx.2;
        Wed, 28 Nov 2018 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdGqriGxoJlUjG9xh4Pzfix7/Tgd8vcSMVeZP6YiI7k=;
        b=YLgaiVUlok02Yx47RC7XsVKu8A4lIULrPFWfvmU6zcpf2ZKIpGlyG14Qc7aeemB9Q/
         G24TYaZ0GtpqDfj+B49iQp4zo//wjVwQOwjNsZMaWA1Ost/AQ1uNcQn6wShA0mgWnhWS
         tMmi15fonDO4vlCjZ3KJcV0VdVCg2ZQOFbqsrkGGq9L6SSpw2RgEZZfnsvZ8LZ27sRY0
         Rr7ixtrTef1zeo2OHE0eJTe79aSfYB+GDe1PanH4j2F+sP4Lure149+3a7C+E2B9w9Ze
         RNJ2BYwNnkd/W11eT7sM4k6fB82cBw5Zr3jGg+fLsxHwaup2Wi2mMrbom9fqYcSclMog
         ebmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdGqriGxoJlUjG9xh4Pzfix7/Tgd8vcSMVeZP6YiI7k=;
        b=gYKRWbFaYX9A3ey1XFqtqdJMxwcFBslKP1QDVZB2pnjmBBut6wg3pO6Xct9IKlHET/
         iGDdFFSnIAyqGGDkBWSHG/AHAZv6aCB9WYGDVvpOLm+FpzgLlCD2/b3EmksbhO7NJGtb
         PHuu6WF7A/ZkzJcxMRH+wa+pST1q/PlQhpale8Q0MIjDmnRlGN0IpwzqBGpCfc8qqSZ/
         fU96P7vkVdvb1vOL900IOquVIgX+WyhafZzV44O6feNqB2jSoztC5MkPNyHueGiTARxw
         q7+Cp9rUIx7kd+9xoyYSZ2MjbgJTt2Wm//KjPKHe5VCj97QHy0AquuGFnagu1AEyueoV
         7lcg==
X-Gm-Message-State: AA+aEWaVC7O95F8ZsUwxsoNNsQ5VR59Uzt6oKbQm9iDDmkeKNxLZxzJI
        8MW8RgAt1nUurEMS/0kZIU8=
X-Google-Smtp-Source: AFSGD/Xjv3OwgDG6GnPOThySq8Da77kNyfsthyDsqzq/Dbio2mbC7Q96e+2xWKnOkUoMtB1UC7FHcg==
X-Received: by 2002:aa7:c906:: with SMTP id b6mr29906995edt.17.1543397045654;
        Wed, 28 Nov 2018 01:24:05 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 24sm1647115eds.97.2018.11.28.01.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:24:04 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:24:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 2/3] clk: tegra: ignore unused vfir clock shared with
 uartb
Message-ID: <20181128092404.GF17419@ulmo>
References: <20181101015230.27310-1-marcel@ziswiler.com>
 <20181101015230.27310-3-marcel@ziswiler.com>
 <20181101084152.GS7636@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <20181101084152.GS7636@tbergstrom-lnx.Nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 10:41:52AM +0200, Peter De Schrijver wrote:
> On Thu, Nov 01, 2018 at 02:52:29AM +0100, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >=20
> > As UARTB and VFIR share their clock enable bit it is rather unwise for
> > the kernel to turn off the VFIR one should that be unused (and
> > potentially vice versa but so far there anyway is no VFIR driver).
> >=20
> > Without this patch trying to use UARTB with the regular 8250 driver
> > will freeze as soon as ttyS1 is accessed after boot. Luckily, using the
> > high-speed Tegra serial driver won't exhibit the issue as clocks are
> > dynamically enabled/disabled on every access.
> >=20
> > This has been reproduced both on Apalis T30 as well as Apalis TK1 but
> > may be an issue on all Tegra UARTB's which share the clock enable with
> > VFIR.
> >=20
>=20
> Ah.. the correct fix for this is to initialize the enable_refcnt based on=
 the
> hw state. This is done in 9619dba8325fce098bbc9ee2911d1b0150fec0c9 for
> periph gate clocks, but obviously also applies to normal periph clocks.

Hi Marcel,

were you going to send a new version with the alternative fix as
suggested by Peter?

Thierry

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XrMACgkQ3SOs138+
s6GXtg/+IuuqToPbfBDICYwJJQ8uXHPGJXDS+Z7bthtYwuqo5M2r3s5Bvnxek+Sn
hGHjVuPBc5vcM/JoD2UrSO086bREgody0yDunjDQdQDCkw1sJ/JM3YUz7amHabkg
mWrEKDaf7k9Xs4KKBHyq67mpgn/WA2+Zyjtp7LX6sYGFaKTe2Qa8NHUtVdh0YKTL
Mie6WfoFjpSkx/YghDIV8WorY8SLa9mN698H2f75HTAWRF2UaVj+VtbGrYWlUWzy
NP14u8Gp4yYqQ/Xv3Lq0rtEDUA8u7QedSh8ICYAPyEUljbi1tVuyeHSjktLHFUrF
bCeqyLgePdq5icyF2ipPmW4kx6Nsy6iMwlbQeDWwg8Dw4WNo6qZPhWwsG/LVCQiq
L30BlkmKG75J4urufG8uRvIKzRNhd9t4ABWVOrbM+XyPB8gE/I3u3WrSvygIyGXl
PL+QWQzUMJMW+PLnGa7ZVEZJn6CwB/fHpxq/HHiNZhPK+v1K1ww54cwRue2+RjXm
A8A4bwXD5A+qU0EWUZZo0mk7TsUgAaeLY5sFI0fEKMNXtL6m2ceOGhipQjA8cVOr
2V2bFCetZJGtPezJVUuhzGEZRd+R46FvhNDkGPA2xQ80Fbenja2DBZs+e78XTrXu
bLnF79vVm+dzUoeV1D/XLaBBzkHJ1mKW/ZFBtQiCJm7G/AT3Zo0=
=cuvx
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
