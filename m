Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A2AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430012150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BenAI8/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430012150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeISFYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:24:52 -0400
Received: from ozlabs.org ([203.11.71.1]:33777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeISFYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:24:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FKV46WH3z9s4s;
        Wed, 19 Sep 2018 09:49:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537314588;
        bh=uOmrHNv+t4H4hlNfyIgXksc7dtit13RIx1lSu/tc1w0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BenAI8/XsOCB7iwRGSrNchDY7gM7M63zTpFtz/tyaLgxhxuiB5VCibusP4mfSLy+j
         O1PAQHLdRycDmMy8SoecmexVXZ0t/JC1PretiCsoEBvNw62EOW639zG5YeL5tJM/d5
         qmesEugcvg9UGZTducoq0HrafoK8pc8pAm4pIel091KHUBtmruxok0c+Kvzz7yMou7
         /x+ppttIZo0e+GcHInfOYCl2BbyqFxCuWNx/zP8zqABy5l91Q7La6JkAx9WVcK7u9v
         twCNknMaVdxqKqY8IuORUIwVdqpS6QXvXU1YkIXsTI9EZDAU+qso+i3j8dWtMKFsZe
         pu0Q+07U65Ysg==
Date:   Wed, 19 Sep 2018 09:49:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180919094847.2103082b@canb.auug.org.au>
In-Reply-To: <15925.1537309041@warthog.procyon.org.uk>
References: <20180919073826.02370812@canb.auug.org.au>
        <20180910133525.28c5dd20@canb.auug.org.au>
        <15925.1537309041@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A3kqd4LaF7HuI/jy6GhqSpL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A3kqd4LaF7HuI/jy6GhqSpL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 18 Sep 2018 23:17:21 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > > After merging the vfs tree, today's linux-next build (powerpc
> > > allyesconfig) failed like this:
> > >=20
> > > samples/vfs/test-fsinfo.c: In function 'fsinfo':
> > > samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (fir=
st use in this function); did you mean 'fsinfo'? =20
>=20
> I think the problem is that I haven't allocated system call numbers for a=
ny
> arches other than x86 - even the x86 syscall numbers are provisional unti=
l the
> patchset is taken upstream.  I'm not sure of the best way to deal with th=
is -
> make the samples dependent on the X86 arch?

But the sample programs are built with HOSTCC, so you can't depend on
ARCH (since I, for one, am cross compiling).  Maybe SUBARCH.  Better
would be to use either Kconfig's shell primitive or some make magic to
figure out if the syscall number define's are defined.

> > > samples/vfs/test-fsinfo.c:180:30: warning: format '%llx' expects argu=
ment of type 'long long unsigned int', but argument 2 has type '__u64' {aka=
 'long unsigned int'} [-Wformat=3D]
> > >   printf("\tmax file size: %llx\n", f->max_file_size); =20
>=20
> Sigh.  On powerpc __u64 is unsigned long, but on x86_64 it's unsigned long
> long.  Is it possible to shift all arches to use unsigned long long for _=
_u64?

I doubt it - that would probably cause more warnings in the arch code.
Instead, just explicitly cast it to unsigned long long.
--=20
Cheers,
Stephen Rothwell

--Sig_/A3kqd4LaF7HuI/jy6GhqSpL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluhjxYACgkQAVBC80lX
0GxW6gf/Vs35Z87tFVTKLvK3DyMWgVcJl17DclSTyVJbxE+KYVF3qyFYT9/Rvk0g
DKEu0BymA/Zn2c7Qu1KKavt6roUqOmPWyxuiIG2xTZDWf/kow38p3TmWOoUtcwvZ
uu7WFbUQIdDPF2gk8FGJwzNIpFJDTTW+LbFpbHhXAByfJfhN0/yC9/04BFsmjawW
cVz7I2V5nL1cg5Lvu52OOzZu/9Ntw0XW40gE0RPmX+Q1kPQ9lCkNvs97wwYigveH
mb+7NJkVi2ZQvFKtkpa9DaMMhipL1mN9HmlplXdjDIaSqbGlk+fn9opeZ4KyhN/e
AfPuNstm+2Gc9zRxjjULCfBsDltnVA==
=4n9x
-----END PGP SIGNATURE-----

--Sig_/A3kqd4LaF7HuI/jy6GhqSpL--
