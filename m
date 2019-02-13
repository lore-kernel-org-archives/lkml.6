Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF7C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01878222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3b2z03i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394720AbfBMVIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:08:13 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44691 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394707AbfBMVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:08:11 -0500
Received: by mail-vs1-f67.google.com with SMTP id r201so2281329vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7SvKQ1TvjGYg+UAiVae7QPlYFqhm5NIrukMtQdwxWY=;
        b=N3b2z03i4aRTpxbBVAhcYhwV/Yb17YgJiNfCxc3NVQ4gLb+vr9JaR9RDhpQCiUcbdA
         FQrVruZAwfgyBjvtfWeaxB5Gal2kKotls/ENHIapv0+kOxr6/eCn6LN0KILE2r6jGJDR
         6r6pyPFjq4JcG6hDvCg7vrLTrClqvLOwzBRZIz6BSjCo3ux3b3b1JcUB1NCwNf5yxeEE
         1nXIS3/FtVxVMocLowwQhMblQCNtg10rQ3cgRXLYcj28OEExvHk98WSXFuYRo3opX6CY
         6jioz0acTjXW2yDvWV/SbRCXPYtfuu16j3yeiKgNYIZ+EKJg+F6gyUDGOTMNPE54azKR
         JXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7SvKQ1TvjGYg+UAiVae7QPlYFqhm5NIrukMtQdwxWY=;
        b=eJOjtv4ISIPAnX7iKSNH/v74FZCfmh9MesJ8X3Ltzfa4BUu3NwYFAJgwo2eseAr4zj
         HJhEVpDlWcgF7MT6yDzp/fTVSL0qJJ8K2PptOOpQSraOQsfy+CfE1wHnV6QS2dJ0GYX7
         o/kpu1ZjJth7hdpQHL7JSOGudL+JOVYUzcegw8FUrGF6HcCTJSOzxS4CfbAh1wTdYLlN
         MfrIvjV+2eZw6JahG+/oCACV+Nun2bE/rvyRIXDIbul1h43OCTWJ4vfcCOHTI333Ass2
         ARX0f5jBhLEhfBczwSBNQWza7Vyzja5M4MGwIJd2OuyQ3wJSOfMbWOsfaSwBUkoIgCBU
         eTIQ==
X-Gm-Message-State: AHQUAuZQFPBa2uTi2wTr4w3WV+vk9Du5U5B1T2WEnXMfNaSewzBqakxF
        AG6dI8jzTTAyVVchma6JxLTs3zw7INVyzFQ9nfRo8A==
X-Google-Smtp-Source: AHgI3IaRJOiNgTjLNEyrIVM61sSIMAj0dAyLJrsfA/SMw/ged5fIbGY0i/++T7kmR0blWpByptj29GXn4MJWeO8IDFE=
X-Received: by 2002:a67:ec89:: with SMTP id h9mr92361vsp.119.1550092090173;
 Wed, 13 Feb 2019 13:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20190206195354.40576-1-sqazi@google.com> <20190207041455.GY2217@ZenIV.linux.org.uk>
 <CAKUOC8Xvda0KPkck3Tunksm8gg2aCi8Zf1EWb7VVa_y9rv6j3g@mail.gmail.com>
In-Reply-To: <CAKUOC8Xvda0KPkck3Tunksm8gg2aCi8Zf1EWb7VVa_y9rv6j3g@mail.gmail.com>
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 13 Feb 2019 13:07:58 -0800
Message-ID: <CAKUOC8U8=2oG0vGgjgY6uR3ezw62kR2TsKH1d2mey9j265tFFg@mail.gmail.com>
Subject: Re: [PATCH] fs, ipc: Use an asynchronous version of kern_unmount in IPC
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have any additional concerns?

On Thu, Feb 7, 2019 at 10:43 AM Salman Qazi <sqazi@google.com> wrote:
>
> On Wed, Feb 6, 2019 at 8:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Feb 06, 2019 at 11:53:54AM -0800, Salman Qazi wrote:
> >
> > > This patch solves the issue by removing synchronize_rcu from mq_put_mnt.
> > > This is done by implementing an asynchronous version of kern_unmount.
> > >
> > > Since mntput() sleeps, it needs to be deferred to a work queue.
> > >
> > > Additionally, the callers of mq_put_mnt appear to be safe having
> > > it behave asynchronously.  In particular, put_ipc_ns calls
> > > mq_clear_sbinfo which renders the inode inaccessible for the purposes of
> > > mqueue_create by making s_fs_info NULL.  This appears
> > > to be the thing that prevents access while free_ipc_ns is taking place.
> > > So, the unmount should be able to proceed lazily.
> >
> > Ugh...  I really doubt that it's correct.  The caller is
> >                 mq_put_mnt(ns);
> >                 free_ipc_ns(ns);
> > and we have
> > static void mqueue_evict_inode(struct inode *inode)
> > {
> >
> > ...
> >
> >         ipc_ns = get_ns_from_inode(inode);
> >
> > with
> >
> > static struct ipc_namespace *get_ns_from_inode(struct inode *inode)
> > {
> >         struct ipc_namespace *ns;
> >
> >         spin_lock(&mq_lock);
> >         ns = __get_ns_from_inode(inode);
> >         spin_unlock(&mq_lock);
> >         return ns;
> > }
> >
> > and
> >
> > static inline struct ipc_namespace *__get_ns_from_inode(struct inode *inode)
> > {
> >         return get_ipc_ns(inode->i_sb->s_fs_info);
> > }
> >
> > with ->s_fs_info being the ipc_namespace we are freeing after mq_put_ns()
> >
> > Are you saying that get_ipc_ns() after free_ipc_ns() is safe?  Because
> > ->evict_inode() *IS* called on umount.  What happens to your patch if
> > there was a regular file left on that filesystem?
> >
> > Smells like a memory corruptor...
>
> Actually, the full context in the caller is
>
>         if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
>                 mq_clear_sbinfo(ns);
>                 spin_unlock(&mq_lock);
>                 mq_put_mnt(ns);
>                 free_ipc_ns(ns);
>         }
>
> And
>
> void mq_clear_sbinfo(struct ipc_namespace *ns)
> {
>         ns->mq_mnt->mnt_sb->s_fs_info = NULL;
> }
>
> Therefore, s_fs_info should be NULL before we proceed to unmount.  So,
> as far as I know, it should not be possible to find the ipc_namespace
> from the mount.
