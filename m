Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853AFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0B520844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tDuofHTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfBEFZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:25:17 -0500
Received: from ozlabs.org ([203.11.71.1]:45145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbfBEFZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 00:25:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ttLx1cwwz9s4Z;
        Tue,  5 Feb 2019 16:25:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549344314;
        bh=ssmkjVj1Z+Huzre2rBRdtSv2fktVXE3PVSjBi1x0inM=;
        h=Date:From:To:Cc:Subject:From;
        b=tDuofHTRElgi4k6RdsBXO9PirYamSzEG7bRTj0123qKhYqtfyY28AuDqTQFdVGmkQ
         +JkHGyMDbEt/61Pjhq02nxb52BcmvXMPdhX27tVOAIb1+vEqoMnq7n59G6F5an9Nm3
         briitV6hIqBP1bn7T9gSMYqAvsJUNdx2TlV+ORchdfUqt2DCyClmzhe+kpCJs9pNM1
         dBZi9KTXahx9M00Z3t5PpuVzyQjp+KjC0WLIkKRVNu8a+mkEcrADL2YZ0jYmgtG0cF
         W9tgpEhFAt3mwdSTu+Sf1rWIHJfMi71ZiVoWV8ek5S2/QViEEJpFvX+bGjiS2ZrAKk
         RDuDXORkTiWxw==
Date:   Tue, 5 Feb 2019 16:25:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the net tree
Message-ID: <20190205162512.696c2c3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eXXShqYv0dL=P/DQLXg5jNk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eXXShqYv0dL=P/DQLXg5jNk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  net/sctp/stream.c

between commit:

  cfe4bd7a257f ("sctp: check and update stream->out_curr when allocating st=
ream_out")

from the net tree and commit:

  2bd3fbb3ff23 ("sctp: convert to genradix")

from the akpm-current tree.

I fixed it up (the latter removed the code modified by the former, so I
did that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eXXShqYv0dL=P/DQLXg5jNk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxZHjgACgkQAVBC80lX
0Gwzdwf6Ao3cgh2wcTap/BLvemTLoGWAlal3etp6kdfmCWBj4iHIHOkOZwtvmjKh
r6kBeMMqqceWkPcBMQ7k5vlmaqyTipf2ziPu87TFDoY0cNOiYK7/waFT6sn+RMwE
O0qY+DhFc7+6Pl3R+KfCqg7gYurQf2bom3DxZsQL5Waa8PWdkn2+GM15DMh35kDw
C6bjSloARhtYLJUiSemxLA0nEVdX0GNicdd4a9KjRd+L1EDBGVMAM62vhW4EZCAr
yP6LlCpna1j/7JUPRrDRMv04KcxhXOSE7Jp9+mbMzGqvV2zuI1Kgl401ynpJM6yn
q4d7l55044kOvmPjySd5bnL1XOIAmQ==
=zbID
-----END PGP SIGNATURE-----

--Sig_/eXXShqYv0dL=P/DQLXg5jNk--
