Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE053C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700A32064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz3RklXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700A32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeH3DLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:11:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41404 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeH3DLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:11:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so2980399pgv.8;
        Wed, 29 Aug 2018 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwpcOXQkAdKXRkCiTcrJDHXBPW7S4CUq9+j7OgaZBqI=;
        b=uz3RklXgYnc2mr0cGTAJe3zRvn9Y3QWwMcnjQ+JyFapPQ+lp55stwhmvqpeAFOzJxX
         d1HUeeTGxmIsIuEPH9leB6U2XWvvn8JlKDEPyHE8UZQMV3y2PIs/SrMjGH+F77YdvvNq
         h8h8qJ6HuOeq8/j/WFtAW6GbY9dbaJAHnnPjT8wLVAM67iR07sP1qukc3vYxIuQykgff
         BxIPd72EecCyfm+QnNuAjlwZVGYRj6GKmfUCJKQbr6BQKHV37Dj8EV64ztFnvCqs3KoA
         9K0o/vL5hIDj/bciALDdHpXbmeM19jyG555r1tz8N9/drQXFYf1+IKeja9rdgwTzp/vh
         IcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwpcOXQkAdKXRkCiTcrJDHXBPW7S4CUq9+j7OgaZBqI=;
        b=XEd8g8qCHhpaxjjAUOc9M4IhC1eEo3WtgeCZrkdA7t56+1PAQKRpyXJMsdpHyKpKdg
         1+87/Ov+bgyNL7dgQzh1J1wdyabr/3nBlrufsgOI+BV1AtoqrsiHSZwVwJZxdS7Uh5+f
         LWXCK6sW6QKuOOZniasyDYnZ7WHFDmJsTQIJ7iJoxItfAJUI7e/z8bh4mJW+/leGFjjL
         GSoSuIpFEiVjfuLg0c6KwMK+KuDFvFxOewwzNuUd10JdCXSwB7MF0BPPxf+KCxXFCIoM
         nD+171hT+0Y9dcjvkQQmIAg9MxL62O6EVcSD25ff8wSCITn4E5D0N+duac6FloYTc9Qz
         Fopw==
X-Gm-Message-State: APzg51BdZ3fenkgXLHemSwbPmGV3XTT724FG76TZZv7TntF1nfw2IF2P
        hmiWQA3C73anrkx8XQuZhJs=
X-Google-Smtp-Source: ANB0VdbTVxnNI2RCTemOR/VYUrqEODw+417CO4rJybgkLCyY/WYE4dbZxCsWxoCBta1QmMkB4a6TLQ==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr7936374pfi.2.1535584343407;
        Wed, 29 Aug 2018 16:12:23 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id 143-v6sm7188780pfy.156.2018.08.29.16.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 16:12:22 -0700 (PDT)
Date:   Thu, 30 Aug 2018 09:12:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling
 in fork
Message-ID: <20180830091213.78b64354@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-3-npiggin@gmail.com>
        <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 08:42:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Aug 28, 2018 at 4:20 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > fork clears dirty/accessed bits from new ptes in the child. This logic
> > has existed since mapped page reclaim was done by scanning ptes when
> > it may have been quite important. Today with physical based pte
> > scanning, there is less reason to clear these bits.  
> 
> Can you humor me, and make the dirty/accessed bit patches separate?

Yeah sure.

> There is actually a difference wrt the dirty bit: if we unmap an area
> with dirty pages, we have to do the special synchronous flush.
> 
> So a clean page in the virtual mapping is _literally_ cheaper to have.

Oh yeah true, that blasted thing. Good point.

Dirty micro fault seems to be the big one for my Skylake, takes 300
nanoseconds per access. Accessed takes about 100. (I think, have to
go over my benchmark a bit more carefully and re-test).

Dirty will happen less often though, particularly as most places we
do write to (stack, heap, etc) will be write protected for COW anyway,
I think. Worst case might be a big shared shm segment like a database
buffer cache, but those kind of forks should happen very very
infrequently I would hope.

Yes maybe we can do that. I'll split them up and try to get some
numbers for them individually.

Thanks,
Nick
