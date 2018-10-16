Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA60C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X8ccg64x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAB5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJPIVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:21:11 -0400
Received: from ozlabs.org ([203.11.71.1]:48029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeJPIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:21:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YxB047Kwz9s8T;
        Tue, 16 Oct 2018 11:33:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539650008;
        bh=prxPTtb9R2mqXVqo7vpbWCxk32aScWP55D5km6gax7s=;
        h=Date:From:To:Cc:Subject:From;
        b=X8ccg64xVbQ225ZlXJd1nGdFbgKbr7C6GulAdBD/fgaqwOJVaPxFXJ50zCCnV4HA9
         zqZ0SjZnTQuJ8qRc9/X4nTeJIAOzxAIvx6eeLKaHJr7HVK7Lohytps3pP7QtGC0VVv
         qLnrcg61Aomy2bQ6GaKu2JyktjNeVLIKSd5feTWE8u0jT1f7a4rvUJOlqTYVqrJMrH
         bSwud4CT3kW6K8h3BcSAeEzpRSgj+R2ucuQXNZ/eaEgr6Y72po8aUFjWbVIzd6rTm5
         z1AuDAmJaVwRECC9TMr4SZThugUVbtra/ffM/uyX8tHKDG/twJnHqpYtdq0bCVqXLR
         rX414+EHLA4lg==
Date:   Tue, 16 Oct 2018 11:33:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: linux-next: manual merge of the block tree with the pci tree
Message-ID: <20181016113327.02ea2317@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F4bvzE/Gpdg7RSm4r2g.Yk2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F4bvzE/Gpdg7RSm4r2g.Yk2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Today's linux-next merge of the block tree got a conflict in:

  include/linux/blkdev.h

between commit:

  113ff970ccda ("block: Add PCI P2P flag for request queue")

from the pci tree and commit:

  cd84a62e0078 ("block, scsi: Change the preempt-only flag into a counter")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/blkdev.h
index c32f7171899b,61207560e826..000000000000
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@@ -698,8 -704,6 +704,7 @@@ struct request_queue=20
  #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk =
*/
  #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
  #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
- #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 +#define QUEUE_FLAG_PCI_P2PDMA  30	/* device supports PCI p2p requests */
 =20
  #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
  				 (1 << QUEUE_FLAG_SAME_COMP)	|	\

--Sig_/F4bvzE/Gpdg7RSm4r2g.Yk2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFMdcACgkQAVBC80lX
0GwX2wf+Kg7aFS1kLmO+eHIz+PR8MNT+eVwcUjn3pFzcGqFYbCKUVUlzz5h/4u5Y
LKWQjCLv6hOeRbB4RMGs7i6Lo6n8t4yf0NXl6s0lXYA4RBJzusJf2i99QuhgCc/6
EhPABu6zq28Eg3eABXu3GerE+3pCiLmhBtHjx/m1RLsHjpMkSgnn4dRSBPQVbhBZ
LRFt1uC3FXmbUlcQC06iSK6G7svyu4Ny09StJRmgv+Cu5XXEamhk8U5SrnLg0VvD
MII3BHUsm3tV+/cL+sVm8CYSHOjpu8sPvHZBhBvvSiGyyMHzgD8eLRBh/7Fj9ww8
m+YJ1YoM5F69+ub4uB9XmriziBnssA==
=5WY/
-----END PGP SIGNATURE-----

--Sig_/F4bvzE/Gpdg7RSm4r2g.Yk2--
