Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2398CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A77208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QgrVH1YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A77208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeGaTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:31:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54666 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeGaTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:31:05 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so5720008itb.4;
        Tue, 31 Jul 2018 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMnhkj+uN1WyHd0klgsn6XEPLEkU9GzwvBGDs/L2sPs=;
        b=QgrVH1YV+UFfWC3tyEcPFCgplvK17nX1cI2nQwFpDsC1kJT/xrSTbwS7BJ5wyzF37h
         hV1HEijvZiDlGvF8IcCP1PhE/8yqYHNhrOJWDiWpcRJ7+rv3HWbk1EFA7dG4TjTlJbR3
         Ld4BTVz+kpDMM3r2BnHqppCVpjKqWTkyUXDjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMnhkj+uN1WyHd0klgsn6XEPLEkU9GzwvBGDs/L2sPs=;
        b=EbUevyA8FxgWav7jlyJCX+dNJTLbexfD2NCWRb3eC1jID3+H3vqAxNAW0ft4XM7GBi
         UpaLwHv/MpwnlVoP7lZ92jMJv31RYzzlBby/Q/HZTzMqUqCyIHltOCheWXAQMFRwPo5p
         pcCSqZ4NXxe+2WtxhGOR3IEoRz1wkGZQcbGFof63Bp7vVBjlxXI/EwTHyWoWstGN17cb
         dkYyTv/3Cz+ie1vdj958dIY0j/0nJ50xpZ3J3UJtGWCe2ENIMsZec7IsjcywossSDskk
         urXeEVP8L/Ufpy6ecj5BJFufd225mZgbEvsA6ex9MoTXZUXfEtl4rBuJwT+1XKljw7yV
         JjhA==
X-Gm-Message-State: AOUpUlFShPkFpqNnXoo1LmL/l1U3MGEsxnaztl5wvFX7iSgTzSYXVqB8
        M+8bnpu/1bPVkrt2hiS7OusHpnq/76MAo43mPAs=
X-Google-Smtp-Source: AAOMgpfRt3b+Bek22SKOPCbNu7ySFqgURD/sYI+GqOIdzvTLjazCp5K8dDUO9cHqWWLKOZFruRkaU7/JYBXpnC79ZCU=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr647617itb.16.1533059379396;
 Tue, 31 Jul 2018 10:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com> <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
In-Reply-To: <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Jul 2018 10:49:28 -0700
Message-ID: <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Christoph Lameter <cl@linux.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        gerrit@erg.abdn.ac.uk, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:36 AM Christopher Lameter <cl@linux.com> wrote:
>
> If there is refcounting going on then why use SLAB_TYPESAFE_BY_RCU?

.. because the object can be accessed (by RCU) after the refcount has
gone down to zero, and the thing has been released.

That's the whole and only point of SLAB_TYPESAFE_BY_RCU.

That flag basically says:

  "I may end up accessing this object *after* it has been free'd,
because there may be RCU lookups in flight"

This has nothing to do with constructors. It's ok if the object gets
reused as an object of the same type and does *not* get
re-initialized, because we're perfectly fine seeing old stale data.

What it guarantees is that the slab isn't shared with any other kind
of object, _and_ that the underlying pages are free'd after an RCU
quiescent period (so the pages aren't shared with another kind of
object either during an RCU walk).

And it doesn't necessarily have to have a constructor, because the
thing that a RCU walk will care about is

 (a) guaranteed to be an object that *has* been on some RCU list (so
it's not a "new" object)

 (b) the RCU walk needs to have logic to verify that it's still the
*same* object and hasn't been re-used as something else.

So the re-use might initialize the fields lazily, not necessarily using a ctor.

And the point of using SLAB_TYPESAFE_BY_RCU is that using the more
traditional RCU freeing - where you free each object one by one with
an RCU delay - can be prohibitively slow and have a huge memory
overhead (because of big chunks of memory that are queued for
freeing).

In contrast, a SLAB_TYPESAFE_BY_RCU memory gets free'd and re-used
immediately, but because it gets reused as the same kind of object,
the RCU walker can "know" what parts have meaning for re-use, in a way
it couidn't if the re-use was random.

That said, it *is* subtle, and people should be careful.

                 Linus
