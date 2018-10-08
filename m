Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F09F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djoTiV57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F09F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJHSKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:10:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35089 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeJHSKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:10:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id j9-v6so19171621otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApICHchZOvrUbgw6LQgKbxDEtLCUPiixEnHG2TUL65M=;
        b=djoTiV57bcKuUR3s3b6oDe9Z8xaDBTyUp4ptiufRn3MsJB3s050LGJXqgpBEiDz6Gx
         ZBcTzjiZ4Kh4QvSGw7+14o0F4mQduEgfzUhPSdg1s1Tqf2j42h2oEYjhokSnbdb1DHbV
         YPpvPS4pdhVfGVWuUdOyULUvfbi6oJ//2DQSe9ih1CphweYBQhLaqxStV1Dsp+0E7JOD
         i0aR9ejv0cLXQfGhI7wWREvBfNT39MWhGHXdeZ6uspkzJ0fRJ0Hl7zXln140YR3NwGyG
         bkgpgqBXqhB1oVe0Ch5p64c3ZJ7//l8P7egysNhQGVKHjj11+M2PRqPf01XsJJIeg7S9
         VTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApICHchZOvrUbgw6LQgKbxDEtLCUPiixEnHG2TUL65M=;
        b=ERNzTSWhMFQeasZ+vQoODglCNobeVjNRiQl3kQrzfd/tgNL6lPPooMzC2FYUEyJzbl
         kGqrxwYdVGFIYzYVwE5esPCOJRYsxnUj0xHCVBWH4xuNJqIHxJIKKId36CERsmJbASqx
         SGQvEX0Rn6/VXwvpxOIb/jnbA1hbHBchtz8EEUicVt/LJb/MsdbKqPzpFyFrQNqiQsLA
         H1ktkKeLxk/KW69rE8d+yUKKKn3C+wauvfNXZHKx2lWSJjwy/Ai6AoSa21L7YDejzNNP
         TgvQb/FgldJfM8LBRtmKjUvQmGXHchO2owuBK4vU2+uVizuzTvbVS/yIFjZGiBLIqq2W
         YTBA==
X-Gm-Message-State: ABuFfogza7r2lDK/3WQbkoSveBPColqs1yATgxzCs5LKMJNED5nIfsdv
        lwIm1h0tRsC0u1zGbWpXYYCDvgZ2B41WCsjNYzcatoBPl2I=
X-Google-Smtp-Source: ACcGV63VUayPn9+XyyHs49Ek7ZpE8vVrf0mq0aUcXgqpbRYoXg44KMaUuobMTfYWgRWSCCuyO6Lf1AucsEWoDh1Y7S0=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr12791645otb.230.1538996339837;
 Mon, 08 Oct 2018 03:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181003225022.32033-1-laurent@vivier.eu> <20181003225022.32033-2-laurent@vivier.eu>
 <20181006060427.GA15164@gmail.com>
In-Reply-To: <20181006060427.GA15164@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Oct 2018 12:58:33 +0200
Message-ID: <CAG48ez0z2b-xwME25mrEnd7++mTj=07g_L+pZdgowGLY9-xqPQ@mail.gmail.com>
Subject: Re: [RFC v3 1/1] ns: add binfmt_misc to the user namespace
To:     avagin@gmail.com
Cc:     Laurent Vivier <laurent@vivier.eu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@openvz.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 8:04 AM Andrei Vagin <avagin@gmail.com> wrote:
> On Thu, Oct 04, 2018 at 12:50:22AM +0200, Laurent Vivier wrote:
> > This patch allows to have a different binfmt_misc configuration
> > for each new user namespace. By default, the binfmt_misc configuration
> > is the one of the host, but if the binfmt_misc filesystem is mounted
> > in the new namespace a new empty binfmt instance is created and used
> > in this namespace.
> >
> > For instance, using "unshare" we can start a chroot of an another
> > architecture and configure the binfmt_misc interpreter without being root
> > to run the binaries in this chroot.
> >
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> >  fs/binfmt_misc.c               | 85 +++++++++++++++++++++++-----------
> >  include/linux/user_namespace.h | 15 ++++++
> >  kernel/user.c                  | 14 ++++++
> >  kernel/user_namespace.c        |  9 ++++
> >  4 files changed, 95 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > index aa4a7a23ff99..78780bc87506 100644
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> > @@ -38,9 +38,6 @@ enum {
> >       VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
> >  };
> >
> > -static LIST_HEAD(entries);
> > -static int enabled = 1;
> > -
> >  enum {Enabled, Magic};
> >  #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
> >  #define MISC_FMT_OPEN_BINARY (1 << 30)
> > @@ -60,10 +57,7 @@ typedef struct {
> >       struct file *interp_file;
> >  } Node;
> >
> > -static DEFINE_RWLOCK(entries_lock);
> >  static struct file_system_type bm_fs_type;
> > -static struct vfsmount *bm_mnt;
> > -static int entry_count;
> >
> >  /*
> >   * Max length of the register string.  Determined by:
> > @@ -85,13 +79,13 @@ static int entry_count;
> >   * if we do, return the node, else NULL
> >   * locking is done in load_misc_binary
> >   */
> > -static Node *check_file(struct linux_binprm *bprm)
> > +static Node *check_file(struct user_namespace *ns, struct linux_binprm *bprm)
> >  {
> >       char *p = strrchr(bprm->interp, '.');
> >       struct list_head *l;
> >
> >       /* Walk all the registered handlers. */
> > -     list_for_each(l, &entries) {
> > +     list_for_each(l, &ns->binfmt_ns->entries) {
> >               Node *e = list_entry(l, Node, list);
> >               char *s;
> >               int j;
> > @@ -133,17 +127,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
> >       struct file *interp_file = NULL;
> >       int retval;
> >       int fd_binary = -1;
> > +     struct user_namespace *ns = current_user_ns();
> >
> >       retval = -ENOEXEC;
> > -     if (!enabled)
> > +     if (!ns->binfmt_ns->enabled)
> >               return retval;
> >
> >       /* to keep locking time low, we copy the interpreter string */
> > -     read_lock(&entries_lock);
> > -     fmt = check_file(bprm);
> > +     read_lock(&ns->binfmt_ns->entries_lock);
>
> It looks like ns->binfmt_ns isn't protected by any lock and
> ns->binfmt_ns can be changed between read_lock() and read_unlock().
>
> This can be fixed if ns->binfmt_ns will be dereferenced only once in
> this function:
>
>         struct binfmt_namespace *binfmt_ns = ns->binfmt_ns;

Technically, wouldn't you want READ_ONCE(ns->binfmt_ns)?
