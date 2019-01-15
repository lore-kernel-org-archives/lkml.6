Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39892C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38D720859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xbn+a9Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbfAOUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:34:42 -0500
Received: from ozlabs.org ([203.11.71.1]:44725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389809AbfAOUel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:34:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fMWx1lyPz9sBZ;
        Wed, 16 Jan 2019 07:34:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547584478;
        bh=WW3n4uGPLUkYo8tgzSKIimpKOjXuZ+VDZ4pMwLw+3k8=;
        h=Date:From:To:Cc:Subject:From;
        b=Xbn+a9FqlxRETfzn08ISfC4nJIpSxIrHSkXqHCgsHH2tOhgq1Js5ogh1BZdKZc+ZS
         WZtC4tqx7GGgjxBcqaIetgbm5zGPUzXW2xERvSmDSNRXn+ulymPCgha+NcDFtjnsil
         mYv0yJOLf/TY0LdqDhEFMIrQO94Qg2ARbSPbcSgW6FbJd5qhP8fvNMs42OvIs2kQBL
         +D8vsUJR9577URlTtI7hhqTQF0f3Cv9kMqeDAPerFqhCQ43XW2eZep36n7rowQ0RAt
         zjEMUJF4YlzNG0kzMEbnmDNTDwflLOgKP37f8xHQGG3H/5cXp2Q95AjP6rbrBEMw5P
         GPTYNYk1MKFZQ==
Date:   Wed, 16 Jan 2019 07:34:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg KH <greg@kroah.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: Fixes tag needs work in the usb-gadget tree
Message-ID: <20190116073424.1a091912@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eMEQ0EwfU1dD=pZ8nReOXm/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eMEQ0EwfU1dD=pZ8nReOXm/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi Felipe,

Commit

  4a995e3496de ("usb: dwc2: gadget: Fix Remote Wakeup interrupt bit clearing
Malformed Fixes tag")

has a malformed Fixes tag:

  Fixes: 187c5298a122 ("usb: dwc2: gadget: Add handler for WkupAlert
  interrupt")

It should not be split across to lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/eMEQ0EwfU1dD=pZ8nReOXm/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+Q9AACgkQAVBC80lX
0GxNlgf+OEabwCXDUWRTymZPTUSyHDCNkJo86L5nfdi5POO/NPaTYAVOB3L49Pa6
3MpLtWn+iG6Lgd+SpPKCDC4daAR3rKGk5JeJAnr0a8qFR0NKoi9xOr68D9vIs01t
3ilLOH0Rbi+Sa3515+ZWVraoYQhPEM39NRBGjwfE9Uopg0f+5a70tmSDUwhDIxDh
+3McxZ7vGg10HWPn6ugAWT0vBIoKiDEglOQu59VZtbjDo7SVZlUOD6vpnZxltyuQ
jdUTjDjnNbTKonsdQILAD9gA5W9MW0GKLQgqzJt977wHCc86dPkMgYPZgekmTCwv
CEHOCVUtLIo+1cy6JNIud/UMLLy1/w==
=2Orw
-----END PGP SIGNATURE-----

--Sig_/eMEQ0EwfU1dD=pZ8nReOXm/--
