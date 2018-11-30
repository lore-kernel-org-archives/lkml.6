Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7BF20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WhdzBmCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7BF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3Qsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:48:40 -0500
Received: from ozlabs.org ([203.11.71.1]:57949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeK3Qsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:48:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435jsV3gZwz9s8r;
        Fri, 30 Nov 2018 16:40:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543556430;
        bh=56PTVhqQ94psC1dFVs8Psr7NVHiR9DLF22a6uPq5c+E=;
        h=Date:From:To:Cc:Subject:From;
        b=WhdzBmCC0+NVW6sBO6k5p2mlJynLJVvafFCTMLWPmqBkDujDUTUTed/o77XNZdxkk
         sZ3rk9/orqQWT40H9U4eDb2paHESMEHowVrpyjg4oTleBbpfzmcXLCapuzXnFHJ50o
         604JMk97zD4ItwPTqRuWOzzCf4DrYftuCD1jdifklwJy7UUv+wPBT98aa5bTbUmO90
         7gncDGxXd3ZnCJDA8ozEDITrK/O3qk8vFXo1ERmMeTW1iyK5CDfiHAMFI1IO7I4UpV
         IURwqFLBnXYE2sXwMxzpYq8iUvzZTLcprXuRiepZLJ/ARSMQXNahrhZZLk1eGkTxR4
         M2D01iTqkG+Mg==
Date:   Fri, 30 Nov 2018 16:40:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Rodgman <dave.rodgman@arm.com>
Subject: linux-next: build warning after merge of the akpm tree
Message-ID: <20181130164030.3dbeb8b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yiQl9OK0_w+H=ql+FP9TfeD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yiQl9OK0_w+H=ql+FP9TfeD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

lib/lzo/lzo1x_compress.c: In function 'lzo1x_1_do_compress':
lib/lzo/lzo1x_compress.c:239:14: warning: 'm_pos' may be used uninitialized=
 in this function [-Wmaybe-uninitialized]
   m_off =3D ip - m_pos;
           ~~~^~~~~~~
Probably introduced by patch

  "lib/lzo: implement run-length encoding"
or
  "lib/lzo: separate lzo-rle from lzo"

--=20
Cheers,
Stephen Rothwell

--Sig_/yiQl9OK0_w+H=ql+FP9TfeD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAzU4ACgkQAVBC80lX
0Gz3gAf/eue7DBYUc3dJFaInC25gKclZKgmetu5lVK+oKZBhXeglywuahWGUxgID
y1Fe2yBq8UXeWD3nWm9wt6JC1cy4V4mlNszJ2OPlncFCCVzo7J09Oiu19k+vpaEQ
lxwWIxel0hxxulehpbDjyBExcR/NY9jH4KO2iDLC1RfRep//hj5ULF9aAAS0uroo
jKCDYnJUM4R92bw//gX+8EvGrlRmQq0BA4A3dEWIgzb4DpU9IgfKarNxssbfsPRa
PDVYM91Fwn07DbNWplhHU+qCZ1c0xIRaNSq0X4OefyHsiW0u4TedID1ZVrwA88rt
4T5VHyCyzatz7kQyVX3w7ciw8pr7wg==
=iur9
-----END PGP SIGNATURE-----

--Sig_/yiQl9OK0_w+H=ql+FP9TfeD--
