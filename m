Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B1EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AAE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LFGi2RGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfA1X0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:26:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40239 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfA1X0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:26:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so13201251lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kye8695DLp3str/2Hf+YhMs+QJtZFuu0kW0X4B9eP8E=;
        b=LFGi2RGPVhcwSi/XXwL7S9vvY9+SNaaJYyrjwSBjy5maa29iMMdRfjTfB1oTDWeigF
         D060Q6bsHCcYlPYJcoRhW6iXkYSMguQ//DXRrWjeU4QMiQnbY+WDRUZ1r27hFo2IktQc
         OKMHESScF4J9N0L4+vMdynV1cA4vmWbp6/u7r9UIiNZc0nDb2Hx0GVgSys1wo65NDULg
         8kmX4SA3sQ0aouz/sy08fTnZXg+0vfwpb2l3BGkgtP9aE1663GqijzGuZ7SuIy2xlCUg
         RsclQuss4nbGV+L8EZu3CyOQArus+IMld+baidHhR9qYSdVjnBJw7Z4wCDcMFxxyUNb5
         hUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kye8695DLp3str/2Hf+YhMs+QJtZFuu0kW0X4B9eP8E=;
        b=uYGZuVBRKQD/OazfAnO1B6N+BP3vZ3JEJowcBTjvk3cMEGEy5HOLJjUNjmkkKurkNu
         ON5rEJJR6IhhWYNLEXyhG/OTlsCcVeC0kxxWPJeloGQReRbfRazE9hUyqZoXbW1lIZZh
         //wzV5unDkW1Cw35CQH7Qz6hM0BFL+s32T68++q29MnJ8avY4vSjusYPSq0S0Cdct4af
         jGkwwlOhda99p4IyFBwGYy0ZrhF0OQz3sY5NmcFew/LjJkkfsG066GX9YAJQJc2RMeiO
         sLDX32pTwekUXJBR3tjkN0t35trSv2fMb4h2yaI1yEtE0X+tgQCudx+HH6q6zlv49e3j
         zJMg==
X-Gm-Message-State: AJcUukfrDIr1K1Xxf65+LwtVVBR7SRetaQoEcPzKzWphEej8LQKEY5bz
        WBzryt0Djg8jpmkwbVA/o8qNl+IK0wJ+/utD6yGz
X-Google-Smtp-Source: ALg8bN5QiT0niTmfQgBVkRdf0ssJI2A+f4xFIdjr2VjQIqjANmc9ndr0KrcnYHVRD1x0IkCs3YouF/atQNF8emOQJWo=
X-Received: by 2002:a19:c995:: with SMTP id z143mr17683320lff.79.1548717966745;
 Mon, 28 Jan 2019 15:26:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <CAHC9VhQ14FtJAMxjmrGNu2-AkJe6ELjHnaEHjULLHjwo2FDhkQ@mail.gmail.com> <20190125222717.x7lyzjn2qfzdzp4k@madcap2.tricolour.ca>
