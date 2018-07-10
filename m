Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB332086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ar0Lizlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB332086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeGJBdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:33:51 -0400
Received: from ozlabs.org ([203.11.71.1]:39175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754597AbeGJBdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:33:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Pl8l3pxhz9rxs;
        Tue, 10 Jul 2018 11:33:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531186423;
        bh=X90ZMNUsOLO+/q0L0ezl9wQ8A2BWNor87E6buf+SKfA=;
        h=Date:From:To:Cc:Subject:From;
        b=Ar0LizlcoJug0WWCtSH/C8q0zsz4GUmuu+zP5RD8V0698ejZBAYcRXdw8mh0HuQUk
         r9Q9Ay8ULnfga0tboI6hrgKzLFX1vCKIDbmGGwRMx38cs4B7gz5mcxanCbIQpEQrdl
         J54bODGL8YTm1a2+sBi3K4pPsMz2NlyAkPV2nCECPNT0Ge8gziaPjd7r2Z8IcFk4Cg
         +BlxRRzDO19+jwUp8WmVoUyeBfhT8roI/lqXORAUVtbw2VTCZDstLDFXMPapedlmZi
         sGMbSYQVfxEW3JApLAnB0JwBavSP3sUFY3QR5RG/N5BoXqf5R7n7X9w0DFod5MmFoo
         Rw7rbseJXj0ew==
Date:   Tue, 10 Jul 2018 11:33:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: linux-next: build warnings after merge of the rdma tree
Message-ID: <20180710113342.605e53e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/f1b5CFzKy9XM64wKgjeAdmJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f1b5CFzKy9XM64wKgjeAdmJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

In file included from include/linux/printk.h:336:0,
                 from include/linux/kernel.h:14,
                 from arch/x86/include/asm/percpu.h:45,
                 from arch/x86/include/asm/current.h:6,
                 from include/linux/mutex.h:14,
                 from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
                 from drivers/infiniband/hw/cxgb4/cq.c:33:
drivers/infiniband/hw/cxgb4/cq.c: In function '__c4iw_poll_cq_one':
include/linux/dynamic_debug.h:127:3: warning: 'cqe.u.gen.wrid_hi' may be us=
ed uninitialized in this function [-Wmaybe-uninitialized]
   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
   ^~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.u.gen.wrid_hi' was decl=
ared here
  struct t4_cqe cqe;
                ^~~
In file included from include/linux/printk.h:336:0,
                 from include/linux/kernel.h:14,
                 from arch/x86/include/asm/percpu.h:45,
                 from arch/x86/include/asm/current.h:6,
                 from include/linux/mutex.h:14,
                 from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
                 from drivers/infiniband/hw/cxgb4/cq.c:33:
include/linux/dynamic_debug.h:127:3: warning: 'cqe.u.gen.wrid_low' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
   ^~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.u.gen.wrid_low' was dec=
lared here
  struct t4_cqe cqe;
                ^~~
In file included from include/linux/printk.h:336:0,
                 from include/linux/kernel.h:14,
                 from arch/x86/include/asm/percpu.h:45,
                 from arch/x86/include/asm/current.h:6,
                 from include/linux/mutex.h:14,
                 from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
                 from drivers/infiniband/hw/cxgb4/cq.c:33:
include/linux/dynamic_debug.h:127:3: warning: 'cqe.len' may be used uniniti=
alized in this function [-Wmaybe-uninitialized]
   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
   ^~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.len' was declared here
  struct t4_cqe cqe;
                ^~~

Introduced by commit

  4ab39e2f98f2 ("RDMA/cxgb4: Make c4iw_poll_cq_one() easier to analyze")

Again, I can't easily tell if these are false positives or not.

--=20
Cheers,
Stephen Rothwell

--Sig_/f1b5CFzKy9XM64wKgjeAdmJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEDPYACgkQAVBC80lX
0GzUVAf9FjuBtyhILSITkzHBuATTHFS9pKAzuQP/CoZqlql23kcZ3z68XJyaKf39
YzILhidXgvA93oqDZCfv9zrbLT0+tPrYhDm64+uQZ/ZJGyELHNd7FsURSUQ1Ind7
mndZvA7bRV5FWJmXFksgEyJXnHVKl4TE9BxEORmhNgZG4yK3ndTkgRqqTXTvHZBN
5cMjorezOA6ichh+6IJZuMQ//ZGR8UHrVMhDBk3+WqDQ3DiUBU+f0ZyxKVxd1WwB
p9/CcikWxr+3o0ALb586cUipP/n414Ef759ig5ZHZk/V8/c09aWXwoB303KeD33q
1GkcIZJ3kktMC7vY81At5jdLiISt9A==
=CqmQ
-----END PGP SIGNATURE-----

--Sig_/f1b5CFzKy9XM64wKgjeAdmJ--
