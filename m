Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A449C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B36720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dz9K88dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBAHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:22:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36112 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:22:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so4939083ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P18BFRM3FHB2HT0zP5dgNZMDiNjCSTJ5pMr531eoN/M=;
        b=Dz9K88dHG0MbOo5xXIKHy6zdQlsgU8yR75VOq/fcOVBfdMTH0TkY2f7OZ29Vni7G7T
         PrPv8xbCSagWseLm8k1O37oAaGqIQshCQSPPfK6Op87yEDO24e8qkElqk+QU7F0wW8Bm
         eG7DkoUiiW6lL19Q6f2MiV+avBrpKbTpyAAkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P18BFRM3FHB2HT0zP5dgNZMDiNjCSTJ5pMr531eoN/M=;
        b=BaVOwQQk+5lOnMA6DjopcozAWt2d6WSCB9ic6hbYGgz8t6MHu/bBU8iSFDv0c4kT9s
         MxlI86Wj4EZBcK1ZKvB7cspNgol14dggmvHcQaQT4smP/Nld2zgou31oWulDBtfzKske
         i0UvBzEGyjqXSUVKYNKrIFwLQfKbyevpXPd40BgDH2hxBLQtnsOmwfxB57pVWQ8Lo09L
         q5CxOi2tBvB7/nB4e6LkuChkJ8V46Jj4X80kZ4TOSVgnv2i3+dZ84T+rJKFJ2FFV+GLc
         L1T93CaRRioj6790HWSvWxAGHtp3g8S2SgjYrwD9VMsggvZCUrKyJO+N5iu55iuMCm3r
         CbOQ==
X-Gm-Message-State: AJcUukfqkKNEv7A4icIbXVkZR7J8G4IuwWvEI8ThyOAQWZKqhLNZS11f
        V06PsvvRhTWy65AtmMep0jJrqKHbMB4=
X-Google-Smtp-Source: ALg8bN4BM83CG8ZoVT6QigUNZYqzUScB0dKxVO/xZBKZy5y5hIgLq/AOHZIWKBBlgM/y713iocVFJg==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr31937390ljz.54.1549005731848;
        Thu, 31 Jan 2019 23:22:11 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e97-v6sm1158341lji.51.2019.01.31.23.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 23:22:10 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id b20so4252804lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:22:10 -0800 (PST)
X-Received: by 2002:a19:ef15:: with SMTP id n21mr29965253lfh.21.1549005729676;
 Thu, 31 Jan 2019 23:22:09 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz>
 <20190131095644.GR18811@dhcp22.suse.cz> <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
 <20190131102348.GT18811@dhcp22.suse.cz> <CAHk-=wjkiNPWb97JXV6=J6DzscB1g7moGJ6G_nSe=AEbMugTNw@mail.gmail.com>
 <20190201051355.GV6173@dastard> <CAHk-=wg0FXvwB09WJaZk039CfQ0hEnyES_ANE392dfsx6U8WUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg0FXvwB09WJaZk039CfQ0hEnyES_ANE392dfsx6U8WUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 23:21:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibb_cXG2e81ZiapC-SJPDwG4kaQ16XgJ_1cb3jgF9X3Q@mail.gmail.com>
Message-ID: <CAHk-=wibb_cXG2e81ZiapC-SJPDwG4kaQ16XgJ_1cb3jgF9X3Q@mail.gmail.com>
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

On Thu, Jan 31, 2019 at 11:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And part of "best effort" is very much "not a security information leak".

Side note: it's entirely possible that the preadv2(RWF_NOWAIT)
interface is actually already effectively too slow to be effectively
used as much of an attack vector.

One of the advantages of mincore() for the attack was that you could
just get a lot of page status information in one go. With RWF_NOWAIT,
you only really get "up to the first non-cached page", so it's already
a weaker signal than mincore() gave.

System calls aren't horrendously slow (at least not with fixed
non-meltdown CPU's), but it might still be a somewhat noticeable
inconvenience in an attack that is already probably not all that easy
to do on an arbitrary target.

So it might not be a huge deal. But I think we should at least try to
make things less useful for these kinds of attack vectors.

And no, that doesn't mean "stop all theoretical attacks". It means
"let's try to make things less convenient as a data leak".

That's why things like "oh, you can still see the signal if you can
keep the backing device congested" is not something I'd worry about.
It's just another (big) inconvenience, and not all that simple to do.
At some point, it's simply not worth it as an attack vector any more.

               Linus
