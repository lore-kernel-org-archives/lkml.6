Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0092620866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyg7EhY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0092620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIJOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:01:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeIJOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:01:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so21028573wre.10;
        Mon, 10 Sep 2018 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5SMEAmgtPH5r28FlBfQ79cJstxcEqCg6dugweJOELPU=;
        b=gyg7EhY7myVCyIPGAB/vnWV5LceSfQHGseo9AQF3ext4/KLF2Ru2V0Q14RsfUroIJ4
         2mqx8vj3KNssVzh1X5ioEbqjr5OMWfLiJS4RUEcIR1N+Esjp+PDHrYMv3MnIV1mgSljC
         E/dETmvCvp3OlwOpAEuqznFGETG3tNOemJvqaTy1TS5/NfLbvel83+JFshKVE4m/GcAT
         Y8W7aAruynjCpwZDD1e3n1YqOIxj7LxXKQOExMcwK3U4xTQ9Mnv8R3GDsYgTfwhS+fQK
         RYXD+oTStj4vga9ZfO6gsBAz1S3mRjBvHtoo8+lmYD23oxiXFI8oRIYfK9W+09Iro+Es
         iD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5SMEAmgtPH5r28FlBfQ79cJstxcEqCg6dugweJOELPU=;
        b=RAqtrYZboCmF+KYrwAx2Rf7hPm4/fAr3hKzy/lz++s1fslSPV7sYFd0v8c7Z6Zacs7
         UuGqC0G6hGS1A4of3sEv1DRtfPj2V3FKr93GeZXwFti4le20BV93UFfk0i3Q6+4u1/If
         n1uR/jM+FZSbisHIvp/s5lhZpJO8WWtYlAiJ3HQQS/uZHEUpySZr9W9OUtHWkW6azsVQ
         bSij1vNx7qHg6ra0Lf80WQ0kffqOBwfwoVdoObEfNN9/T9+nJ7Iiy4WMW/oxMRkoec5j
         zWofjuPXRliDWoPE5J2wF2PLLaiMjQRlpZNPcugl94yFVA9CRAlOHIS0ygIpFuMGSMLl
         KH0w==
X-Gm-Message-State: APzg51AZ2ujrSQRHNFKb5YlXT1ZBy6WcJly3ypFroBIHqciaa6ZTNhbL
        RqhODfZmWKXEB/iUC+oFFIWzRb9q
X-Google-Smtp-Source: ANB0VdbZ8PWCtubRSpysz11WjbN8uWglaWXEn/Ittv7O5E/TwS/Oz9G1RxIhpL5qLcoTxy8siJqjxQ==
X-Received: by 2002:a5d:674d:: with SMTP id l13-v6mr13629644wrw.197.1536570502039;
        Mon, 10 Sep 2018 02:08:22 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id x16-v6sm17000968wrm.69.2018.09.10.02.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:08:21 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:08:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: Split up name & type in modalias generation
Message-ID: <20180910090820.GB702@ulmo>
References: <20180907142247.2931-1-thierry.reding@gmail.com>
 <CAL_JsqJ0VZftZ+Qve+=91tbvgYof68NW+dBf4bPv+b8uQ0y1hg@mail.gmail.com>
 <32ff0b7e-a710-2c23-75ad-8c527d3453c7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <32ff0b7e-a710-2c23-75ad-8c527d3453c7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:56:09PM -0700, Frank Rowand wrote:
> On 09/07/18 11:49, Rob Herring wrote:
> > On Fri, Sep 7, 2018 at 9:22 AM Thierry Reding <thierry.reding@gmail.com=
> wrote:
> >>
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> The kernel's vsnprintf() implementation discards all alpha-numeric
> >> characters following a %p conversion specifier. This is done in order =
to
> >> generically skip any of the various modifiers that the kernel supports.
> >> Unfortunately, the OF modalias is generated with a format string that
> >> violates the assumption made by vsnprintf():
> >>
> >>         of:N%pOFnT%s
> >>
> >> While processing the above format string, vsnprintf() will eat the 'T'
> >> character, assuming that it belongs to the preceeding %p specifier. Th=
is
> >> results in a modalias with an incompatible format, which in turn causes
> >> the automatic loading of drivers based on modalias to no longer work.
> >>
> >> To fix this, split up the generation of the name & type fields into two
> >> separate snprintf() calls to avoid confusing the parser.
> >>
> >> Fixes: 73813f8483b1 ("of: Convert to using %pOFn instead of device_nod=
e.name")
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >> Note that a more elegant fix would be to make the %p format specifier
> >> parser report back the exact number of characters consumed. I briefly
> >> tried to implement it, but quickly ran into numerous special cases
> >> that make this solution rather involved.
> >>
> >> I can spend some more time to improve this in general if that's what we
> >> ultimately want, but I think this patch is a better short-term fix to
> >> workaround the issue.
> >=20
> > See my reply on the original patch. I've updated the patch in my
> > dt/next branch with the fix to use %c.
> >=20
> > Rob
> >=20
>=20
> Agreed, your updated patch is more compact and looks cleaner.

Not sure about "cleaner", but yeah, that works as well.

Thierry

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluWNIQACgkQ3SOs138+
s6FxtA/8CkU+Oilip3vkyQ8zmTV9Xx9m9Vu3e9+JcvWaGt2cY/xNd6ALpt7KsTm4
K10jW+Jam9u4KPN6IeIHQD6bFgOxU9BJewEFA4WmKE2cO2ttlsNIApgqBFuSrwOX
xR/mUXUGrIX9vtw7Bg2vjiCzX6eSjJt7XsFMVOD/P7aMSeMyv5p8/Qwcmh7/t4rj
iZ64lB194AdtcR/7gdBXiOtpu9R5NFWZSjcwIiln0cHpsW7vzzIhLfqMKwEJ0E0F
Iolfc3FqnxWO+Iv43Fqhh9rtqjuYrJfECGN38fNkxa/8SblEUMrVi2+tWhBiie6J
NGope74WcAulWExj4j2dDAFVxCEcMnqdg9rrUYZiNr5JhQhrxzM1Lbn0UQfaACli
fn9VnlRaF1PvXxgUb/3J29GKsdI3OzS2YFuPRdFjFyXff+k2iJsjapOCUvC+p/M8
IDrs/ms1ouaZCRxPWSpazM3+28Eh20nUB9f8KuerdqMIwOsaKPgPVd7aiZURFvBV
trRB1CDBeGA+s6cZxQzyHDeRkDjGLersietcfjBShEhhS4Wthahr2tYGwxdB81+y
/rxQdxHTZnQy3AqDoEMRZSxnazpk6W7hxuEuUX/DKDOHW0nodvPlIJNnsdiEyIyp
Fc2bLClevU0Ha5cS6HPfw5H2+IgnVkWGgQcreIQ/VLkBS8uMNOs=
=03b9
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
