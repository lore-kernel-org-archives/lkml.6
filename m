Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27100C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3D2218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB+RtKyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfAYE0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:26:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39568 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfAYE0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:26:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so7394644otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBMiS9jiHeX1+9Jc28pbyzOv/aSJOX4d3/bRU2zYuPY=;
        b=PB+RtKyQmneW/2Mw2ggVPzFQ+2ImFYrwBeXGTA0gjBCSydSrCRP0RjweuxVn+KyRf7
         WfWwyEnZrpKLAaafmMea5YhdTtrD7AVnBeb2UrWy/FftKlcJL8x57Hbv/S6tGeGrYJj3
         fsVhhCoIv8XQ0DGepuYa74/WOCTn7ophmmIUhFx1HXCg8xHvqWPZvGWelvk5KTTC1RPA
         QNQtb2nOu6ZP0iXaKtcXSGMXkXToC5FO5sDeol24CCMpJc1F8z7yKPank/DFkq5dQL/L
         lNkWPtzbfiACth/OIlYebljC8YO0R6NSpO63AAAKFktbM3qhMdXsghLVUjtYRGwiBuxi
         PNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBMiS9jiHeX1+9Jc28pbyzOv/aSJOX4d3/bRU2zYuPY=;
        b=Pvk6GOGBe36BeyLS1Y9HiUmrziuN6GnOtc06H4kWJx1TlYIjiuijK4BcbuszXwa2vc
         QNaLfev8cA0nsuw63rXLUMVwkCnEbyh8HgUJgy3d7JCnR2+UwpmCkF4Q9BlXEtfmdzRT
         szLDoXC1wn48O+II9EBt0i7Xg6pBI1oEwO1RTF6Ajq//Dz/ckgiK1kPFBddsfPmCZH0M
         2djLPUptpPnhYkgNQgngjEK47d7aAUSJ9LBWxbvxmSbYtPPM/GjSOPQVH/Jex9xVVOrt
         LkWY0Mqqi4Ma2CGRJHoEa3MuP/1blQHa9MVY3if5xkMahfxReu9GrXanb8C2DiX6nfz8
         mwwQ==
X-Gm-Message-State: AJcUukdUID82bOzudE9v02zUY0nSV1Mu83rM/PrF1cFRp8rpovK5wckS
        MBSjyEANyxofU7LfOD5ldELxkPw42eK+QnXd/gU=
X-Google-Smtp-Source: ALg8bN7BfBeqGyz64gcYfEkG9GIVFChBhLyiEmm7mfSEi79EnCI/Ox4T2Zx7Ac9oF0Xe99G7kbW4wUnfFJTq9zAI3Hc=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr6587531otq.303.1548390400481;
 Thu, 24 Jan 2019 20:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20190118193200.32691-1-malat@debian.org>
