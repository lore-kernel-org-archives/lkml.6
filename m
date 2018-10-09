Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EEEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86BA214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcLeu2sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86BA214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJJALm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:11:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43545 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJJALl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:11:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id k9so2348792otl.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XLScJQ3M0L+Pt8WJbGYIgvxV+Ts8MyCg7P0E5Ju8AQs=;
        b=CcLeu2sj8u7IIqSsPW/L0Oor/Sv1rGkYmrQVD5Ke9gsqdeyRvjzTxHVO78axkMhADn
         vqI2L3IeKDXqVFlNrVdUIHPa9CB6amNxdJkCm1KMzsldVFO6mAQSSWNUjo98fhoQrtI3
         bgJS6B0a8QGIOLsoeajsPQJO4mKh1dS0SuBStXS9nXTT6ueCZpdO1mwpmr74Npfazlyw
         1EzRLlft1/7XqAeYeLpGSOjSkZVYdPocNuUkcXHmVv0cH7AYtuch+IB82nFHl3wtoHPq
         lKbayCzlduuFgDnskwHqYAhfizgAawRGDDHr4glJuHzKT2W9opMFMCKvNVhGx66T18nU
         qE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XLScJQ3M0L+Pt8WJbGYIgvxV+Ts8MyCg7P0E5Ju8AQs=;
        b=dD69eRAEvSxmtZz/GcNd84CtuuloKQK5YMEI+7Ajk27cprj44t2aDqlcVcbHik6R9j
         h6fwmGg6/VB6RoYDy/C26tTF+MPLwu9Kr4eeV53V8yktlCreFdC5yoTzVVSJheczD0Je
         vm1a+litt6ZdpLPUtmtKvSWl5Y9fzBxxJLt5hSU1hAo9v/QdjIAAgllHOzW+MBCTLD5s
         MY2XHOfpablI1nQxXmFYfeGVqpZyHvi2yW+mX5GxxvUM8H5Hr8VtCXdAy5txNoqvmTAU
         yok1KSQIbaQArU56APwld7DZNqnT6rzewwQ1I2VJ5MFMAjkcgIel+frcYDVKhOovGDxe
         4HOg==
X-Gm-Message-State: ABuFfoh1ORSyfcxK1vQz4rgeZUl5rDCKoBJcH8MHJcN9/PEEKSkGqs95
        5ygA0bscywEiaEH1hnLq/b87nxuEqCI2FcvmK1PWTIrVGYU=
X-Google-Smtp-Source: ACcGV63gjdM5pBNIJ8UwKAVE7OEBXu6QrDHb6q+tgfsN8jhG0q1r6mE1koW3qimuN43a/5cgHOmY8IPiIhJp7b4czqM=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr16375411oth.292.1539104028723;
 Tue, 09 Oct 2018 09:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181009103752.21482-1-laurent@vivier.eu> <20181009103752.21482-2-laurent@vivier.eu>
 <f14ce318-5a1a-06f3-2e90-91220f39e74b@virtuozzo.com> <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
In-Reply-To: <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 18:53:22 +0200
Message-ID: <CAG48ez0pAxC+yetPfM+XyS8kfqA4hw1hxjKG55gbF-4qcNWUiA@mail.gmail.com>
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

