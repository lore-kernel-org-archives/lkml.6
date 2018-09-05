Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA23C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1789220645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q0KkivcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1789220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIFD5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:57:41 -0400
Received: from ozlabs.org ([203.11.71.1]:56231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeIFD5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:57:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425KYf56xZz9sB5;
        Thu,  6 Sep 2018 09:25:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536189911;
        bh=EUyBUWnx+7UpVqQMr9l/3kGWhKa5ncOrXQ5P5d/WMMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q0KkivcDvb/c/T5GCr6HfgrdPAAb80wy5Hn8Asx+t/Cxu7jLuQgxXwV05EeItCNxt
         WM/Efbtg2RQzg6V0yVpK20huztGXD9s2ukcKiu92a5dj8gV/GRijE+bjaYUl2pxyLy
         4T5rUhjnk7oq8j/y1I4w0e86r+GDCOLfUqbWU/dxm0O0rUoYM/sqqE+cMEo7fXuH7r
         7IwkXshf+hctdMefFgKvD+KJIGZmZ7x8xrChGBK6P6f94JxMc6TX9CnYWqSKXOZuH8
         uH/QDbFPK903z/K6OM8z8bn4R1QcJzTkCtQg6dH0m8xRPp8XdSyfEtAmE4DW1oVUNX
         APBulgt+TSjKw==
Date:   Thu, 6 Sep 2018 09:25:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chao Yu <yuchao0@huawei.com>,
        "David Howells" <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
Message-ID: <20180906092504.282d5f62@canb.auug.org.au>
In-Reply-To: <20180829094403.3a3bf19b@canb.auug.org.au>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
        <20180828054444.GA4453@kroah.com>
        <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
        <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
        <20180828130559.GA5427@kroah.com>
        <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
        <20180829094403.3a3bf19b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oiWkIwsV0XXcyypa3spQP5m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oiWkIwsV0XXcyypa3spQP5m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 29 Aug 2018 09:44:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 28 Aug 2018 22:13:02 +0800 Chao Yu <yuchao0@huawei.com> wrote:
> >
> > On 2018/8/28 21:05, Greg Kroah-Hartman wrote: =20
> > > On Tue, Aug 28, 2018 at 04:56:43PM +0800, Chao Yu wrote:   =20
> > >>
> > >> On 2018/8/28 14:28, Gao Xiang wrote:   =20
> > >>>
> > >>> On 2018/8/28 13:44, Greg Kroah-Hartman wrote:   =20
> > >>>> On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote:   =20
> > >>>>> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
> > >>>>>
> > >>>>> Since XArray and the new mount apis aren't merged in 4.19-rc1
> > >>>>> merge window, the BROKEN mark can be reverted directly without
> > >>>>> any problems.
> > >>>>>
> > >>>>> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporari=
le")
> > >>>>> Cc: Matthew Wilcox <willy@infradead.org>
> > >>>>> Cc: David Howells <dhowells@redhat.com>
> > >>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > >>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > >>>>> ---
> > >>>>>
> > >>>>> Hi Greg,
> > >>>>>
> > >>>>>  Could you please apply this patch to enable EROFS from 4.19-rc2,=
 thanks...
> > >>>>>
> > >>>>>  p.s. We would like to provide a more stable EROFS when linux-4.1=
9 is out,
> > >>>>>       and there are also two patchsets (the one is already sent o=
ut by Chao
> > >>>>>       and me, the other is previewing in linux-erofs mailing list=
 and it will
> > >>>>>       be sent out after gathering enough testdata and feedback fr=
om community
> > >>>>>       and carefully reviewed), could you also please consider app=
lying these
> > >>>>>       two patchsets in the later 4.19-rc (both >2, or the first p=
atchset
> > >>>>>       could be in rc2 in advance) if it is convenient to do so, o=
r the next
> > >>>>>       4.20 is also ok...
> > >>>>>
> > >>>>>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@k=
ernel.org/
> > >>>>>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-e=
mail-gaoxiang25@huawei.com/   =20
> > >>>>
> > >>>> I applied those patch sets to my -next branch already, right?  So =
those   =20
> > >>>
> > >>> Yes, Thank you for applying those patches. :)
> > >>>   =20
> > >>>> would be going into 4.20-rc1, it is time now for "bugfixes only" f=
or
> > >>>> 4.19-final.
> > >>>>
> > >>>> So perhaps we should just leave it as "BROKEN" for now for 4.19 an=
d add
> > >>>> this to my tree now and let people work on it for the next few mon=
ths in   =20
> > >>
> > >> I'm worry about that once we plan to reenable erofs in next x.xx-rc1=
, in the
> > >> merge window, if there are any other features change common api or s=
tructure in
> > >> vfs/mm/block, but related patch didn't cover erofs, that would make =
conflict
> > >> with erofs.
> > >>
> > >> So if that happens, we can just reminder them to cover erofs? or we =
should
> > >> handle this by just delay removing 'BROKEN' state?
> > >>
> > >> Thanks,
> > >>   =20
> > >>>> linux-next so that 4.20 has a solid base to start with?
> > >>>>   =20
> > >>>
> > >>> EROFS is be marked as "BROKEN" just because of conflict with
> > >>> XArray and the new mount apis, as Stephen Rothwell suggested in
> > >>>
> > >>> https://lore.kernel.org/lkml/20180802010705.24a72730@canb.auug.org.=
au/
> > >>>   =20
> > >>>> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS =
patch
> > >>>> to the staging tree itself for his first pull request during the m=
erge
> > >>>> window and then send a second pull request (after the vfs and mayb=
e the
> > >>>> Xarray stuff has been merged by Linus) with these patches followed=
 by a
