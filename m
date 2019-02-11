Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C8FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDF3218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SqiX0il2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfBKQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:37:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44611 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfBKQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:37:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so4559905otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y+WgygOtpVO0gM+ieHP6u5F87v+TX254wZk88lkZFfs=;
        b=SqiX0il20523leaUZO7Dw38Xu6z7Ct3I5gNH6tsjk3SOor7NXieso6+6knlODFRARF
         +MHzR/xdvbH+lUfNPEsFyVg87HaKR4Gi14Mow0TyNFpvFS83EiuNkX6ZoiBUzVAgH6sF
         RAjC4zMoteQ3fN9s64bFKc0qhLk/MjDv8y8oewpW+lS8EqpgtCsh2H6V9/M5+n/p6Hi/
         jdQVVb88/YWQfTQG8G9M/fBD6MAQR9wHHheEu6OMHlGl2XiHlN3Ivecg9a9V+RM18GNi
         5D5HZ6heq54TbMRG21sWsB9jDVp/9nMCp5aoaQ+PxIOeedIkU3FXKZ87AdUZ4/VhL/T8
         cQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y+WgygOtpVO0gM+ieHP6u5F87v+TX254wZk88lkZFfs=;
        b=RkghCwTwztVd4ChAuzkz7y1iWErHw/g30Qb7Rq6MOkznjf7y8bXWews0pLKDo/EZU+
         QG76WyvpCzI/8VXxn4lwdQed3NUZjR1bO4FHft50rOpaNMZYIiwION1+TffgNTfk2zsO
         gWzXItoUoGd1+DFwAAVfHHVSO9TEnBQXvdDvMVZhm9s4BQIe/kN6cOm13JomgxV1utTh
         I7Ag/+gN7CZrdO6ywqo8L07qpjtRrgDWyHi/vTmh62aS9h4Xv3cVT7C76dMaSGKv9Peu
         LTxyVvoClGYNLRiL7YN3qC1s1hSm9+n7P/YczDQ+gvObWgQNurZ+NQKwKb+rWW1DcWrW
         QzhA==
X-Gm-Message-State: AHQUAuYlAazH1U3YZpxh/zPIAKRqCaiYRMXuS5J8L0v02WT1h2l/fKFc
        rz7n3/KLFqr0F2zSWCSHCkLxOqAdF9pNsgfcIV3U/Q==
X-Google-Smtp-Source: AHgI3IabdQ7lZF57qC2GpDfHRURDHsO3iu0cds0tRnOd/QNyPhKQ0SKinNYmkBta3EuPU4wOk+GFAYAvwsMC+Gaa09Y=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr12257432ota.229.1549903072090;
 Mon, 11 Feb 2019 08:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20190207053740.26915-1-dave@stgolabs.net> <20190207053740.26915-2-dave@stgolabs.net>
 <CAJ+HfNg=Wikc_uY9W1QiVCONq3c1GyS44-xbrq-J4gqfth2kwQ@mail.gmail.com> <d92b7b49-81e6-1ac5-4ae4-4909f87bbea8@iogearbox.net>
In-Reply-To: <d92b7b49-81e6-1ac5-4ae4-4909f87bbea8@iogearbox.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 08:37:41 -0800
Message-ID: <CAPcyv4gjUmRdV1jZegLecocj155m7dpQLxQSnF_HQQErD8Gtag@mail.gmail.com>
Subject: Re: [PATCH 1/2] xsk: do not use mmap_sem
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Ira ]

On Mon, Feb 11, 2019 at 7:33 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> [ +Dan ]
>
> On 02/07/2019 08:43 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> > Den tors 7 feb. 2019 kl 06:38 skrev Davidlohr Bueso <dave@stgolabs.net>=
:
> >>
> >> Holding mmap_sem exclusively for a gup() is an overkill.
> >> Lets replace the call for gup_fast() and let the mm take
> >> it if necessary.
> >>
> >> Cc: David S. Miller <davem@davemloft.net>
> >> Cc: Bjorn Topel <bjorn.topel@intel.com>
> >> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> >> CC: netdev@vger.kernel.org
> >> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> >> ---
> >>  net/xdp/xdp_umem.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> >> index 5ab236c5c9a5..25e1e76654a8 100644
> >> --- a/net/xdp/xdp_umem.c
> >> +++ b/net/xdp/xdp_umem.c
> >> @@ -265,10 +265,8 @@ static int xdp_umem_pin_pages(struct xdp_umem *um=
em)
> >>         if (!umem->pgs)
> >>                 return -ENOMEM;
> >>
> >> -       down_write(&current->mm->mmap_sem);
> >> -       npgs =3D get_user_pages(umem->address, umem->npgs,
> >> -                             gup_flags, &umem->pgs[0], NULL);
> >> -       up_write(&current->mm->mmap_sem);
> >> +       npgs =3D get_user_pages_fast(umem->address, umem->npgs,
> >> +                                  gup_flags, &umem->pgs[0]);
> >>
> >
> > Thanks for the patch!
> >
> > The lifetime of the pinning is similar to RDMA umem mapping, so isn't
> > gup_longterm preferred?
>
> Seems reasonable from reading what gup_longterm seems to do. Davidlohr
> or Dan, any thoughts on the above?

Yes, any gup where the lifetime of the corresponding put_page() is
under direct control of userspace should be using the _longterm flavor
to coordinate be careful in the presence of dax. In the dax case there
is no page cache indirection to coordinate truncate vs page pins. Ira
is looking to add a "fast + longterm" flavor for cases like this.
