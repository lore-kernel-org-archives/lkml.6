Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5479BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09FD24788
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EaIvklWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09FD24788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeFVS4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:56:24 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42169 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbeFVS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:56:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so9806361lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2lTSUAHjjANx1f66RsUdetVjOLGqRPeGFWvg/dfFZU=;
        b=EaIvklWmNa5V1AXlLXl5vtuU7OPhl1qZExpRBTWvmIUY4Extcn2XVZCt2fGIPut6fb
         01r2MSYvCwjdNrImi8I4LRpMCzvrrmKggfVnaDGhYF2FDGH2TBcSrjB9zuxR1aIpmSjZ
         v/uiILPbnitRWzhBDWkfxlOlb1zFXtOKflZ354SInGhQE9na1lCRm0DtSKWaE2YRweOl
         oTs+sz7BfcR8tfjFk1Q8JGu8Ry9lTZTnpc08tWrEt3a3OaAklMcjsrwwevINiS3LbLLv
         28uWKAUeBsTcnb9Hu5mRxoUBSHYSlmA5Z5FhsaBJDeRaGo0E8m5sIyVGz7sIrgyT15dj
         c/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2lTSUAHjjANx1f66RsUdetVjOLGqRPeGFWvg/dfFZU=;
        b=SQaL7l30THwv8VdEUaPWZWTXUjsGmr8Kd0iIDZJv5L/KEgybi9pdC19IdSUudVUmDR
         yEtnx/kKIdTynumKDNDkVQn5DhfAIrHimdAMCXh7mwQSGgIfJd0iksHukNLcWTz0I2r7
         78tWDCmQrZkmMrYF2MTfXWIGSSh0WkLFIcogMTUG4QzDabF6ui15AddQit1OSKAYPqR1
         hHmVwpFlM0b86I7tloEHkckPEWAeQ28GveiUW/uOT2WBRBFzhRoLGfeIWYUfRahPMMml
         hBGzR3ygSYoQFuPanTJHpggzNq/yUFdSQMRSrIrbKijpOewVVQCHx2ej26+iYvrEMQa2
         Hwog==
X-Gm-Message-State: APt69E1kwue+WZvrIBjMI19UB/xz6qSrmXKEKGT+fF8sd0ker+Y6E5qe
        9la1Yk3EMqLY/++b37G7/TfQlvjF+OBFy5/6P8zz
X-Google-Smtp-Source: ADUXVKKt63Vi5n8+94BOtcWT2u8S/jiyerTLi21flYlOcAHZh8Qu8J9ekbQGi24/ms6bad55qvzeBTFwQCM/WarjrE4=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr19402lfe.39.1529693781156;
 Fri, 22 Jun 2018 11:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180621033245.10754-1-baijiaju1990@gmail.com>
 <20180621042912.GA4967@bombadil.infradead.org> <20180622092340.dzl2ea7tdkjdkdhg@quack2.suse.cz>
In-Reply-To: <20180622092340.dzl2ea7tdkjdkdhg@quack2.suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jun 2018 14:56:09 -0400
Message-ID: <CAHC9VhTPCmAXjZgo_i=M_Yo9pJXqUJAmAfL7+pYYb6cOSWw9Zw@mail.gmail.com>
Subject: Re: [PATCH] kernel: audit_tree: Fix a sleep-in-atomic-context bug
To:     jack@suse.cz
Cc:     willy@infradead.org, baijiaju1990@gmail.com,
        Eric Paris <eparis@redhat.com>, amir73il@gmail.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:23 AM Jan Kara <jack@suse.cz> wrote:
> On Wed 20-06-18 21:29:12, Matthew Wilcox wrote:
> > On Thu, Jun 21, 2018 at 11:32:45AM +0800, Jia-Ju Bai wrote:
> > > The kernel may sleep with holding a spinlock.
> > > The function call paths (from bottom to top) in Linux-4.16.7 are:
> > >
> > > [FUNC] kmem_cache_alloc(GFP_KERNEL)
> > > fs/notify/mark.c, 439:
> > >             kmem_cache_alloc in fsnotify_attach_connector_to_object
> > > fs/notify/mark.c, 520:
> > >             fsnotify_attach_connector_to_object in fsnotify_add_mark_list
> > > fs/notify/mark.c, 590:
> > >             fsnotify_add_mark_list in fsnotify_add_mark_locked
> > > kernel/audit_tree.c, 437:
> > >             fsnotify_add_mark_locked in tag_chunk
> > > kernel/audit_tree.c, 423:
> > >             spin_lock in tag_chunk
> >
> > There are several locks here; your report would be improved by saying
> > which one is the problem.  I'm assuming it's old_entry->lock.
> >
> >         spin_lock(&old_entry->lock);
> > ...
> >         if (fsnotify_add_inode_mark_locked(chunk_entry,
> >                              old_entry->connector->inode, 1)) {
> > ...
> >         return fsnotify_add_mark_locked(mark, inode, NULL, allow_dups);
> > ...
> >         ret = fsnotify_add_mark_list(mark, inode, mnt, allow_dups);
> > ...
> >         if (inode)
> >                 connp = &inode->i_fsnotify_marks;
> >         conn = fsnotify_grab_connector(connp);
> >         if (!conn) {
> >                 err = fsnotify_attach_connector_to_object(connp, inode, mnt);
> >
> > It seems to me that this is safe because old_entry is looked up from
> > fsnotify_find_mark, and it can't be removed while its lock is held.
> > Therefore there's always a 'conn' returned from fsnotify_grab_connector(),
> > and so this path will never be taken.
> >
> > But this code path is confusing to me, and I could be wrong.  Jan, please
> > confirm my analysis is correct?
>
> Yes, you are correct. The presence of another mark in the list (and the
> fact we pin it there using refcount & mark_mutex) guarantees we won't need
> to allocate the connector. I agree the audit code's use of fsnotify would
> deserve some cleanup.

I'm always open to suggestions and patches (hint, hint) from the
fsnotify experts ;)

-- 
paul moore
www.paul-moore.com
