Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F570C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70F026AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7xqszTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70F026AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935027AbeFZMm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:42:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35825 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932438AbeFZMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:42:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id e8-v6so15853192oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eLYNtASiDOAlMoqr1YfWqB7aTxNWIQ6KuRvStP7jJY=;
        b=S7xqszTvOHl1zUssczwNZMJ46hU210tWfzZ/ddDQ/PuCleRclRLmCxS0KH7U5N5J6h
         fDgiWzuDOGofQabaG3VJEH2WNe+WfqksuaIWLNopr9AY39+tB/YMHZKW25rFegYLVMO+
         jdCGB4cYXAP31xCHU43Gchg1eMFIXOibO/Nt6ezyDmdzkYzpsWlzNNfujnGytVmbUlFl
         29MpgYSsfM4WE9Myt/T7rN7DfyUrMEZ45adHDyf9mdHDy90N3DG5o36ageor8MIKvakL
         DmyH9jN3lDQlXQVr5To7dH7PSYf/YsLuxMvlSMDZH2Z112zK+A61njRR69bvlsGp+n6D
         erpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eLYNtASiDOAlMoqr1YfWqB7aTxNWIQ6KuRvStP7jJY=;
        b=bO4Ndq4rEUWg7l5D/DwXmkgb+oCPtgdeZFjLEidwEl0AyD3fyt0kdtUL/S7L4/lE+j
         09u3GqJQmlXrjsVunAcUbkcx5AhGtyQisnpF0itl0REOR9u3FVLiMPtj9VnflUGnWH2V
         CPWgL/5dy9h1AKpXSWLV7IJegDkeXl1L9Lj+G0Ko8YRDIGRFBQB3jEpIzTYDgqgqq4ZO
         HmyceZjBVTuyc33qejWZ5Tqb1LBRTgcEDG50H4AMgl3LGYYDzJJSVYF4yL/VfTYHbIv9
         K6Kbl3hgPgFsG66oldxrSpye4I3O1Dm6GAPGVPwZL40xZexjhwqOUeqNETEc9q/7m18J
         rUwA==
X-Gm-Message-State: APt69E0SDty73S6Pgf/56ehULcIkWYDmKmALKvB8CVtLM74bjZH2K5uY
        ggCSW+XzHYcc1+Jz27scUAvhn1rUkp8U4zEQ8osmig==
X-Google-Smtp-Source: AAOMgpe2dKit4cBbw92j0hCjFsLwiB4UtJp0v9J+7Qs9ZZZ0hXaLPfupuWJMWg0899qmUHLKcw7UZtFPpj/uzmpO9JM=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr781807oib.91.1530016975567;
 Tue, 26 Jun 2018 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
In-Reply-To: <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Jun 2018 14:42:43 +0200
Message-ID: <CAG48ez1oRA7ysqWXnNX3eGMm4P=dtakmVGuQamUrEz9i_9nvEg@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 06/25/2018 12:34 PM, Jann Horn wrote:
> > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > stall indefinitely, which can block fsi->mutex if it is held.
> >
> > For sel_read_policy(), remove the locking, since this method doesn't seem
> > to access anything that requires locking.
> >
> > For sel_read_bool(), move the user access below the locked region.
> >
> > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > up above the locked region.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> do we need it to be back-ported any further than the commit which introduced it.

You can also use FUSE, if the system is configured appropriately:
Mount a FUSE filesystem, mmap() a file from it, then pass a pointer to
the mmapped region to a syscall. AFAICS FUSE was added to the kernel
in commit d8a5ba45457e4a22aa39c939121efd7bb6c76672, first in
v2.6.16.28.

> Otherwise, you can add my
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

This patch should go through Paul Moore's tree, right?

