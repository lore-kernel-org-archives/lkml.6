Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BCE2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxwQ4Xo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BCE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH1WfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:35:16 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35876 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeH1WfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:35:16 -0400
Received: by mail-yb0-f194.google.com with SMTP id d34-v6so1003259yba.3;
        Tue, 28 Aug 2018 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72jb2gGwS7x6y4GgUk8P2e2+GcHI7zxIQttp7hAKHtk=;
        b=QxwQ4Xo8sQePdz+JtcB8uuwNnWdoV6TOxnHmxG60lJ8dsGYMY7zHxPrqrKK0NL6KWb
         SrSrNJM28xkt4k2A5O+ptbC8pSJvbnqBYsJgLFDyNGBH82xr9yGHAeDokYCd3zd46ii0
         Mff13u/MjYcgJn5Ws6QgYrhVp3rfR5PJMsvFa2nWVooKhQMDHhp5X4btWxhYwS87n0dQ
         zMXvcJsCUwtNA03cWBAnRAJDpD4wrZNUgsESJiwYLVui5ztn4vdjh+r7fr1UYIY3l3po
         bAK5MVRcX22XN4FYI/JeZqmVHiQ3Qvlg4bCNXN/HxyZnRScE2DDtLqxI9KDk+00a3c+q
         NCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72jb2gGwS7x6y4GgUk8P2e2+GcHI7zxIQttp7hAKHtk=;
        b=EMckwudgZLPejGQ9PFYtll2+i64EDyQjY+Ow1gHNcRDSne2LOahjWY1gmxVzAYOQm3
         6vAjMOq4NX5K5hihZZE02EXdRUr0HZPhbBZnefOHPTBwXyTZXpV1FSMS9H4zSO0J9twT
         CNVDRdXa0LgUPLYLNtBemU6mGA5Q3xGhYO3V/g/pjHyPEMECQnhFgiXDUQGMkbKJ/SB9
         26gUfylb9v/il5cJb0yQPiU5DCImuOeYSC1W6y5kQfPluxvo8fUsV8efNtbAbhc4qyDz
         TSkXdnuT3bb9+/avTWO0LyaVs80RusUBbdxdnrkuif7HPJ7A16s0FdTqHLoREHioIDJ9
         I33Q==
X-Gm-Message-State: APzg51D87h+rdGLOWU4D32AO1EsztemwrzpLdw7ZWFUQjWecw9LMgR/P
        boUuOqkabQ+plfUVHLbaS52ahNpYQY/COM556Hk=
X-Google-Smtp-Source: ANB0VdZEsOv4ye//twx6zWHBxHcmvRX0uSkApGf1i+o3vGYbvTBiVHBNaGjrPLKIh/MrxgHbA+jo3I4t4qIDDkTh5UQ=
X-Received: by 2002:a25:1a85:: with SMTP id a127-v6mr1555786yba.507.1535481740341;
 Tue, 28 Aug 2018 11:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180828165319.211563-1-salyzyn@android.com> <CAOQ4uxhRPOC_prhygrjndMMUrtU-S7FrLJ0tb4eJUV94GFj38w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhRPOC_prhygrjndMMUrtU-S7FrLJ0tb4eJUV94GFj38w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Aug 2018 21:42:09 +0300
Message-ID: <CAOQ4uxg=maKZi=5Xet4mC1=uUXftyyKZagj0TBBm8emPDaLmtg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] overlayfs: check CAP_MKNOD before issuing vfs_whiteout
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >
> > Assumption never checked, should fail if the mounter creds are not
> > sufficient.
> >
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > v5
> > - dependency of "overlayfs: override_creds=off option bypass creator_cred"
> > ---
> >  fs/overlayfs/overlayfs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 7538b9b56237..bf3a80157d42 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -176,7 +176,7 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
> >
> >  static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
> >  {
> > -       int err = vfs_whiteout(dir, dentry);
> > +       int err = capable(CAP_MKNOD) ? vfs_whiteout(dir, dentry) : -EPERM;
>
> Should that be ns_capable()? Should the test go into vfs_whiteout()?
> I feel there is no convention at all.
>

Nevermind, I don't think creating a whiteout poses any risk, so don't think
we need to worry about CAP_MKNOD.

Thanks,
Amir.
