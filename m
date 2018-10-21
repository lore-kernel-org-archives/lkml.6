Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FFFECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B25520843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 06:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiAyAsI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B25520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJUOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 10:55:52 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43076 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJUOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 10:55:51 -0400
Received: by mail-yb1-f195.google.com with SMTP id g75-v6so2283001yba.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9344Oxp5ysUAQiNDm1Sqpr948zAqqLiocH4jL9NBAMY=;
        b=CiAyAsI/lP/fH8SFIOe+lzywAYifGfvTrG3bjUSdg0MA2RRbvJ8e2+aWabT4QAk0lP
         uy8X8yrYDWpI5kN2i/Io46RkGg2K38CatghZauWw5j2c2pfhsD3LovP+GBZGeJ0OWnPC
         Fv7iF7jSUdHogPRSkLmtle0a/FJ3KvCqgixPQZGqZS8taI+E0pRr9Be60mqAxLhI4dDI
         x5dA9FZUlAIi3myLKzuPuVGcTSNris+aaPu99ToFpsAPALsXU5TNlvqtu1ntrMxSIWzH
         0NDgjiofkf7FvoAbLQqUx6sF/VD8mon58GkhvkYKO0m3+0mvnGVkaCvIAlkftPYGHaTR
         uEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9344Oxp5ysUAQiNDm1Sqpr948zAqqLiocH4jL9NBAMY=;
        b=ciX8gMe3POIDRcJ+gBadT0Iwi1N7NO1PsGSQgzFh64cYrGF2yVR72ICL7Aw84zhkJ3
         RveaU/RouNZuK7j5+jRgSnJfI/bK3C8Gg8g/OxPg3ahA6ovaERGGh4GdwpejjdtcJjD9
         CPZAjsbspNT/vbcMT12EWwj4oLPoF7BMlEvftFbe22BQ9Ddr4vQOSYf6Ta4XPcf0+1ra
         /YTVhZCIJzbSVVQHXczUZ4SsQFg/n9oZyOdZBOFOuO/viArvJ6ycGLyoaRAXNXbNS5P0
         NgdlAfhoY5K4PKq1VMq+0T7lC0H9qH9iRz4DIY5xCNSLjkU/hfz5Nmlz9hc2tf8BID/e
         eJrw==
X-Gm-Message-State: AGRZ1gIcXZ5If3djX1r0jm4zg2n1ZmzXwZtetgdBJlId27CuSVa2lda7
        wX1lh+wFOnXXu8ABtcgkMRK8+Ue1uCWQNj+J4i4=
X-Google-Smtp-Source: AJdET5fRCauzzKVjJapM2Af5cKRNjmwUYp+MoFkHUDqStZnGjvOTCrZWA0EhVhfyYp9HqDih9FZ7t5EHfbvYpY45tR8=
X-Received: by 2002:a25:6607:: with SMTP id a7-v6mr1946208ybc.507.1540104155074;
 Sat, 20 Oct 2018 23:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <1540100386-28137-1-git-send-email-rhmcruiser@gmail.com>
In-Reply-To: <1540100386-28137-1-git-send-email-rhmcruiser@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 Oct 2018 09:42:23 +0300
Message-ID: <CAOQ4uxh2Tq90YzYJ=OY0di8MgB9oOhtzBBs94kYGRaE6QoGhgg@mail.gmail.com>
Subject: Re: [PATCH] [fs] exportfs/expfs.c Validate the dentry in
 exportfs_decode_fh function
To:     rhmcruiser@gmail.com
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 8:42 AM Monthero Ronald <rhmcruiser@gmail.com> wrote:
>
>     Linux kernel 3.16
>

So basically, you want to backport Neil Brown's upstream commit
09bb8bfffd29 exportfs: be careful to only return expected errors.
to stable kernel 3.16 maintained by Ben Hutchings.

You got the wrong address for this patch.
And I suspect you did not check upstream for fixes, before writing your patch?
Please try to apply Neil's patch to 3.16 and it it solves your problem
post the backport to Ben Cc: <stable@vger.kernel.org>

