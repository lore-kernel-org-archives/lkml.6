Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14BC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HiiQVwlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfBYBgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:36:20 -0500
Received: from ozlabs.org ([203.11.71.1]:46659 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfBYBgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 20:36:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4474KW3xFnz9s9y;
        Mon, 25 Feb 2019 12:36:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551058576;
        bh=5D0Pok9c7S0G7IhF+MP9PbpmghFNJVDqX6CJARVsmBs=;
        h=Date:From:To:Cc:Subject:From;
        b=HiiQVwlmWkXfN0wD1Kc5+c8L1rMiSDnWfnnXvELUSX4UN1A7K7SKUr/eGz6O7TQ/Z
         bItZE2MVGnxzHMFXi+fq7CtdBcNAklygcIP07v9ZELUtUAQvzrZ6EkhoAQrtdQ1+CY
         lg1oYJPV1wn3MUpVKY9m0Vj53gf8yNLJKdXs19wRa9gLmS8NVXxabaQVuv8ycjqDFS
         XQKGumgrPMenDrfnImfpMLTmTx3WYLPYfdx4EcIZdP/2VsMXXvXyLJo1YS6TzKC7I9
         duA59KvpkUQQNpeJjLo94FEmxeqVfQGFX8FzhvDwtjJOXsmfYqbaM9HIgsP3s+UiKt
         DBJnvIASxwMMQ==
Date:   Mon, 25 Feb 2019 12:36:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: linux-next: manual merge of the sound tree with the arm-soc tree
Message-ID: <20190225123615.49bce7cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gOUuL6Xp8A/fATV3sl+Fm2t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Today's linux-next merge of the sound tree got conflicts in:

  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi

between commits:

  5eef17ee764d ("arm64: tegra: p2972: Sort nodes properly")
  be4f0dd347ad ("arm64: tegra: p2597: Sort nodes by unit-address")

from the arm-soc tree and commit:

  11ce4308307c ("arm64: tegra: custom name for hda sound card")

from the sound tree.

I fixed it up (see below - in tegra194-p2972-0000.dts. the line added
just needed to be moved up a few lines) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 34a7044927fd,39c616737232..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
diff --cc arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 8780b5b3d2b9,6096dfb7e17a..000000000000
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@@ -1317,15 -1303,6 +1317,16 @@@
  		clock-frequency =3D <100000>;
  	};
 =20
 +	sata@70020000 {
 +		status =3D "okay";
 +		phys =3D <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 +	};
 +
 +	hda@70030000 {
++		nvidia,model =3D "jetson-tx1-hda";
 +		status =3D "okay";
 +	};
 +
  	usb@70090000 {
  		phys =3D <&{/padctl@7009f000/pads/usb2/lanes/usb2-0}>,
  		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-1}>,

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzRo8ACgkQAVBC80lX
0GwojQf/axAwG3MvV2YIiXYaY4KBVgwJ8snq1sGpPg1o3rEOz7ykmsKRHTKXT2nV
u4LWA3nV7wJfFBk+r5CzV3gin4WVnaALVwByfHajr/cm3HKgLYQ7bIDRszV7CTUI
zowX38D7+oYbKVTjOYGs7ET/3u+3q+IKLS8frBt3YLHntkuz6/xXADt2u7v2sEVO
EAO4ru6wQ647NFMJroPUDhsNYULHyjPizvDy0Ii0Kg8lj2Cor8q4xiN79Z314CZb
9FLBj+YhEjygYRKUU8uXuPGFzzI4JxV2VMSTxH8e7gBMk9vw4wakPLNquzCUlA2k
gJv6w966C3F8M5sqf2F3nulFp8ptOA==
=iJlS
-----END PGP SIGNATURE-----

--Sig_/gOUuL6Xp8A/fATV3sl+Fm2t--