In-Reply-To: <20190118193200.32691-1-malat@debian.org>
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
Date:   Thu, 24 Jan 2019 20:26:24 -0800
Message-ID: <CAH7mPvi2TN0b=j-6fqDpjGPkZVSEQnDiT2nj9NWmoBOhUiwKEg@mail.gmail.com>
Subject: Re: [PATCH] writeback: tracing: Copy only up to 31 characters in
 strncpy() calls
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:32 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> In the past an attempt was made to remove a set of warnings triggered by
> gcc 8.x and W=1 by changing calls to strncpy() into strlcpy(). This was
> rejected as one of the desired behavior is to keep initializing the rest
> of the destination string whenever the source string is less than the
> size.
>
> However the code makes it clear that this is not a desired behavior to
> copy the entire 32 characters into the destination buffer, since it is
> expected that the string is NUL terminated. So change the maximum number
> of characters to be copied to be the size of the destination buffer
> minus 1.
>
> Break long lines and make this patch go through `checkpatch --strict` with
> no errors.
>
> This commit removes the following warnings:
>
>   include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>
> Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> Link: https://lore.kernel.org/patchwork/patch/910830/
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/trace/events/writeback.h | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 32db72c7c055..7bc58980f84f 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -67,7 +67,8 @@ TRACE_EVENT(writeback_dirty_page,
>
>         TP_fast_assign(
>                 strncpy(__entry->name,
> -                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> +                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) :
> +                       "(unknown)", sizeof(__entry->name) - 1);

Does strncpy guarantee that destination will be NULL terminated if
(sizeof(src) > sizeof(dst)) || (32 > sizeof(dst))?

>                 __entry->ino = mapping ? mapping->host->i_ino : 0;
>                 __entry->index = page->index;
>         ),
> @@ -97,7 +98,8 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>
>                 /* may be called for files on pseudo FSes w/ unregistered bdi */
>                 strncpy(__entry->name,
> -                       bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
> +                       bdi->dev ? dev_name(bdi->dev) : "(unknown)",
> +                       sizeof(__entry->name) - 1);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
>                 __entry->flags          = flags;
> @@ -177,7 +179,8 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>
>         TP_fast_assign(
>                 strncpy(__entry->name,
> -                       dev_name(inode_to_bdi(inode)->dev), 32);
> +                       dev_name(inode_to_bdi(inode)->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->ino            = inode->i_ino;
>                 __entry->sync_mode      = wbc->sync_mode;
>                 __entry->cgroup_ino     = __trace_wbc_assign_cgroup(wbc);
> @@ -221,7 +224,8 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>         ),
>         TP_fast_assign(
>                 strncpy(__entry->name,
> -                       wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
> +                       wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)",
> +                       sizeof(__entry->name) - 1);
>                 __entry->nr_pages = work->nr_pages;
>                 __entry->sb_dev = work->sb ? work->sb->s_dev : 0;
>                 __entry->sync_mode = work->sync_mode;
> @@ -274,7 +278,8 @@ DECLARE_EVENT_CLASS(writeback_class,
>                 __field(unsigned int, cgroup_ino)
>         ),
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +               strncpy(__entry->name, dev_name(wb->bdi->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>         ),
>         TP_printk("bdi %s: cgroup_ino=%u",
> @@ -296,7 +301,8 @@ TRACE_EVENT(writeback_bdi_register,
>                 __array(char, name, 32)
>         ),
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strncpy(__entry->name, dev_name(bdi->dev),
> +                       sizeof(__entry->name) - 1);
>         ),
>         TP_printk("bdi %s",
>                 __entry->name
> @@ -321,7 +327,8 @@ DECLARE_EVENT_CLASS(wbc_class,
>         ),
>
>         TP_fast_assign(
> -               strncpy(__entry->name, dev_name(bdi->dev), 32);
> +               strncpy(__entry->name, dev_name(bdi->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->nr_to_write    = wbc->nr_to_write;
>                 __entry->pages_skipped  = wbc->pages_skipped;
>                 __entry->sync_mode      = wbc->sync_mode;
> @@ -372,7 +379,8 @@ TRACE_EVENT(writeback_queue_io,
>         ),
>         TP_fast_assign(
>                 unsigned long *older_than_this = work->older_than_this;
> -               strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
> +               strncpy(__entry->name, dev_name(wb->bdi->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->older  = older_than_this ?  *older_than_this : 0;
>                 __entry->age    = older_than_this ?
>                                   (jiffies - *older_than_this) * 1000 / HZ : -1;
> @@ -584,7 +592,8 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>
>         TP_fast_assign(
>                 strncpy(__entry->name,
> -                       dev_name(inode_to_bdi(inode)->dev), 32);
> +                       dev_name(inode_to_bdi(inode)->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
>                 __entry->dirtied_when   = inode->dirtied_when;
> @@ -658,7 +667,8 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>
>         TP_fast_assign(
>                 strncpy(__entry->name,
> -                       dev_name(inode_to_bdi(inode)->dev), 32);
> +                       dev_name(inode_to_bdi(inode)->dev),
> +                       sizeof(__entry->name) - 1);
>                 __entry->ino            = inode->i_ino;
>                 __entry->state          = inode->i_state;
>                 __entry->dirtied_when   = inode->dirtied_when;
> --
> 2.19.2
>
