Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A31AC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ABD208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV5onYGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9ABD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeGLQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:39:56 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36399 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:39:55 -0400
Received: by mail-yw0-f195.google.com with SMTP id t198-v6so10677821ywc.3;
        Thu, 12 Jul 2018 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rk9zojcY8gGLr/qBvm3G0913px+0U76+mL5Nt/d2yik=;
        b=BV5onYGxzL4uJL6D7dDUaxj/ZT/bMW1nxFMia85qyCy1YY6d08y4tkpMsqtBak45aJ
         eHuG2IJeXkIJPlqtUHMnf+F9hyn1giBfJv8B53J7/i4hmZm6Yq0Qrkn1+65xcfLib3pt
         QlroYW3xMKBKAo+CMgQ8vZ0bVcBEU3JKXqLS4WeC1oBi6BLP7dqlC7tij+tCMQGwkZXV
         ZIgstXi/4U8zLFtKLQIoAFIxkwT4HDQ5nrf9569PBohwn/w6k2lbhE5KHkrf4MFlPd3Q
         ApiEG9fcQFZJjtbnlSTGEFN3D1D2frk0lqf0ucNVwr1GIFjl4ocT5NPLhCw9wMzizWEa
         HNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rk9zojcY8gGLr/qBvm3G0913px+0U76+mL5Nt/d2yik=;
        b=mEZMBXlzX6bB1nh0ewMEfkTWFEw8npix6cMZYj+c7zZ2FkB9PQfDyVD2fOZPTjPuZX
         8RUm3It/wyJtMPuy4tYXdyUk0ikVMg2ahsPyUEqjdUol7KF983oBqrKAktVm4tu/Q6g5
         RBueb5Ui+VRwlh9hFA9eVK4l5Awa/YYiBuOl2bEtvRuljy6GS/+P2MLej+uMRpVjZ8iF
         YOBaT0hAberRaZqm/B3LyvCUeNIXp9a8w80EbSGSiv8gAERWgbz4j1pwWLUwD0DS8nwp
         Kwk+doh0UmW7DLtrPFlajV6TYcApUxjIr53LtlRnUMczpeSYWwTQD5dSSU6xqxjxQfM7
         WO3A==
X-Gm-Message-State: AOUpUlES13j9E2qDgffPShtijae3GugKTSKLziJVYd29NkWFtLAxaCxT
        dihQ7t0VzBPkyJ7InbZf/qq7soa4YJ6XB85Ofnk=
X-Google-Smtp-Source: AAOMgpdiziPwoCIxIndASDyGGLD+tmULdADAsBRBbDpiH7T+1I7gD50ZZt142xjA6R8spDfZoSpjXfHxzWNf/U4EJ9A=
X-Received: by 2002:a81:9a91:: with SMTP id r139-v6mr1484776ywg.181.1531412978754;
 Thu, 12 Jul 2018 09:29:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:7dc5:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:29:38
 -0700 (PDT)
In-Reply-To: <20180706204521.29654-1-mszeredi@redhat.com>
References: <20180706204521.29654-1-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Jul 2018 19:29:38 +0300
Message-ID: <CAOQ4uxjYxhiBgsVEzpx6Z=f56KFK61gr9R_WAkadKNHiQAFaAg@mail.gmail.com>
Subject: Re: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:45 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> iput() ends up calling ->evict() on new inode, which is not yet initialized
> by owning fs.  So use destroy_inode() instead.
>
> Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
> that it wasn't allocated with new_inode(), which already does the
> insertion).
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
> ---

Al,

Did you loose track of this 4.18 regression fix?

Thanks,
Amir.

>  fs/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 04dd7e0d5142..e7de38c1d9d8 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1050,6 +1050,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  {
>         struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
>         struct inode *old;
> +       bool creating = inode->i_state & I_CREATING;
>
>  again:
>         spin_lock(&inode_hash_lock);
> @@ -1083,6 +1084,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>         inode->i_state |= I_NEW;
>         hlist_add_head(&inode->i_hash, head);
>         spin_unlock(&inode->i_lock);
> +       if (!creating)
> +               inode_sb_list_add(inode);
>  unlock:
>         spin_unlock(&inode_hash_lock);
>
> @@ -1117,12 +1120,12 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>         struct inode *inode = ilookup5(sb, hashval, test, data);
>
>         if (!inode) {
> -               struct inode *new = new_inode(sb);
> +               struct inode *new = alloc_inode(sb);
>
>                 if (new) {
>                         inode = inode_insert5(new, hashval, test, set, data);
>                         if (unlikely(inode != new))
> -                               iput(new);
> +                               destroy_inode(new);
>                 }
>         }
>         return inode;
> --
> 2.14.3
>