In-Reply-To: <20190125222717.x7lyzjn2qfzdzp4k@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 18:25:55 -0500
Message-ID: <CAHC9VhSGmTKOAXA74_zcBWn=wL1LAxnx91Wv7v9d49Y-QskWBg@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
To:     Richard Guy Briggs <rgb@redhat.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-25 16:45, Paul Moore wrote:
> > On Wed, Jan 23, 2019 at 1:35 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > > it waits for the missing resource to (possibly never) re-appear.
> > >
> > > Note the comment above user_path_mountpoint_at():
> > >  * A umount is a special case for path walking. We're not actually interested
> > >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> > >  * simply want track down the dentry and vfsmount attached at the mountpoint
> > >  * and avoid revalidating the last component.
> > >
> > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > >
> > > Please see the github issue tracker
> > > https://github.com/linux-audit/audit-kernel/issues/100
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/namei.c            |  2 +-
> > >  fs/namespace.c        |  2 ++
> > >  include/linux/audit.h | 15 ++++++++++-----
> > >  include/linux/namei.h |  3 +++
> > >  kernel/audit.c        | 10 +++++++++-
> > >  kernel/audit.h        |  2 +-
> > >  kernel/auditsc.c      |  6 +++---
> > >  7 files changed, 29 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 914178cdbe94..87d7710a2e1d 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -2720,7 +2720,7 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
> > >         if (unlikely(error == -ESTALE))
> > >                 error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
> > >         if (likely(!error))
> > > -               audit_inode(name, path->dentry, 0);
> > > +               audit_inode(name, path->dentry, flags & LOOKUP_NO_EVAL);
> > >         restore_nameidata();
> > >         putname(name);
> > >         return error;
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index a677b59efd74..e5de0e372df2 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -1640,6 +1640,8 @@ int ksys_umount(char __user *name, int flags)
> > >         if (!(flags & UMOUNT_NOFOLLOW))
> > >                 lookup_flags |= LOOKUP_FOLLOW;
> > >
> > > +       lookup_flags |= LOOKUP_NO_EVAL;
> > > +
> > >         retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
> > >         if (retval)
> > >                 goto out;
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index a625c29a2ea2..5d914b534536 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -25,6 +25,7 @@
> > >
> > >  #include <linux/sched.h>
> > >  #include <linux/ptrace.h>
> > > +#include <linux/namei.h>  /* LOOKUP_* */
> > >  #include <uapi/linux/audit.h>
> > >
> > >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> > > @@ -225,6 +226,7 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
> > >
> > >  #define AUDIT_INODE_PARENT     1       /* dentry represents the parent */
> > >  #define AUDIT_INODE_HIDDEN     2       /* audit record should be hidden */
> > > +#define AUDIT_INODE_NOEVAL     4       /* audit record incomplete */
> > >  extern void __audit_inode(struct filename *name, const struct dentry *dentry,
> > >                                 unsigned int flags);
> > >  extern void __audit_file(const struct file *);
> > > @@ -285,12 +287,15 @@ static inline void audit_getname(struct filename *name)
> > >  }
> > >  static inline void audit_inode(struct filename *name,
> > >                                 const struct dentry *dentry,
> > > -                               unsigned int parent) {
> > > +                               unsigned int flags) {
> > >         if (unlikely(!audit_dummy_context())) {
> > > -               unsigned int flags = 0;
> > > -               if (parent)
> > > -                       flags |= AUDIT_INODE_PARENT;
> > > -               __audit_inode(name, dentry, flags);
> > > +               unsigned int aflags = 0;
> > > +
> > > +               if (flags & LOOKUP_PARENT)
> > > +                       aflags |= AUDIT_INODE_PARENT;
> > > +               if (flags & LOOKUP_NO_EVAL)
> > > +                       aflags |= AUDIT_INODE_NOEVAL;
> > > +               __audit_inode(name, dentry, aflags);
> > >         }
> > >  }
> > >  static inline void audit_file(struct file *file)
> > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > index a78606e8e3df..9138b4471dbf 100644
> > > --- a/include/linux/namei.h
> > > +++ b/include/linux/namei.h
> > > @@ -24,6 +24,8 @@
> > >   *  - internal "there are more path components" flag
> > >   *  - dentry cache is untrusted; force a real lookup
> > >   *  - suppress terminal automount
> > > + *  - skip revalidation
> > > + *  - don't fetch xattrs on audit_inode
> > >   */
> > >  #define LOOKUP_FOLLOW          0x0001
> > >  #define LOOKUP_DIRECTORY       0x0002
> > > @@ -33,6 +35,7 @@
> > >  #define LOOKUP_REVAL           0x0020
> > >  #define LOOKUP_RCU             0x0040
> > >  #define LOOKUP_NO_REVAL                0x0080
> > > +#define LOOKUP_NO_EVAL         0x0100
> > >
> > >  /*
> > >   * Intent data
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index ca55ccb46b76..45d5131943eb 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -2081,6 +2081,10 @@ void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
> > >
> > >  static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
> > >  {
> > > +       if (name->fcap_ver == -1) {
> > > +               audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
> > > +               return;
> > > +       }
> > >         audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
> > >         audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
> > >         audit_log_format(ab, " cap_fe=%d cap_fver=%x",
> > > @@ -2111,7 +2115,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
> > >
> > >  /* Copy inode data into an audit_names. */
> > >  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > > -                     struct inode *inode)
> > > +                     struct inode *inode, unsigned int flags)
> > >  {
> > >         name->ino   = inode->i_ino;
> > >         name->dev   = inode->i_sb->s_dev;
> > > @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > >         name->gid   = inode->i_gid;
> > >         name->rdev  = inode->i_rdev;
> > >         security_inode_getsecid(inode, &name->osid);
> > > +       if (flags & AUDIT_INODE_NOEVAL) {
> > > +               name->fcap_ver = -1;
> > > +               return;
> > > +       }
> >
> > I'm not in love with the -1 sentinel, especially without a cast in
> > front of it (style nit I suppose), but I love the idea of adding
> > another flag to audit_names even more.  Since it looks like the
> > version portion of cpu_vfs_cap_data.magic_etc is limited to eight bits
> > I suppose we could break up fcap_ver and use some of the 32 bits for
> > our own flags.  Not sure I like that option any more than the others.
>
> Would you prefer 0xFFFFFFFF, or 0xFF (assuming it somehow needs to be
> compatible with the shifted revision mask), or even 0xFFFFFF00 to avoid
> using those 8 bits?
>
> As far as I know, only one bit of the original 24 magic_etc flag bits is
> used and that is for the fE (file Effective) bit.
>
> > I'm also beginning to wonder why we don't just include the fcaps
> > version info in the audit_cap_data struct; I can't think of a reason
> > why you would ever want to know one without the other.  Thoughts?
>
> I wondered that myself...  struct audit_cap_data is also used in
> audit_context.capset where it has no need of the version since it is
> storing process caps (and the effective field is a union with fE) and in
> audit_context.aux where it is chained in as audit_aux_data_bprm_fcaps
> with three instances of audit_cap_data but only one version.
>
> We could just keep fcap_ver and fE in the original magic_etc and use
> a high order bit of the VFS_CAP_FLAGS_MASK...
>
> Is it worth changing?

Yeah, that is the question I was grappling with last week, and again
now.  Although to be more specific, the question isn't really is it
worth changing, but rather what would be an improvement on this?  I
can think of a few small things, but nothing that would warrant a
respin, especially since this all audit internal so we can change it
without much fuss if needed.

You posted this patch on the 23rd (last Wednesday), let's give the FS
folks another day or two to comment since it does touch their code.
If we don't see any objections by later this week I'll merge it into
audit/next.

-- 
paul moore
www.paul-moore.com
