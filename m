Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B351320857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RjNdbbwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBAHOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:14:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41605 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBAHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:14:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so4891237ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZ6l/FA/GUGfptSWUSsSvsPRMmY7tMc07VEVRU1/bZo=;
        b=RjNdbbwUIFJ0LwmamP5F0mU3irkYq2z0IVuzFdanXrbhj8sEB4vxYpXt3m3Fy+AB1M
         SPS0q/lXChAKZa7+XTmR/PS28WXYasFDvxUp+ubNu2T9eyNkNiPyzBdq2/uXlJ4I+rNj
         IqrPf9cFc5xriouM82L1v7b8OYmIQRv6uSAyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZ6l/FA/GUGfptSWUSsSvsPRMmY7tMc07VEVRU1/bZo=;
        b=M9XBuOdtnjbGK6WvAKbCn1XcRxUQutsmNWC9XBWEzHdt4d3YcPQn0eiW+66/9MFRX+
         uNrpXGGiWEU7v/SXiDsz1YbZm//4tQCvcqGnAAd/gMAyV3NevC1pDufwR9AaYCaQn9sY
         HkuUdFNlzoIsQllqzGFHeMH5BJsREHV3VAM1Y6qzanrYmha4P1KDy4vEA33Gau+nvtuk
         3aSwGOb6bjWRKiy3h9L9tFaO9VGqVqGhDaF0+GwP2JaX7t7uMH5wL4OFPCl8aaJ3xMpW
         Oc3kBFqtqdbQ8piuoz+FG7uprrOMgbNpHNRP32INw4R9TSgd5HJXznRNZFnb1TF5RINt
         qRWw==
X-Gm-Message-State: AJcUukeldAcFmhvBV9A98up9hTwk79VjpYwqL1NUub2B9zPDFSe3XCU8
        kAkXRl1EUp+QVK1VUaI9O6kk9ThoGp0=
X-Google-Smtp-Source: ALg8bN6arvMT0/vuyeKOtStLMIm9pI8fiXMZUBE2Iqd+u7cPnoiu05m3OOMNTvUkMr3w3oNpuxTNjg==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr30125507ljh.139.1549005238061;
        Thu, 31 Jan 2019 23:13:58 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f16-v6sm1152850lji.88.2019.01.31.23.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 23:13:57 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k15-v6so4891191ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:13:57 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr29493803ljg.87.1549004749092;
 Thu, 31 Jan 2019 23:05:49 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz>
 <20190131095644.GR18811@dhcp22.suse.cz> <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
 <20190131102348.GT18811@dhcp22.suse.cz> <CAHk-=wjkiNPWb97JXV6=J6DzscB1g7moGJ6G_nSe=AEbMugTNw@mail.gmail.com>
 <20190201051355.GV6173@dastard>
In-Reply-To: <20190201051355.GV6173@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 23:05:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0FXvwB09WJaZk039CfQ0hEnyES_ANE392dfsx6U8WUQ@mail.gmail.com>
Message-ID: <CAHk-=wg0FXvwB09WJaZk039CfQ0hEnyES_ANE392dfsx6U8WUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is
 set for the I/O
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
>
> You are conflating "best effort non-blocking operation" with
> "atomic guarantee".  RWF_NOWAIT/IOCB_NOWAIT is the
> former, not the latter.

Right.

That's my *point*, Dave.

It's not 'atomic guarantee", and never will be. We are in 100%
agreement. That's what I _said_.

And part of "best effort" is very much "not a security information leak".

I really don't see why you are so argumentative.

As I mentioned earlier in the thread, it's actually quite possible
that users will actually find that starting read-ahead is a *good*
thing, Dave.

Even - in fact *particularly* - the user you brought up: samba using
RWF_NOWAIT to try to do things synchronously quickly.

So Dave, why are you being so negative?

             Linus