>     Strengthen the check for invalid dentry returned by fh_to_dentry,
>     because it does not catch the error when dentry is a non-zero invalid address. This results
>     a kernel panic in nfsd.
>
>     Some details of crashed context and issue:
>     crashed task: nfsd
>     crash> bt | grep RIP
>         [exception RIP: exportfs_decode_fh+0x8d]
>         RIP: ffffffff812947fd  RSP: ffff8808085f7bf0  RFLAGS: 00010207
>
>     Disassembly of crash IP:
>     crash> dis -r ffffffff812947fd | tail
>     0xffffffff812947d0 <exportfs_decode_fh+0x60>:       mov    %r8,%r12
>     0xffffffff812947d3 <exportfs_decode_fh+0x63>:       mov    -0x144(%rbp),%edx
>     0xffffffff812947d9 <exportfs_decode_fh+0x69>:       mov    -0x140(%rbp),%rsi
>     0xffffffff812947e0 <exportfs_decode_fh+0x70>:       callq  0xffffffff81337db0 <__x86_indirect_thunk_rax>
>     0xffffffff812947e5 <exportfs_decode_fh+0x75>:       test   %rax,%rax
>     0xffffffff812947e8 <exportfs_decode_fh+0x78>:       mov    %rax,%r13
>     0xffffffff812947eb <exportfs_decode_fh+0x7b>:       je     0xffffffff812948b0 <exportfs_decode_fh+0x140>
>     0xffffffff812947f1 <exportfs_decode_fh+0x81>:       cmp    $0xfffffffffffff000,%rax
>     0xffffffff812947f7 <exportfs_decode_fh+0x87>:       ja     0xffffffff812948a2 <exportfs_decode_fh+0x132>
>     0xffffffff812947fd <exportfs_decode_fh+0x8d>:       mov    0x30(%rax),%rax            << Crashed here
>
>     Source code of exportfs_decode_fh function context with assembly snippet for the checks
>
>                  /*
>                   * Try to get any dentry for the given file handle from the filesystem.
>                   */
>                  if (!nop || !nop->fh_to_dentry)
>                          return ERR_PTR(-ESTALE);
>                  result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);    => mov    %rax,%r13
>
>     => The dentry returned for this filesystem was corrupted and the value held in RAX was mov    %rax,%r13
>        Register   R13: 0000000000000028    RAX: 0000000000000028
>
>                  if (!result)           < Error check bypassed as dentry was not 0x0 but was still an invalid value 0x28
>                          result = ERR_PTR(-ESTALE);
>                  if (IS_ERR(result))                  < As well
>                          return result;
>
>                  if (S_ISDIR(result->d_inode->i_mode)) {      << Crashed  here during dereference
>
>     In assembly       <exportfs_decode_fh+0x8d>:      mov   0x30(%rax),%rax  << Crashed assembly instruction
>
>     The offset 0x30 for d_inode attempted to dereference was
>     crash> struct dentry -ox | grep d_inode
>       [0x30] struct inode *d_inode;   < Offset
>
>     Register  RAX: 0000000000000028  ( dentry held in result = nop->fh_to_dentry(mnt->mnt_sb,
>                                                                  fid, fh_len, fileid_type); )
>     RAX + offset 0x30  = 0x58 which was the invalid address tried to deference for d_inode
>     from dentry structure and hence the crash
>
>     Crash string: PANIC: "BUG: unable to handle kernel NULL pointer dereference at 0000000000000058  <<
>
> Signed-off-by: Monthero Ronald <rhmcruiser@gmail.com>
> ---
>  fs/exportfs/expfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index b01fbfb..d9e1adf 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -423,12 +423,12 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
>         if (!nop || !nop->fh_to_dentry)
>                 return ERR_PTR(-ESTALE);
>         result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
> -       if (!result)
> -               result = ERR_PTR(-ESTALE);
> -       if (IS_ERR(result))
> -               return result;
> +       if (PTR_ERR(result) == -ENOMEM)
> +               return ERR_CAST(result);
> +       if (IS_ERR_OR_NULL(result))
> +               return ERR_PTR(-ESTALE);
>
> -       if (S_ISDIR(result->d_inode->i_mode)) {
> +       if (d_is_dir(result)) {
>                 /*
>                  * This request is for a directory.
>                  *
> --
> 1.8.3.1
>
