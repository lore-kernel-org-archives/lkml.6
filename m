Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F3E21773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVx41vj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfAIKgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:36:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:36:06 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so5253743lfk.5;
        Wed, 09 Jan 2019 02:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNExPV9gJWAWY0qO0jvj0zY0I7SecyreXzGwCEM8KoE=;
        b=lVx41vj2Gmh6Waw+ufQgJ8xlbn17olIJXNKKur0q5DGxUqQw+FNkG9i6ShlF82KL2L
         26nx/OwfmsuEA6eLJBvZLzQ+V+FK24H65V1r7YVUppXe8/RVH3xdnWZx+IIOVmXS0scY
         ZpPtr5LZRdBgzjUPmoO0AZNGGVwCdjjT1CYRrvGyraMQyRhHMRVPxusm8iVIDN3qUhkR
         SCwEyu0N0C7GHiL837wCRZOoYFFXOC2GonZvuWq5uKQ+bH3Twd+gjuCC59x/y/SNA89K
         S+WqW1aoo0PXlrCXy9552UFQzhMOzC+xYRJHHVZa85lfhp3W+igVasFZfJ3/Qi9bVx8H
         P/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNExPV9gJWAWY0qO0jvj0zY0I7SecyreXzGwCEM8KoE=;
        b=l8DFxZjDnsXe9hM0IMAphV/ZRe3UJkjbZO1el7He3IAtljx//Rajnh9PvsFU+JO/8d
         9bkhI5/tUdGQRs0GQ+6JMjwKolBaLv39rBvjzbuMBetz1hIzyveje9wKbvhRgjYUyM8V
         4qyvYmlOxSGfj+oOOQGs2QgjHLWzPh05FX57uKr9vrZ91OIo8T9eZS5l1D/NhKwyoJ43
         w9TEO8TuFboZMDGdHK5XHF0fxVbRbFof18BFkOiEymwa16ZJ1UdW+mZ9zvVvSpnNwMpq
         hqT3+Lv/pUloYUQMz05zUKpFxuSgCH4Uy9sByOwR5zeEyHoed/fQ9eQRz+7pDRKj92p9
         wyhQ==
X-Gm-Message-State: AJcUukfmgJMwfVLG0EuEgJgkvJ8Tv1wtb8EIeeuOs4gGWDgo2qd8kA1i
        u2dr8+fG9Gmc+uHEGzp5IKyUXD73ELlV3i3/OyU=
X-Google-Smtp-Source: ALg8bN67H3v+oueLWKnBc0eOLkqq/vnTTYt59hEZpmYkgCzB817+glfiz2DzgJCrxpaZl9eei3G1sHYRTlMdWEOQ5y0=
X-Received: by 2002:a19:54d7:: with SMTP id b84mr2958547lfl.131.1547030163247;
 Wed, 09 Jan 2019 02:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
In-Reply-To: <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Jan 2019 11:35:52 +0100
Message-ID: <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org,
        Eric Christopher <echristo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Also for more context, see:
> commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> dead store elimination")

By the way, shouldn't that barrier_data() be directly in compiler.h
too, since it is for both gcc & clang?

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> + Miguel
> Miguel, would you mind taking this into your compiler-attributes tree?

Sure, at least we get quickly some linux-next time.

Note it would be nice to separate the patch into two (one for the
comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
for barrier_data().

Cheers,
Miguel
