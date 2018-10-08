Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A87C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BDB20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="wkdUaX0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BDB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJID5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:57:22 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40676 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJID5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:57:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id w7-v6so8839966ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SofTPVKrem4Eo86PYDtaVpAOpLJ/n1mtpBidSMh7xO0=;
        b=wkdUaX0nTYAnQgFsC/7MAHJhMpL+KCPS/rODPBPp4cbKdLA8JiTdECsO5KR6DMZEdX
         yLtJCKXFLCD4HjVkGEh68kjgeHDIvwBOy6E9ApRLRR1coCX6m7/7O/LTZ7QIepMUApRy
         zwlSsMYAr+fE6xukkFFoXhG8xMOSLHfOUUe8wLFg8K8rOYo8rq97ep+KfRkjtErRLUC0
         Ny1UrSGGdiQYns+DI879Uyt0zZqEyXlHktwFVD+jmALb9qOa8kngLHToMPF8oIQePM1p
         5IyDXfHeyW74cQYwzGIrY21RHxjB4t6yoro/jReziMz6bsdkvhSt6aveBKsiVOutXs7i
         ZWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SofTPVKrem4Eo86PYDtaVpAOpLJ/n1mtpBidSMh7xO0=;
        b=iEGVe/ho5O4I/38fTZqkrvZrILm7i73ZuqtzlDLSXtQT+spHA4P4JfEoYXmKM7n91E
         J2Jws3Qce4eKpR6nGruz223k8HzRaTjd1XPK9QAfXRw6Hu9WzetOh81zmhpwfXyKRJmr
         jLtE8tauFBx7EYrwPMgZkX372FJgpR4ZVC28CBTaTVR8rlcdCcwpGNi003wA58HqOiTo
         4oLlt2CcW77oVzvGVQ2RzZHuu437gRrX3JhMmuTDZFExjc3LD6HN6PmyJQzDq8N3ob+c
         z83lwk5I0MKJO/PebWkdHNVkEB+LV/MtyRGxti67yrjHDDoZ6du7H7kPs29kNlVwSMpd
         9kig==
X-Gm-Message-State: ABuFfohGTn6sNo9AY3v2z1bJ/Srbmkfyt/5OzXeo2Pusm/SvYuEiYf1t
        riQVkx7yWqYRItXni/i22YtY2RitG+Q/HFeqZ4NYBA==
X-Google-Smtp-Source: ACcGV60qaSXskss7uzUtXhCQ+Lgzijc/hsfxxezYqC3Mt6CKXsHrfUQAxzgfZOnzt/o47XPYCu38LIPLJQl9Phzfirc=
X-Received: by 2002:a25:9191:: with SMTP id w17-v6mr13763123ybl.316.1539031427797;
 Mon, 08 Oct 2018 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181007232736.3780-1-martin@omnibond.com>
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 8 Oct 2018 16:43:36 -0400
Message-ID: <CAOg9mSTBRni_NVtTr2-W8g7e3LromGrpSww3MOJRNSw=Y_-oaA@mail.gmail.com>
Subject: Re: [PATCH 00/19] [V2] orangefs: page cache
To:     Martin Brandenburg <martin@omnibond.com>
Cc:     devel@lists.orangefs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I still hit writepages_callback not private! on xfstests generic/127...

-Mike
On Sun, Oct 7, 2018 at 7:27 PM Martin Brandenburg <martin@omnibond.com> wrote:
>
> V2... see https://marc.info/?l=linux-fsdevel&m=153721507330730&w=2
>
> One important change is the following, without which an unaligned write
> may end up written to the beginning of its page.  Surprisingly xfstests
> did not catch this.  This was caught by an invalidate_inode_pages2 call
> in read_iter (not part of this patch series) which exposed the bug.
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 34b98d2ed377..cd1263c45bb2 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -56,7 +54,7 @@ static int orangefs_writepage_locked(struct page *page,
>
>         bv.bv_page = page;
>         bv.bv_len = wlen;
> -       bv.bv_offset = 0;
> +       bv.bv_offset = off % PAGE_SIZE;
>         iov_iter_bvec(&iter, ITER_BVEC | WRITE, &bv, 1, wlen);
>
>         ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
>
> The other big thing is an improved releasepage implementation and a
> launder_page implementation.
>
> We also size the writepages buffer based on the client core buffer.
> However I'm not happy with the memory allocation in writepages.
>
> Mike, I know you've had some trouble with the original series.  I'd like
> to know if this fixes that.
>
> Martin Brandenburg (19):
>   orangefs: implement xattr cache
>   orangefs: do not invalidate attributes on inode create
>   orangefs: simplify orangefs_inode_getattr interface
>   orangefs: update attributes rather than relying on server
>   orangefs: hold i_lock during inode_getattr
>   orangefs: set up and use backing_dev_info
>   orangefs: let setattr write to cached inode
>   orangefs: reorganize setattr functions to track attribute changes
>   orangefs: remove orangefs_readpages
>   orangefs: service ops done for writeback are not killable
>   orangefs: migrate to generic_file_read_iter
>   orangefs: implement writepage
>   orangefs: skip inode writeout if nothing to write
>   orangefs: write range tracking
>   orangefs: avoid fsync service operation on flush
>   orangefs: use kmem_cache for orangefs_write_request
>   orangefs: implement writepages
>   orangefs: use client-core buffer size to determine writepages count
>   orangefs: do writepages_work if a single page must be written
>
>  fs/orangefs/acl.c             |   4 +-
>  fs/orangefs/file.c            | 194 +++--------
>  fs/orangefs/inode.c           | 628 ++++++++++++++++++++++++++++------
>  fs/orangefs/namei.c           |  41 +--
>  fs/orangefs/orangefs-cache.c  |  24 +-
>  fs/orangefs/orangefs-kernel.h |  56 ++-
>  fs/orangefs/orangefs-mod.c    |  10 +-
>  fs/orangefs/orangefs-utils.c  | 181 +++++-----
>  fs/orangefs/super.c           |  38 +-
>  fs/orangefs/waitqueue.c       |  18 +-
>  fs/orangefs/xattr.c           | 104 ++++++
>  11 files changed, 893 insertions(+), 405 deletions(-)
>
> --
> 2.19.0
>
