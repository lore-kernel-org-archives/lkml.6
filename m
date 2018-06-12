Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2455BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36520693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGYy94Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeFLGMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:12:49 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36278 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeFLGMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:12:47 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so12682030iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20D5JoSCtEuHKsqV00Qc2uDV5JFL1tztQ3hlbw9h4Oo=;
        b=dGYy94Qwn0jXb4pnBBHASoInffr1cluDirhOICwXtVZAQ4V34wbyLbATmYTpewivD/
         j/ZJ//MdK1YpN9xycn9AR0yI7a6oDefraiC0EFuJe7U8EJ6rIzvC3OkIVoIQckmxKUYd
         2KlR0bZzZnIcBlLZg4uVPUEDGTBkKm5cLXZr+ISglsGbLL6l4VPGrX7VnpKDwigs9WCW
         BiIdYmbUEHJya0cT/PPM/OxeW1mAvyTH5YsGWZ5xf92aublfRZ4pIcx3DVPLxVoqf7GF
         ATTNESfpWBOCE4ecMuiqEJHWzqGUBTfeON45KNz054Aier0nUhbtJK9HDNWqk+vwElQT
         PFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20D5JoSCtEuHKsqV00Qc2uDV5JFL1tztQ3hlbw9h4Oo=;
        b=AeqlDHnW008Wp5gYocLrP3+aZmyv8CMvCsp0oHC6Y91oYvYqNvfiqTvaF7FBNkB59+
         gRg+TmaeUD7jUWOTjQClx0f5C1HEiC0o4Q+qDJduo+D4/UaqlXuEXuSt2bsP7eOPht1J
         ylTO6U7Ed8lj4F27e4pgYmcDsVGCSwUw4/pA/CelMDf9NUYZa1twco7evwKfA0cGy/1r
         6UNBYVaUX07rghWmnqX2qNChWyoTQZICVqXT2FCiidkgIlm5N3DKgXfUy/q/9Chi4gPl
         Xpt1NJHSOOvqxuqMwar5fcs9EAcNZKIjKeWFOxsLWBG/XB2D1ELpkWcAueTFcBvZkhsx
         yEzA==
X-Gm-Message-State: APt69E0Yso3kY1gOnyyCMecHHaYL4cDyfUXIVhnbARYb2N1rRrGdnjIy
        EN6vA1cDjUT+1+ry563V7VF42WK34grxPMEKYBAG/w==
X-Google-Smtp-Source: ADUXVKLz54WpKQnsJh06eSzE9ACZyOOX/Ohh1e3xP9RrbpL/6tYKGs1uxkwWlGYj9DdYfI4FCbWlJAR+ES//nvdHOQk=
X-Received: by 2002:a6b:3a4:: with SMTP id e36-v6mr2018459ioi.297.1528783966529;
 Mon, 11 Jun 2018 23:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180611195744.154962-1-astrachan@google.com> <87bmcgpzno.fsf@xmission.com>
In-Reply-To: <87bmcgpzno.fsf@xmission.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Mon, 11 Jun 2018 23:12:35 -0700
Message-ID: <CANDihLFmc21Ox_pe9S+oimiZcHB-hQLkv4avF7nReu+QjjL2Zg@mail.gmail.com>
Subject: Re: [PATCH] proc: Fix parsing of mount parameters.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Djalal Harouni <tixxdz@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 6:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Alistair Strachan <astrachan@google.com> writes:
>
> > In commit e94591d0d90c "proc: Convert proc_mount to use mount_ns"
> > the parsing of mount parameters for the proc filesystem was broken.
> >
> > The SB_KERNMOUNT for procfs happens via:
> >
> >   start_kernel()
> >     rest_init()
> >       kernel_thread()
> >         _do_fork()
> >            copy_process()
> >              alloc_pid()
> >                pid_ns_prepare_proc()
> >                  kern_mount_data()
> >                    proc_mount()
> >                      mount_ns()
> >
> > In mount_ns(), the kernel calls proc_fill_super() only if the superblock
> > has not previously been set up (i.e. the first mount reference),
> > regardless of SB_KERNMOUNT. Because the call to proc_parse_options() had
> > been moved inside here, and the SB_KERNMOUNT uses no mount options, the
> > option parser became a no-op.
> >
> > When userspace later mounted procfs with e.g. hidepid=2, the options
> > would be ignored.
> >
> > This change backs out a part of the original cleanup and parses the
> > procfs mount options at every mount call. Because the options currently
> > only update the pid_ns for the mount, they are applied for all mounts of
> > proc by that pid or childen of that pid, instantaneously. This is the
> > same behavior as the original code.
>
> Two years for a regression to be reported is a litte long.  I think that
> gets out of the kneejerk immediate fix or revert phase and into thinking
> a little bout about what makes sense in this code.

