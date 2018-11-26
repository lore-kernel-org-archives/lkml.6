Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C1CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91035208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LtKdYzsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91035208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeK0JNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:13:30 -0500
Received: from ozlabs.org ([203.11.71.1]:36007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeK0JNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:13:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433hB8554gz9s3l;
        Tue, 27 Nov 2018 09:17:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543270673;
        bh=/wRpLNyPG2OWZldnDFdD/ECtIJTrHPp4gOuPdTwqu7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LtKdYzsPJa/j54Z2OkAMqAqzOYyfP3npNnV9S4xnQzgmmLxrwuv9omecT23aNpAxO
         +QxpbHJQjNGqHe19T7sxwwABsFIZ3mMCCZVBtYHQo0cDGKJYZ+3LnFACc1Gdmhtopw
         uSIV5dJms0yhgtpXZVgxndMEg/m8FS/saXYPxhu1sh3la3Otxx5X7nQFumeg7gdnIQ
         IRuNFFW1M3SiZG1gdItyh8uSf1xi3VXquKw04rBtAeYsxfiPVZVtAu3JCxlNsAlgXx
         eBM6UmzPckyrThhq0MOs4uUWoPkrtTZtzAGCC/guL+LO01OVELM8HrVV+1U8nN2jxV
         az7jDCqt6mXsw==
Date:   Tue, 27 Nov 2018 09:17:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: linux-next: build warning after merge of the f2fs tree
Message-ID: <20181127091747.4830d123@canb.auug.org.au>
In-Reply-To: <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181126111933.1b0fb324@canb.auug.org.au>
        <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1CNKR_JuZ7EXqjn9Aby.ik6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1CNKR_JuZ7EXqjn9Aby.ik6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,

On Mon, 26 Nov 2018 13:59:24 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 11/26, Stephen Rothwell wrote:
> >=20
> > After merging the f2fs tree, today's linux-next build
> > (x86_64_allmodconfig) produced this warning:
> >=20
> > In file included from fs/f2fs/dir.c:11:
> > fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
> > fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimpl=
icit-fallthrough=3D]
> >    if (set)
> >       ^
> > fs/f2fs/f2fs.h:2390:2: note: here
> >   case FI_DATA_EXIST:
> >   ^~~~
> >=20
> > Exposed by my use of -Wimplicit-fallthrough
> >=20
> > I am not sure why this has turned up now (as opposed to earlier today).=
 =20
>=20
> The above change had been there for a long time, as an intended behavior.

Yeah, it popped up due to line number changes in that file and the way
I was filtering new warnings.

> Hmm, I'm not sure how to avoid this.

if you add a comment
	/* fall through */
at the point the fall through occurs, then the warning is suppressed
(and it documents that it is deliberate).

--=20
Cheers,
Stephen Rothwell

--Sig_/1CNKR_JuZ7EXqjn9Aby.ik6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv8cQsACgkQAVBC80lX
0GxO+Qf9G6YnjUx/tFlb5nlzFmjONkb4fSe4BTc2s3LWhClbBmvIJ1ZwAy5xV52R
uqL2orFeRi0I2VfXYhAhspGf4a2xaQC0bD9QMfiWKfYq+CDHb+lyuZzP69ZL7uFS
BvoK3gXsFgnQWRn5VjOLCTArqN17RouqE1l4iPxbHOpNLybnXwpBL0El//38bYEd
/CDHPGVg7rNHG1cV07v7uaI5W3nt7PTlRAaSi6gckGqxkRfcH0IM+DoCYK35ys9d
OiFQhx8oglPj1YQ2mg1ihMOXWmj3eIU5lTBKCf8P3pk9uUKRgzH9pZZqSHWp3wqC
A2ssZNP5pFRsVU/Rkz9ycV6Jy5QtEA==
=I5ve
-----END PGP SIGNATURE-----

--Sig_/1CNKR_JuZ7EXqjn9Aby.ik6--
