Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeCUCbW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:31:22 -0400
Received: from ozlabs.org ([103.22.144.67]:47783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751905AbeCUCbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:31:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 13:30:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180321133040.6754c372@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9GBRwumKv_kUus_VfHV7B_K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9GBRwumKv_kUus_VfHV7B_K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/amd/acp-pcm-dma.c: In function 'acp_dma_open':
sound/soc/amd/acp-pcm-dma.c:714:35: error: 'struct dw_i2s_dev' has no membe=
r named 'i2s_instance'; did you mean 'i2s_base'?
   adata->i2s_play_instance =3D dev->i2s_instance;
                                   ^~~~~~~~~~~~
                                   i2s_base
sound/soc/amd/acp-pcm-dma.c:715:35: error: 'I2S_SP_INSTANCE' undeclared (fi=
rst use in this function); did you mean 'SS_ONSTACK'?
   if (adata->i2s_play_instance =3D=3D I2S_SP_INSTANCE)
                                   ^~~~~~~~~~~~~~~
                                   SS_ONSTACK
sound/soc/amd/acp-pcm-dma.c:715:35: note: each undeclared identifier is rep=
orted only once for each function it appears in
sound/soc/amd/acp-pcm-dma.c:717:40: error: 'I2S_BT_INSTANCE' undeclared (fi=
rst use in this function); did you mean 'I2S_SP_INSTANCE'?
   else if (adata->i2s_play_instance =3D=3D I2S_BT_INSTANCE)
                                        ^~~~~~~~~~~~~~~
                                        I2S_SP_INSTANCE
sound/soc/amd/acp-pcm-dma.c:722:38: error: 'struct dw_i2s_dev' has no membe=
r named 'i2s_instance'; did you mean 'i2s_base'?
   adata->i2s_capture_instance =3D dev->i2s_instance;
                                      ^~~~~~~~~~~~
                                      i2s_base
sound/soc/amd/acp-pcm-dma.c: In function 'acp_dma_close':
sound/soc/amd/acp-pcm-dma.c:1046:8: error: 'I2S_BT_INSTANCE' undeclared (fi=
rst use in this function)
   case I2S_BT_INSTANCE:
        ^~~~~~~~~~~~~~~
sound/soc/amd/acp-pcm-dma.c:1049:8: error: 'I2S_SP_INSTANCE' undeclared (fi=
rst use in this function); did you mean 'I2S_BT_INSTANCE'?
   case I2S_SP_INSTANCE:
        ^~~~~~~~~~~~~~~
        I2S_BT_INSTANCE

Caused by commit

  363fe37948e2 ("ASoC: amd: dma driver changes for BT I2S controller instan=
ce")

I have used the sound-asoc tree from next-20180320 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9GBRwumKv_kUus_VfHV7B_K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqxw9AACgkQAVBC80lX
0Gwf0Af/bF9Ix2oPc9rY2e/QDU2AlUmkn651wPFz4DZJO8CJJ/qV/kF1Dp0NC0we
miZ7e5f5dZsUIpfo6UBFvn0Fk6zV55dyWiY9q/B9gFqf1WAJih4ymncysUcFbt6b
xBsFABOBEp88A9MDpsUb7aKYfCzLYgS1a5zd9RfxntZ77Rg6VUf+Wf4yuaxNorko
N9/6NRpd6vEHnJAOPCdikPeAt0X4rVTKXPmae9QxWyfbwdsxxag02R4b+rLR8Q9p
lVnzvkxUcpKaCpJJkrAPEv5i7YGYiYHRDcsWDUbu9Q3LjXlDs+vlOXIczX7dgyhJ
NiF7n2UBobDZ9Wa+gI0fSmULmCKVYw==
=KSNR
-----END PGP SIGNATURE-----

--Sig_/9GBRwumKv_kUus_VfHV7B_K--
