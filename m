Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8619C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63C2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FJKWfJvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLJGRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:17:20 -0500
Received: from ozlabs.org ([203.11.71.1]:37295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeLJGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:17:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CtCK2GFLz9s2P;
        Mon, 10 Dec 2018 17:17:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544422637;
        bh=Hq0tUq/9gZFUoO7PiL63FR2OQWQf/Pef+GvHF9nhtDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FJKWfJvfZeDSNU5K6jVlYDPPAEjNZKo2tkgMloKJgZpWpXAaHf2yowcYI+whYyIl5
         u9bciMKfMbj/wh+dp44oxhOFQ5cEjRMaKsyZ/nJkWZVTOLE/Wciv4GlXYrWeNDV21G
         WNKA/8asaOrt5jcjwQf03g8UZseu+gXBSveh1DwC6hT0yI9TN3/KUdI3tayHbq+Lea
         4MAemL19fl3gm+Y/lE56aUTFa3XjaLzjNNg3DIeNUFdEHmmO5T16TU5N16B2HJse5z
         GsfeNua4AuWT6AkSfqW3lHytv0QiFiGDlOpjqf4tP1KqqWcchsigKcgvd08DB2ardR
         RlJE4bOTke8tw==
Date:   Mon, 10 Dec 2018 17:17:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Bill Kuzeja <William.Kuzeja@stratus.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20181210171716.77cbf9fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.QX.aC5b=vRQG9v3VMFWp5_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.QX.aC5b=vRQG9v3VMFWp5_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/qla2xxx/qla_os.c

between commit:

  f2ffd4e5bc7b ("scsi: qla2xxx: Timeouts occur on surprise removal of QLogi=
c adapter")

from Linus' tree and commit:

  c4e521b654e1 ("scsi: qla2xxx: Split the __qla2x00_abort_all_cmds() functi=
on")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/.QX.aC5b=vRQG9v3VMFWp5_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwOBOwACgkQAVBC80lX
0GxCaggAiC9eDxDQr+82IFhFUHwEP2mzZMc5qErB/+z3ZBTmgzu2y596/BQUk9tg
sd1tTX+FWg4emXgaGXZOOyQajUl/TDqx+X3vbVkKU1/R0Pu9t7cfbqQKHH1r2xN3
1RRZqVARS71H5iikfBphzpQ8Ja8ONC4YzNDGVCcwFSYM4k8Kw9VU7K4B24ZDoPzc
K/D9LpANwS1pw4dJbOxSC62E+CIaumEcfckiW+xlrF7AYQ0SmJElrKH//kc1ugwP
FZpzOWi3Q0g61iQKB/SXYFf/7aOOmGinT9WbliMs7qanjngwgcuOzBscwQmHhNnv
qbIeWUeUo7OnHGO95w6Q9CPy5VaWMw==
=HLOB
-----END PGP SIGNATURE-----

--Sig_/.QX.aC5b=vRQG9v3VMFWp5_--
