Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D837AC31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A702520989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SrLNNxfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfAUH2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:28:24 -0500
Received: from ozlabs.org ([203.11.71.1]:60347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbfAUH2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:28:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43jXKm6Rw7z9sCr;
        Mon, 21 Jan 2019 11:21:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548030111;
        bh=RhEk9XjfxFBisfuvW4E4ORAL/jvKLKR2fKDS6trssII=;
        h=Date:From:To:Cc:Subject:From;
        b=SrLNNxfshhnrPQfeLDGU91FIkm5aSoUIUh0CDYyycwuBBIfhM9qSXh8hKzTceZs7A
         Mu8dmUFb/CcAKZXbGvdddbhrhBoGFFLP4OSAsiptLtfdx+DvPpfs1k2ROh71bPklkA
         9o5xKygVv0AwbihcL6pSq/zmD9MKQcZVH8BpgJK/V9dWcVxkF9vmTHCglDtiNQ7p6e
         fO887gWewClHNIoQl6Dk5LAMBUf1WlQBIor3vj+jRxZJ0yq8VhkS23QNh3j1MOxsXH
         mac5g2pX70N9lFsFY329dyYCWhtg/tqk2SG46RSiLNTadTGLV9usYvz4I8nzbjtDdL
         q+680o/wBX0KQ==
Date:   Mon, 21 Jan 2019 11:21:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: linux-next: build warning after merge of the sound tree
Message-ID: <20190121112148.591aa586@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i0=jcW/0wXIqaqa5k9yLkpH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i0=jcW/0wXIqaqa5k9yLkpH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

After merging the sound tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

sound/pci/hda/hda_codec.c: In function 'hda_codec_runtime_suspend':
sound/pci/hda/hda_codec.c:2926:18: warning: unused variable 'pcm' [-Wunused=
-variable]
  struct hda_pcm *pcm;
                  ^~~

Introduced by commit

  17bc4815de58 ("ALSA: pci: Remove superfluous snd_pcm_suspend*() calls")

--=20
Cheers,
Stephen Rothwell

--Sig_/i0=jcW/0wXIqaqa5k9yLkpH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxFEJwACgkQAVBC80lX
0Gyk2Af/f91kbIth3V532/gGMTmJk6Pr49NM2M/AeyJrAB1ypLKoy3UaeGOs1VEy
gbS8nH9nHSkha3jyJKdFG3ir+A7jLqzX/dKLLD+806UoaqFOa6OBM2nBj1QGI/Y4
QBQKoD/gF6H9zuBXgW30X9tSIRp1/+twGZ4WsgsdSDfMPhqBGGts2+zesVpcAQFC
HTSyed4tlthe6PbwbSAb/OpMQL8tnJ4BafzS5QxOicM+Q5xxlNvTdPOCbmrvV9ZI
ctgGMjpJ3C+oLVKT9TtQHc8UJO4P03rl3ufmE8PepPJAAz43n+NByWwPcqhhTbN2
YYiNm1Miq3DZX8r5AM/XpJjwb/4yLg==
=6w2p
-----END PGP SIGNATURE-----

--Sig_/i0=jcW/0wXIqaqa5k9yLkpH--
