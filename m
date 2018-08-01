Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F51208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ddbm+gQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F51208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbeHAQxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:53:18 -0400
Received: from ozlabs.org ([203.11.71.1]:35041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388988AbeHAQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:53:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gc962jcYz9s3q;
        Thu,  2 Aug 2018 01:07:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533136027;
        bh=Ib9Lhs2Ecv3sjSmA3V+5zI2d2I6cxZ1MQVWOdxizi0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ddbm+gQx/Qq5SIOq/3PJmy19/4jolR1dpVU5G6UDzx4PhsryVzqSPSlbQ4Wp66vmr
         B3ja3GZrE8Vjyz01a2wcQceoxjKVF3Lt7+K82OqI+MsbpI5k2tJDc1iEeUHtl8LdZk
         ClJEmIXXc04FSiOdGeQKJqsDo1mvkfV4jw9wHU6LgE9yvcguGVv2gPouNj0FJZ5IwN
         Elo4R+uIO7NLKOKvY/zEdcKjDzP7RBchpudGyabbwc0tsQdBpBXvkIXoYfzv61sMn2
         JTA/o/63pSvDpxRPc964yb7qZsrhxnmERbwjQubuz3X9DqCNthY1yr9IcWpwNrhgsh
         gg76LHz9JHzHg==
Date:   Thu, 2 Aug 2018 01:07:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Greg KH <greg@kroah.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miao Xie <miaoxie@huawei.com>,
        Linus <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: linux-next: build failure after merge of the staging tree
Message-ID: <20180802010705.24a72730@canb.auug.org.au>
In-Reply-To: <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
References: <20180730161622.3837cb15@canb.auug.org.au>
        <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
        <7152b6ba-9ad6-4a9c-3b13-2d5310266ccd@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6gHwjK/X8hKbAfmFlwPSlMJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6gHwjK/X8hKbAfmFlwPSlMJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chao,

On Wed, 1 Aug 2018 17:09:13 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>
> Xiang has submitted several patches as below to fix compiling error on -n=
ext
> tree, could you consider to merge those temporary fixes into -next after =
merging
> staging-next's updates, and reenable CONFIG_EROFS_FS for further integrity
> compiling and test?
>=20
> staging: erofs: fix superblock/inode flags (MS_RDONLY -> SB_RDONLY, S_NOA=
TIME)
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000282.html
>=20
> staging: erofs: remove RADIX_TREE_EXCEPTIONAL_{ENTRY, SHIFT}
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000283.html
>=20
> staging: erofs: update .mount and .remount_sb
> https://lists.ozlabs.org/pipermail/linux-erofs/2018-July/000285.html

OK, I will apply those tomorrow (actually later today :-)) and and stop
disabling CONFIG_EROFS_FS.

> BTW, for this condition that erofs was not covered by some common vfs
> stuff changes in other one's tree, who should take care of those
> missing fixes during coming next merge window?

It might be easiest for Greg to add the disabling CONFIG_EROFS_FS patch
to the staging tree itself for his first pull request during the merge
window and then send a second pull request (after the vfs and maybe the
Xarray stuff has been merged by Linus) with these patches followed by a
revert of the disabling patch.

--=20
Cheers,
Stephen Rothwell

--Sig_/6gHwjK/X8hKbAfmFlwPSlMJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthzJkACgkQAVBC80lX
0Gwe9Qf/SDpVeOnYLrCqQSPYNt8Fx4fD82J43kv746+qqMsN6sSfgXqUm6KdONYD
2dXVGwMhp0XGabf48uw35X7kNl76KwXh1BEMSkBuXIcJrUXNF3sUAa8q1+Tl2kPM
DA/su1F6MElnDaOJ88mj2oJd0PN/1PA5RMBcdXRLQLdLBDgenonQm2yzZ9j2+REg
qEdHvyfGzxhx3rk4t11mVfQbQwvYW36LcIFRO3owqN/42hNEGxcyF4ouxBsIoDPM
XQOcthold2IirqH18ZXL6yO0EZWR1PzSJwCh+5svNPd+Z5kQT6gqzgfCtc9XGKqR
mMw8GoUPqN14ojmKIu9ZC2esBLXD1Q==
=cYYy
-----END PGP SIGNATURE-----

--Sig_/6gHwjK/X8hKbAfmFlwPSlMJ--
