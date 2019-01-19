Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B60C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E8D2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do5BfSJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfASSfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:35:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46410 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfASSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:35:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so12762112lfg.13;
        Sat, 19 Jan 2019 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP5aKteC5epjnCFE/cVSielWVaoYfwdwpKPnCoIHAlE=;
        b=do5BfSJf9iKpsRvFeJyQgATzB038hF3LayCL8Qde8gpCGA8z/YjbcsUggt0Mhe6F7l
         GYrc9zfwXua2/PVKMdtKmx4fxNJAXy98xz77B2WsnZOpzpxMGJ2LmP9AwOd4OiL+iv12
         blmTb8NaXEQF59ZVLP+dJihq+z/rj2XbT/8WPLNphzAjRNOmvxu57EYQRlLjMnzSj+1e
         J45Vvav8wS4dR6NpXaRMbPaTY1qQvgZM4VVtkIW5a8Of+IymKTqSi7uD83ST1QPvxanP
         ZkVdh+JFCkuTmuG9TDjxCggsN/rbrN0F6XiI5U+qzRUrXuva9kXDmJh/bA9wjm+akbpJ
         yVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP5aKteC5epjnCFE/cVSielWVaoYfwdwpKPnCoIHAlE=;
        b=gjSdI/RPB/PTE+A7bmpIiZn96ffTgvDDkmWD9wKX/Zg5OW47Br3Oa+oEk4DrPsjTW6
         5I5arK1Nn/fjQRtCh6Qe5NURmbtJSfdgwuqerosRKLHrGjeRVjm0UoUGiCQAxq0GwA6/
         vwwcg1xOi5GWCv1aMMypGDb4y7xa3/f5U84qSfGYVAUSHrvZeShp9lvZz9wz6HqsfqOJ
         D/hjyt8tsZyD+yjufCLH/pMmgLE9fuQhQARheZpcFka/BvrjszeGKv0efJ9FqjU9O7Bj
         0aGAB0SxE/qvoYlEUM6admEN9VEQJVRP3ft2UJm8f4OpPh+JsiyyfnvxS3tYQr41j4bO
         OAkQ==
X-Gm-Message-State: AJcUukfRgheRMk/z1NLiG0hpOamPRtjSAGxcpnOobVZa3k5Bw3/yV58w
        kaE4YAn5OE82gk/vwqbzEQz9xlyH8G2gtqXcLag=
X-Google-Smtp-Source: ALg8bN5IiTdCArPpkYkvRopIMDwN9n8CBwxebkURxs5DUqjmARgZQrAz+eoOluNpO6BZ4b09LjLJOUuGfEEn4F2wciQ=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr14669958lfk.151.1547922944761;
 Sat, 19 Jan 2019 10:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com> <20190109094959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190109094959-mutt-send-email-mst@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Jan 2019 19:35:33 +0100
Message-ID: <CANiq72npFGsoHmBQUSNRLohDmMBNQFka8AcmhMz--QU1v2Aorg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

Hi Michael,

On Wed, Jan 9, 2019 at 3:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > Note it would be nice to separate the patch into two (one for the
> > comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
> > for barrier_data().
>
> Okay, I will try.

Did you have a chance to do it (or maybe I missed the patches)? If
not, no worries, I can send this to Linus as it is and get it in
already, then we can do the barrier_data later.

Cheers,
Miguel
