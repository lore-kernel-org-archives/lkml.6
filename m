Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642CE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwYarCVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642CE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJISqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeJISqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:46:36 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B6B2087D;
        Tue,  9 Oct 2018 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539084603;
        bh=NX6G0pO16mvkUr+38SFHl+ceWXVvAw9lvqpoplE5XrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwYarCVl42J/S8iLJEDyLiOw8qs7VGJNFxdwx6HXVM0aTQYJhRaPhw45sit/5/8bE
         AnCb5muWo8CKU0N/SQU8hVQy58mAvr853BKRbk9NeQg6EjvhR4BUgoQfJ60s3ZL+RU
         P2Y1v4MAaBbq+k6Lg/haCvpqaX6V0DbT6oR5rjTE=
Date:   Tue, 9 Oct 2018 14:30:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com>,
        dledford@redhat.com, swise@opengridcomputing.com,
        markb@mellanox.com, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        marcos.souza.org@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: WARNING in __put_task_struct (2)
Message-ID: <20181009113000.GC4105@mtr-leonro.mtl.com>
References: <000000000000b3d5610577b9e12c@google.com>
 <CACT4Y+bfqk8Fczw4dJHhVzM63YhYNSovEE-KygZ1XmgUQVGCWQ@mail.gmail.com>
 <20181008194513.GC27639@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GAoked8QSizNecZ5"
Content-Disposition: inline
In-Reply-To: <20181008194513.GC27639@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GAoked8QSizNecZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 01:45:13PM -0600, Jason Gunthorpe wrote:
> On Mon, Oct 08, 2018 at 06:15:22PM +0200, Dmitry Vyukov wrote:
> > On Mon, Oct 8, 2018 at 6:12 PM, syzbot
> > <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12e7c6a1400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1ed9dfaa984c88cf0ef8
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com
> >
> >
> > This was triggered by the following program, all is rdma-related, so
> > +rdma maintainers.
> >
> > 10:27:26 executing program 5:
> > r0 = openat$rdma_cm(0xffffffffffffff9c,
> > &(0x7f0000000380)='/dev/infiniband/rdma_cm\x00', 0x2, 0x0)
> > write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000080)={0x0, 0x18,
> > 0xfa00, {0x0, &(0x7f0000000040)={<r1=>0xffffffffffffffff}, 0x13f}},
> > 0x12d)
> > write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000200)={0x3, 0x40,
> > 0xfa00, {{0xa, 0x4e21}, {0xa, 0x0, 0x0, @mcast1}, r1}}, 0x48)
> > write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000340)={0x0, 0x18,
> > 0xfa00, {0x0, &(0x7f0000000300)={<r2=>0xffffffffffffffff}, 0x13f}},
> > 0x20)
> > write$RDMA_USER_CM_CMD_SET_OPTION(r0, &(0x7f00000002c0)={0xe, 0x18,
> > 0xfa00, @id_afonly={&(0x7f0000000000)=0x1, r1, 0x0, 0x2, 0x4}}, 0x20)
> > write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000100)={0x3, 0x40,
> > 0xfa00, {{0x2, 0x4e21}, {0xa, 0x0, 0x0, @local}, r2}}, 0x1ff)
> > write$RDMA_USER_CM_CMD_DESTROY_ID(r0, &(0x7f0000000180)={0x1, 0x10,
> > 0xfa00, {&(0x7f00000000c0), r2}}, 0x18)
>
> This might be fixed in Linux-next now by this commit:
>
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Tue Oct 2 11:48:03 2018 +0300
>
>     RDMA/restrack: Release task struct which was hold by CM_ID object

Jason,

I afraid that the opposite it more accurate.

This issue was introduced by that commit and According to linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/tag/?h=next-20181008
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20181008&id=ae16eea39a86735f4ed0b5a6e9fe43c6cedb13b3
The RDMA tree has commit ed7a01fd3fd77f40b4ef2562b966a5decd8928d2,
which is exactly the one you cited above.
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=ed7a01fd3fd77f40b4ef2562b966a5decd8928d2

Any ideas how?

Thanks

>
>
> Jason

--GAoked8QSizNecZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbvJE4AAoJEORje4g2clinGKEQAKA9y9F6M/cHxxESNdQEDPuZ
I6PpoDNOfSsqgNk2HxszivxggPGFBl2FgoOOJShNkTaFR00bSojEt1E+MBVruokh
UcKufdklDJW4OgrLjpaSIezAOAxvsQydwHoXE7MOQgfftILeMWqT6d1EhR8Yr3qJ
fQKIId60m7CAbFgFOwQjsk1UFhNrXAC1wNuNKnvSifUzgtFw9Q+2iC2Awf5LhVmo
hkjRSStDv6kkYtl/kKSKGAPvWXqLS2J8zmRacTL9a/blhri9yh/2kFeqXPnyoAc8
Wji9S371KGPsBztQR0KD+4+e30CrAUVQU4Yrjv7EJs9n3J/mT7ZYr9yDac+arFyt
bnUlV9O0hVDW1pzJj51xLz8XIyAgxag7UmGNM/EsVxRR+Z3ayEUS3v0VAtnx4Ad7
bhohUzPiOqTAbNTTJIdDs0djqlXvD0+DsreAoK6EAUbtNk8yZO0xtyPygdkrECev
oLb8n9v95eqWPbIABH10WmYCHBsE3lzTe9XTCfV4OpI/bvqUbjErYlauxmgFGELG
CutqUaHy3vngcNE/xA4I2Q1ldhbQIygdJBIv4+y+t1/kjGAwU4C9EJUcIuIss1/H
HCsLDjrO9JRze6QmTzWkSR89+93e5ilwUs6+JoeL8/J1e64bE4Br80LEaVnx95xA
HOFTck/F304asGTg0gef
=wuDR
-----END PGP SIGNATURE-----

--GAoked8QSizNecZ5--
