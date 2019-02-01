Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C148C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23650214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EjS0WvK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBAW2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:28:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43301 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfBAW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:28:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id x201so4923805lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1L3nD3MeZSQrTi08WK8vTqYNRlNfbWk8MgEQrovkvec=;
        b=EjS0WvK3eTCyfecKrwxVH9CmcBDQgKT9QJoYbZGhdAyAAsih7ELaItAhf9Y1G2B1iM
         fsuijiEfGq+7lXlzGReJQQkCiCeI4f4kT+lpzgc6DMASd0RO8Vtn4qHWS9hMImIthLBW
         vhEuBnLBPt7Du9csGLfZoZm5nzkZjYUBozU7bqnZg6EIbtp7vdv4L6n6LmTXb0CeQOnH
         +x9cd99X/Rv+4JsKjv+j56BoVgWwTDfY337BX4gUIfUtuUOG3PGjIQWJi/T0Y91fB+Vy
         eCH+9hazvCN5KxXJ2M6bW2VsIy9zT1NbLR71awSIGRZjmCHbA0UJlwe8bWJMniUbhz4H
         Wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1L3nD3MeZSQrTi08WK8vTqYNRlNfbWk8MgEQrovkvec=;
        b=X/UISlaSBdy5O2Xo9p/052J+kSB0oXK9E6qCN+WRI+zIPqYAOAx0WI9Kxfnj3z5klT
         4pubZOqzRno616sTOZufpy+TWcEGXFDl9Nj/fJP8omu3dBHg4aZv913ftim5g5CiKyy3
         xP/w6+5AW4cR0zbf7caMsE/op0I1FvCJYzzj6UAhg/1JZ+VRF+ErXQX/2yfpz+8gA7uA
         /6vL0huQGUyt1gXo7cPzcyr3Tl2QRXzYalCqAkl/j0hdouPiWyfjOrXohIk71txEzTdC
         VCkntWlQwLxyKC34ez7bbBZ5An3pcFSXJlkic6hma3NdXiTwLLKh+AdeiVhqEu6IZMWT
         Qu5w==
X-Gm-Message-State: AJcUukeyaZLFJS6tTAmfeoT6HYB4EsRZjsA8o4UAAwUMb9NaIfeSCNNX
        c3gzHDHzQLuOl3soRXrR8KglqMaiSKCzn4M6sAWs
X-Google-Smtp-Source: ALg8bN7VSSTFyPIQZ4ylTqHkLHgTghzfputNEfXuYfdGIfc2EOTHc29plJVEExPQycFdFumFNW0lG73EPUMfa6c5r8c=
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr31779986lfg.117.1549060077955;
 Fri, 01 Feb 2019 14:27:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <20190201204205.GA26179@archlinux-ryzen> <CAHC9VhTzy-0cPgD01XyRRPcsgtoV2NZ1NEzun388jPmXmEB-7Q@mail.gmail.com>
 <20190201215746.poboa7dgz643zsfg@madcap2.tricolour.ca>
In-Reply-To: <20190201215746.poboa7dgz643zsfg@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 17:27:46 -0500
Message-ID: <CAHC9VhRCeazCqm67zrte_uXPmtLRR7YptRsHpq-Ditw2x_wmOA@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 4:57 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-02-01 16:05, Paul Moore wrote:
> > On Fri, Feb 1, 2019 at 3:42 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > > On Wed, Jan 23, 2019 at 01:35:00PM -0500, Richard Guy Briggs wrote:
> > > > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > > > it waits for the missing resource to (possibly never) re-appear.
> > > >
> > > > Note the comment above user_path_mountpoint_at():
> > > >  * A umount is a special case for path walking. We're not actually interested
> > > >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> > > >  * simply want track down the dentry and vfsmount attached at the mountpoint
> > > >  * and avoid revalidating the last component.
> > > >
> > > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > > >
> > > > Please see the github issue tracker
> > > > https://github.com/linux-audit/audit-kernel/issues/100
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  fs/namei.c            |  2 +-
> > > >  fs/namespace.c        |  2 ++
> > > >  include/linux/audit.h | 15 ++++++++++-----
> > > >  include/linux/namei.h |  3 +++
> > > >  kernel/audit.c        | 10 +++++++++-
> > > >  kernel/audit.h        |  2 +-
> > > >  kernel/auditsc.c      |  6 +++---
> > > >  7 files changed, 29 insertions(+), 11 deletions(-)
> >
> > ...
> >
> > > >  /* Copy inode data into an audit_names. */
> > > >  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > > > -                   struct inode *inode)
> > > > +                   struct inode *inode, unsigned int flags)
> > > >  {
> > > >       name->ino   = inode->i_ino;
> > > >       name->dev   = inode->i_sb->s_dev;
> > > > @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > > >       name->gid   = inode->i_gid;
> > > >       name->rdev  = inode->i_rdev;
> > > >       security_inode_getsecid(inode, &name->osid);
> > > > +     if (flags & AUDIT_INODE_NOEVAL) {
> > >
> > > I don't know if this has been reported or if I am missing something but
> > > on next-20190201, this line causes an error with arm allyesconfig (as
> > > CONFIG_AUDITSYCALL doesn't get selected):
> >
> > ...
> >
> > >   CC      kernel/audit.o
> > > kernel/audit.c: In function 'audit_copy_inode':
> > > kernel/audit.c:2130:14: error: 'AUDIT_INODE_NOEVAL' undeclared (first use in this function); did you mean 'AUDIT_TYPE_NORMAL'?
> > >   if (flags & AUDIT_INODE_NOEVAL) {
> > >               ^~~~~~~~~~~~~~~~~~
> > >               AUDIT_TYPE_NORMAL
> > > kernel/audit.c:2130:14: note: each undeclared identifier is reported only once for each function it appears in
> > > make[2]: *** [scripts/Makefile.build:277: kernel/audit.o] Error 1
> > > make[1]: *** [Makefile:1699: kernel/audit.o] Error 2
> > > make: *** [Makefile:296: __build_one_by_one] Error 2
> >
> > I hadn't seen this reported to the audit list yet, thanks for letting us now.
>
> Thanks Nathan for the report.
>
> > Richard, please submit a patch to fix this ASAP.  Looking at this, the
> > obvious fix is to move audit_copy_inode() to auditsc.c, but I'm not
> > sure if that itself is going to cause problems (it doesn't look like
> > it).  Actually, thinking out loud, I wonder if we shouldn't move
> > audit_log_cap(), audit_log_fcaps(), audit_copy_fcaps(), and
> > audit_log_name() too?
>
> They have all been moved in ghak105 v2 patch 2 which is in your queue.
> Lemme think if there is a quicker simpler solution for this patch ...

I think there was some confusion about the patch; see the other
thread.  If you make that small requested change I'll merge it and I
think we can call this resolved.

-- 
paul moore
www.paul-moore.com
