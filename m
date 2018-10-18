Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F066ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C2321479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h6FGtnmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C2321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeJRQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38014 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeJRQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so33331656qtf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6xjmYMFwjAXpy6FDafW/Cc3gYvg5c8BxwdbpQblls8=;
        b=h6FGtnmDbc8CBVzmwUoWDRq/79oaQhpFsuFSyBch9J6FcfCc5Dy25aYKqbSNHf6mFb
         k93KyXSFX9s3VGD69MAOHDtm15kwyxf0I/HrLvSCr0XeaAuFig1TIuPatNR4Pv0iB+ZY
         nDV8IXRCeJJ3aBg35gPYNQ9jxXCHlSNZoRmN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6xjmYMFwjAXpy6FDafW/Cc3gYvg5c8BxwdbpQblls8=;
        b=NT/szvJIvxGW8/1qawP6x+YrBS1oNpRhT8SByMHM3k7TlxeQmHYG5TYH1kXKXWx/mt
         sJFx4TaHqYXUWXczQsgMHPTS0FBuUdqqqLk9I/aOky2SOOD6mYnTdXKz/Z9aYVeBMppz
         IXMCN/L3FY2FPqdOaJXZ8prvFLiJ/zUPi+K+Oi87eq06MJHdtm/eoxSIJseXQ+oi/UxI
         KMn5LMd1GLPV3pQpK1Ud7ahoWZxH5i/ZtuxOD6G4fqN+0JZTcgsFuQlrYlS72oTGoc40
         Zo5SSCsn3Hli3WZ74B7r9qLsFYHLRysn9vb2O26ebBRF9F5yHXibzcXB8LIbQ+6cVZ3D
         /apw==
X-Gm-Message-State: ABuFfog+UWqKPpiBrH+ihMjt5u7T97o3rQRFVoNQVU33Wz8JZOLJXWdt
        MinzIy7aee9KnwXlaQOWYAxNkAwlvVYvjoR/PK5czg==
X-Google-Smtp-Source: ACcGV60d9gzx01zLHu3WR82Fex5roPmOjo+3T+UdTX43hFuR50Qlnsl4iN0LjtQRTRGI8qdqSkAAJRueWwwWmAYYvmw=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr27564990qtc.194.1539853008505;
 Thu, 18 Oct 2018 01:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20171207100849.407-1-daniel.vetter@ffwll.ch> <20171208105419.jdzene5wrsriwm2n@hirez.programming.kicks-ass.net>
 <20171211091928.cpw3srz2rddmruxj@phenom.ffwll.local> <20171218071159.GW26573@phenom.ffwll.local>
 <CA+55aFwD+0hhehWHmh8PW9eDCVtEBTi9KCmCrJXZRUFj77r82Q@mail.gmail.com>
 <20171219095925.GY26573@phenom.ffwll.local> <aae95b90-a0c8-4825-17fb-b31eb1aecf80@lge.com>
 <CAKMK7uHdk1CT9YP00fb0mpBQdg_Di6CKv+z5ZXSS9Q4tbOcwAg@mail.gmail.com>
 <20180315124130.GY4064@hirez.programming.kicks-ass.net> <30162a1d-74d4-3bce-f901-12a29f38632e@lge.com>
In-Reply-To: <30162a1d-74d4-3bce-f901-12a29f38632e@lge.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 18 Oct 2018 10:56:37 +0200
Message-ID: <CAKMK7uE=k4X-wc0nJ6OqwwtoUvKDcXjnEZ0YpKd62VbXEw8CqA@mail.gmail.com>
Subject: Re: [PATCH] kthread: finer-grained lockdep/cross-release completion
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Marta Lofstedt <marta.lofstedt@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>, kernel-team@lge.com,
        Amir Goldstein <amir73il@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:26 AM Byungchul Park <byungchul.park@lge.com> wrote:
>
> On 3/15/2018 9:41 PM, Peter Zijlstra wrote:
> > On Thu, Mar 15, 2018 at 11:31:57AM +0100, Daniel Vetter wrote:
> >> Is there any progress on getting cross-release enabled again?
> >
> > Not yet, I'm still fighting the meltdown/spectre induced backlog.
> >
> > We'll get to it eventually.
>
> Please let me know when you get available so that I can start.

Hi Byungchul,

Do you have a branch somewhere with latest/rebased cross-release
patches? I'd be interested in resurrecting them, and least for local
testing in drm. I'm still carrying around some patches to improve
annotations here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
