Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeBRXct (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:32:49 -0500
Received: from ozlabs.org ([103.22.144.67]:46721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbeBRXcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:32:47 -0500
Date: Mon, 19 Feb 2018 10:32:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180219103245.54d9ec8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HHneoNZw+Ka6R4tOP6DTBdA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HHneoNZw+Ka6R4tOP6DTBdA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_da7219_init':
sound/soc/amd/acp-da7219-max98357a.c:79:22: error: passing argument 1 of 'd=
a7219_aad_jack_det' from incompatible pointer type [-Werror=3Dincompatible-=
pointer-types]
  da7219_aad_jack_det(codec, &cz_jack);
                      ^~~~~
In file included from sound/soc/amd/acp-da7219-max98357a.c:38:0:
sound/soc/amd/../codecs/da7219-aad.h:209:6: note: expected 'struct snd_soc_=
component *' but argument is of type 'struct snd_soc_codec *'
 void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_s=
oc_jack *jack);
      ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
sound/soc/intel/boards/kbl_da7219_max98357a.c: In function 'kabylake_da7219=
_codec_init':
sound/soc/intel/boards/kbl_da7219_max98357a.c:194:22: error: passing argume=
nt 1 of 'da7219_aad_jack_det' from incompatible pointer type [-Werror=3Dinc=
ompatible-pointer-types]
  da7219_aad_jack_det(codec, &ctx->kabylake_headset);
                      ^~~~~
In file included from sound/soc/intel/boards/kbl_da7219_max98357a.c:23:0:
sound/soc/intel/boards/../../codecs/da7219-aad.h:209:6: note: expected 'str=
uct snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
 void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_s=
oc_jack *jack);
      ^~~~~~~~~~~~~~~~~~~
sound/soc/intel/boards/kbl_da7219_max98357a.c: In function 'kabylake_card_l=
ate_probe':
sound/soc/intel/boards/kbl_da7219_max98357a.c:552:34: error: passing argume=
nt 1 of 'hdac_hdmi_jack_port_init' from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
  return hdac_hdmi_jack_port_init(codec, &card->dapm);
                                  ^~~~~
In file included from sound/soc/intel/boards/kbl_da7219_max98357a.c:21:0:
sound/soc/intel/boards/../../codecs/hdac_hdmi.h:8:5: note: expected 'struct=
 snd_soc_component *' but argument is of type 'struct snd_soc_codec *'
 int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
     ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commits

  608a300fc1f0 ("ASoC: AMD: Add machine driver for ST DA7219 MAX98357")
  b3ea70ee64ea ("ASoC: Intel: Add Kabylake-y Dialog Maxim machine driver")

interacting with commit

  451011221711 ("ASoC: hdac_hdmi/nau8825/rt286/rt298/rt5663/da7219: replace=
 codec to component")

I have used the sound-asoc tree from next-20180216 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HHneoNZw+Ka6R4tOP6DTBdA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqKDR0ACgkQAVBC80lX
0Gxu9ggAmswgSddAdO27Y5jYHhw3RWntXiPlnEtdbng+8lpKSqhao+CKpsjEy2xw
i4d1pf1nKgbVFrpCaBuU4Rh6M3ZYl/KpbdmYVV2f7Mj5T0keNtYjenNzgf4eeKF4
TeuS3VKLt1Ch6wr5ZJh1pZ4PnUJUGX4jdTNbGBwq5EQRm96VvGUBCdb37JAng4zp
3zO7HQ3/ThB+YY74l7nJQVIYQBA7RlGrbH/8Z2F92Lk+B2P9n/Gc+EATaM8xgw6q
h1edLdClXcuuiSe3859q9NmU7pnZbPB5aiorsNQ24fKkEZt+YURaUbSj9n9Y9fnZ
4hzq8xgpu+aUuZGLGYK7r+XaNvzCQA==
=lFbI
-----END PGP SIGNATURE-----

--Sig_/HHneoNZw+Ka6R4tOP6DTBdA--
