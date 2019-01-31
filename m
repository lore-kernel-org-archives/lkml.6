Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5820833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZO8iZeIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfAaEOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:14:15 -0500
Received: from ozlabs.org ([203.11.71.1]:42945 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfAaEOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:14:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qn1K22Qtz9sBb;
        Thu, 31 Jan 2019 15:14:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548908053;
        bh=c6xd4b1IgYiz06n3B9p8ejvsy4TWlW5IvVIROWMzprI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZO8iZeIBRjAIloF8Gp8w0l2t0yaa45EOn9cWBKwDwzEmD4ZxlDakVITw71BOb/Emm
         F+BGdV7B5+duey49WN/8zTwQKnBTkjAzW1aKo9Rc1QdnRrYeFDgS5zjlwdCMCOPKHm
         KvKy8cqqysaSa2JWLuHHZNgg8C6bbxs5986K+wJhom7GziPfu7dnB/KEnx29Xh/3l1
         eB+ekUL4Kp+npes0PAHA1MJrSj6lzJWvEZ1wza/Xd5DToE38DNPr5aOVUSdK3s53qz
         6ZLMG7lWGqGpejpRjNX+14Zd9Ijsp2bIzzD7fMnR+I5e3jVb5mUgp0RVGVJzMJU1vi
         HUvfTM8jT/4UQ==
Date:   Thu, 31 Jan 2019 15:14:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the ext3 tree
Message-ID: <20190131151411.7e8b89b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8o/_ST.PInOHu0vP8rsGp0e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8o/_ST.PInOHu0vP8rsGp0e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

After merging the ext3 tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

ld: fs/ext2/super.o: in function `ext2_fill_super':
super.c:(.text+0x1494): undefined reference to `__divdi3'
ld: super.c:(.text+0x14bc): undefined reference to `__divdi3'

Caused by commit

  455d38a0e62f ("ext2: Fix underflow in ext2_max_size()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8o/_ST.PInOHu0vP8rsGp0e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSdhMACgkQAVBC80lX
0GxR9gf9FEto0xpI7MLQl7zy+a/dkbLaUuljzr5mdaRNn39EFCQhiujoPRtDAtRZ
rTGRelCJ9mMpnjXNmYFtCEmrGSsJs0zEMh2ZxdHjsj+QIAeBhXv+J+6Tof1U31OZ
25fNTfjKk/uOUESQ/MtWg6k2LI5k7iguaWZajCK9B1Rb4HfGC8K198+T2brdC2Cy
0Mp060+akFsii7J7x+ECvaX+9NSG1p6iR2tn4KC/JUJ0X6w8k8axc6artsm0FhUG
/V1/i22SyPz0Kpyjl5nnaW4Bgt0kvyYSjW7VPo1vy3DXUQoYGlFQIf+lvb6bCmmR
bs1Xzjiljm2YW5O56mGvtg3Ca1TUOA==
=m/j+
-----END PGP SIGNATURE-----

--Sig_/8o/_ST.PInOHu0vP8rsGp0e--
