Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF6DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AC9214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDjbi/p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AC9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJIUcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:32:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32798 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:32:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id q50so1566099otd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TRhGGeaPXsaYp2Hu2N/S5hZ7bCrEHRBOB/tebeOhOeY=;
        b=jDjbi/p63yImlnr1Z8+DYNy+l820CAOQxoCDUYC52IYTc9kMbVBPEje9Gjd0p67/EV
         +BMxCoGF0jprd7rIaZv/8nm/PZnyPo+m4jY5QpUrD/yCzHQV8ZoSoAIKohOc5lN3f0lC
         RR9pnbTr4SYT2MGfpUVbkkaqqWb0LDuPimCEMoXL/YWPxdGK470Sv1gRHgaGzkOT/Frx
         pD0u7FEraAmOchlMbKVD1EkYmKEvFv/VIgslOGuB5bwFAEy5cF2bQRh5TkQdPB0Ce5xX
         rt8v0071EURjI2wRgIOl1ZpiOVn05wwOKE5H7UJPvc4CicIvZmc/QZBRC2KS/wpyUyxd
         bvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TRhGGeaPXsaYp2Hu2N/S5hZ7bCrEHRBOB/tebeOhOeY=;
        b=KvXRQPiCMCZVQmr0amWz/IgCfxCkKWWlYkVSii5z+3Y9H9NCW8ky4KdrFoL25HA4we
         bYBMu5AxKxvVo51GO8+iPNaYc/JOSltIVzDXc4VnhISazRB3juqvH6f04APBYqRU+r+Q
         Pe+aGmgT8EBCz/BVxtgb2HzHceid9HYqsez0p4/clKv54PlbxNgfHaXpynfyJYmmTfFp
         2nBTAXtMewBejB0zVQwJ+7+AnfnuG2gsoWLIuRH4Fbe5mxfiFaZkVObyIhjcWmg6159N
         g0Tfblw9Wzst/qjSlsS9at+PxsJ0Gixn4M9ITcclyRHuwyye+xMRQuZwJaZyJg3eds62
         AvpA==
X-Gm-Message-State: ABuFfoj/JOuOjhvueb+ZciE+7SfjNos7Ma5BnNbixNvh30DAVYJ4R206
        Kzfa1FHUP2j8F6SPYam2LJIRIBCT8z71ZG/nJJsJRw==
X-Google-Smtp-Source: ACcGV616jM92JPGqRAiJASzqGfBjkl3wD4L1IyJ4Qh6J6juMV8LjEQ1+jGtrJ4X9adxMwkxffDiSNKueKArAkhs1FA8=
X-Received: by 2002:a9d:2641:: with SMTP id a59mr11175708otb.35.1539090936539;
 Tue, 09 Oct 2018 06:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181009103752.21482-1-laurent@vivier.eu> <20181009103752.21482-2-laurent@vivier.eu>
 <CAG48ez1OVKqRZe6AtTwXSc27AjNF596nt-46J9WPffKu7fNb8Q@mail.gmail.com> <9059ed5a-6a0d-7f4d-7854-48b3ae4cca76@vivier.eu>
In-Reply-To: <9059ed5a-6a0d-7f4d-7854-48b3ae4cca76@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 15:15:10 +0200
Message-ID: <CAG48ez1g6kHP+2Mhfv6j=8JGeM0RDWunW8xPY-P3yeeVW5gs2Q@mail.gmail.com>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Linux API <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, avagin@gmail.com,
        containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:06 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 09/10/2018 =C3=A0 14:43, Jann Horn a =C3=A9crit :
> > On Tue, Oct 9, 2018 at 12:38 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
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
> > [...]
> >> @@ -823,12 +847,34 @@ static const struct super_operations s_ops =3D {
> >>  static int bm_fill_super(struct super_block *sb, void *data, int sile=
nt)
> >>  {
> >>         int err;
> >> +       struct user_namespace *ns =3D sb->s_user_ns;
> >>         static const struct tree_descr bm_files[] =3D {
> >>                 [2] =3D {"status", &bm_status_operations, S_IWUSR|S_IR=
UGO},
> >>                 [3] =3D {"register", &bm_register_operations, S_IWUSR}=
,
> >>                 /* last one */ {""}
> >>         };
> >>
> >> +       /* create a new binfmt namespace
> >> +        * if we are not in the first user namespace
> >> +        * but the binfmt namespace is the first one
> >> +        */
> >> +       if (READ_ONCE(ns->binfmt_ns) =3D=3D NULL) {
> >> +               struct binfmt_namespace *new_ns;
> >> +
> >> +               new_ns =3D kmalloc(sizeof(struct binfmt_namespace),
> >> +                                GFP_KERNEL);
> >> +               if (new_ns =3D=3D NULL)
> >> +                       return -ENOMEM;
> >> +               INIT_LIST_HEAD(&new_ns->entries);
> >> +               new_ns->enabled =3D 1;
> >> +               rwlock_init(&new_ns->entries_lock);
> >> +               new_ns->bm_mnt =3D NULL;
> >> +               new_ns->entry_count =3D 0;
> >> +               /* ensure new_ns is completely initialized before shar=
ing it */
> >> +               smp_wmb();
> >> +               WRITE_ONCE(ns->binfmt_ns, new_ns);
> >> +       }
> >
> > You're still not preventing a concurrent race of two mount() calls,
> > right? What prevents two instances of this code block from running
> > concurrently in two different namespaces? I think you want to take
> > some sort of global lock around this.
> >
>
> My guess was we have only one binfmt superblock by user namespace, so as
> we can't have duplicate superblock, we will not have duplicate binfmt_ns
> structure. This function is only called once in the namespace and I
> think the superblock creation is already protected by some kind of lock.

Ah! Nevermind, I missed the mount_ns().