> > ---
> >  security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 44 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index f3d374d2ca04..065f8cea84e3 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
> >       struct policy_load_memory *plm = filp->private_data;
> >       int ret;
> >
> > -     mutex_lock(&fsi->mutex);
> > -
> >       ret = avc_has_perm(&selinux_state,
> >                          current_sid(), SECINITSID_SECURITY,
> >                         SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
> >       if (ret)
> > -             goto out;
> > +             return ret;
> >
> > -     ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
> > -out:
> > -     mutex_unlock(&fsi->mutex);
> > -     return ret;
> > +     return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
> >  }
> >
> >  static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
> > @@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
> >       ret = -EINVAL;
> >       if (index >= fsi->bool_num || strcmp(name,
> >                                            fsi->bool_pending_names[index]))
> > -             goto out;
> > +             goto out_unlock;
> >
> >       ret = -ENOMEM;
> >       page = (char *)get_zeroed_page(GFP_KERNEL);
> >       if (!page)
> > -             goto out;
> > +             goto out_unlock;
> >
> >       cur_enforcing = security_get_bool_value(fsi->state, index);
> >       if (cur_enforcing < 0) {
> >               ret = cur_enforcing;
> > -             goto out;
> > +             goto out_unlock;
> >       }
> >       length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
> >                         fsi->bool_pending_values[index]);
> > -     ret = simple_read_from_buffer(buf, count, ppos, page, length);
> > -out:
> >       mutex_unlock(&fsi->mutex);
> > +     ret = simple_read_from_buffer(buf, count, ppos, page, length);
> > +out_free:
> >       free_page((unsigned long)page);
> >       return ret;
> > +
> > +out_unlock:
> > +     mutex_unlock(&fsi->mutex);
> > +     goto out_free;
> >  }
> >
> >  static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
> > @@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
> >       unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
> >       const char *name = filep->f_path.dentry->d_name.name;
> >
> > +     if (count >= PAGE_SIZE)
> > +             return -ENOMEM;
> > +
> > +     /* No partial writes. */
> > +     if (*ppos != 0)
> > +             return -EINVAL;
> > +
> > +     page = memdup_user_nul(buf, count);
> > +     if (IS_ERR(page))
> > +             return PTR_ERR(page);
> > +
> >       mutex_lock(&fsi->mutex);
> >
> >       length = avc_has_perm(&selinux_state,
> > @@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
> >                                            fsi->bool_pending_names[index]))
> >               goto out;
> >
> > -     length = -ENOMEM;
> > -     if (count >= PAGE_SIZE)
> > -             goto out;
> > -
> > -     /* No partial writes. */
> > -     length = -EINVAL;
> > -     if (*ppos != 0)
> > -             goto out;
> > -
> > -     page = memdup_user_nul(buf, count);
> > -     if (IS_ERR(page)) {
> > -             length = PTR_ERR(page);
> > -             page = NULL;
> > -             goto out;
> > -     }
> > -
> >       length = -EINVAL;
> >       if (sscanf(page, "%d", &new_value) != 1)
> >               goto out;
> > @@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
> >       ssize_t length;
> >       int new_value;
> >
> > +     if (count >= PAGE_SIZE)
> > +             return -ENOMEM;
> > +
> > +     /* No partial writes. */
> > +     if (*ppos != 0)
> > +             return -EINVAL;
> > +
> > +     page = memdup_user_nul(buf, count);
> > +     if (IS_ERR(page))
> > +             return PTR_ERR(page);
> > +
> >       mutex_lock(&fsi->mutex);
> >
> >       length = avc_has_perm(&selinux_state,
> > @@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
> >       if (length)
> >               goto out;
> >
> > -     length = -ENOMEM;
> > -     if (count >= PAGE_SIZE)
> > -             goto out;
> > -
> > -     /* No partial writes. */
> > -     length = -EINVAL;
> > -     if (*ppos != 0)
> > -             goto out;
> > -
> > -     page = memdup_user_nul(buf, count);
> > -     if (IS_ERR(page)) {
> > -             length = PTR_ERR(page);
> > -             page = NULL;
> > -             goto out;
> > -     }
> > -
> >       length = -EINVAL;
> >       if (sscanf(page, "%d", &new_value) != 1)
> >               goto out;
> >
>
