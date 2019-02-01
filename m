Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C098CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B05A20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n/GQa2gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfBAVFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:05:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36854 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBAVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:05:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so7012097ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC3xedC87FUapAOAnhdYzzrqDWDfPu9PQYgnT1p0Y3Q=;
        b=n/GQa2gcrU/Hc/hQOfNv7wh/WhNCWC4wENWujRKWLdBNd3ZDId+ekGtPxenowUiKEP
         xXH7t20szPhib5sHLMXpPO5AepVvUvLP5MEbLLcFADB/PpYgpwUdco1ojNqmGLhfWk89
         7Nj2cyI5skZIfFC3Qq7UdgzDR/B7qdAA8eqyk/Tr8FniZ+TqxXhEN5G6epSn6sgEWlWN
         xq7eKCM0Zi9zofSt08q+mXlIz1ojt8tJD0UENkcwdjXNYBXI0/g6nDAUqhzbSt/cTaAI
         uhhsS6VCQG2S8yYmFVCGk9VaHBU4LfHurh6c5+jM2hUvQ7HbKKxGJEMc/KIgJGz2SShT
         Ej2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC3xedC87FUapAOAnhdYzzrqDWDfPu9PQYgnT1p0Y3Q=;
        b=SE+MCyy0HYQbPzifCVelRT5SIfZhLz6pX/Sga6aQBGt6drTivHr2eC8c4yujAmVtHq
         wAVgqXSUSW9IeLAsn/k7dDY/wALuch8Hr7XzxqW+WsbnR3AZ/IYp3J/4QfvA1MfPW7sF
         J9NjWKuk/FaxYydOy4ysspliETJewToGKCz4ohXQYJVg6r14tLUz9xWYFsmE9LO3wlOb
         QBHk3RAt1oAEuuTnitT2jKO3xiKtQrt+vkNMZpLZdMTcHYpDewSLvIH3W6jLFH/1y9wq
         nMuxObBS+5EeJqIRcvS+YmS9s5h/Hun1TRqrAJ+M76dTOpYSlMi3cP+R/buHCW0T+CTp
         heHA==
X-Gm-Message-State: AJcUukdo5lqWVUChaGrjGl42MEMO0QmXk/EYpiQbQYLeDhrOiHCEQW4Z
        688KWG0SO198UFkitgHkp+SIWzNcxP8/c32vUW9F
X-Google-Smtp-Source: ALg8bN5t+vo60ogygifAf4dBqL8Yjr/SzBSWK5u+BTERAdYHDDvF/qMOv2ShAKQi9trFLtLpKtHPFSl2jMqJvy3mwwE=
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr33075950ljf.5.1549055134102;
 Fri, 01 Feb 2019 13:05:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <20190201204205.GA26179@archlinux-ryzen>
In-Reply-To: <20190201204205.GA26179@archlinux-ryzen>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 16:05:22 -0500
Message-ID: <CAHC9VhTzy-0cPgD01XyRRPcsgtoV2NZ1NEzun388jPmXmEB-7Q@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Jan 23, 2019 at 01:35:00PM -0500, Richard Guy Briggs wrote:
> > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > it waits for the missing resource to (possibly never) re-appear.
> >
> > Note the comment above user_path_mountpoint_at():
> >  * A umount is a special case for path walking. We're not actually interested
> >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> >  * simply want track down the dentry and vfsmount attached at the mountpoint
> >  * and avoid revalidating the last component.
> >
> > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> >
> > Please see the github issue tracker
> > https://github.com/linux-audit/audit-kernel/issues/100
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/namei.c            |  2 +-
> >  fs/namespace.c        |  2 ++
> >  include/linux/audit.h | 15 ++++++++++-----
> >  include/linux/namei.h |  3 +++
> >  kernel/audit.c        | 10 +++++++++-
> >  kernel/audit.h        |  2 +-
> >  kernel/auditsc.c      |  6 +++---
> >  7 files changed, 29 insertions(+), 11 deletions(-)

...

> >  /* Copy inode data into an audit_names. */
> >  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> > -                   struct inode *inode)
> > +                   struct inode *inode, unsigned int flags)
> >  {
> >       name->ino   = inode->i_ino;
> >       name->dev   = inode->i_sb->s_dev;
> > @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> >       name->gid   = inode->i_gid;
> >       name->rdev  = inode->i_rdev;
> >       security_inode_getsecid(inode, &name->osid);
> > +     if (flags & AUDIT_INODE_NOEVAL) {
>
> I don't know if this has been reported or if I am missing something but
> on next-20190201, this line causes an error with arm allyesconfig (as
> CONFIG_AUDITSYCALL doesn't get selected):

...

>   CC      kernel/audit.o
> kernel/audit.c: In function 'audit_copy_inode':
> kernel/audit.c:2130:14: error: 'AUDIT_INODE_NOEVAL' undeclared (first use in this function); did you mean 'AUDIT_TYPE_NORMAL'?
>   if (flags & AUDIT_INODE_NOEVAL) {
>               ^~~~~~~~~~~~~~~~~~
>               AUDIT_TYPE_NORMAL
> kernel/audit.c:2130:14: note: each undeclared identifier is reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:277: kernel/audit.o] Error 1
> make[1]: *** [Makefile:1699: kernel/audit.o] Error 2
> make: *** [Makefile:296: __build_one_by_one] Error 2

I hadn't seen this reported to the audit list yet, thanks for letting us now.

Richard, please submit a patch to fix this ASAP.  Looking at this, the
obvious fix is to move audit_copy_inode() to auditsc.c, but I'm not
sure if that itself is going to cause problems (it doesn't look like
it).  Actually, thinking out loud, I wonder if we shouldn't move
audit_log_cap(), audit_log_fcaps(), audit_copy_fcaps(), and
audit_log_name() too?

-- 
paul moore
www.paul-moore.com
