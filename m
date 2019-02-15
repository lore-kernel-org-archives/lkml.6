Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA632C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C89217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z67hndWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfBOTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:02:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBOTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:02:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so10347547wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPo4L00nJNWboHbjRe2yO506WpmxFVponUnGvafgyYk=;
        b=z67hndWyOGYJ12sSSJSnu9dDJFzvdFG+T0cXGR7aqKpkGy6GcItiRQhC3geOxjv/BV
         cjkv3ZTnKJ/RF0Y5n9xmeUsO2VUXWJKDafp8I+Ul0PbP38J/545hgq0COFrkdTtjL9tX
         /NTP4n1wJfe84OrOZBKK6Jl1x9XFh1Grz0/i+L2kGOd0g6S4VfVm6XMeC8upDkYNFMF4
         SNWLp3/nDVjLwMcb3Z82Zh1sDyFJuEkC5AKZ+DAoQCbz1iZZPBEoyMygMSFHxo0HbVRD
         yXhIag0ddgMyE4/4iKbkQeGZkdeisljcnXfoDM6zolwXFdkR4aYsDqGIQHVUMifT0jSV
         LGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPo4L00nJNWboHbjRe2yO506WpmxFVponUnGvafgyYk=;
        b=bQrU21vhOb8E+XVT5Bie1uxcS4mtjOou4S/lYyOFFRD6eUb//CmVPe5Y2B8TpmJt6P
         1RT103DvBQUeZ7LRZUpHT8uyTKQfeKtXHDUJFkF4hy7sx1h1yu73Fn7qpCkkF0sJCxqz
         MqQ6I+x958p+bgOO4YFj2EdGx+dcc9IcBtJ4RD0lSrDmiy8tqhtCI0v5URMTrCSk1SP6
         y3ZycoiyJXwXsWXCpjvtsPXnOKteq3nuRjIDk/6mZZREYpAffPt8/JXCpcw6sMGQXhJM
         c4JF1iSuga+wteYiUzOUnX2hSsZ47x0yGBJ6JZXJjjiNJpyWduNnVmusU8b5qhrawcSx
         sCUg==
X-Gm-Message-State: AHQUAua0rEkwWlCIQZa3ok9JShnAT82fT0n5y2HdZrprqaUN2fmcUmDc
        fOYSolwKf3kSabvweOP+rvbAxmwqlxnlOfNNs/70EA==
X-Google-Smtp-Source: AHgI3IYIfpzL3YrOnIjx1Fjdv6yfSf+bVRrBpoufR2R9m+amtMDHLso3iOhZKyMCe0ITZw6c1wwXvvwRi5PutTXoOsY=
X-Received: by 2002:adf:c543:: with SMTP id s3mr4747020wrf.192.1550257331718;
 Fri, 15 Feb 2019 11:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20190128214408.25442-1-afd@ti.com> <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Feb 2019 11:01:59 -0800
Message-ID: <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi John,
>
> On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
> >
> [snip]
>
> > Some thoughts, as this ABI break has the potential to be pretty painful.
> >
> > 1) Unfortunately, this ABI is exposed *through* libion via
> > ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
> > will have a wider impact to vendor userland code.
>
> I figured libion could fairly easily loop through all the set bits in
> heap_mask and call the ioctl for each until it succeeds. That
> preserves the old behaviour from the libion clients' perspective.

Potentially, though that implicitly still caps the heaps to 32.  So
I'm not sure what the net benefit would be.


> > 2) For patches that cause ABI breaks, it might be good to make it
> > clear in the commit what the userland impact looks like in userspace,
> > possibly with an example, so the poor folks who bisect down the change
> > as breaking their system in a year or so have a clear example as to
> > what they need to change in their code.
> >
> > 3) Also, its not clear how a given userland should distinguish between
> > the different ABIs.  We already have logic in libion to distinguish
> > between pre-4.12 legacy and post-4.12 implementations (using implicit
> > ion_free() behavior). I don't see any such check we can make with this
> > code. Adding another ABI version may require we provide an actual
> > interface version ioctl.
> >
>
> A slightly fragile/ugly approach might be to attempt a small
> allocation with a heap_mask of 0xffffffff. On an "old" implementation,
> you'd expect that to succeed, whereas it would/could be made to fail
> in the "new" one.

Yea I think having a proper ION_IOC_VERSION is going to be necessary.

I'm hoping to send out an ugly first stab at the kernel side for
switching to per-heap devices (with a config for keeping /dev/ion for
legacy compat), which I hope will address the core issue this patch
does (moving away from heap masks to specifically requested heaps).

thanks
-john
