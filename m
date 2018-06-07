Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dGApKuOxGFt0TwAAmS7hNA
	; Thu, 07 Jun 2018 04:19:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E8DA9608D2; Thu,  7 Jun 2018 04:19:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k3YFaHJG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F8F26089E;
	Thu,  7 Jun 2018 04:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F8F26089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeFGETL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:19:11 -0400
Received: from ozlabs.org ([203.11.71.1]:42071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbeFGETK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:19:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 411XNn30nzz9s2t;
        Thu,  7 Jun 2018 14:19:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528345147;
        bh=EycXhSnvnD16TXNcds13ajBmNZT5TRRx5Oeu5U7e34k=;
        h=Date:From:To:Cc:Subject:From;
        b=k3YFaHJGXgKlnY/SOVw7kT+/QbtWY3HEtP/BQUAgJlrZmlZgag9HofXLa4auOd/Yu
         qiRw02hvi9B831FJGqYN+uaoAeoIQTPkTVUx3fTeNUn9S1mVVdMWh7WgtjBdPWy2PI
         K6lcaPbQDlezj4Qp+Lc+t8ic/ULOJ9C9Cwk9RYrkH8E2P6j5VjfXTjtPA38q/48h4j
         6aKl4XEZRwzM/5Dvi1sSOkNc1UooON44oQKfZafZ6BIhUDyDiET4FyE+oNjFlTKM81
         Zln+7qRmQxmn2F5xJWRWJ3G50uoR2tt0N0lAmVmkqKjojc9C7Eipx9Zv+z5pjhWLgF
         aVeDElErohE3A==
Date: Thu, 7 Jun 2018 14:19:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: linux-next: manual merge of the nvdimm tree with the tip tree
Message-ID: <20180607141904.701b8061@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L3tyTh5XHWRzf_y1_xg_mtu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L3tyTh5XHWRzf_y1_xg_mtu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nvdimm tree got a conflict in:

  kernel/Makefile

between commit:

  d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

from the tip tree and commit:

  5981690ddb8f ("memremap: split devm_memremap_pages() and memremap() infra=
structure")

from the nvdimm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/Makefile
index 7085c841c413,9b9241361311..000000000000
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@@ -112,8 -112,8 +112,9 @@@ obj-$(CONFIG_JUMP_LABEL) +=3D jump_label.
  obj-$(CONFIG_CONTEXT_TRACKING) +=3D context_tracking.o
  obj-$(CONFIG_TORTURE_TEST) +=3D torture.o
 =20
- obj-$(CONFIG_HAS_IOMEM) +=3D memremap.o
+ obj-$(CONFIG_HAS_IOMEM) +=3D iomem.o
+ obj-$(CONFIG_ZONE_DEVICE) +=3D memremap.o
 +obj-$(CONFIG_RSEQ) +=3D rseq.o
 =20
  $(obj)/configs.o: $(obj)/config_data.h
 =20

--Sig_/L3tyTh5XHWRzf_y1_xg_mtu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsYsjgACgkQAVBC80lX
0GxCmAf/b/ylZzlwBAB6Cbvfg2NuRo4P2oWxKC6Se71d2MWfWJ30GwbKjs0AgshJ
RDhAVxbhysnCfWiiUhkXVPNiXcrL8jUTGdjRu8lEV3FRFUB/r+AwtmmPFTD4BlWC
0jqIs0rMyYFnPxHB3m/oPxHd4kltwq1yjrsMQbsF8qq8WR98EY8arjyXRc43//6s
t6pVHD+2q3kmcFrtJn8Qedj1MvoObvdEw8FEuzmlvIfs/cMSNthwP/GStnipQl+Y
FaTPkfOAMF2RZf9kZgqG+ICOkBfquCrI101tg5WiZSebO7L/qA2Hl8DjwRt8/oNj
rQ/ciEbxsRnSmAXlDSwVJSD+WOjenw==
=jRe3
-----END PGP SIGNATURE-----

--Sig_/L3tyTh5XHWRzf_y1_xg_mtu--
