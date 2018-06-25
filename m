Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08219C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27B25769
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dw+jGbuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A27B25769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeFYWZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:25:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34476 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeFYWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:25:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id l12-v6so2858145lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyR1YY6hnnl2em8Nf3X3cY6j1m0bPCqE33ovi1g3/Sg=;
        b=dw+jGbuZzI6AWOcHt0diGdmQt9BoSlBciUyhb08xBc0AocMvAh3rTyrLe11hrnZwNq
         2aK+D7vw0OZW0EYKDNkl8rrIcq+EbUpz4+KWvbzzPZeO+6fTTPWjL1mdxbq/MdSzDMJV
         5W4f4BTXn6WF18QCsz0Vxd0X6BEELWIU6cxOEhV0Veajk/ipuhJunT7ImsiBGc4hQVu/
         9yniaxFw+MzYg9itMTQJ0u+3d+SJ9tutNdEgwoIUJFK3c+S+4xSEFfiyiXCH4vpakeIW
         6eUUVm6y2LmJy82ZywEmM3D7De/m9Gq8AyJf2Ao+mVG976MaeqJkk2nfeQb+ZDW89zCf
         Z63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyR1YY6hnnl2em8Nf3X3cY6j1m0bPCqE33ovi1g3/Sg=;
        b=q9Mzsxk617gLfAf7UKrN21E+A5ZDz1E1AISFXyGhd9BZgLbNdsJPD5XUkP9/9hlZ5u
         GPwuAMnUc14cYFKIfb9tn/aJaC/R6Sp+u7dAQPkzXWxRycNMaYHXGq/GZb5Rf6dm7lTZ
         zDdjVIs7d9SPrzw+aj1l52kg7Yob+VPHB9npnLv79m1AGXcuN5zm2z2/g7a2iFFg/oG/
         J3Q6XbIPSoRQsie8ggDr6fjAfAm4z406/xt+w1eC4wOUpqkaEslFQHmH8gsXhlriZgBY
         xRrZWgQ1VSWTqZDf/L5nj3826jn/bPKk6A+tMZ3mx8pbl5U0Yz1qG8jVP4N5yt9Tv6B0
         Vv1A==
X-Gm-Message-State: APt69E0E7NV/kICfS9btRl9VzAR2JmhaFEBJ6uiEHZ2lNFEbN2Hu6XR9
        i5YHVvOTrHCeUpLfOFv+uIdoP7vtoStAp7zqa/Az
X-Google-Smtp-Source: ADUXVKL3RCtMdnCGlxu13DTnH7Y9vETZ/SV0uyq6fH/28cc5H55zKm2FiWyH5Fv0OsSHALwMk0yzLWLb3qiYa7hQOOA=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr8412281ljd.72.1529965524223;
 Mon, 25 Jun 2018 15:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180621033245.10754-1-baijiaju1990@gmail.com>
 <20180621042912.GA4967@bombadil.infradead.org> <20180622092340.dzl2ea7tdkjdkdhg@quack2.suse.cz>
 <CAHC9VhTPCmAXjZgo_i=M_Yo9pJXqUJAmAfL7+pYYb6cOSWw9Zw@mail.gmail.com> <20180625092257.kyqnmn4ki7cuqkat@quack2.suse.cz>
In-Reply-To: <20180625092257.kyqnmn4ki7cuqkat@quack2.suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jun 2018 18:25:12 -0400
Message-ID: <CAHC9VhSv7drmJOEapks2W=fqT48TQnv=ERrFGHj4EbmpdgbxbA@mail.gmail.com>
Subject: Re: [PATCH] kernel: audit_tree: Fix a sleep-in-atomic-context bug
To:     jack@suse.cz
Cc:     willy@infradead.org, baijiaju1990@gmail.com,
        Eric Paris <eparis@redhat.com>, amir73il@gmail.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, rgb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:23 AM Jan Kara <jack@suse.cz> wrote:
