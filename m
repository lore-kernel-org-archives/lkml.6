Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D925F208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBFHP5p4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D925F208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeHVXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:03:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38441 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeHVXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:03:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id q15-v6so2113024eds.5;
        Wed, 22 Aug 2018 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ufcz6UeIxBD+E+Tn+2REon+gK2+vFl2qb/k/1cEwa80=;
        b=RBFHP5p4SThrtULxM0EAntnngokvzbpA6LLUPv6/wp3UNYtkGk43WjaKFd+dPmb/02
         AmAR0o080xdZu1fTZ7VYXwc9/9GJaf1DmJ8yJMz+XQfXdkkL1DloA8kAbpndkS85ydRR
         KWGzdhWHw+R+V0kWCXRa8hGtUzzskAg8cQVL8xBAH5YgP1tiSqdtO+Rf/JxDh7vOP/Qr
         H7olWc0ObM2gulKRTc/4jsethrpTYyaIuS7g7x43CXXKRMG81OtuW2cvMDOCFuFzNSZt
         eRw+GUA2j5iL8yTLJAx6HLXV+6be3TlhE+XCJgIOk4ouUfwnACfy2LS98OqaOFUNPQzj
         IfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ufcz6UeIxBD+E+Tn+2REon+gK2+vFl2qb/k/1cEwa80=;
        b=o5LmqOZPMyYvKtZskrSEzLYb+gOPpnyZWPOOtpGk/ijtcKGwEMitbaTg7iYqD9U6v5
         nVRdAoMZ+VxtNiAd9/4qjBAn/2pyUwsfw0I+l9H1MfVIxti6G+4Ur0ez5uuQwsrm7as1
         PAxt+shICUue6UdTv2GiWaxQvHHmJXpRPWHrpa5UqPiBY6zMYF43JJF7sZ3LUa/iYBDX
         2jR0iNjwy+qUA+O83ZId6X2hymcSk7b1mwVcUF7nKydycz6RQ/4LruHjtNZciSOOEgYE
         Ue75fGSfYApQso+ttROX50x5j0cI/dHaPbiET1gnCvc9PTuSff3RG2mhuP/ipoqppyiK
         +Jsw==
X-Gm-Message-State: AOUpUlFWz0TaHOClEc5xYYpEOtNr43r/8J8HHAKE8hqniqhs90AVRIqf
        ymv8Lk0j9/3eHfF/QV1B0cW8gofXf4GuN2XxRDs=
X-Google-Smtp-Source: AA+uWPwUsSx0vUBPr+RUfyhCBHk63zispqC9qQ5fQozFZ6+tSySr9tDNKslNX2FZFofml04Z93qv+6JfUT+ZVXJX0Ds=
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr67142423edc.64.1534966655864;
 Wed, 22 Aug 2018 12:37:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:de42:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 12:37:35
 -0700 (PDT)
In-Reply-To: <20180724130155.20641-1-mszeredi@redhat.com>
References: <20180724064929.GD19722@shao2-debian> <20180724130155.20641-1-mszeredi@redhat.com>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 22 Aug 2018 16:37:35 -0300
Message-ID: <CAB9dFdvzTx3tn=z=he08_+QrpnaPsXQ5qWTGyu65Tv7cy2=L1w@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: don't evict uninitialized inode
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:01 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
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
>  fs/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 04dd7e0d5142..0aa5b29b6f87 100644
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
> @@ -1117,12 +1120,13 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>         struct inode *inode = ilookup5(sb, hashval, test, data);
>
>         if (!inode) {
> -               struct inode *new = new_inode(sb);
> +               struct inode *new = alloc_inode(sb);
>
>                 if (new) {
> +                       new->i_state = 0;
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

FYI with this patch (now merged) I'm seeing warnings whenever an
object is created in an overlayfs mount:

[  842.152673] list_add double add: new=ffff88017efe03d8,
prev=ffff88015c07ad88, next=ffff88017efe03d8.
[  842.152687] WARNING: CPU: 4 PID: 7592 at lib/list_debug.c:31
__list_add_valid+0x6e/0x80

The call stack looks like this, for the file creation case:

[  842.152746]  inode_sb_list_add+0x4e/0x90
[  842.152753]  ? ovl_inode_test+0x20/0x20 [overlay]
[  842.152757]  ? ovl_get_redirect_xattr+0x140/0x140 [overlay]
[  842.152759]  inode_insert5+0x13e/0x1f0
[  842.152764]  ovl_get_inode.cold.16+0x38/0x44 [overlay]
[  842.152768]  ovl_instantiate+0x75/0x130 [overlay]
[  842.152773]  ovl_create_or_link+0x1c9/0x7d0 [overlay]
[  842.152776]  ? ovl_alloc_inode+0x1b/0x80 [overlay]
[  842.152778]  ? inode_sb_list_add+0x4e/0x90
[  842.152782]  ? ovl_fill_inode+0xd8/0x150 [overlay]
[  842.152787]  ovl_create_object+0xa1/0xd0 [overlay]
[  842.152791]  ovl_create+0x23/0x30 [overlay]

.. where the inode passed to inode_insert5 originally comes from
new_inode (ovl_create_object ->  ovl_new_inode -> new_inode), was
already added to the sb list, and doesn't have I_CREATING set.

Originally seen from docker's use of overlayfs, but easily
reproducible by creating a simple overlay of 2 ext4 directories and
creating a new file or directory in the overlay.

Marc
