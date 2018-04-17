Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDQXwk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:52:40 -0400
Received: from ozlabs.org ([203.11.71.1]:44883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeDQXwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:52:39 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 18 Apr 2018 09:51:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180418095113.21c84c83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H2zGha.o3/DcDidRHMxFlv0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H2zGha.o3/DcDidRHMxFlv0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/intel/skylake/skl-topology.c: In function 'skl_fill_sink_instance=
_id':
sound/soc/intel/skylake/skl-topology.c:833:45: error: 'struct skl_kpb_param=
s' has no member named 'u'
   struct skl_mod_inst_map *inst =3D kpb_params->u.map;
                                             ^~
sound/soc/intel/skylake/skl-topology.c: In function 'skl_tplg_find_moduleid=
_from_uuid':
sound/soc/intel/skylake/skl-topology.c:953:17: error: 'struct skl_kpb_param=
s' has no member named 'u'
     &uuid_params->u.map_uuid[i].mod_uuid);
                 ^~
sound/soc/intel/skylake/skl-topology.c:959:10: error: 'struct skl_kpb_param=
s' has no member named 'u'
    params->u.map[i].mod_id =3D module_id;
          ^~
sound/soc/intel/skylake/skl-topology.c:960:10: error: 'struct skl_kpb_param=
s' has no member named 'u'
    params->u.map[i].inst_id =3D
          ^~
sound/soc/intel/skylake/skl-topology.c:961:16: error: 'struct skl_kpb_param=
s' has no member named 'u'
     uuid_params->u.map_uuid[i].inst_id;
                ^~
sound/soc/intel/skylake/skl-topology.c: At top level:
sound/soc/intel/skylake/skl-topology.c:3544:5: error: conflicting types for=
 'skl_tplg_init'
 int skl_tplg_init(struct snd_soc_component *component, struct hdac_ext_bus=
 *ebus)
     ^~~~~~~~~~~~~
In file included from sound/soc/intel/skylake/skl-topology.c:27:0:
sound/soc/intel/skylake/skl-topology.h:463:5: note: previous declaration of=
 'skl_tplg_init' was here
 int skl_tplg_init(struct snd_soc_platform *platform,
     ^~~~~~~~~~~~~
sound/soc/intel/skylake/skl-pcm.c: In function 'skl_populate_modules':
sound/soc/intel/skylake/skl-pcm.c:1351:4: error: implicit declaration of fu=
nction 'skl_tplg_add_moduleid_in_bind_params'; did you mean 'skl_tplg_updat=
e_pipe_params'? [-Werror=3Dimplicit-function-declaration]
    skl_tplg_add_moduleid_in_bind_params(skl, w);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    skl_tplg_update_pipe_params
sound/soc/intel/skylake/skl-pcm.c: In function 'skl_platform_soc_probe':
sound/soc/intel/skylake/skl-pcm.c:1372:23: error: passing argument 1 of 'sk=
l_tplg_init' from incompatible pointer type [-Werror=3Dincompatible-pointer=
-types]
   ret =3D skl_tplg_init(component, ebus);
                       ^~~~~~~~~
In file included from sound/soc/intel/skylake/skl-pcm.c:28:0:
sound/soc/intel/skylake/skl-topology.h:463:5: note: expected 'struct snd_so=
c_platform *' but argument is of type 'struct snd_soc_component *'
 int skl_tplg_init(struct snd_soc_platform *platform,
     ^~~~~~~~~~~~~

Caused by commit

  81e9b0a07889 ("ASoC: topology: Give more data to clients via callbacks")

I have used the sound-aoc tree from next-20180416 again today.

--=20
Cheers,
Stephen Rothwell

--Sig_/H2zGha.o3/DcDidRHMxFlv0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrWiHEACgkQAVBC80lX
0GysGgf/QUgfq2mTWjxAM0s0EQLfHlsPGScVODEH7DMd1d9vXnSqtEhIEo1OA32z
BY/jQG+u2hgnhD8Q9Jsa7ho1VX6ReuBLlqmSY+ap8N/wXDi9o3WxQn2Ksk5SYIPJ
Yq0UISTUFLWa7sRUAKDFDgR5X5amw2a5kA1rEK0cjUD00r62J6bNdynm5KqRs/xg
5IezF2lRJbRn6FDcfoWHt2prosgTgXPqx/TR8tnYPjpZEaKF/TOTxL60uKzFkCor
l5hYq3jrKWJjJFoKcSYoeZX0OYiYc5NkzrJAJxnU1GjEN43Des9dYhU8ujRHMxTJ
Jyuvb2vsT4xQ7hFWiG4X7Uz4e/y4kQ==
=497v
-----END PGP SIGNATURE-----

--Sig_/H2zGha.o3/DcDidRHMxFlv0--
