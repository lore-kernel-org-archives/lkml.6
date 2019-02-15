Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D14C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D85206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYkx/RYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfBOSfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:35:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56148 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbfBOSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:35:30 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so16008370itf.5;
        Fri, 15 Feb 2019 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeMcGtowQVXXn9BVS2r2knxqqUiLBaw5SVXxbHWcM3M=;
        b=fYkx/RYAFDSw9ejLNKqUlrjp4bs6GhnjyxNIkEb9N1HCsxIGRyJ9rKojTOnwpCo64T
         ey97Gf0/H1/RxuQkZ8Y9kwNjchinXGrW25E3GcGUlBBIaivpAs4v8nhYzCLTlQU1MUR9
         t+r/A3uEgqewmy1l+APC2Faao1ptFvw4Rmd/a66Ot7KWmrfYsofv+R8KPLQvoJXZikHD
         x++gOjRYojPpbEyRcWIfYDSOlNvYwDJ55mPI/MWLLViuNd/aS3mvZDNNHsLZUGUY932s
         teGMWub+qG5BP3i9jT21tNR3Z+cGXlOUdnzM0hm8SlL3dvZduSV8VYZQx9mSXHzbIpUx
         h7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeMcGtowQVXXn9BVS2r2knxqqUiLBaw5SVXxbHWcM3M=;
        b=EdWCv7RQGKBB7d/+/5kzCwigSoKCULJn+VdqtwKq5P/Y9HfvY5joTtgcfyEWrBaVtl
         FVmsDpyLfXeyPDLB2LPIWokO8r0YWaUpFdwIjpSKc/a+GC/+ZKmsAaHwpZ2IT4iogQDN
         Ascx/k9R3cQidb9e9j4jzoZMsPFoOKbSCm5hE1662UuUgR3AmwAffDyyKD6mIx8Ho/d6
         2EHb3h3EABqJD175wQigs73HIFfNFYxcNBHWdfVHr2e4N4hwQSatsQkOcXJNrC6Kab1E
         R2C0w4LkxRCYm52dV2RE0qRYI0VHIRU5y5168X9d+6x8SiargesEgv05HFPEQnG5mip7
         LdKg==
X-Gm-Message-State: AHQUAuZlR+E1oVPSoo5i6dC8guIubQjnMzrZN0O3kCJvzBxbXfxxEBIm
        J5uMUHyslrehdqoxGRQpDXwf6fJdsYyyUoc0gDY=
X-Google-Smtp-Source: AHgI3IZ6nOutVYXMGF5sUphJHUMFhXgQYndAX8ArZ8Rixw2ONvrvoc10yIA3qOUYzxIdSkRQrXvR3TBOl6rN+NKWscQ=
X-Received: by 2002:a24:2ed3:: with SMTP id i202mr5245968ita.89.1550255729234;
 Fri, 15 Feb 2019 10:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20190213214559.125666-1-jannh@google.com> <20190214.091328.1687361207100252890.davem@davemloft.net>
 <CAG48ez3p9kyyON4qDybveNhCNdTPfsvi3hUp7rDQUk-f43xMsQ@mail.gmail.com>
 <20190214.142100.1155290437338631379.davem@davemloft.net> <CAG48ez0bFsKPBubARtjs+NQmRiUAbPEGbNjXPJaceuDa9Dd7OA@mail.gmail.com>
In-Reply-To: <CAG48ez0bFsKPBubARtjs+NQmRiUAbPEGbNjXPJaceuDa9Dd7OA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 15 Feb 2019 10:35:18 -0800
Message-ID: <CAKgT0UeOGPQO0viM0w3JD71357uj7uuZ+wX2tCUTP6u_ZQG78Q@mail.gmail.com>
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
To:     Jann Horn <jannh@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 6:10 AM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Feb 14, 2019 at 11:21 PM David Miller <davem@davemloft.net> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> > Date: Thu, 14 Feb 2019 22:26:22 +0100
> >
> > > On Thu, Feb 14, 2019 at 6:13 PM David Miller <davem@davemloft.net> wrote:
> > >>
> > >> From: Jann Horn <jannh@google.com>
> > >> Date: Wed, 13 Feb 2019 22:45:59 +0100
> > >>
> > >> > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> > >> > number of references that we might need to create in the fastpath later,
> > >> > the bump-allocation fastpath only has to modify the non-atomic bias value
> > >> > that tracks the number of extra references we hold instead of the atomic
> > >> > refcount. The maximum number of allocations we can serve (under the
> > >> > assumption that no allocation is made with size 0) is nc->size, so that's
> > >> > the bias used.
> > >> >
> > >> > However, even when all memory in the allocation has been given away, a
> > >> > reference to the page is still held; and in the `offset < 0` slowpath, the
> > >> > page may be reused if everyone else has dropped their references.
> > >> > This means that the necessary number of references is actually
> > >> > `nc->size+1`.
> > >> >
> > >> > Luckily, from a quick grep, it looks like the only path that can call
> > >> > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> > >> > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> > >> > used for kernel testing and fuzzing.
> > >> >
> > >> > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> > >> > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> > >> > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> > >> > with a vector consisting of 15 elements containing 1 byte each.
> > >> >
> > >> > Signed-off-by: Jann Horn <jannh@google.com>
> > >>
> > >> Applied and queued up for -stable.
> > >
> > > I had sent a v2 at Alexander Duyck's request an hour before you
> > > applied the patch (with a minor difference that, in Alexander's
> > > opinion, might be slightly more efficient). I guess the net tree
> > > doesn't work like the mm tree, where patches can get removed and
> > > replaced with newer versions? So if Alexander wants that change
> > > (s/size/PAGE_FRAG_CACHE_MAX_SIZE/ in the refcount), someone has to
> > > send that as a separate patch?
> >
> > Yes, please send a follow-up.  Sorry about that.
>
> @Alexander Do you want to do that? It was your idea and I don't think
> I can reasonably judge the usefulness of the change.

I'll take care of it. I'm kind of annoyed that you resubmitted this to
netdev before anyone had a chance to even provide review comments
though.

As is this doesn't really address the issue anyway since the bigger
issue is the data alignment issue that I pointed out. I'll have
patches for both ready shortly.

- Alex
