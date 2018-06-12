Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 750EFC004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24188208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQLDkGo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24188208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbeFLB7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:59:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39163 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeFLB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:59:52 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so13471138itp.4;
        Mon, 11 Jun 2018 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiY2sachHv/Xfv4pN/U0cdB/aqZyxZxrWR1MZZwuqsg=;
        b=TQLDkGo8tzB6iEexk7+EIWzrnEdgMlcLeZlU52CZ1VlsWQOxsaX1SNvf9sakQbb1Gu
         v/Pf8mtT3xcV9k3DH4Dsuh1FiO5vZkizPvEmZGPAtDRUefunW+6F+BCVtRSXkjtNkB6p
         bezm9NcE1pWrjqZJnzTfpoSjmi0NPOIWCUB9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiY2sachHv/Xfv4pN/U0cdB/aqZyxZxrWR1MZZwuqsg=;
        b=jAmHr9owNakkn9dewgIscn8fRJE8UkZb8KZuJ6u4FwfRDbzT2+w0MKgSqoR0699qhY
         SbFwq5vGnc6BYv5JUX8tcQYC4FZfZpHHLwC7RltdD5neczFMRDHiVf+93OCvvSK94bn4
         m8gu6oZqQyZ3HYHlR4HuLyJ2YV8spxyIGsQStvRflsbzBYWbAA5mwDgdigzrn0lvrirl
         1ct1ZreNPPBheuPqpCxDq1jlqq7a+YvZkk+1y4iby+/wzli3VCDN0zzFF0/rNk1c1KTj
         1ehB1VBCxGPS3gJyGf4yG9DoXaxEsfTyzwF9NYli9ZdOBrAsTfKyhShckGuoTA+pEqK0
         O5Iw==
X-Gm-Message-State: APt69E0sI6qSaYoWGX3HzQu5qIu7VBescBVU+Lw1QnmSeAR2Dimz6rDC
        tLSrVW41sT1eAbBww1t95xtRkkwF3YQ4lx60ZJoBGaCZ
X-Google-Smtp-Source: ADUXVKKTvcPCaB7njriGdb8128CgatEkCszfkA0oRnTnhco0KowYQ03Q9iKS+mERaNcxywvMXoKtZhPNYanUWJmKrsQ=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr1289542itb.1.1528768791439;
 Mon, 11 Jun 2018 18:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180611192353-mutt-send-email-mst@kernel.org>
 <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
 <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com> <20180612042600-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180612042600-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 18:59:40 -0700
Message-ID: <CA+55aFyNhEzzufw0XP9DcqZNS1CH+jDGdN4CVnazb3ssFxFbzQ@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Maybe it will help to have GFP_NONE which will make any allocation
> fail if attempted. Linus, would this address your comment?

It would definitely have helped me initially overlook that call chain.

But then when I started looking at the whole dma_map_page() thing, it
just raised my hackles again.

I would seriously suggest having a much simpler version for the "no
allocation, no dma mapping" case, so that it's *obvious* that that
never happens.

So instead of having virtio_balloon_send_free_pages() call a really
generic complex chain of functions that in _some_ cases can do memory
allocation, why isn't there a short-circuited "vitruque_add_datum()"
that is guaranteed to never do anything like that?

Honestly, I look at "add_one_sg()" and it really doesn't make me
happy. It looks hacky as hell. If I read the code right, you're really
trying to just queue up a simple tuple of <pfn,len>, except you encode
it as a page pointer in order to play games with the SG logic, and
then you hmap that to the ring, except in this case it's all a fake
ring that just adds the cpu-physical address instead.

And to figuer that out, it's like five layers of indirection through
different helper functions that *can* do more generic things but in
this case don't.

And you do all of this from a core VM callback function with some
_really_ core VM locks held.

That makes no sense to me.

How about this:

 - get rid of all that code

 - make the core VM callback save the "these are the free memory
regions" in a fixed and limited array. One that DOES JUST THAT. No
crazy "SG IO dma-mapping function crap". Just a plain array of a fixed
size, pre-allocated for that virtio instance.

 - make it obvious that what you do in that sequence is ten
instructions and no allocations ("Look ma, I wrote a value to an array
and incremented the array idex, and I'M DONE")

 - then in that workqueue entry that you start *anyway*, you empty the
array and do all the crazy virtio stuff.

In fact, while at it, just simplify the VM interface too. Instead of
traversing a random number of buddy lists, just trraverse *one* - the
top-level one. Are you seriously ever going to shrink or mark
read-only anythin *but* something big enough to be in the maximum
order?

MAX_ORDER is what, 11? So we're talking 8MB blocks. Do you *really*
want the balloon code to work on smaller things, particularly since
the whole interface is fundamentally racy and opportunistic to begin
with?

The whole sequence of events really looks "this is too much
complexity, and way too fragile" to me at so many levels.

                 Linus
