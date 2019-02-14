Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026F21900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrwWX1f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440138AbfBNV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:26:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45626 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfBNV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:26:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so13014201ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrJlq2e7JVQMqZUAtTmbixDjXaTTAsckZ/gODu3TZJk=;
        b=QrwWX1f8wdP8bljHQDqETUJg1mSagsQ9nuHNFE5eVnS33gqd8dLRIWLMoSo4gC31zx
         pqgpPYxgJzcK/MBgmtE1t8km74bTp5uGi+yuU/V/6viDFuarG7Npco1S1M/ebwCMEhw0
         2r072IA3enxft25fQJOMRNSSuPgZavftysWS0ASa3H2kHzo5fYlWxAb3UmcOUA8d6ugI
         g6IcBKzq18zoEnFPLvNnePeN1YjyouVpDbdFdA1yuQOzX1muUfIG2RO9KJ5qf6r7GPxD
         /AATqX94mXBoysT3AQfSTomaNTYX8N455tLwxeSDqzgSP78UAy2qVV/UQAQNQn8h8kRz
         QiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrJlq2e7JVQMqZUAtTmbixDjXaTTAsckZ/gODu3TZJk=;
        b=jE2Eq0r9QxKs0cUoIn1zj4WTJwLMs55EiBxoA6s1oJ0JLS0qTuWUfi3GmoPv/hR1nE
         RJ5KVtML46axYqjV2vUg8Cm+CmS3qq+r1UX5ArfU4NvHHTCBjkUuDIqLJzcbZcClmq9w
         XQMkO5iI64ZVx29dk2QCmLNJpCsrmd0Jv/ELhZbGslXMUIcPPtVQTK2L7U0gpDgqAi5h
         twjps1l4SlXHZ539hHFWigtP+b8AV4MiGqREigNUfvXwy5JPKObY8t/UXUcSSTd54ZY7
         YPLIETqs0d8OJSeaccE0HTf3RrdAWcs4CBwc2PQGmY9ukbOvQgMJPX0rLYfvxlTVrlrd
         zhGA==
X-Gm-Message-State: AHQUAuazsEcUYlYXc1sm57Il+m3ZkKNBm629PNtWCMf6O8hfLSOUQ1HW
        /qJTTr7KOFaVQIVn6CePe7OoQRQAeXB5hwvLpBFJHw==
X-Google-Smtp-Source: AHgI3IaYG2snDwj0tXCMb1CyOYPoJwZOUXUrW9HCqw9CdIPGwiUK8kfLqr+pOtJU2BbhffuHRUY+dNHG2RKU+Gx/91o=
X-Received: by 2002:a9d:4e06:: with SMTP id p6mr3970026otf.73.1550179608116;
 Thu, 14 Feb 2019 13:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20190213214559.125666-1-jannh@google.com> <20190214.091328.1687361207100252890.davem@davemloft.net>
In-Reply-To: <20190214.091328.1687361207100252890.davem@davemloft.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Feb 2019 22:26:22 +0100
Message-ID: <CAG48ez3p9kyyON4qDybveNhCNdTPfsvi3hUp7rDQUk-f43xMsQ@mail.gmail.com>
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
To:     David Miller <davem@davemloft.net>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:13 PM David Miller <davem@davemloft.net> wrote:
>
> From: Jann Horn <jannh@google.com>
> Date: Wed, 13 Feb 2019 22:45:59 +0100
>
> > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> > number of references that we might need to create in the fastpath later,
> > the bump-allocation fastpath only has to modify the non-atomic bias value
> > that tracks the number of extra references we hold instead of the atomic
> > refcount. The maximum number of allocations we can serve (under the
> > assumption that no allocation is made with size 0) is nc->size, so that's
> > the bias used.
> >
> > However, even when all memory in the allocation has been given away, a
> > reference to the page is still held; and in the `offset < 0` slowpath, the
> > page may be reused if everyone else has dropped their references.
> > This means that the necessary number of references is actually
> > `nc->size+1`.
> >
> > Luckily, from a quick grep, it looks like the only path that can call
> > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> > used for kernel testing and fuzzing.
> >
> > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> > with a vector consisting of 15 elements containing 1 byte each.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Applied and queued up for -stable.

I had sent a v2 at Alexander Duyck's request an hour before you
applied the patch (with a minor difference that, in Alexander's
opinion, might be slightly more efficient). I guess the net tree
doesn't work like the mm tree, where patches can get removed and
replaced with newer versions? So if Alexander wants that change
(s/size/PAGE_FRAG_CACHE_MAX_SIZE/ in the refcount), someone has to
send that as a separate patch?