On Tue, Oct 9, 2018 at 6:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/10/2018 =C3=A0 18:15, Kirill Tkhai a =C3=A9crit :
> > On 09.10.2018 13:37, Laurent Vivier wrote:
> >> This patch allows to have a different binfmt_misc configuration
> >> for each new user namespace. By default, the binfmt_misc configuration
> >> is the one of the previous level, but if the binfmt_misc filesystem is
> >> mounted in the new namespace a new empty binfmt instance is created an=
d
> >> used in this namespace.
> >>
> >> For instance, using "unshare" we can start a chroot of an another
> >> architecture and configure the binfmt_misc interpreter without being r=
oot
> >> to run the binaries in this chroot.
> >>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> ---
> >>  fs/binfmt_misc.c               | 106 ++++++++++++++++++++++++--------=
-
> >>  include/linux/user_namespace.h |  13 ++++
> >>  kernel/user.c                  |  13 ++++
> >>  kernel/user_namespace.c        |   3 +
> >>  4 files changed, 107 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> >> index aa4a7a23ff99..1e0029d097d9 100644
> >> --- a/fs/binfmt_misc.c
> >> +++ b/fs/binfmt_misc.c
> ...
> >> @@ -80,18 +74,32 @@ static int entry_count;
> >>   */
> >>  #define MAX_REGISTER_LENGTH 1920
> >>
> >> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> >> +{
> >> +    struct binfmt_namespace *b_ns;
> >> +
> >> +    while (ns) {
> >> +            b_ns =3D READ_ONCE(ns->binfmt_ns);
> >> +            if (b_ns)
> >> +                    return b_ns;
> >> +            ns =3D ns->parent;
> >> +    }
> >> +    WARN_ON_ONCE(1);
> >> +    return NULL;
> >> +}
> >> +
> ...
> >> @@ -823,12 +847,34 @@ static const struct super_operations s_ops =3D {
> >>  static int bm_fill_super(struct super_block *sb, void *data, int sile=
nt)
> >>  {
> >>      int err;
> >> +    struct user_namespace *ns =3D sb->s_user_ns;
> >>      static const struct tree_descr bm_files[] =3D {
> >>              [2] =3D {"status", &bm_status_operations, S_IWUSR|S_IRUGO=
},
> >>              [3] =3D {"register", &bm_register_operations, S_IWUSR},
> >>              /* last one */ {""}
> >>      };
> >>
> >> +    /* create a new binfmt namespace
> >> +     * if we are not in the first user namespace
> >> +     * but the binfmt namespace is the first one
> >> +     */
> >> +    if (READ_ONCE(ns->binfmt_ns) =3D=3D NULL) {
> >> +            struct binfmt_namespace *new_ns;
> >> +
> >> +            new_ns =3D kmalloc(sizeof(struct binfmt_namespace),
> >> +                             GFP_KERNEL);
> >> +            if (new_ns =3D=3D NULL)
> >> +                    return -ENOMEM;
> >> +            INIT_LIST_HEAD(&new_ns->entries);
> >> +            new_ns->enabled =3D 1;
> >> +            rwlock_init(&new_ns->entries_lock);
> >> +            new_ns->bm_mnt =3D NULL;
> >> +            new_ns->entry_count =3D 0;
> >> +            /* ensure new_ns is completely initialized before sharing=
 it */
> >> +            smp_wmb();
> >
> > (I haven't dived into patch logic, here just small barrier remark from =
quick sight).
> > smp_wmb() has no sense without paired smp_rmb() on the read side. Possi=
ble,
> > you want something like below in read hunk:
> >
> > +             b_ns =3D READ_ONCE(ns->binfmt_ns);
> > +             if (b_ns) {
> > +                     smp_rmb();
> > +                     return b_ns;
> > +             }
> >
> >
>
> The write barrier is here to ensure the structure is fully written
> before we set the pointer.
>
> I don't understand how read barrier can change something at this level,
> IMHO the couple WRITE_ONCE()/READ_ONCE() should be enough to ensure we
> have correctly initialized the pointer and the structure when we read
> the pointer back.
>
> I think the pointer itself is the "barrier" to access the memory
> modified before.

Things don't work that way on alpha, but that's why READ_ONCE()
includes an smp_read_barrier_depends():

#define __READ_ONCE(x, check)                                           \
({                                                                      \
        union { typeof(x) __val; char __c[1]; } __u;                    \
        if (check)                                                      \
                __read_once_size(&(x), __u.__c, sizeof(x));             \
        else                                                            \
                __read_once_size_nocheck(&(x), __u.__c, sizeof(x));     \
        smp_read_barrier_depends(); /* Enforce dependency ordering from x *=
/ \
        __u.__val;                                                      \
})
#define READ_ONCE(x) __READ_ONCE(x, 1)
