Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7D9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0018320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SchPm+iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0018320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGXHIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:08:47 -0400
Received: from ozlabs.org ([203.11.71.1]:59487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388207AbeGXHIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:08:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZSV548QTz9s2M;
        Tue, 24 Jul 2018 16:03:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532412237;
        bh=MYO88e37b605TAYqYyyCwav8qao7TKhmBdlhKG6D3oQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SchPm+iYC8TtaS8pbUitFMYJPXPfgHbpAoGBT/MOo9P0vQgR5U2PgwMwpXc0xbU+o
         b736yAFgXsLDcAFflsX3gKmXiCMyhXT76e0pQeKrlOQ940i9s7tps2TwUMjWFcJAlF
         1Dr6OoDa9RIImZbwJH18HLqfvaxN68ja71pKZMmEdZIgGZvkWe4rwoDbFn5b0LnJPl
         5HW5Gx3ffj8Q6mD0g1Dl24+LmY5IBN8K7GOzRpFBVwA4B2uYvVoNRurR1akgTz1Vbb
         VcH8YZ97X+AOQMDBodPyYhvH0CbwjLK/xdUnhRh7PlycLLyPKMV3Z013cD0p5NU5nu
         oIUV3O6n1qzvg==
Date:   Tue, 24 Jul 2018 16:03:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the fsi tree
Message-ID: <20180724160356.7f5a018d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WqxBh6ysu54ywQm7mPM.b+i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WqxBh6ysu54ywQm7mPM.b+i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

After merging the fsi tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

In file included from include/linux/printk.h:336:0,
                 from include/linux/kernel.h:14,
                 from include/linux/delay.h:22,
                 from drivers/fsi/fsi-master-ast-cf.c:8:
drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_read':
drivers/fsi/fsi-master-ast-cf.c:609:23: warning: format '%u' expects argume=
nt of type 'unsigned int', but argument 6 has type 'size_t {aka long unsign=
ed int}' [-Wformat=3D]
  dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
                       ^
include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic=
_dev_dbg'
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                       ^~~
include/linux/device.h:1428:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
drivers/fsi/fsi-master-ast-cf.c:609:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
  ^~~~~~~
drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_write':
drivers/fsi/fsi-master-ast-cf.c:634:23: warning: format '%u' expects argume=
nt of type 'unsigned int', but argument 6 has type 'size_t {aka long unsign=
ed int}' [-Wformat=3D]
  dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
                       ^
include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic=
_dev_dbg'
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                       ^~~
include/linux/device.h:1428:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
drivers/fsi/fsi-master-ast-cf.c:634:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
  ^~~~~~~

Introduced by commit

  6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFi=
re")

--=20
Cheers,
Stephen Rothwell

--Sig_/WqxBh6ysu54ywQm7mPM.b+i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltWwUwACgkQAVBC80lX
0Gz3HAf/Ucki1Bzw1wcwaHLY51E4H6yjqKTZMPeNNj9hpU3iAOHTNp2u1hjprs9T
Fffqsf5GG1hO0SDZ2HoY03cXrFqUlXnS7BZmbWKsHJcXriO8wRN0fq1HD+qeB9sT
1QCFwImzFeQcqMSqlGy+AnD+5dJMwHb91aJ1QWhOpd+4883xe+iLeiySTo75ra2Y
LQq+pjgkOFutuWnTov2CHPamRJIDctvTkfYkccZF9syZt4vELGcCq/ujfNZPaYDd
j7z6gKDPWuzQuJnl0NO4JCQKXxhXn9ARPxOsMWxXmMvwdCt+g03ur5mlGfIy+F2x
7SrtfexRLadFSOYS3ngFdrzYxJnXRg==
=cRpY
-----END PGP SIGNATURE-----

--Sig_/WqxBh6ysu54ywQm7mPM.b+i--
