Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D01C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6772089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6772089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJPAAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:00:30 -0400
Received: from anholt.net ([50.246.234.109]:35042 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJPAAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:00:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CA15710A1218;
        Mon, 15 Oct 2018 09:14:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KL83Lz81Pikl; Mon, 15 Oct 2018 09:14:35 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8514E10A0A02;
        Mon, 15 Oct 2018 09:14:35 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E489A2FE1B6A; Mon, 15 Oct 2018 09:14:34 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        phil@raspberrypi.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
In-Reply-To: <1715113043.52878.1538821118324@email.1und1.de>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi> <1715113043.52878.1538821118324@email.1und1.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 15 Oct 2018 09:14:34 -0700
Message-ID: <87a7nf5gr9.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Tuomas,
>
>> Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 11:=
37 geschrieben:
>>=20
>>=20
>> Drop various pieces of dead code from here and there to get rid of
>> the remaining users of VCHI_CONNECTION_T. After that we get to drop
>> entire header files worth of unused code.
>>=20
>> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
>> snd-bcm2835 can still play analog audio just fine.
>>=20
>
> thanks and i'm fine with your patch series:
>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Unfortunately this would break compilation of the downstream vchi
> drivers like vcsm [1]. Personally i don't want to maintain another
> one, because i cannot see the gain of the resulting effort.
>
> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/b=
roadcom/vc_sm

I think the main concern would be if we removed things necessary for
6by9's new vcsm (the one that will let us do dma-buf sharing between
media decode and DRM).

On the other hand, git revert is a thing, so it's not like we actually
lose anything.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvEvOoACgkQtdYpNtH8
nujIzA/9H7tZqvMJ5d3G9UNFSfE/y1x0Abd8+K3HxMM5ywJ2Xwfc1153310dYv/Y
ey/DCIpSHdF+QX8A/e7qu0W5FGKIhw0GKzKdDk/Tqi4DAHvq5DKNkDN7q78DkNk4
ER461j8EohBSPkuByi9M60AQMgWcgmakQyeS0Qs3epI8H1VwjFBuaccaYhsLR4I2
gZzm1pTqjhDu+c3qTCNQyL/mpFRJjVfSdUNd+zIKYPTaVIT2JNgPA4DAEVkHxV02
OOBw/CV7ih/yXqx6AvmHiVRSCVIgXHtQ1U2FEpa4fcjrsbgjvWmqnJcm2NucoL/c
VPWZPS/Cjq9UxhBunK+XWbTISR2xr97j6UGLw5TOvNjYMD/J+T6g+vGJ5Qt8CtmX
b5E9bNwak78BALt3thhE3hMCzpnIepeDZLnN41KdLeJHnTmBBtkxXsdEQkggCnvF
8b5flze24JQ2OM3SJJE133usqA8pIf5BuWucQId19eEdQh6ZoxVJQtYVIcVv7qH3
q+j4HS4crEOvP+vGBo+hw++l7sxwI99iTVlNRyBT0yO7Sii3zQVKX0z0AJFhGGLz
oDjK4Rj931YH4l8Qsf/XsVbkY4e4cnHXH+ponmZ+uy1UaJZFSd99pVmd5EjT0wh6
L+VjFuU9LZCxXK7N7gSCUrD16xHXD65GmUI59foazP8L1nqdcvs=
=zzIW
-----END PGP SIGNATURE-----
--=-=-=--
