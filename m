Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8D20FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337CA208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Oso0aq2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337CA208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeFKXxW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:53:22 -0400
Received: from ozlabs.org ([203.11.71.1]:42915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933381AbeFKXxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:53:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414VFn08Mrz9s1B;
        Tue, 12 Jun 2018 09:53:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528761198;
        bh=1SSSVAPKHoGClIH7ypknvV8d1jm6IzhAzNUROIjNljg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oso0aq2hM1Wn0asV5De//+YMDshbad9HmQXhU5cNHfw0U8mmXzJusdCnPElMNGyKa
         tEd7niwrhCVYE+6cEE7GIFjTqba+UnH3cbHjzEO9ONujxoUNDEF6PnZiKlfnVzAOX1
         uVoAl4sdzU5KfMKX3M2q8bJ+4FsOm4vctd+HO2CZ4RJbv7euEh9YMjWtEosp47IKhN
         8dtVn1MreCfDImmjEqrW/jJeaafCl/CQ1xswp/LQGN/cR+7mOLdGazMJreXt6TgnNt
         QU7I7m+UYGDRCg49LxKwkXxL8c6WswR+3+GExnIy9YpSnytAjM+WfHFltiQE2eASUz
         ehkHJgy3Ld17Q==
Date:   Tue, 12 Jun 2018 09:53:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20180612095309.26f5c6f4@canb.auug.org.au>
In-Reply-To: <20180601115619.73a8f966@canb.auug.org.au>
References: <20180601115619.73a8f966@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H.vnieOUtcD4tVOrK6c+=fS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H.vnieOUtcD4tVOrK6c+=fS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Jun 2018 11:56:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   include/linux/fs.h
>=20
> between commit:
>=20
>   29aca8b3f7cd ("fsnotify: introduce prototype struct fsnotify_obj")
>=20
> from the ext3 tree and commit:
>=20
>   d9a08a9e616b ("fs: Add aio iopriority support")
>=20
> from the vfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/fs.h
> index d1f3d572349f,482563fe549c..000000000000
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@@ -36,7 -36,7 +36,8 @@@
>   #include <linux/delayed_call.h>
>   #include <linux/uuid.h>
>   #include <linux/errseq.h>
>  +#include <linux/fsnotify_obj.h>
> + #include <linux/ioprio.h>
>  =20
>   #include <asm/byteorder.h>
>   #include <uapi/linux/fs.h>
> @@@ -1717,9 -1713,10 +1719,11 @@@ struct file_operations=20
>   	int (*iterate) (struct file *, struct dir_context *);
>   	int (*iterate_shared) (struct file *, struct dir_context *);
>   	__poll_t (*poll) (struct file *, struct poll_table_struct *);
> + 	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
> + 	__poll_t (*poll_mask) (struct file *, __poll_t);
>   	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>   	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>  +	int (*pre_mmap) (struct file *, unsigned long, unsigned long);
>   	int (*mmap) (struct file *, struct vm_area_struct *);
>   	unsigned long mmap_supported_flags;
>   	int (*open) (struct inode *, struct file *);

This is now a conflict between the ext3 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/H.vnieOUtcD4tVOrK6c+=fS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsfC2UACgkQAVBC80lX
0Gx3vwf+NSX9TcByitTc4R/1JSKK4rObCnlVuCb5/8Lgd6gtUGMKWP1/w1eyURdG
MBBKr3/q19RDIJFLl424yIQGT7ghzq+0Xqe/jynBy09bOTqHufzdtvV0/8zVlGYE
OCwbtxnw5ZV4fa7jaP7oTz4nCjKI43P7J9pRil0dqhT4D64DicaXRjK8bw4JObq3
nzlGbdjmW+bsQ8cyRaRo15CNnSzHdIm2YM/E9SW7xdUAlajDTdvdKtCmx1bUVVWN
LTXXpPHDgLjy6q3XDiR3cexhGs07GMdOgvQkVwYDe0eEhZ6EJXJWtsu8srzIFfVs
CiaIwB7GGa7aokH/fMtwyqyq/YQ7hg==
=pnSW
-----END PGP SIGNATURE-----

--Sig_/H.vnieOUtcD4tVOrK6c+=fS--