> > >>>> revert of the disabling patch.   =20
> > >>>
> > >>> But these two features was still discussing in the mailing list eve=
n at the
> > >>> last time of 4.19-rc1 merge window. I cannot decide whether they we=
re eventually
> > >>> get merged in 4.19 or not. But it seems that it is regretful that l=
inux-4.19
> > >>> is out without XArray and the new mount apis.
> > >>>
> > >>> Therefore, I think EROFS should work for linux-4.19 without any mod=
ification
> > >>> if just revert the BROKEN mark.   =20
> > >=20
> > > Ok, you are right, I'll go apply this.
> > >    =20
> > >>> EROFS works fine with the 4.19-rc1 code except that it has some __G=
FP_NOFAIL
> > >>> and BUG_ONs on error handling paths and very rarely race between me=
mory
> > >>> reclaiming and decompression... :( I personally think it is complet=
e enough
> > >>> for people to test since it is an independent and staging filesyste=
m driver (no
> > >>> other influence...) Anyway, removing EROFS BROKEN mark at 4.20 is a=
lso ok of course...
> > >>>
> > >>> On the other head, if XArray and the new mount apis is still pendin=
g for 4.20,
> > >>> should EROFS uses the same policy as Stephen suggested? I have no i=
dea how to do next...   =20
> > >=20
> > > As the code is now part of the common tree that everyone works off of,
> > > any filesystem changes that happen will normally cover erofs as well.
> > > So this shouldn't be an issue anymore.   =20
> >=20
> > Thanks very much for the help and explanation, we will keep an eye on t=
hose vfs
> > changes. :) =20
>=20
> Unfortunately, those vfs changes are still in the vfs tree in
> linux-next and cause a build failure in the erofs code.  I have
> disabled the build of erofs again for today.
>=20
> Dave, Al, it would be good if you could add a patch/revise the series
> that adds the necessary erofs changes.

I still have to disable erofs .....

--=20
Cheers,
Stephen Rothwell

--Sig_/oiWkIwsV0XXcyypa3spQP5m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluQZdAACgkQAVBC80lX
0GxHvAgAnjn2ahH02iH87exZQnstxqlAU/hDo5E7CdtZE90j0zQDN0AooCeXQ2JQ
N9MoRjFbdhn/6fWYkSwmuedPFDT1kNUiu40Wt0wJE2qwl43+UHIAAfZfbkZuy4B/
6f2rAbSzTG9HeAz861fy/invYX+7UoCEGksX3e30W9L9onb4aR5WJXIOoj3Rh0UC
X/60vAUNrufTyh21U9sBv64ydGf4EIrwlrBsQ5RUnZ82hKPt1kiHnPxlCV7brp1n
gbRA2D0957dw/xHwYa7f/gc3n1jq0tidYL9KQr9Wd9TCfZyltJJ5o693lzmvZdnf
1MOo/89Sc6nO2Wr7bGC0miIahDEdJA==
=feZ6
-----END PGP SIGNATURE-----

--Sig_/oiWkIwsV0XXcyypa3spQP5m--
