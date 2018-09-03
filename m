Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8780120862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ2cWVJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeICUZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:25:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46405 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeICUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:25:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so1679716oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtUjP5ObZzzXIgXiAmw4XLtRO+8ysTLyMdkscW0oDWQ=;
        b=dJ2cWVJrkUiPNtJhK4/t6ZST1Wtia/dlZcFVctHQ1Zpqc88dm76PDCh3tjC6SS07JH
         EYvfa+hym65uBjIi/oCIvdUFV6tz+MT5pTMMG+RbmXUjQZFEgnMTeFMr7285Xp+SKNKV
         dksgB5DWWdYjMb4bu6ar4t85b4N+OdfpJJXbUb756xaucA1kmiArLq372e+q53tte2tP
         RpUCs1TQjRmySrcDgjIuf/pAS+0KEW9anKurpfRl8Uzuv3BQaptoFMepNN1CMpnh8Gqx
         NstVSZfbO+KiTnhcN3UF/lAoia8WE+Qq2U3+eBTP0zA0RmufKpCHefIsuQKfoKx1opoR
         nbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtUjP5ObZzzXIgXiAmw4XLtRO+8ysTLyMdkscW0oDWQ=;
        b=fWGPoUXB/uScbYVNqf7hjtz7grCcbfl+Ykt7g2H0RG3IMlZ3dffI6vqTsi1MQuJo+r
         s19VqaxpuLdUIMdTCrdesDHj8SQdEfeWhhtnSs0Ri0zb3I7pT6vmzlxMbXmOXpDxRMyh
         zL75u23jwMtaSV9qN9Zxki8FCVoS+4yaoQvjtVIZxMXi5NWg3Hg3TQ9d4eow0SYrPXfO
         S2YcGi8i/XHjBnQxt4a3o7Wry19AGUlExEf7wu/u+nAVqX4OxdCQet9myJdjflvoc5n2
         ogPudGcKJLWnHxiKMhKuR+Tt5qzkODMsLVioC5h+sXnLHyy8bG/0wVkoPFqinOy1LrGq
         8qDQ==
X-Gm-Message-State: APzg51CkcCNEkM7gYnp8YtEs251aRUjx9gtfTVEK2anzahPn3V1hCa4d
        tS/Ak1aFUv0CScBom5+4k40YG8RamtbE6yZpJFnprA==
X-Google-Smtp-Source: ANB0VdYAiECq5uXMpzbviVrXEGBb7N3JcrAC828IUc9WF8lnR+CqkKggaQSKrjy1NtBg2odi4Bj7bx+/x2QKqRqb1cU=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr20946380oia.229.1535990674361;
 Mon, 03 Sep 2018 09:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180802163335.83312-1-jannh@google.com>
In-Reply-To: <20180802163335.83312-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Sep 2018 18:04:08 +0200
Message-ID: <CAG48ez1eD=govPAZcO0C3Q8VCS0SqqsZFNpV72OvvxouhZt9eQ@mail.gmail.com>
Subject: Re: [PATCH] reiserfs: propagate errors from fill_with_dentries properly
To:     reiserfs-devel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 6:33 PM Jann Horn <jannh@google.com> wrote:
>
> fill_with_dentries() failed to propagate errors up to
> reiserfs_for_each_xattr() properly. Plumb them through.
>
> Note that reiserfs_for_each_xattr() is only used by
> reiserfs_delete_xattrs() and reiserfs_chown_xattrs().
> The result of reiserfs_delete_xattrs() is discarded anyway, the only
> difference there is whether a warning is printed to dmesg.
> The result of reiserfs_chown_xattrs() does matter because it can block
> chowning of the file to which the xattrs belong; but either way, the
> resulting state can have misaligned ownership, so my patch doesn't improve
> things greatly.
>
> Credit for making me look at this code goes to Al Viro, who pointed
> out that the ->actor calling convention is suboptimal and should be
> changed.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Ping.

> ---
> I have tested this by manually patching error injection into
> fill_with_dentries().
>
> Opinions? Is this a sensible change?
>
> Because the changes in this patch are more superficial than the changes
> in the other one, I split this out so that the security patch is a
> clean change that obviously belongs in stable and can hopefully go in
> quickly.
>
> After the cases I can see where errors are returned improperly are
> cleaned up, I plan to change the calling convention for ->actor as
> suggested by Al Viro.
>
>  fs/reiserfs/xattr.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
> index ff94fad477e4..ae4a28410dbd 100644
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -185,6 +185,7 @@ struct reiserfs_dentry_buf {
>         struct dir_context ctx;
>         struct dentry *xadir;
>         int count;
> +       int err;
>         struct dentry *dentries[8];
>  };
>
> @@ -207,6 +208,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
>
>         dentry = lookup_one_len(name, dbuf->xadir, namelen);
>         if (IS_ERR(dentry)) {
> +               dbuf->err = PTR_ERR(dentry);
>                 return PTR_ERR(dentry);
>         } else if (d_really_is_negative(dentry)) {
>                 /* A directory entry exists, but no file? */
> @@ -215,6 +217,7 @@ fill_with_dentries(struct dir_context *ctx, const char *name, int namelen,
>                                "not found for file %pd.\n",
>                                dentry, dbuf->xadir);
>                 dput(dentry);
> +               dbuf->err = -EIO;
>                 return -EIO;
>         }
>
> @@ -262,6 +265,10 @@ static int reiserfs_for_each_xattr(struct inode *inode,
>                 err = reiserfs_readdir_inode(d_inode(dir), &buf.ctx);
>                 if (err)
>                         break;
> +               if (buf.err) {
> +                       err = buf.err;
> +                       break;
> +               }
>                 if (!buf.count)
>                         break;
>                 for (i = 0; !err && i < buf.count && buf.dentries[i]; i++) {
> --
> 2.18.0.597.ga71716f1ad-goog
>
