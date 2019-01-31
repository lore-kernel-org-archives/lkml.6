Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e7MhdO1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfAaFjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:39:00 -0500
Received: from ozlabs.org ([203.11.71.1]:54969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfAaFi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:38:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qpv341WSz9sBb;
        Thu, 31 Jan 2019 16:38:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548913135;
        bh=QbRkFz2eSuxgAk/k8V5DjMoNfUAh9wTJI0QF91SW+nA=;
        h=Date:From:To:Cc:Subject:From;
        b=e7MhdO1idGS0ykWNXq09oeqGBKEkUA7yjhFtb1nrbXhEeEn9q4ULgkwZrDuWxYp4D
         62OXn08eFvWbjZqa673uPByamKIKR7ujYZMIZQqDnSTsKs7jXrUtdCfuVJDMn2NNqa
         4dKsjWI5Lc55kLdrbd0hvK3D9N5Y/cUMUb1uZijj+8bcHOxTaV0Me6XaoJK8p243qR
         BZtnUy+zh/hnDafc1ugdeohCQai5ZpwBRJqLPPte6ErS97JWHzSK2k9kj1HI6KEB1Z
         jL6o+0Aor2A0ZCxhtp16lUZD0i8ip1cHu2OFTHMMRqfz1F92XMVQW620aPR9I7QuuD
         +f3WyJJobEDBw==
Date:   Thu, 31 Jan 2019 16:38:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: powerpcle qemu boot failure after merge of the akpm
 tree
Message-ID: <20190131163854.307e17ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ntkEG4.kWchexs_2hOHxgT1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ntkEG4.kWchexs_2hOHxgT1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[I am guessing that is is something in Andrew's tree that has caused
this.]

My qemu boot of the powerpc pseries_le_defconfig config failed like this:

htab_hash_mask    =3D 0x1ffff
-----------------------------------------------------
numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 21474836=
48 bytes align=3D0x10000 nid=3D0 from=3Dfffffffffffffff
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
Call Trace:
[c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliable)
[c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
[c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
[c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
[c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
[c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
[c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
[c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c

--=20
Cheers,
Stephen Rothwell

--Sig_/ntkEG4.kWchexs_2hOHxgT1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSie4ACgkQAVBC80lX
0GyoNwf8D5nWY24NFrP/NjzcK9jc58lkkCPf1DekarNUeR5vdhoLXoFXw4v1ShJz
EXdvMvCwmCG6eAVANIyRxPpZIwUEKPYOmRE0nP5SIUBoPPt04WLB70SPmPFeaECL
3CBDDSB8ZkTYLXTRHCWKfwYIHzvktXqf7gTSG73gxTaOv+4bHh3MA3jRZ/3WQJ7/
EA0m/G3nsfZWVrjyKbiaA0ONS/QRN9tYkMtnrV8S/DVE/U06eSrSeJeKpYZA1FDr
zPijbbOEY87VgncKCVw/0DOZjdttM/k7uMyR6Gk15ZjbPa2w11IgrbX9MD2zo2tx
Pm4vgyN0qKKrRuZePOflXndb5x5PNQ==
=bVoJ
-----END PGP SIGNATURE-----

--Sig_/ntkEG4.kWchexs_2hOHxgT1--
