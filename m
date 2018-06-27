Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D70259C6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="peHJBb5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D70259C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeF0WnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:43:12 -0400
Received: from ozlabs.org ([203.11.71.1]:55087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeF0WnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:43:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GHxR4S46z9ryk;
        Thu, 28 Jun 2018 08:43:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530139389;
        bh=G9hGFK/H2MM8brdt5LYjT+WPc2bx25u9QvWmonPhr9U=;
        h=Date:From:To:Cc:Subject:From;
        b=peHJBb5BNKJ5kn8RnZwNPcAto1hfdYgzcXtWy5V6b6t3zyHB1dIMQP9ve6qG1SJKM
         7iICPKto6US8BYQ4TjLMXoeZtPuhjGCJb1dR9w7oXBl32RuUkOeMc9HH2WcIpuHeW1
         lduT3dUO++wbXRln/1/2vwsvbPbMWd/vqJNgNUsWTD43DEf9AJ03W+ATiQ2g1dIAHc
         xB8PLnLObtqMFEtokv413fjMONTSJ2Ho++Km4S1X5H44Hea0s5JthWHbDsJYxqZHyq
         VUhmv1SBCNrl1EGPpuJgiCJEpyOdhP3YEj2K9DvublV3t+KWqmxuhxeJnLQifLO3GJ
         ZPsZ2q9HRTVeg==
Date:   Thu, 28 Jun 2018 08:42:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: linux-next: build failure after merge of the sunxi tree
Message-ID: <20180628084248.3aa1b0fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QVywD+8YQ=QWUU4G1WaRUH/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QVywD+8YQ=QWUU4G1WaRUH/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sunxi tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts:45:=
0:
arch/arm/boot/dts/sun8i-r40.dtsi:47:10: fatal error: dt-bindings/clock/sun8=
i-tcon-top.h: No such file or directory
 #include <dt-bindings/clock/sun8i-tcon-top.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts:44:=
0:
arch/arm/boot/dts/sun8i-r40.dtsi:47:10: fatal error: dt-bindings/clock/sun8=
i-tcon-top.h: No such file or directory
 #include <dt-bindings/clock/sun8i-tcon-top.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  2324106f7e43 ("ARM: dts: sun8i: r40: Add HDMI pipeline")

I have used the sunxi tree from next-20180627 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/QVywD+8YQ=QWUU4G1WaRUH/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls0EugACgkQAVBC80lX
0GyKAgf9G6RElfwsIoRjnob19TaASAOrs0aEjOf4Vv/TDeMtyutFrKSbC5X9JTSk
DXShui1BJ331UPmHSku4NKKEiJf+NHvYvC3ueUu03OJmpSvmIRIxqRFE+G62MwW8
cNp1XKVAC/xjQ0h5qVbxqx2/w3cp1Fd0+92LeSSTUvzjLqxcLqRkD65nYS9q57kJ
GN88NInHMp0bqkyxw41Gt+6kw4VT7XHCOEWYCpE0vkHsnBaBTIrz+wgT+L/0JUat
l0fgZbjLXQFZLowwgYknGyc1Hz5p1zHMGYbpFR+qfJdROmyi0m9WCtpqOOGeuwT9
Eyn8zS9Qjnn9d6A/hex7pzkxnRk96Q==
=Q7Pe
-----END PGP SIGNATURE-----

--Sig_/QVywD+8YQ=QWUU4G1WaRUH/--
