Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V4zXZS0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfAJWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:30:20 -0500
Received: from ozlabs.org ([203.11.71.1]:52961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfAJWaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:30:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bLKh2rXmz9sCr;
        Fri, 11 Jan 2019 09:30:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547159416;
        bh=5haN7Rpaq+kKqv+1PUmOXtWC819W3qlXMQ0aUDGqP5k=;
        h=Date:From:To:Cc:Subject:From;
        b=V4zXZS0b5fssBwcdb0wLbrzq/XIIx13Y1y3r9aT3QOCPWdR6xWBuxXGq3/qNM5HQU
         Uj+GhhKLAS9ejmwzO3TJcD6tOLiNpz3641Xib0l1ooe95/H3tG+i19U9QysJzafdBd
         LWo88Cke4a6+duPDG6JS/DozT5HCAkaUn+9GiurDNxvQroK9o2Qbs3v+CTnWZJ94M9
         dxVe0bBoCkEAlfoX7RyfXslSQpAomTdoQp+NWY/Pr15Fd5umyQW/b6iWE8EmlytMhQ
         SuSJ7380+kxhzkrHT5da9ZFDEeZmk+nYIQ2xZ4wf5mof3CbPvuAwcMaGO3wf4cOCwd
         hw7DqIkkmmrng==
Date:   Fri, 11 Jan 2019 09:30:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <lukma@denx.de>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190111093003.2f00829e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mL+ddRtA3ixjl0kR+FYTqM2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mL+ddRtA3ixjl0kR+FYTqM2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge): /soc/a=
ips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/vf610-bk4.dts:130.8-142.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'


Caused by commit

  cf91ce9696a0 ("ARM: dts: vf610-bk4: Provide support for reading ID code f=
rom MVB device")

--=20
Cheers,
Stephen Rothwell

--Sig_/mL+ddRtA3ixjl0kR+FYTqM2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw3x2sACgkQAVBC80lX
0GzjJAf+IHo5uMYfhpAD6bI4AnG1kIEHOoXUkIlDD5aiD5QjGRmEc+vOmMZ9Y/8+
c2COwfLc9gUnzwd01UnHVWoridLPkBDOBx5vvD6oHj9JCj4HzN8dV5E93MQ8CfVT
0qvRotV3ThwW7e3/fh8L+vqlldlmHUW30IrwwuIrupMKma479WnqCT9Z0yJkzVnr
0ol/D6FGB/A+Gee5ZVId5y5+YoUmPoB/tf+OdM1j+HMmAQNo8omH9qY2HCCHRy9x
W8fJk0cINAmIuRCv/zdDHeq2D5c3BDjsq5U6WjVGfhO6KnYh2jQwlxlamxQgjwRP
0CPci/GlE41ZMFb+r/9eQEuOhKsKRw==
=3Kag
-----END PGP SIGNATURE-----

--Sig_/mL+ddRtA3ixjl0kR+FYTqM2--
