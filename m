Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF72087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gno/PFPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH2DiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:38:24 -0400
Received: from ozlabs.org ([203.11.71.1]:55311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeH2DiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:38:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 420QMQ5zLjz9ryn;
        Wed, 29 Aug 2018 09:44:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535499860;
        bh=e5+y7DBn8sEMEjchQDiO/Pw2lsnamHuYOpPsuHLB9Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gno/PFPqYZH3DD1/6YyZUutNkrds5DWP+JlAgTCSRJAAPJ7kVYWnYid12NwzE4R+j
         pPsdxNBm5lG9iCvStWGr5hvJHEpQ4951ztK3kd2sRmOdd5rTjGQ7+o53/IR8/nviUj
         xWfiYmyVzQst2qM5T9uDeDzeyAEbokLCvYAhaVLZEAakoH9kYcY9BjmmIj2G+TDeil
         EC/5UIHDH7hIooDVBIWgy8CoDbD35eL8aADXzFvbABB5I6S4ZXisfAg+aP/F67Oehf
         g8Z4c5kNmkAKJtF5F4bN9SN8BAbU9og8UGj9jQaLfZ+f4EO+xl8f7NVUXzCIIsHDsP
         wxw0z+PErxkEQ==
Date:   Wed, 29 Aug 2018 09:44:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David Howells" <dhowells@redhat.com>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
Message-ID: <20180829094403.3a3bf19b@canb.auug.org.au>
In-Reply-To: <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
        <20180828054444.GA4453@kroah.com>
        <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
        <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
        <20180828130559.GA5427@kroah.com>
        <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=oelIaZSFIlJ53LFId5bh9K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=oelIaZSFIlJ53LFId5bh9K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 28 Aug 2018 22:13:02 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2018/8/28 21:05, Greg Kroah-Hartman wrote:
> > On Tue, Aug 28, 2018 at 04:56:43PM +0800, Chao Yu wrote: =20
> >> Hi Greg,
> >>
> >> On 2018/8/28 14:28, Gao Xiang wrote: =20
> >>> Hi Greg,
> >>>
> >>> On 2018/8/28 13:44, Greg Kroah-Hartman wrote: =20
> >>>> On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote: =20
> >>>>> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
> >>>>>
> >>>>> Since XArray and the new mount apis aren't merged in 4.19-rc1
> >>>>> merge window, the BROKEN mark can be reverted directly without
> >>>>> any problems.
> >>>>>
> >>>>> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile=
")
> >>>>> Cc: Matthew Wilcox <willy@infradead.org>
> >>>>> Cc: David Howells <dhowells@redhat.com>
> >>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> >>>>> ---
> >>>>>
> >>>>> Hi Greg,
> >>>>>
> >>>>>  Could you please apply this patch to enable EROFS from 4.19-rc2, t=
hanks...
> >>>>>
> >>>>>  p.s. We would like to provide a more stable EROFS when linux-4.19 =
is out,
> >>>>>       and there are also two patchsets (the one is already sent out=
 by Chao
> >>>>>       and me, the other is previewing in linux-erofs mailing list a=
nd it will
> >>>>>       be sent out after gathering enough testdata and feedback from=
 community
> >>>>>       and carefully reviewed), could you also please consider apply=
ing these
> >>>>>       two patchsets in the later 4.19-rc (both >2, or the first pat=
chset
> >>>>>       could be in rc2 in advance) if it is convenient to do so, or =
the next
> >>>>>       4.20 is also ok...
> >>>>>
> >>>>>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@ker=
nel.org/
> >>>>>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-ema=
il-gaoxiang25@huawei.com/ =20
> >>>>
> >>>> I applied those patch sets to my -next branch already, right?  So th=
ose =20
> >>>
> >>> Yes, Thank you for applying those patches. :)
> >>> =20
> >>>> would be going into 4.20-rc1, it is time now for "bugfixes only" for
> >>>> 4.19-final.
> >>>>
> >>>> So perhaps we should just leave it as "BROKEN" for now for 4.19 and =
add
> >>>> this to my tree now and let people work on it for the next few month=
s in =20
> >>
> >> I'm worry about that once we plan to reenable erofs in next x.xx-rc1, =
in the
> >> merge window, if there are any other features change common api or str=
ucture in
> >> vfs/mm/block, but related patch didn't cover erofs, that would make co=
nflict
> >> with erofs.
> >>
> >> So if that happens, we can just reminder them to cover erofs? or we sh=
ould
> >> handle this by just delay removing 'BROKEN' state?
> >>
> >> Thanks,
> >> =20
> >>>> linux-next so that 4.20 has a solid base to start with?
> >>>> =20
> >>>
> >>> EROFS is be marked as "BROKEN" just because of conflict with
> >>> XArray and the new mount apis, as Stephen Rothwell suggested in
> >>>
> >>> https://lore.kernel.org/lkml/20180802010705.24a72730@canb.auug.org.au/
> >>> =20
> >>>> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS pa=
tch
> >>>> to the staging tree itself for his first pull request during the mer=
ge
> >>>> window and then send a second pull request (after the vfs and maybe =
the
> >>>> Xarray stuff has been merged by Linus) with these patches followed b=
y a
> >>>> revert of the disabling patch. =20
> >>>
> >>> But these two features was still discussing in the mailing list even =
at the
> >>> last time of 4.19-rc1 merge window. I cannot decide whether they were=
 eventually
