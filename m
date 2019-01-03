Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D1C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DE820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCM66DbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfACLPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:15:10 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43777 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfACLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:15:09 -0500
Received: by mail-vk1-f193.google.com with SMTP id o130so7171015vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a0n6CyMm6hwl/joSsCPfkxZj3706joqbfmr+h7uXdOc=;
        b=GCM66DbMSmSpgQmrmLCRo11EMFZfyCTkYUyNcXa4j8CCk48gQaAhckRbfc3lgRGp9A
         vcPaw08LBCIDWILKjY0WyQqALYB2sXdZVsnaKKql5DveXwLc20+xFMO5LdrCRi5flMa7
         AV0Vp+SsaWeYQj4iGqc2LuaLNutB3flD6Legh9O8T7Z1w0taD3nvpQ6zf3eSgS2n2eUM
         T++Ozgycx7F6znPQRAaKjDUo2YxJlXxtWtf6nu4rycOPR2CT8cZTJVIgg3ZzxAd68XXh
         UIf0Ha5ZNMTmR9IBTO+tP/LsKMAlBFdiYeBfS7kbpEM+mmVhMABoG2zncJVeDNT6l603
         Zr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a0n6CyMm6hwl/joSsCPfkxZj3706joqbfmr+h7uXdOc=;
        b=QfiN+4rIMKEtrRqZPssqYNZWlg2p6qWXcJAckBZPgRzmUFjCEccyMrzVEQdgEOoLPh
         qJm34GwuDJpfrnmBcGvO1DNEePNsvNp39eV87uHOoI+3GhJdg6vxSSbFgPz2DAtVbx5d
         QRgTx5nKvs3XsvoTFX4OUwPRNUAB8N48hA4QTX66FYUNybyZegbUF3T1fKlbC8BfVn6z
         pWND2rFplp6RtfwZNzw1c7RzeAB4FcSjglzz07apz9Qbi+q/kAW6A6TQtFtbM3R1kixi
         gij2wmW9eZ4jvGvKya5kPn1wrR3XlSd0u7k+dT9b8NPBk2uiqtgIArdAmjTIVG40fQwu
         0pmA==
X-Gm-Message-State: AJcUukcq9VVjVtydcm2Rp/iDZkp1rHoBgI18wrSnfKiGR9fCxopM2nYN
        wNHhJj+bey3KF2qZPgRYkmOesOgSkGdPjiInAyLgI+9EP0M=
X-Google-Smtp-Source: ALg8bN4Q7p6UkkymTi7A6kGiGYO8YuKTQXzHM5XWsN2b6Na2GJJPID2KUpKkNM+Ogf+Jp2dK5mqoesEBCAHeDNxsXa8=
X-Received: by 2002:a1f:6306:: with SMTP id x6mr16928790vkb.26.1546514107035;
 Thu, 03 Jan 2019 03:15:07 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c06550057e4cac7c@google.com> <a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz>
 <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com>
In-Reply-To: <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 3 Jan 2019 12:14:54 +0100
Message-ID: <CAG_fn=Wmjqo8yWesAfF+E2QTT1pqoODaUMA56ufsrDOE_R4snQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in mpol_rebind_mm
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:42 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Jan 3, 2019 at 9:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> >
> > On 12/31/18 8:51 AM, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    79fc24ff6184 kmsan: highmem: use kmsan_clear_page() i=
n cop..
> > > git tree:       kmsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13c48b674=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D901dd030b=
2cc57e7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db19c2dc2c99=
0ea657a71
> > > compiler:       clang version 8.0.0 (trunk 349734)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:353 [in=
line]
> > > BUG: KMSAN: uninit-value in mpol_rebind_mm+0x249/0x370 mm/mempolicy.c=
:384
> >
> > The report doesn't seem to indicate where the uninit value resides in
> > the mempolicy object.
>
> Yes, it doesn't and it's not trivial to do. The tool reports uses of
> unint _values_. Values don't necessary reside in memory. It can be a
> register, that come from another register that was calculated as a sum
> of two other values, which may come from a function argument, etc.
>
> > I'll have to guess. mm/mempolicy.c:353 contains:
> >
> >         if (!mpol_store_user_nodemask(pol) &&
> >             nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
> >
> > "mpol_store_user_nodemask(pol)" is testing pol->flags, which I couldn't
> > see being uninitialized after leaving mpol_new(). So I'll guess it's
> > actually about accessing pol->w.cpuset_mems_allowed on line 354.
> >
> > For w.cpuset_mems_allowed to be not initialized and the nodes_equal()
> > reachable for a mempolicy where mpol_set_nodemask() is called in
> > do_mbind(), it seems the only possibility is a MPOL_PREFERRED policy
> > with empty set of nodes, i.e. MPOL_LOCAL equivalent. Let's see if the
> > patch below helps. This code is a maze to me. Note the uninit access
> > should be benign, rebinding this kind of policy is always a no-op.
If I'm reading mempolicy.c right, `pol->flags & MPOL_F_LOCAL` doesn't
imply `pol->mode =3D=3D MPOL_PREFERRED`, shouldn't we check for both here?

> > ----8<----
> > From ff0ca29da6bc2572d7b267daa77ced6083e3f02d Mon Sep 17 00:00:00 2001
> > From: Vlastimil Babka <vbabka@suse.cz>
> > Date: Thu, 3 Jan 2019 09:31:59 +0100
> > Subject: [PATCH] mm, mempolicy: fix uninit memory access
> >
> > ---
> >  mm/mempolicy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d4496d9d34f5..a0b7487b9112 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -350,7 +350,7 @@ static void mpol_rebind_policy(struct mempolicy *po=
l, const nodemask_t *newmask)
> >  {
> >         if (!pol)
> >                 return;
> > -       if (!mpol_store_user_nodemask(pol) &&
> > +       if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOC=
AL) &&
> >             nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
> >                 return;
> >
> > --
> > 2.19.2
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-bugs/a71997c3-e8ae-a787-d5ce-3db05768b27c%40suse.cz.
> > For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
