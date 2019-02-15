Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2F222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhZeerjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfBOSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:53:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36414 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732588AbfBOSxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:53:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so9402046otb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sb3Sc09qPUrAUp+JHtXSuq89LJkxcpv7hFHYtJuu4UE=;
        b=FhZeerjfosPTqJJsR7sJ987QkuclpYPvALOAHmgzkKP8JtR4Z9ronaIxP5nPg7hdv/
         kbXEtxc2Zs0wADEJqqBcvSwWKUMJMMrBiuLmcoLLzDbM2mxoNyy8IEmon+l9JXAm86ID
         nTDpgSuzvYBo4K5Abup6NfaoQ3MIysTlMaE44gFA9W3YaLAaeya5fDneIq3VVxSVApT9
         UaxeyvfUaVTe0a0hTEbTJ7aisWK4j9xJf8ey0Pl5LxMEkni3vapWAKDefYpzVSG0kQdu
         +3NhmpCUpROvtRswXVKkRxv8c4wH2uVQ4afko2RNAnQR1aFN6XYYvE4IdVrYByXu/zwf
         7i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb3Sc09qPUrAUp+JHtXSuq89LJkxcpv7hFHYtJuu4UE=;
        b=EYGU4bdRTGe61+dl9IuRuHQVvnWrljISrzqykGd32jJeZZhmyOFNZsHHITGe5ybrnm
         UaPnPa41YGUjMSjMIQ/gTgkaraMW114EMVpEm7k9NfrPYgORxp+4xJVfNr48CN7E0im8
         Zff2oVgCskK6JSwxlEfyRUiFHrFiyaosk60HXOE0HR1B9DO36KHabLjifGl+L8GIVsl7
         7aJUIuS/kaJoQ6Chp9Cv8k4uwfav8A0TetMZiE9DOY4qgVmlQG7l7lG9e4fYQAIY+19d
         BYMIJt6zAvdeimRn//P7mxpMi4d485kJiQCd2uTL5wzmriYf5wduELbWBOyLMYKspNvY
         i0gQ==
X-Gm-Message-State: AHQUAuZJ4h3zFi0sNR/L1iY+LNZqpAmZu1LiDHIfG9NLco9hdcvx0yGg
        UvIADZa3GFnOpOs9MDiSRHbxSwIXf3l6/aSjK0luKg==
X-Google-Smtp-Source: AHgI3IaG80gMk1cL+YWwTcgMLO/QKE60fb6Aj6SdPeGVrEyJgOISzEwCht+L0B41TwXCU5kjbAcNT13sgHPk1xHsMMw=
X-Received: by 2002:aca:d607:: with SMTP id n7mr6450861oig.3.1550256818550;
 Fri, 15 Feb 2019 10:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20190213214559.125666-1-jannh@google.com> <20190214.091328.1687361207100252890.davem@davemloft.net>
 <CAG48ez3p9kyyON4qDybveNhCNdTPfsvi3hUp7rDQUk-f43xMsQ@mail.gmail.com>
 <20190214.142100.1155290437338631379.davem@davemloft.net> <CAG48ez0bFsKPBubARtjs+NQmRiUAbPEGbNjXPJaceuDa9Dd7OA@mail.gmail.com>
 <CAKgT0UeOGPQO0viM0w3JD71357uj7uuZ+wX2tCUTP6u_ZQG78Q@mail.gmail.com>
In-Reply-To: <CAKgT0UeOGPQO0viM0w3JD71357uj7uuZ+wX2tCUTP6u_ZQG78Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Feb 2019 19:53:12 +0100
Message-ID: <CAG48ez2BnC2Q5-h5Op+bRvm-96D=v4qV=BghC4WB-xnzG3FSiA@mail.gmail.com>
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 7:35 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Fri, Feb 15, 2019 at 6:10 AM Jann Horn <jannh@google.com> wrote:
> > On Thu, Feb 14, 2019 at 11:21 PM David Miller <davem@davemloft.net> wrote:
> > > From: Jann Horn <jannh@google.com>
> > > Date: Thu, 14 Feb 2019 22:26:22 +0100
> > >
> > > > On Thu, Feb 14, 2019 at 6:13 PM David Miller <davem@davemloft.net> wrote:
> > > >> From: Jann Horn <jannh@google.com>
> > > >> Date: Wed, 13 Feb 2019 22:45:59 +0100
> > > >>
> > > >> > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> > > >> > number of references that we might need to create in the fastpath later,
> > > >> > the bump-allocation fastpath only has to modify the non-atomic bias value
> > > >> > that tracks the number of extra references we hold instead of the atomic
> > > >> > refcount. The maximum number of allocations we can serve (under the
> > > >> > assumption that no allocation is made with size 0) is nc->size, so that's
> > > >> > the bias used.
> > > >> >
> > > >> > However, even when all memory in the allocation has been given away, a
> > > >> > reference to the page is still held; and in the `offset < 0` slowpath, the
> > > >> > page may be reused if everyone else has dropped their references.
> > > >> > This means that the necessary number of references is actually
> > > >> > `nc->size+1`.
> > > >> >
> > > >> > Luckily, from a quick grep, it looks like the only path that can call
> > > >> > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> > > >> > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> > > >> > used for kernel testing and fuzzing.
> > > >> >
> > > >> > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> > > >> > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> > > >> > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> > > >> > with a vector consisting of 15 elements containing 1 byte each.
> > > >> >
> > > >> > Signed-off-by: Jann Horn <jannh@google.com>
> > > >>
> > > >> Applied and queued up for -stable.
> > > >
> > > > I had sent a v2 at Alexander Duyck's request an hour before you
> > > > applied the patch (with a minor difference that, in Alexander's
> > > > opinion, might be slightly more efficient). I guess the net tree
> > > > doesn't work like the mm tree, where patches can get removed and
> > > > replaced with newer versions? So if Alexander wants that change
> > > > (s/size/PAGE_FRAG_CACHE_MAX_SIZE/ in the refcount), someone has to
> > > > send that as a separate patch?
> > >
> > > Yes, please send a follow-up.  Sorry about that.
> >
> > @Alexander Do you want to do that? It was your idea and I don't think
> > I can reasonably judge the usefulness of the change.
>
> I'll take care of it. I'm kind of annoyed that you resubmitted this to
> netdev before anyone had a chance to even provide review comments
> though.

Ah, I wasn't aware that there's a convention against resubmitting a
patch immediately if the first recipient list pointed to the wrong
maintainer. The only recipient I removed for the resend was akpm, so I
assumed that anyone wanting to comment on the patch could just as well
do that on the resent patch. Also, akpm had already put it in his
tree, and I wasn't sure whether that meant that I had to send it to
davem quickly enough to make it land in davem's tree before akpm sends
his next pull request to Linus...

So next time this happens, should I add a note below the resend
pointing out that the resend is of a recent patch and it hasn't had
time to be reviewed yet, or something like that?