> >>> get merged in 4.19 or not. But it seems that it is regretful that lin=
ux-4.19
> >>> is out without XArray and the new mount apis.
> >>>
> >>> Therefore, I think EROFS should work for linux-4.19 without any modif=
ication
> >>> if just revert the BROKEN mark. =20
> >=20
> > Ok, you are right, I'll go apply this.
> >  =20
> >>> EROFS works fine with the 4.19-rc1 code except that it has some __GFP=
_NOFAIL
> >>> and BUG_ONs on error handling paths and very rarely race between memo=
ry
> >>> reclaiming and decompression... :( I personally think it is complete =
enough
> >>> for people to test since it is an independent and staging filesystem =
driver (no
> >>> other influence...) Anyway, removing EROFS BROKEN mark at 4.20 is als=
o ok of course...
> >>>
> >>> On the other head, if XArray and the new mount apis is still pending =
for 4.20,
> >>> should EROFS uses the same policy as Stephen suggested? I have no ide=
a how to do next... =20
> >=20
> > As the code is now part of the common tree that everyone works off of,
> > any filesystem changes that happen will normally cover erofs as well.
> > So this shouldn't be an issue anymore. =20
>=20
> Thanks very much for the help and explanation, we will keep an eye on tho=
se vfs
> changes. :)

Unfortunately, those vfs changes are still in the vfs tree in
linux-next and cause a build failure in the erofs code.  I have
disabled the build of erofs again for today.

Dave, Al, it would be good if you could add a patch/revise the series
that adds the necessary erofs changes.

--=20
Cheers,
Stephen Rothwell

--Sig_/=oelIaZSFIlJ53LFId5bh9K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluF3kMACgkQAVBC80lX
0GxtGQf/WI2VJX9cDgZSD4S5idx4bwbJ3Sa1/Fb3mrBfbD5V06eFm39afwnPjuf2
dfF9MXbNTZBXSOckWxELPp4Y88aBg81i+E4sEvWVIJ6PZkXlBHkKTxbtKxVyK0nx
JBjzvY3h7cqnW0uWs2qk0XR59aJz2w/kK4x0YuwWpJ/+47xRlzcArN1Rk/0y4L5o
LX2mpW1Eb4j1mrwG4RcZQNEItePxmxEAIFri5JZOKbDhLgSuKHuGRqi1Ot+90Xmh
BMRxryD5YJL1pejrX2r4ivEXyoO8c1SQ709/yrp2bPCJDVrZq0cUBS9GQEWnCZ7H
4uT89QHBArnw6vr+Ws6sDjlw7kvSxA==
=Lse5
-----END PGP SIGNATURE-----

--Sig_/=oelIaZSFIlJ53LFId5bh9K--
