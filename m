Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OAEj49SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D5A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPGnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:43:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeJPGnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:43:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Yv242bRRz9s1x;
        Tue, 16 Oct 2018 09:56:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539644188;
        bh=8h+jYTVvMYkLhjI1qv9haok84gasRanz1+ihMfLDfmM=;
        h=Date:From:To:Cc:Subject:From;
        b=OAEj49SYClwQZgOyI8yU/vBAg0GwkhT9+0068t8Dba4rc8YMhsyn7GcryGEnHYKEy
         hgaDm7OnsQhwBdUiYf6SUVf8UOY+ukgB3khnRDhkAPb4Dv9UWL1vesLf0rhpMktQxx
         rpI7jREYJYz2kqhQmMsT0A9gkTYJ67brPzTTlZXGOv8IUkAw3wS+WHpbtc6avUtmkw
         Ggqq5710Cw3efwy4TkuodMJiDIUMpqu3BYdl6u0phTwHfPYKXQu3hxk4tbLwio3wpU
         wujP4gZZYwFS5LNoqDls33NVVa3IcIxD/cDBj3UUYFMBy4ju6f6VkwAKPU7VXYyRis
         GRH96zvPY8Q5Q==
Date:   Tue, 16 Oct 2018 09:56:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the jc_docs tree with the pci tree
Message-ID: <20181016095612.36b5e7bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h/26W0fuzPBTdFRLUBNkVJm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h/26W0fuzPBTdFRLUBNkVJm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/driver-api/index.rst

between commit:

  7618a41f1a25 ("docs-rst: Add a new directory for PCI documentation")

from the pci tree and commit:

  ea2ae0ecc9ad ("FireWire: add a Documentation driver-api chapter")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/driver-api/index.rst
index e9e7d24169cf,1f0cdba2b2bf..000000000000
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@@ -29,7 -29,8 +29,8 @@@ available subsections can be seen below
     iio/index
     input
     usb/index
+    firewire
 -   pci
 +   pci/index
     spi
     i2c
     hsi

--Sig_/h/26W0fuzPBTdFRLUBNkVJm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFGwwACgkQAVBC80lX
0GxWYwf+N+0E8MBZaAMYtf2UIoUGlDW28VykzexxXw8mQSt+CkJzZAotCJzPPNa8
k/IPFiG2tkSVS2olPJ742reoGxx8VDzyu2vSyPanOrjG3v92HTdI8GmwAr1zFHwd
rsFQnPM5t7qGU+2V2AakPICZrAe5Hzvd7RWX0EDwYil+U/woENAQ5srsHrfdPFlu
3UmBTNnnVWqsRHVh32nH1b+ew5OArj78+S6HyPnAe4MWl2jliDjIJr1f39XPLJXc
V/kt5Yof20nYm7B4RdX2TwscSdTLPAdn7scp/d35MHrMVm34WF3hqjYgaMkSaaA8
G1pdFKd70StStt0xz1gZ0Co+aHJJzw==
=vqYC
-----END PGP SIGNATURE-----

--Sig_/h/26W0fuzPBTdFRLUBNkVJm--
