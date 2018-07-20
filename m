Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0545ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B37D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dw73zpDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B37D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeGTE2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:28:32 -0400
Received: from ozlabs.org ([203.11.71.1]:58999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeGTE2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:28:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WxXX5Kknz9s2x;
        Fri, 20 Jul 2018 13:42:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532058140;
        bh=TSXgwUSNIf2JVvhekw6xQuY0ED1lWViLgwxL+Fhr0Xw=;
        h=Date:From:To:Cc:Subject:From;
        b=Dw73zpDuyi8BBWXBu0ILxtTuYq1lpkPh7Hi0wYuVIyZxUgFXGvQY/fn/HPyUZOfT3
         VZ1M3bc4T0swUOyu4G10SGcSgRqi8pGHftSlWh45uhsJIOk0femM1m9jDApiHwIej2
         DzQJwakaKloO7Cei7cKO0aw6LqXynRStGBuAgyJ9Qx2EFYVwmwYBupptgKvo83aCOj
         5FT1mVDSHkfSXTbmFRPqChp4gFdaCdmN8aBUq6WeN7VPJxbBEQCIoA05Oz5Zt2iyk8
         lgwMyivivk0gM8Va3D5O5j5TB44YdLiH6WAfzoNJrytXRvydFBH4U3Pe7aRBoxrb27
         ssE6xTPDnADlQ==
Date:   Fri, 20 Jul 2018 13:42:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: linux-next: manual merge of the mfd tree with the sound tree
Message-ID: <20180720134219.680ae314@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5JD4bK+5wTLCMckjOCK2b9e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5JD4bK+5wTLCMckjOCK2b9e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/gpu/drm/i915/Kconfig

between commit:

  a57942bfdd61 ("ALSA: hda: Make audio component support more generic")

from the sound tree and commit:

  9c229127aee2 ("drm/i915: hdmi: add CEC notifier to intel_hdmi")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/Kconfig
index 5c607f2c707b,2d65d567d5d1..000000000000
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@@ -23,7 -23,7 +23,8 @@@ config DRM_I91
  	select SYNC_FILE
  	select IOSF_MBI
  	select CRC32
 +	select SND_HDA_I915 if SND_HDA_CORE
+ 	select CEC_CORE if CEC_NOTIFIER
  	help
  	  Choose this option if you have a system that has "Intel Graphics
  	  Media Accelerator" or "HD Graphics" integrated graphics,

--Sig_/5JD4bK+5wTLCMckjOCK2b9e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRWhsACgkQAVBC80lX
0GyWpgf+OPe3aiUyVE8K7aSjJluHBiq3EtdDeBYh4fVkvgwCgBM4Tg/X2nrnctpk
g2inYr6Jo0BPG009ePaYvBF/QnEYMB0CzFc5x1AZh8Xi3qaPvTpCaCCPQGdJeJPF
Wlf/FymBUuFI+glD/g6AqXP1kbosTxzGQygxY0P1Zovo4bmy/TqEkhavhajzqd9T
PQEvI8DdyBCPe4abwJdQRAtYTOIeCfYaa/zlBDm9Wwg4tRTTxDRCgkijvgARsT89
3EelS7u5U16DsN6w+/sA6UDF0eaBF9nGzytYG+3l0/AQyae0WcVHPpY1TLIuMisx
sQfYOyPWsWvjkGyH35+X5Yi18RVNlw==
=IeSq
-----END PGP SIGNATURE-----

--Sig_/5JD4bK+5wTLCMckjOCK2b9e--
