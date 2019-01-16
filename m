Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W0lskNPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfAPRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:48:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfAPRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:48:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so5603264lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+afB5wbNUEIen7GSS/LHpIEPOpjXFQl9X924ccGuhY=;
        b=W0lskNPyJGVkwBeCqn7hxuizmoco3Z9p/QtYyRASYKeE5U8WBWejOPMFzYf4XqcQKc
         CP9fTDmdGtWxjB6zod0u9NLNp3tceCfoA1fw/tnTdrduhvigUBxQsJOFBwlUqkIkldn1
         55/K5Ik7gtG5I9h5xV1/dC1/binLkK6pUsqtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+afB5wbNUEIen7GSS/LHpIEPOpjXFQl9X924ccGuhY=;
        b=qZCLwToD1klWi1z3UonJgMuomTaCTxr9gv9tidRLYQUNBtC7feRrh/WEokZMSkPn1y
         mDqjyH/gKMe+re0cO1QXtbwQTiCPLBqcUcn+wlii/RHG8rTMZRaQGXLFBSCF04WZOb7Z
         Js7KxuqZHuwsu8u2uocW8bnEnIMPnLFX9E123ZA1WQMuuBIm+K5rFcNml9WFT1krdUiN
         l++ldS2X+yzJU5z230p5ogAUMtbOb8a9W+EyY54kmnZcsO0PfgN4pjoW8qS7VvN8MJqs
         0eAGygae2qGVoEee8s90jLfrICUA8LG8D2SaeAGycjiIW1DpYERhw+LFWsvFD/8f6yrM
         7lIQ==
X-Gm-Message-State: AJcUukeI63XUUuXm++/EbnG6Mpy1hY3XGdPC/HBtfC1rTrQwfiORVry9
        Jv+W/ZWpIHYaiT51FLoHLcENF7K1sUQ=
X-Google-Smtp-Source: ALg8bN5+YC7RZfSl8UXs/IMUspR+iOX5H+fw3dYbtzzRI2M2wXIWDkQjN8IZRY6qmEK6WUmCQe9cZw==
X-Received: by 2002:a19:c413:: with SMTP id u19mr7652506lff.100.1547660935733;
        Wed, 16 Jan 2019 09:48:55 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s62sm1314469lfg.34.2019.01.16.09.48.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:48:52 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a16so5594092lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:48:51 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr8122372lfc.124.1547660931486;
 Wed, 16 Jan 2019 09:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Jan 2019 05:48:33 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
Message-ID: <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:12 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> So that seems to deal with mincore() in a reasonable way indeed.
>
> It doesn't unfortunately really solve the preadv2(RWF_NOWAIT), nor does it
> provide any good answer what to do about it, does it?

As I suggested earlier in the thread, the fix for RWF_NOWAIT might be
to just move the test down to after readahead.

We could/should be smarter than this,but it *might* be as simple as just

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323e883e..7bcdd36e629d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2075,8 +2075,6 @@ static ssize_t generic_file_buffered_read(

                page = find_get_page(mapping, index);
                if (!page) {
-                       if (iocb->ki_flags & IOCB_NOWAIT)
-                               goto would_block;
                        page_cache_sync_readahead(mapping,
                                        ra, filp,
                                        index, last_index - index);

which starts readahead even if IOCB_NOWAIT is set and will then test
IOCB_NOWAIT _later_ and not actually wait for it.

            Linus
