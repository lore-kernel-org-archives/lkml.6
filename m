Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F1D222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GajKadLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393108AbfBNRis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:38:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50746 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfBNRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:38:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so7172462wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzxb2/6sF1ujNDtDRfGaGMN4dEjiv01x5MSAjKDEmmA=;
        b=GajKadLuglcuOcO6N0R7S0CVX1DDXLtMkOwGWFMbI1HsxnpCoeD4WHTHr0yC6DeS3h
         WrTCLXWB1e1oG7Xwn5QgohwLpjOctFpkSUvbx+hq2yly8CqZfldaHATQaiM17oArxi4Z
         QbX7XsSy0dv3Ev+DdTnJ1/b7vb2aMvSrun2n1addlynmU6hVlAgwkE8yTHnjADZVTk5l
         FSt1Cdiuzeaeyn6dP7F2vTgmgVAh5rrWqZ2ZPGEOMlodjHBJv6FxnF2UthrAn6uJwhKC
         e/KkIzd3MKE024BwAJLcbdoB9pMQ8oPbqQB5lfxMAWv6XsflQjjzdj4IzaQ1iJXilBUk
         Pheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzxb2/6sF1ujNDtDRfGaGMN4dEjiv01x5MSAjKDEmmA=;
        b=Q+TVm/S8Zy5EiacylwNq182sykg+ftCG5xzGVOYM0ewdvbc93y54t0Vbs0qpSfVAUu
         61TQz6MRF6gn9Xev1tgtRbAJS765bqKptSj9pGeskSsBQnrptFlis6sfiDaH0JNv4QM8
         FRqTAHmH3Hs1QeNGigdoCB/8OHGP8ihRW2jHSMBDGqwTDyhNmLFNsA5QWhPfdf+CfoY6
         GdGpH4dBHIJ3QW8q58h+Etm4TtCVjO/w0cu1HaLZJ/0ANiwkXlD37wbDWVAu5RDu/wD3
         5nxB64gaQUWbe+Hytj7SzXfMQ7i48J1E/MGTQW3lpwAwDEqLrOiy+m+oy7G8irhk3hlv
         FyWw==
X-Gm-Message-State: AHQUAubfQewcdBUPlrHlE1t4PMbSQzSG8vGHRcGD03qg9pct8Q/LpFUn
        59CjTtWdjxp9zWBZKRx/C8ItQ5KEJ+Uu/nxfa0uWtQ==
X-Google-Smtp-Source: AHgI3IZULAHbyiperuNIZpAdh8f7W6MDfQitE0PP0jl+2r9ndWnotiILJuIjYSMIlFraWAPiTatQKTCSIDDetU7N9n0=
X-Received: by 2002:a1c:eb10:: with SMTP id j16mr3346247wmh.64.1550165921766;
 Thu, 14 Feb 2019 09:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20190128214408.25442-1-afd@ti.com>
In-Reply-To: <20190128214408.25442-1-afd@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 14 Feb 2019 09:38:29 -0800
Message-ID: <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:44 PM Andrew F. Davis <afd@ti.com> wrote:
>
> Previously the heap to allocate from was selected by a mask of allowed
> heap types. This may have been done as a primitive form of constraint
> solving, the first heap type that matched any set bit of the heap mask
> was allocated from, unless that heap was excluded by having its heap
> ID bit not set in the separate passed in heap ID mask.
>
> The heap type does not really represent constraints that should be
> matched against to begin with. So the patch [0] removed the the heap type
> mask matching but unfortunately left the heap ID mask check (possibly by
> mistake or to preserve API). Therefor we now only have a mask of heap
> IDs, but heap IDs are unique identifiers and have nothing to do with the
> underlying heap, so mask matching is not useful here. This also limits us
> to 32 heaps total in a system.
>
> With the heap query API users can find the right heap based on type or
> name themselves then just supply the ID for that heap. Remove heap ID
> mask and allow users to specify heap ID directly by its number.

Sorry for the very late reply. I just dug this out of my spam box.

While this seems like a reasonable cleanup (ABI pain aside), I'm
curious as to other then the 32-heap limitation, what other benefits
this brings?
My hesitancy is that we still have fixed number to heap mapping.

Curious how this fits in (or if it would still be necessary) if we
finally moved to previously discussed per-heap device-nodes idea,
which is interesting to me as it avoids a fixed enumeration of heaps
in the kernel (and also allows for per heap permissions).


> I know this is an ABI break, but we are in staging so lets get this over
> with now rather than limit ourselves later.
>
> [0] commit 2bb9f5034ec7 ("gpu: ion: Remove heapmask from client")
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>
> This also means we don't need to store the available heaps in a plist,
> we only operation we care about is lookup, so a better data structure
> should be chosen at some point, regular list or xarray maybe?
>
> This is base on -next as to be on top of the other taken Ion patches.
>
> Changes from v1:
>  - Fix spelling in commit message
>  - Cleanup logic per Brian's suggestion
>

Some thoughts, as this ABI break has the potential to be pretty painful.

1) Unfortunately, this ABI is exposed *through* libion via
ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
will have a wider impact to vendor userland code.

2) For patches that cause ABI breaks, it might be good to make it
clear in the commit what the userland impact looks like in userspace,
possibly with an example, so the poor folks who bisect down the change
as breaking their system in a year or so have a clear example as to
what they need to change in their code.

3) Also, its not clear how a given userland should distinguish between
the different ABIs.  We already have logic in libion to distinguish
between pre-4.12 legacy and post-4.12 implementations (using implicit
ion_free() behavior). I don't see any such check we can make with this
code. Adding another ABI version may require we provide an actual
interface version ioctl.


thanks
-john
