Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056BC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OOy3qO5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLKWgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:36:35 -0500
Received: from ozlabs.org ([203.11.71.1]:52365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeLKWgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:36:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Dvtm6CvWz9s0t;
        Wed, 12 Dec 2018 09:36:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544567792;
        bh=xGRLCaojgSvV3EaI54TAjN2MfvH7Gn+MT3/3yVNfY1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OOy3qO5X2LzN7xiTvCqTGEg5lAuXPbjDoV42Wg7w6TUd7ECG02t9YOqOYZdOfBIqq
         W9mXRCuc0rS38IaPRQxlyhcO76jEyg94015Q48dknZtK42cgfUMFbvqmYuR1wKhHxQ
         XAPk9lZn7RKkd6LGuO1e6R8yCZY45hcCApdFelcT6E/WvyofVgEYb/Jya7xlE/7/EI
         /WG3N8aSul1Jn5csbrWplee+mOyQn5aveAgQIIxmyqtMnkHzDrKtbiAxyrDqH55GZ0
         xIq4O9nujMwVjePo+Y658COGQZO3iUaeu0EaK7+UheY3U4dQMRjQfRjtDDj1qc86kH
         /22jhgIvGabnA==
Date:   Wed, 12 Dec 2018 09:36:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181212093632.774c0603@canb.auug.org.au>
In-Reply-To: <20181211180437.GA28010@flashbox>
References: <20181211182627.42b79e40@canb.auug.org.au>
        <20181211173851.GA29028@roeck-us.net>
        <20181211180437.GA28010@flashbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bm1qAIv6N5Tmq+0_b_6lQQO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bm1qAIv6N5Tmq+0_b_6lQQO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Dec 2018 11:04:37 -0700 Nathan Chancellor <natechancellor@gmail.=
com> wrote:
>
> On Tue, Dec 11, 2018 at 09:38:51AM -0800, Guenter Roeck wrote:
> > Build results:
> > 	total: 152 pass: 150 fail: 2
> > Failed builds:=20
> > 	arm:allmodconfig=20
> > 	arm64:allmodconfig=20
> > Qemu test results:
> > 	total: 337 pass: 137 fail: 200
> >=20
> > Build failures:
> >=20
> > arm:
> >=20
> > In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
> >                  from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
> > arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> >  =20
>=20
> Just FYI, I noticed this one yesterday on next-20181210 and sent a patch:
> https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@=
gmail.com/

I have added that patch after the v4l-dvb tree for today.  (and cc'd
the v4l-dvb maintainer - who is also the author of the patch in the
Fixes tag ...)
--=20
Cheers,
Stephen Rothwell

--Sig_/bm1qAIv6N5Tmq+0_b_6lQQO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQO/AACgkQAVBC80lX
0GxxxQf+MpmrYFnkcVNJso5Fw/W3SRICtVE1gpAy7SoaKgk589XZpgOMlOPNf5EG
O8BD+6VagYhM4KzDdS3x/keWwth5M6Gfl2ycNbufJZYZuKLA0mjMH/R6XX5YT/zS
bxHUwniXQRfEIoeEOfyIN4ugas2vAm/upfCTKtTjC5DdQWuitZ26a5cnbU0MhWEc
bJow1UWHSeznJzLhLtMnyB0yDp4Pci0Pt6Hyx3C075wFqqwM4pMIdx8VtmGHEPWO
ePPzttady6Xb9jhp2s+7l33/FFmWJAEGs5xBaoQCx0nSzDZelWI11p5Dd6Ek2y0U
JL9vHfAl6N4ALU4+BgCOlMmtxBcYMA==
=9vE3
-----END PGP SIGNATURE-----

--Sig_/bm1qAIv6N5Tmq+0_b_6lQQO--