Android has been using hidepid=2 for a while, but most shipping
products were on 3.18 or 4.4 kernels. To us, it's a new problem.

> As we say with devpts there is a very real danger of someone mounting
> a second instance of proc in a chroot and causing problems by either
> strengthening or weakening the hid pid protections for the entire pid
> namespace.  If we go with your proposed change in behavior.

I guess my change does change the behavior, but it's just back to the
behavior which the kernel had for a good while (~v3.3 thru v4.7).

> Ordinary block device filesystems (like ext4) avoid this problem by
> allowing a second mount and by not parsing the mount options except
> on remount.  What proc currently does.

IMHO, they're not really comparable. You'll only get kernmounts of an
ext4 filesystem when finding rootfs, and in that case the user knows
about the mount and can see it in /proc/mounts, so they know to use -o
remount,<whatever>.

Since the first mount (where the options might have been respected) is
*always* the kernmount done before init, with your change these mount
options for procfs will never be respected. As userspace didn't yet
mount /proc, it can't know /proc was already mounted, in order to know
to use a remount to re-parse the options. The behavior was changed in
a non-obvious way.

> So I think it can be reasonably argued that the change in behavior is
> was an unintentional fix.
>
> I can see an argument for failing the mount of proc if mount options
> are specified or if those mount options differ from the existing mount
> options.
>
> proc_remount's call of proc_parse_options is definitely buggy as it can
> partially succeed and change the pid namespace and return an error code.
> That is bad error handling.
>
> There may be an argument for making these options available in something
> other than a mount of proc.  As they are pid namespace wide.
>
> There may be an argument for multiple instances of proc so that it makes
> sense to process these options during an ordinary mount.
>
>
> Ultimately what I see is that this is a difficult area of semantics that
> there is at least a little room for improvement on, but it is not
> as simple as this proposed change.

An alternative fix might be to ignore the super setup if done from a
kernmount of procfs. IMO, this initial mount shouldn't be considered
the first reference, because it will not pass the mount options and
cannot be observed by userspace. Such a change looks complicated,
though, and it would only be relevant to procfs. It might be better to
roll back the cleanup and implement these semantics directly in the
procfs code.

> > Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns")
> > Signed-off-by: Alistair Strachan <astrachan@google.com>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Djalal Harouni <tixxdz@gmail.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: kernel-team@android.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  fs/proc/inode.c    | 4 ----
> >  fs/proc/internal.h | 1 -
> >  fs/proc/root.c     | 5 ++++-
> >  3 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> > index 2cf3b74391ca..bbbbf348be0a 100644
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -492,13 +492,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
> >
> >  int proc_fill_super(struct super_block *s, void *data, int silent)
> >  {
> > -     struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
> >       struct inode *root_inode;
> >       int ret;
> >
> > -     if (!proc_parse_options(data, ns))
> > -             return -EINVAL;
> > -
> >       /* User space would break if executables or devices appear on proc */
> >       s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
> >       s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 50cb22a08c2f..89b7e845b000 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -264,7 +264,6 @@ static inline void proc_tty_init(void) {}
> >   * root.c
> >   */
> >  extern struct proc_dir_entry proc_root;
> > -extern int proc_parse_options(char *options, struct pid_namespace *pid);
> >
> >  extern void proc_self_init(void);
> >  extern int proc_remount(struct super_block *, int *, char *);
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index 61b7340b357a..d40676a5dd6c 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -36,7 +36,7 @@ static const match_table_t tokens = {
> >       {Opt_err, NULL},
> >  };
> >
> > -int proc_parse_options(char *options, struct pid_namespace *pid)
> > +static int proc_parse_options(char *options, struct pid_namespace *pid)
> >  {
> >       char *p;
> >       substring_t args[MAX_OPT_ARGS];
> > @@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
> >               ns = task_active_pid_ns(current);
> >       }
> >
> > +     if (!proc_parse_options(data, ns))
> > +             return ERR_PTR(-EINVAL);
> > +
> >       return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
> >  }
