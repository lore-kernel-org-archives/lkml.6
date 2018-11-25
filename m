Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C110BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702CE20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C8WUTXo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702CE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeKZFaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:30:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43529 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKZFaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:30:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so11881920lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xg1RbGX81TYpMbFBxsVFb3iN6WEagcd1RlSMpmSO0s8=;
        b=C8WUTXo4Yo+bSox9ezbLEg7hzWRgrxYI8Rc70esGKe/JSx4XhxHGddjN0RJF0qvbBk
         +LgbyJGGIzdRWP4CGOoPRhVeHOUc875oobr0ZYRWd0VRutHJuDYsCT+5hs2zhuOKYXtB
         bE5aIMqeoEdYLOADYF3VJg6YClg19kKq/Info=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xg1RbGX81TYpMbFBxsVFb3iN6WEagcd1RlSMpmSO0s8=;
        b=h4Ue52/3dJoGoW/yp6KDYkHPPGc6j4AnUPSpM5n6DJQlpa53mvaiWaTBH7mlcBrcJr
         5KDhGxNHef7Xemd6P+yq6Z5q5qpvT9NZ+Aoa0VU5ru1o2UuFEjQPM1LWtMobaOQO0XIo
         y4Vx2o26EP+61wAEE4D2yPl/u5sturZBFvudZSzihhvB3bMC7h6sti7A8nUhDPcQrvFx
         kdr6aaX8AS5lNQotFI+Q4jkz7g9QhrIGih7MN712Ua9KkYsG+Fzq+KOGWvuiQeyZ15Kp
         YtbTNblp4eS6KVryFqAXHAF/11bRWOJg2cWXgSsgkzRQRymk2C4Uct5/niJAX3HgoFxf
         dOCg==
X-Gm-Message-State: AGRZ1gII0dr4c9B2PaAjMuEhLwTxbLAJizxHkD9eod/bwZajb7odqcdM
        KUv2EPMwDDv0T0T0W1JtW1Jd5dFfjAw=
X-Google-Smtp-Source: AJdET5etmbqAa5+5j1jVF83klfImQ/yzVJZUijNeAlb8x54aq99BH4PLvOaKhJe52LpXr3ppdUekEA==
X-Received: by 2002:a19:f20:: with SMTP id e32mr14561834lfi.51.1543171114891;
        Sun, 25 Nov 2018 10:38:34 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c133sm9936821lfc.45.2018.11.25.10.38.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 10:38:34 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id e26so11895400lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:38:34 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr14649228lfg.117.1543170641790;
 Sun, 25 Nov 2018 10:30:41 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Nov 2018 10:30:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
Message-ID: <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
Subject: Re: [PATCH] mm: put_and_wait_on_page_locked() while page is migrated
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, david@redhat.com,
        mgorman@techsingularity.net, dh.herrmann@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, kan.liang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 7:21 PM Hugh Dickins <hughd@google.com> wrote:
>
> Linus, I'm addressing this patch to you because I see from Tim Chen's
> thread that it would interest you, and you were disappointed not to
> root cause the issue back then.  I'm not pushing for you to fast-track
> this into 4.20-rc, but I expect Andrew will pick it up for mmotm, and
> thence linux-next.  Or you may spot a terrible defect, but I hope not.

The only terrible defect I spot is that I wish the change to the
'lock' argument in wait_on_page_bit_common() came with a comment
explaining the new semantics.

The old semantics were somewhat obvious (even if not documented): if
'lock' was set,  we'd make the wait exclusive, and we'd lock the page
before returning. That kind of matches the intuitive meaning for the
function prototype, and it's pretty obvious in the callers too.

The new semantics don't have the same kind of really intuitive
meaning, I feel. That "-1" doesn't mean "unlock", it means "drop page
reference", so there is no longer a fairly intuitive and direct
mapping between the argument name and type and the behavior of the
function.

So I don't hate the concept of the patch at all, but I do ask to:

 - better documentation.

   This might not be "documentation" at all, maybe that "lock"
variable should just be renamed (because it's not about just locking
any more), and would be better off as a tristate enum called
"behavior" that has "LOCK, DROP, WAIT" values?

 - while it sounds likely that this is indeed the same issue that
plagues us with the insanely long wait-queues, it would be *really*
nice to have that actually confirmed.

   Does somebody still have access to the customer load that triggered
the horrible scaling issues before?

In particular, on that second issue: the "fixes" that went in for the
wait-queues didn't really fix any real scalability problem, it really
just fixed the excessive irq latency issues due to the long traversal
holding a lock.

If this really fixes the fundamental issue, that should show up as an
actual performance difference, I'd expect..

End result: I like and approve of the patch, but I'd like it a lot
more if the code behavior was clarified a bit, and I'd really like to
close the loop on that old nasty page wait queue issue...

                   Linus
