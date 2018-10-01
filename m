Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235DDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17802084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LczL+K6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17802084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbeJBFP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:15:27 -0400
Received: from ozlabs.org ([203.11.71.1]:46445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJBFP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:15:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PHDC4TtHz9s3l;
        Tue,  2 Oct 2018 08:35:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538433323;
        bh=WNkrlg5XmptQsClbl5sKJz36BrBoAwiELegUKKWJ1YE=;
        h=Date:From:To:Cc:Subject:From;
        b=LczL+K6LmJW8p+MFBagh562l/apQWKY1g9LDKr5VL8kOs1Zer7PnrZQleHTLGUnFA
         oGjM0Q0udGXo15kRNCVj98CyVs6z3I5BEHeM0seyp5u+JCZSF4vZxg/+wcTnyyXURc
         Q5FSEIHPqjs55EHlgjqaFls51zzxFNUr4I3DGqdSuekCOHxOJUUzuVmJrFTVQP+AFh
         t2MO5+ysu/cS0bojdrA+HB1M56H69MAjocbo8gY3LvqRh61NyvmrnONoWuafAMJJXO
         SYQzY/AFGldUTKl1xDcpakEcqvTNUPaCgpab1FbBo7yEISJ6UlD2keNlBtihAmQ77O
         yWsP+9p4NAapg==
Date:   Tue, 2 Oct 2018 08:35:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the dma-mapping tree
Message-ID: <20181002083517.1807848f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yz89m_hRQyoF9ou0R1hxWk1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yz89m_hRQyoF9ou0R1hxWk1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

After merging the dma-mapping tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/base/platform.c:1182:12: warning: 'dma_default_get_required_mask' d=
efined but not used [-Wunused-function]
 static u64 dma_default_get_required_mask(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  dma_default_get_required_mask ("dma-mapping: make the get_required_mask m=
ethod available unconditionally")

It is only used in the case ARCH_HAS_DMA_GET_REQUIRED_MASK is not defined.

--=20
Cheers,
Stephen Rothwell

--Sig_/yz89m_hRQyoF9ou0R1hxWk1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluyoSUACgkQAVBC80lX
0GyNFAgApnKu/WiOJ9KOcgKaqN7lGP7creL9JROP8x03SX/3svrY6QEZJn0tR/4a
jVNROcwpP/tE1/jhrv0CobT85SuUxLETbCHkC+5BYTMXiOcOyskkBbwyjXSbSRA5
nw2nhuJGvNOj6spWJhmN9TEQK7wqLSUPLc5820Oy/pWE52KubbhDRgF8h+RvZAsd
rXERQVL2m0jSykEhxS23JKA9p0OkoR0AJZ9iZjFHwviXh5GNFMrroeaTXemoIwnz
CnPMaP7L3j04SEv5FuX6DjSTROEly6PeocTlWuAeK1mJVgkGUBa7RZJ42AV2XSjX
ENhcxPyM3YjrKYtW2rF7b99yQHH5HQ==
=fO6V
-----END PGP SIGNATURE-----

--Sig_/yz89m_hRQyoF9ou0R1hxWk1--
