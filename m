Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E7ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC29214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2UnPXR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC29214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJJAUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:20:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35380 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJAUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:20:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so2412183otl.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eYFPc4s+QwgY+HY9B2CjCHW9yeLVZZtyLJMTEOLHSIk=;
        b=W2UnPXR/V2+7n0pT9Nf2EMmVOVE3ra4JNkdKbP/ZrkxnwjNHiyExIwmsvK838h4C/l
         n7S9KQc8O2zf3IoGaYt4VFKubmBh50NK1am8PaeURY3mnmtFO3PZZB7jSWRVjsQEzBPc
         vld2gM364sT0g6UTuLuu2M7JnZ37ROdtDd7J/Zloy/2MqEQQsb6nORf8eDBST/xMMdFm
         GstGGITuOW6li1HXb/EfVt1YZQo88q16AtXoJLsX7VEr0tTDQ4EdYhgBRxh/2rzb/NwN
         XfamLd/za/Iq9qaPiAlK0PTZVwyPDqv+doONpdsqcGc/7MW9hHRpxF/RLW2GaTS1dfhG
         reYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eYFPc4s+QwgY+HY9B2CjCHW9yeLVZZtyLJMTEOLHSIk=;
        b=LPwXCze8E3gW2ikmvxGnKmoty/D2VWDgyFOtpLhZa6UT6qCzBlZpeNNUXci67XsYls
         ZQ02UQ2ilHv7ZU3m2fltX88CBhwCwTP0lhVpiRElx1NekmHbO8w4LjZ3aYhMo1QsQ/KA
         0w4oUSnikdqN5lo1JQTrR3j6BSXg8wquOfRSo2J0azJe103YYZyVIyYQR/AOjap+UXvb
         takqdjZm1py5ZVvRJJdXlm04PNu4+KXyCHJTfXOgSQJdRPVajvXlR46Vw+o034dDb2tx
         CbXO91ZeRIG/jpuJjUaKCG7mJdBYW2wXeklpuBoHW9DFHRTz6b2RpEV8I/N87vki8HTs
         2dHg==
X-Gm-Message-State: ABuFfogIM+3mALO+79wKRix8CmwRzIBnQFRbBS6rDepuDZ7Cp+kyBMbG
        5KhJEgW/8Gq9C6gDRIcyBM2pZYVHByT5zl0dQWJazQ==
X-Google-Smtp-Source: ACcGV63RZyNZ4EztQRctkUlzK06HSSe+mdSCEvUJRb9LZiKyPAyeUE6LiW8nlHA+OGQ0yN63NBL67VOMWmhnZ4gp2HY=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr17856286otf.242.1539104542365;
 Tue, 09 Oct 2018 10:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181009103752.21482-1-laurent@vivier.eu> <20181009103752.21482-2-laurent@vivier.eu>
 <f14ce318-5a1a-06f3-2e90-91220f39e74b@virtuozzo.com> <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
 <CAG48ez0pAxC+yetPfM+XyS8kfqA4hw1hxjKG55gbF-4qcNWUiA@mail.gmail.com> <795fea1a-97bd-87f5-6a14-6d47a4e42f74@vivier.eu>
In-Reply-To: <795fea1a-97bd-87f5-6a14-6d47a4e42f74@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 19:01:56 +0200
Message-ID: <CAG48ez2HHv5VuW3GXk0ExxLqW-qzq8yuwSQ=8Z=-h7iNH0gizg@mail.gmail.com>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     ktkhai@virtuozzo.com, kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Linux API <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 6:57 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/10/2018 =C3=A0 18:53, Jann Horn a =C3=A9crit :
> > On Tue, Oct 9, 2018 at 6:45 PM Laurent Vivier <laurent@vivier.eu> wrote=
:
> >> Le 09/10/2018 =C3=A0 18:15, Kirill Tkhai a =C3=A9crit :
> >>> On 09.10.2018 13:37, Laurent Vivier wrote:
> >>>> This patch allows to have a different binfmt_misc configuration
> >>>> for each new user namespace. By default, the binfmt_misc configurati=
on
> >>>> is the one of the previous level, but if the binfmt_misc filesystem =
is
> >>>> mounted in the new namespace a new empty binfmt instance is created =
and
> >>>> used in this namespace.
> >>>>
> >>>> For instance, using "unshare" we can start a chroot of an another
> >>>> architecture and configure the binfmt_misc interpreter without being=
 root
