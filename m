Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163581AbeCAXyu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:54:50 -0500
Received: from ozlabs.org ([103.22.144.67]:50081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163339AbeCAXys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:54:48 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 2 Mar 2018 10:54:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hsu <KCHSU0@nuvoton.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180302105434.16280703@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gQSKj6fy8.fs8IIGtipn.=V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gQSKj6fy8.fs8IIGtipn.=V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/intel/boards/cht_bsw_nau8824.c: In function 'cht_codec_init':
sound/soc/intel/boards/cht_bsw_nau8824.c:137:29: error: passing argument 1 =
of 'nau8824_enable_jack_detect' from incompatible pointer type [-Werror=3Di=
ncompatible-pointer-types]
  nau8824_enable_jack_detect(codec, jack);
                             ^~~~~
In file included from sound/soc/intel/boards/cht_bsw_nau8824.c:31:0:
sound/soc/intel/boards/../../codecs/nau8824.h:474:5: note: expected 'struct=
 snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
 int nau8824_enable_jack_detect(struct snd_soc_component *component,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  5b00ce63e07f ("ASoC: Intel: add nau8824 sound card")

I have used the sound-asoc tree from next-20180301 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/gQSKj6fy8.fs8IIGtipn.=V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqYkroACgkQAVBC80lX
0GycVAgAnrW0u1d0Mv5eaBhZOveujE8flCrQPhXuP+MwUXQLSUmreuh7sQ+dCCrr
RR2xwapD2ZO9oFyDwZiVLoh0Vl+c/Wj87F/UG8P/+w4E3D4YMWdwM/o0RFt1XJOg
vS7dN+A+LysimmxU662IQeitgm4kMXPpOzVFMAbmlpmOZNATG9xkSk2V0PZKFhl8
X32XiRBRnP+Wag7ZsogtCsWwPDqtix9MiMlE0OysOnXhtjOmBcwxm+A2V/JiiZmD
xy1lroHmFoiItORnNS4b64/lwPs8wcVgay2bUOTVOClW1xvpPlDpR12P1oM3ml3v
GiAyePh6ZvDJoiBvUiRpZrC2ddHTUg==
=Z24F
-----END PGP SIGNATURE-----

--Sig_/gQSKj6fy8.fs8IIGtipn.=V--
