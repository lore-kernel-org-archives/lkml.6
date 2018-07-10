Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2737C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6622089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BiCqEkf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6622089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeGJB2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:28:39 -0400
Received: from ozlabs.org ([203.11.71.1]:39195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754607AbeGJB2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:28:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Pl2l3rRKz9rxs;
        Tue, 10 Jul 2018 11:28:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531186113;
        bh=ZEQB+neK7YvDcuybQfJNJRI+KLVMN8AI5nzCocVYq18=;
        h=Date:From:To:Cc:Subject:From;
        b=BiCqEkf2CHOnp+FtbtOnkCX6pAHEzW2iCaXSP3dbdKcGwf+kl01WtBSlIYCd89tTZ
         8u1benyR0VBmuT8jtKQOaRZzXWDRBaJE4Hu8SYPHGW+ATikrXIp+tcT0eEXpCI2KId
         apm1bchnZ1zLWAAPvtq54XqZiEicYBuO9IkJKKNjcr0idIJCXyAM4HgEFMUZl3p8Kx
         233tPr+0QP/L77n/yp7JP4LROZMsAnFCJ4RZtghLjqcPCHw6+UMTBUmxfKI9tYgnRt
         FPKGpeWut8VlfyM+qFmq99WvMpCcW0h+zP17KstQf0UcSo7nO787DMPP80Ciz8JCgL
         zJsyDfoH3UTpQ==
Date:   Tue, 10 Jul 2018 11:28:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: linux-next: build warning after merge of the rdma tree
Message-ID: <20180710112831.40add0eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JTUXcpEHUhp==jV4n4.f5.m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JTUXcpEHUhp==jV4n4.f5.m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from include/linux/kernel.h:14:0,
                 from include/asm-generic/bug.h:18,
                 from arch/powerpc/include/asm/bug.h:128,
                 from include/linux/bug.h:5,
                 from arch/powerpc/include/asm/mmu.h:126,
                 from arch/powerpc/include/asm/lppaca.h:36,
                 from arch/powerpc/include/asm/paca.h:21,
                 from arch/powerpc/include/asm/current.h:16,
                 from include/linux/mutex.h:14,
                 from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
                 from drivers/infiniband/hw/cxgb4/cq.c:33:
drivers/infiniband/hw/cxgb4/cq.c: In function '__c4iw_poll_cq_one':
include/linux/printk.h:308:2: warning: 'cqe.header' may be used uninitializ=
ed in this function [-Wmaybe-uninitialized]
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~
drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.header' was declared he=
re
  struct t4_cqe cqe;
                ^~~

Introduced by commit

  4ab39e2f98f2 ("RDMA/cxgb4: Make c4iw_poll_cq_one() easier to analyze")

I can't tell easily if this is a false positive or not.

--=20
Cheers,
Stephen Rothwell

--Sig_/JTUXcpEHUhp==jV4n4.f5.m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEC78ACgkQAVBC80lX
0GyPCAf+IqZk0Sv0KxNnHkDKpk02JHcaxI5+FeOlTfNvhD6i0LUgK6fsviV7NN8M
XE71jz0hsPeywZLRKw8A3WP0xAcN9F1EolfG5pBXkdHIQ0s/HMziLT9qplBREqAt
HkkMgEXX8BBYIObUGF8B73GrEqHRLbeYf7cZtExepvOMLZeFEp2mCzliKpFJuFjc
FIYAZmob6kM77Ns6WlpEmhy80mOkvFNALsSf5dN8+p17kN3PEbE74YQhxBDc4cFI
XP7mlhaD8sFI9abFVh1jwj807615nMe8xi4Jur3LJI+g0miHdOiMKi7mod1jioQ/
Twvb57Xnqk1sdMkIp/4cvlkacCcXew==
=HGmh
-----END PGP SIGNATURE-----

--Sig_/JTUXcpEHUhp==jV4n4.f5.m--