> On Fri 22-06-18 14:56:09, Paul Moore wrote:
> > On Fri, Jun 22, 2018 at 5:23 AM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 20-06-18 21:29:12, Matthew Wilcox wrote:
> > > > On Thu, Jun 21, 2018 at 11:32:45AM +0800, Jia-Ju Bai wrote:
> > > > > The kernel may sleep with holding a spinlock.
> > > > > The function call paths (from bottom to top) in Linux-4.16.7 are:
> > > > >
> > > > > [FUNC] kmem_cache_alloc(GFP_KERNEL)
> > > > > fs/notify/mark.c, 439:
> > > > >             kmem_cache_alloc in fsnotify_attach_connector_to_object
> > > > > fs/notify/mark.c, 520:
> > > > >             fsnotify_attach_connector_to_object in fsnotify_add_mark_list
> > > > > fs/notify/mark.c, 590:
> > > > >             fsnotify_add_mark_list in fsnotify_add_mark_locked
> > > > > kernel/audit_tree.c, 437:
> > > > >             fsnotify_add_mark_locked in tag_chunk
> > > > > kernel/audit_tree.c, 423:
> > > > >             spin_lock in tag_chunk
> > > >
> > > > There are several locks here; your report would be improved by saying
> > > > which one is the problem.  I'm assuming it's old_entry->lock.
> > > >
> > > >         spin_lock(&old_entry->lock);
> > > > ...
> > > >         if (fsnotify_add_inode_mark_locked(chunk_entry,
> > > >                              old_entry->connector->inode, 1)) {
> > > > ...
> > > >         return fsnotify_add_mark_locked(mark, inode, NULL, allow_dups);
> > > > ...
> > > >         ret = fsnotify_add_mark_list(mark, inode, mnt, allow_dups);
> > > > ...
> > > >         if (inode)
> > > >                 connp = &inode->i_fsnotify_marks;
> > > >         conn = fsnotify_grab_connector(connp);
> > > >         if (!conn) {
> > > >                 err = fsnotify_attach_connector_to_object(connp, inode, mnt);
> > > >
> > > > It seems to me that this is safe because old_entry is looked up from
> > > > fsnotify_find_mark, and it can't be removed while its lock is held.
> > > > Therefore there's always a 'conn' returned from fsnotify_grab_connector(),
> > > > and so this path will never be taken.
> > > >
> > > > But this code path is confusing to me, and I could be wrong.  Jan, please
> > > > confirm my analysis is correct?
> > >
> > > Yes, you are correct. The presence of another mark in the list (and the
> > > fact we pin it there using refcount & mark_mutex) guarantees we won't need
> > > to allocate the connector. I agree the audit code's use of fsnotify would
> > > deserve some cleanup.
> >
> > I'm always open to suggestions and patches (hint, hint) from the
> > fsnotify experts ;)
>
> Yeah, I was looking into it on Friday and today :). Currently I've got a
> bit stuck because I think I've found some races in audit_tree code and I
> haven't yet decided how to fix them. E.g. am I right the following can
> happen?
>
> CPU1                                    CPU2
> tag_chunk(inode, tree1)                 tag_chunk(inode, tree2)
>   old_entry = fsnotify_find_mark();       old_entry = fsnotify_find_mark();
>   old = container_of(old_entry);          old = container_of(old_entry);
>   chunk = alloc_chunk(old->count + 1);    chunk = alloc_chunk(old->count + 1);
>   mutex_lock(&group->mark_mutex);
>   adds new mark
>   replaces chunk
>   old->dead = 1;
>   mutex_unlock(&group->mark_mutex);
>                                           mutex_lock(&group->mark_mutex);
>                                           if (!(old_entry->flags &
>                                                 FSNOTIFY_MARK_FLAG_ATTACHED)) {
>                                             Check fails as old_entry is
>                                             not yet destroyed
>                                           adds new mark
>                                           replaces old chunk again ->
>                                             list corruption, lost refs, ...
>                                           mutex_unlock(&group->mark_mutex);
>
> Generally there's a bigger problem that audit_tree code can have multiple
> marks attached to one inode but only one of them is the "valid" one (i.e.,
> the one embedded in the latest chunk). This is only a temporary state until
> fsnotify_destroy_mark() detaches the mark and then on last reference drop
> we really remove the mark from inode's list but during that window it is
> undefined which mark is returned from fsnotify_find_mark()...
>
> So am I right the above can really happen or is there some higher level
> synchronization I'm missing? If this can really happen, I think I'll need
> to rework the code so that audit_tree has just one mark attached and
> let it probably point to the current chunk.

Full disclosure: I inherited almost all of this code, and aside from
work by Richard to add some new functionality early in my tenure, and
the fixes you've sent, I've not ventured too far into this
audit/fsnotify code.  This means I don't have a quick answer for you,
in fact since you've been digging through the code recently, you're
probably more knowledgeable than I am with this particular corner of
the audit code.

I've added Richard to the CC line; he was the last audit person to
spend any quality time with this code, he may have some insight;
although it has been many years if the git log is to be believed.

As far as the "bigger problem" is concerned, we actually are aware of
this - partially anyway - we just haven't had the cycles to deal with
it:

* https://github.com/linux-audit/audit-kernel/issues/12

-- 
paul moore
www.paul-moore.com
