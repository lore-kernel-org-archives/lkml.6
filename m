Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E932C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C6B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FLX25Sv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C6B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJLNZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:25:45 -0400
Received: from ozlabs.org ([203.11.71.1]:47593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJLNZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:25:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WcVl0Rk0z9s47;
        Fri, 12 Oct 2018 16:54:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539323695;
        bh=OYvWfvsdF5ovBU4eAej+vZX8cUvRF1SdHZukkmDLmoY=;
        h=Date:From:To:Cc:Subject:From;
        b=FLX25Sv0SiEPPv0zNXlC42j+QEJ2z2yhR4Ww5olHnTDfjxSOpa5Hu1D0ZV8s1sKt5
         4dmGyv1+h9UKtpaWV4mr2CLlQAK/VYnTAmmga5vnhu5G39891e6Ahbh2chkTGhrX2+
         cKfcqUWgwiXiVPonJ/msZBt5xpObasmC6FGmmuUEj++c85EmnbKBSBAlSIVS6pvQLb
         xTl+5XAz9EtCqUDuonImtOaFKw/+mm9fW0DQa0fL6aF5NMzLX6JRgQwwde6iKCQdMP
         e+uwAYgvur7aO3oHT+Cdi9ibjO5faj6sBzjLH8OHN3ZOQdk5KTG600dCf3geqJJcMK
         qKnMSbgp2kGZA==
Date:   Fri, 12 Oct 2018 16:54:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the xarray tree with the nnvdimm-fixes
 tree
Message-ID: <20181012165454.06e718a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ucItC2GgZun5DunlZq4arx."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ucItC2GgZun5DunlZq4arx.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  fs/dax.c

between commit:

  d7782145e1ad ("filesystem-dax: Fix dax_layout_busy_page() livelock")

from the nvdimm-fixes tree and commit:

  0995344c1493 ("dax: Convert dax_layout_busy_page to XArray")

from the xarray tree.

I fixed it up (I just used the latter - please let me know if more id
needed) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ucItC2GgZun5DunlZq4arx.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvANy4ACgkQAVBC80lX
0GwwoQgAn2jVpohp1PLdSxczHpJOFMr7hOCuRPkWcg/SqgKD6MTEJ+bulMUaF54y
iHdxfPUhlfrCJHwUhwdHphbUPyXdWvwJ3qGmU2esCvqPPlNUzDNujA/MfeLiUYz6
BwilCBytI/gk2Q9Jdv41/aTjyK5QWFpUJ8r/vjAvC5IWLVWH5RZ5GlA4X1scdTO3
hfKwVpMUWxVBut+MTRDSz4qXoBuh4ju5eeh8Xdhnab5xObMa7cnNlAxkd9T5nPoK
KZR+33pzK1C+WT/fZWNy6rWQSPRX/nbQIuqZOm7tQyBKHERIcw9I2hDlYGzn1g/d
B/hlTI77fFWWO3vnKu0jowdnRpBCFw==
=NeuP
-----END PGP SIGNATURE-----

--Sig_/ucItC2GgZun5DunlZq4arx.--
