Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35116C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054432073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh9cYmG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfBDKsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:15 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41928 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbfBDKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:12 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so5440195ywc.8;
        Mon, 04 Feb 2019 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8Km3++BG8GSxxH//qod7Z6Pb2vle8m85XCcbu7Tko4=;
        b=Bh9cYmG/M5XK9+9jBiGSoAy/rG2KIMsEyav1Dw22LFIXcybUX5rmTNpx8FI7BIvGql
         Jrqhp25R87e4rI1lHvNq2vAsMAQzj0mQkmR5io/HxnL2N/j6ONWiu/EUVJpma89wKNW5
         mKDwYcnwtupWBFRSrU0B5Oexn5XE3IWkz2lq18svPkz5Al74qxwn6CYewVAIA6zHZlJL
         HBbohFdu2vuzzCKklokQWYNNf21vEUA9CPbUW4gF7Eu8WUXkVc38tWIcYVD1RaAX49Ed
         PhWoDIDibkFiVuH64yD5QQLNs7bTyyHm2J1pN3xHAnBjtPOQihJEE49BHIY1sCQsPgtc
         /iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8Km3++BG8GSxxH//qod7Z6Pb2vle8m85XCcbu7Tko4=;
        b=MCTd5Kfi3HCbY8/j7hXbiByOR7NdpftMIFG0/OEOqBYsXraIhMYKsJQvufyEGccThX
         DK9JLP8oMctGubyo2daS+MakCG2H4CJhIv+7WT/t13Vc+GJSX5wHhPFtT41Rr+Tm7HOn
         35DoggxO0M9AUx1MGMVq3SfOnyIK7y5/7ItyhkbZiDUUE/xaoA68QzwEeFNQLyf83YAQ
         Y3oKSxpy+qRh/Ys3e5XSTU2x9+84O0FzP1ciPB/vpv11JBIyCUd6AHqOFuVIZWQOEyiK
         l41yS8T5hGUB3yvM2iZbJIFwKyfzQ6w/buJd5h8vmoFEZ6EOy859ZIJc/eVdECOos4dx
         GxOg==
X-Gm-Message-State: AHQUAua3fEOGRdHZ6Zk4nf6fRJEJ80IjfL21i6a2QQDbc66mfKZ0KvWw
        q6jQh+DslO1jYMwcZBHAq7eX9PRROCjubTyHoHo=
X-Google-Smtp-Source: AHgI3IbXB49gSF3Bmn/Tn+mW4lG+QPcDP/cgb3lQFKWF2nc5899fiwKIhozGFCS7O/spzTn9sI8TcWJ/MuW8FC+Z+lA=
X-Received: by 2002:a81:a0c2:: with SMTP id x185mr6834402ywg.241.1549277291317;
 Mon, 04 Feb 2019 02:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20190204103605.271746870@linuxfoundation.org> <20190204103610.774179167@linuxfoundation.org>
In-Reply-To: <20190204103610.774179167@linuxfoundation.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Feb 2019 12:48:00 +0200
Message-ID: <CAOQ4uxhwxgpuzebDdqV61f2ENCVa44XiuKZmLfbnEOYZWvXrLA@mail.gmail.com>
Subject: Re: [PATCH 4.9 30/30] fanotify: fix handling of events on child sub-directory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 12:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> commit b469e7e47c8a075cc08bcd1e85d4365134bdcdd5 upstream.
>
> When an event is reported on a sub-directory and the parent inode has
> a mark mask with FS_EVENT_ON_CHILD|FS_ISDIR, the event will be sent to
> fsnotify() even if the event type is not in the parent mark mask
> (e.g. FS_OPEN).
>
> Further more, if that event happened on a mount or a filesystem with
> a mount/sb mark that does have that event type in their mask, the "on
> child" event will be reported on the mount/sb mark.  That is not
> desired, because user will get a duplicate event for the same action.
>
> Note that the event reported on the victim inode is never merged with
> the event reported on the parent inode, because of the check in
> should_merge(): old_fsn->inode == new_fsn->inode.
>
> Fix this by looking for a match of an actual event type (i.e. not just
> FS_ISDIR) in parent's inode mark mask and by not reporting an "on child"
> event to group if event type is only found on mount/sb marks.
>
> [backport hint: The bug seems to have always been in fanotify, but this
>                 patch will only apply cleanly to v4.19.y]
>

Same comment about this backport hint being misleading in the
context of the backport patch.

> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> [amir: backport to v4.9]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  fs/notify/fsnotify.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -101,9 +101,9 @@ int __fsnotify_parent(struct path *path,
>         parent = dget_parent(dentry);
>         p_inode = parent->d_inode;
>
> -       if (unlikely(!fsnotify_inode_watches_children(p_inode)))
> +       if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
>                 __fsnotify_update_child_dentry_flags(p_inode);
> -       else if (p_inode->i_fsnotify_mask & mask) {
> +       } else if (p_inode->i_fsnotify_mask & mask & ~FS_EVENT_ON_CHILD) {
>                 struct name_snapshot name;
>
>                 /* we are notifying a parent so come up with the new mask which
> @@ -207,6 +207,10 @@ int fsnotify(struct inode *to_tell, __u3
>         else
>                 mnt = NULL;
>
> +       /* An event "on child" is not intended for a mount mark */
> +       if (mask & FS_EVENT_ON_CHILD)
> +               mnt = NULL;
> +
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
>          * be expensive.  It protects walking the *_fsnotify_marks lists.
>
>
