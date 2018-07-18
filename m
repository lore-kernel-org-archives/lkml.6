Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E1CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BC12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JN0CbQ0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BC12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeGRVWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:22:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37871 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeGRVWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:22:48 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so6256538itc.2;
        Wed, 18 Jul 2018 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQWsr5V9I5mAw1juthBwYJKv91i2h6UKJe2EZE/lj70=;
        b=JN0CbQ0uegtyRaK6P/ekUS1yYqGQo6wouomVHUfE2H53iZzUzf13JQ6ycpt8Yyu6ZY
         5/Kd60cUZGJxEdT0mMEvFJKFEglL45AcbDudwGqM63PnWiUYA6R70SayCfaXLv0sMjkw
         Lj5JxQTOtjf6qe1xU8MV/3Z/y1Z5BWyYTPOjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQWsr5V9I5mAw1juthBwYJKv91i2h6UKJe2EZE/lj70=;
        b=HdNxs4Ne3AL8jazn3OJmLNJCxri+aTb0mRbwsvbP72tl4CNefjCn6kg+Tis4rKDxeF
         hQENiDf4qQUmbUahw77psQdJxtkK0QDdsqjqSGNpx86QYDanc0JN+aO5+7vGrSHyVnIr
         13MxsvX1M1sGUuTxf5wczDlmJaKc76LC+L+LxSi+tGecYCa8+YQdS0ozojG55eQzgSa0
         a8jVdYhbDuF/GhyuBpVlGDACq87eVM6jWm6Hgyn4Yr6cyf5bjUjYnKzbSPA2QK0Z+XLK
         D4s4fsQ1OWBwCz8WKNXYMQybNlMDkpg1RNGjtHPdAHRpmr8vsKBpJrTSzTvOGJ8yHDiv
         j0RA==
X-Gm-Message-State: AOUpUlHi2aPINCk4SZrRv256UMB0GiNQmXa0n0GYqvIYom98htvj9hrW
        RxcdbMwukq/V4H7cEoCwFrrE3908AszTKXqg3vU=
X-Google-Smtp-Source: AAOMgpfJZ9MsqxV0m8WS57ZE2Z1Z21NR0VD52KdzmnGeFL/xXPYUtHpNsRcWkWHuCDtz346E6vPwXq037iWwkgrYtW0=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr7114678jaf.70.1531946591821;
 Wed, 18 Jul 2018 13:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180718025636.GA26175@ZenIV.linux.org.uk> <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk> <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk> <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
 <20180718200411.GW30522@ZenIV.linux.org.uk>
In-Reply-To: <20180718200411.GW30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 13:43:00 -0700
Message-ID: <CA+55aFwhnOPO26ubjJ9WhK6YT8JqD5_UTGmNLFWbPdv-On99=w@mail.gmail.com>
Subject: Re: [RFC] call_with_creds()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 1:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
> int cachefiles_write_page(struct fscache_storage *op, struct page *page)
> {
> ...
>         file = dentry_open(&path, O_RDWR | O_LARGEFILE, cache->cache_cred);

Ugh. So on the one hand, in this case I'd actually be more ok with the
whole "call_with_creds()" model, because open() is actually *supposed*
to use creds.

At the same time, my stronger reaction is that "it's actually better
to just pass down the creds as a pointer like we do".

So I think the real problem is simply that people use the current
creds without thinking about it. Often it's just hidden in a
"capable(CAP_SYS_ADMIN)" call or something like that, where people
don't even _think_ about the whole thing.

What I really think I'd prefer is to have some simple way to "poison"
current_cred().  It could be something as simple as a per-thread
counter, and we'd have current_cred() do

        WARN_ON_ONCE(in_interrupt() || current->cred_poison);

and then read/write/open could just inc/dec the cred_poison counter
(when the debug option is set).

We wouldn't even need to catch all the odd cases. We'd only need to
inc/dec the poison counter in the normal read/write/open cases, not
even worrying about the odd special cases (like that
cachefiles_write_page() case).

Why? Because then we'd make sure the filesystems do the right thing,
and then cachefiles_write_page() etc wouldn't even have to worry,
because all the _common_ open cases have already tested that yes, it
uses the right cred pointer and doesn't try to get whatever "current"
happens to be.

So I'd really like to just fix the cases where we access the wrong
creds. And I'd be more than happy to add a few wrapper functions to
make us _see_ the cases where we do so.

What I don't like is the idea of trying to make bad creds accesses
"magically do the right thing".

See what I'm aiming for?

             Linus