> >>>> to run the binaries in this chroot.
> >>>>
> >>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >>>> ---
> >>>>  fs/binfmt_misc.c               | 106 ++++++++++++++++++++++++------=
---
> >>>>  include/linux/user_namespace.h |  13 ++++
> >>>>  kernel/user.c                  |  13 ++++
> >>>>  kernel/user_namespace.c        |   3 +
> >>>>  4 files changed, 107 insertions(+), 28 deletions(-)
> >>>>
> >>>> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> >>>> index aa4a7a23ff99..1e0029d097d9 100644
> >>>> --- a/fs/binfmt_misc.c
> >>>> +++ b/fs/binfmt_misc.c
> >> ...
> >>>> @@ -80,18 +74,32 @@ static int entry_count;
> >>>>   */
> >>>>  #define MAX_REGISTER_LENGTH 1920
> >>>>
> >>>> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns=
)
> >>>> +{
> >>>> +    struct binfmt_namespace *b_ns;
> >>>> +
> >>>> +    while (ns) {
> >>>> +            b_ns =3D READ_ONCE(ns->binfmt_ns);
> >>>> +            if (b_ns)
> >>>> +                    return b_ns;
> >>>> +            ns =3D ns->parent;
> >>>> +    }
> >>>> +    WARN_ON_ONCE(1);
> >>>> +    return NULL;
> >>>> +}
> >>>> +
> >> ...
> >>>> @@ -823,12 +847,34 @@ static const struct super_operations s_ops =3D=
 {
> >>>>  static int bm_fill_super(struct super_block *sb, void *data, int si=
lent)
> >>>>  {
> >>>>      int err;
> >>>> +    struct user_namespace *ns =3D sb->s_user_ns;
> >>>>      static const struct tree_descr bm_files[] =3D {
> >>>>              [2] =3D {"status", &bm_status_operations, S_IWUSR|S_IRU=
GO},
> >>>>              [3] =3D {"register", &bm_register_operations, S_IWUSR},
> >>>>              /* last one */ {""}
> >>>>      };
> >>>>
> >>>> +    /* create a new binfmt namespace
> >>>> +     * if we are not in the first user namespace
> >>>> +     * but the binfmt namespace is the first one
> >>>> +     */
> >>>> +    if (READ_ONCE(ns->binfmt_ns) =3D=3D NULL) {
> >>>> +            struct binfmt_namespace *new_ns;
> >>>> +
> >>>> +            new_ns =3D kmalloc(sizeof(struct binfmt_namespace),
> >>>> +                             GFP_KERNEL);
> >>>> +            if (new_ns =3D=3D NULL)
> >>>> +                    return -ENOMEM;
> >>>> +            INIT_LIST_HEAD(&new_ns->entries);
> >>>> +            new_ns->enabled =3D 1;
> >>>> +            rwlock_init(&new_ns->entries_lock);
> >>>> +            new_ns->bm_mnt =3D NULL;
> >>>> +            new_ns->entry_count =3D 0;
> >>>> +            /* ensure new_ns is completely initialized before shari=
ng it */
> >>>> +            smp_wmb();
> >>>
> >>> (I haven't dived into patch logic, here just small barrier remark fro=
m quick sight).
> >>> smp_wmb() has no sense without paired smp_rmb() on the read side. Pos=
sible,
> >>> you want something like below in read hunk:
> >>>
> >>> +             b_ns =3D READ_ONCE(ns->binfmt_ns);
> >>> +             if (b_ns) {
> >>> +                     smp_rmb();
> >>> +                     return b_ns;
> >>> +             }
> >>>
> >>>
> >>
> >> The write barrier is here to ensure the structure is fully written
> >> before we set the pointer.
> >>
> >> I don't understand how read barrier can change something at this level=
,
> >> IMHO the couple WRITE_ONCE()/READ_ONCE() should be enough to ensure we
> >> have correctly initialized the pointer and the structure when we read
> >> the pointer back.
> >>
> >> I think the pointer itself is the "barrier" to access the memory
> >> modified before.
> >
> > Things don't work that way on alpha, but that's why READ_ONCE()
> > includes an smp_read_barrier_depends():
> >
> > #define __READ_ONCE(x, check)                                          =
 \
> > ({                                                                     =
 \
> >         union { typeof(x) __val; char __c[1]; } __u;                   =
 \
> >         if (check)                                                     =
 \
> >                 __read_once_size(&(x), __u.__c, sizeof(x));            =
 \
> >         else                                                           =
 \
> >                 __read_once_size_nocheck(&(x), __u.__c, sizeof(x));    =
 \
> >         smp_read_barrier_depends(); /* Enforce dependency ordering from=
 x */ \
> >         __u.__val;                                                     =
 \
> > })
> > #define READ_ONCE(x) __READ_ONCE(x, 1)
> >
>
> So my questions are:
>
> - do we need a smp_wmb() barrier if we use READ_ONCE() and WRITE_ONCE()?

Yes.

> - if we need an smp_wmb() barrier, do we need an smp_rmb() barrier as
> the data we want to "protect" are behind an access to the pointer?

No. You only need an smp_read_barrier_depends() to access things
behind the pointer you're reading (documented in a big comment block
in arch/alpha/include/asm/barrier.h); and that barrier is implied by
READ_ONCE(), so you don't have to write it yourself.
