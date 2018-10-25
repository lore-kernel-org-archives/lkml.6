Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FC3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D1C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D1C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeJZBDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:03:11 -0400
Received: from anholt.net ([50.246.234.109]:33178 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeJZBDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:03:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6C7B910A12ED;
        Thu, 25 Oct 2018 09:29:39 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 54a1YIt8-CY9; Thu, 25 Oct 2018 09:29:38 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5ED3010A0F99;
        Thu, 25 Oct 2018 09:29:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id F27DD2FE1BF0; Thu, 25 Oct 2018 09:29:37 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5" touchscreen
In-Reply-To: <20181024184313.2967-1-eric@anholt.net>
References: <20181024184313.2967-1-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 25 Oct 2018 09:29:35 -0700
Message-ID: <87h8harnv4.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> I was going to start working on making the vc4 driver work with
> tinydrm panels, but it turned out tinydrm didn't have the panel I had
> previously bought.  So, last night I ported the fbtft staging
> driver over to DRM.
>
> It seems to work (with DT at
> https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
> fbdev works great including rotated, and so does modetest.  However,
> when X11 comes up at 16bpp, I get:
>
> https://photos.app.goo.gl/8tuhzPFFoDGamEfk8
>
> If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
> any ideas?

Also, with these patches and the format modifier patch I just sent, mesa
with vc4 is now working with this driver on this branch:

https://gitlab.freedesktop.org/anholt/mesa/commits/kmsro

Now I wonder how we can improve performance of the SPI updates.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvR73AACgkQtdYpNtH8
nugoeg/9EehIBTfvLB/4Vnb0J//I6yhUw9Sh0Ltb6fVIl+zuFgycl5RH/jWlA3YZ
aGL0xeAsN5HcW5f+QSlOfqZEvAzo+cwFj8ahs1hqgraLRPOxyf6EyZq6+6zN/d7P
HNR3HIY7MS1/efyEmOZQDUsObgFUV6SOVGIKvcCq/cRkUk/Hh5bh9lGkW2LibUuc
2RiQUMtON33CjgYkDbgOCV6pizxjpx9QvmcAsY7rYwwcCdbnzCfscaM5nIQ7fyAd
b1RIko6zdxGC9IlCbzA/3JwQynW66quNbnZ/2fYTLFtoGBvngWg+KGwlQRv+j/Jz
Ujdta8cTT2jRHsYYnNguFWaKkJZcDSkckPBv4fsWXzxO/zl2ddBfhxo9pZ92FGQI
j295TrNkhUZepb76EYzLF3YzMA6HTmRyKZ43IwCjcDcR93L+yBB/DLgbF0+XdZ84
2jgNoFx4/EX2Jkdq+/ihsI/AWYM0bP3fnhH1DEslEniBKNfWEEadn1B/wfxnmWux
Z0fZOaRorIot5u/A/JsxH4K48p0M0/aC572KlQCSj3IIr5MRsWQGDMwhEXzcGK7P
8d4GYsOxlM102p7CJPwZkdxtSoV6gvYAxQ02gX3p9xXtcUUMM7xI71Bl3QndpUw8
TN9akHZ9x+h0m3ZbkG6H1e+ZlRJ+wGmwQw6YQ53v9bG3cGQueZg=
=apgK
-----END PGP SIGNATURE-----
--=-=-=--
