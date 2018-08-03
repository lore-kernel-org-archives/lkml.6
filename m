Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1590C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FF621709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zEK0+I24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FF621709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeHCC3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:29:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57447 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeHCC3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:29:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 923f85b4;
        Fri, 3 Aug 2018 00:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=I3Vf4yo9VidRu9kA8u15Ys+9FJM=; b=zEK0+I
        24cRhY1YV+pPgDAYQisJ3UNDTZj2u0WC6Hi60lPT1H/v51rjtLL3oQ7I+dqKft8F
        HUKGiRE8Y+pfQqWJ5s1wPkvoUEafMv3Cr7zX5BF+Tn+T4zNEDhIZ941d6xSjH4h7
        SMYRcoZBZP+8l/hhigVgghdM7Lfz8aqSsvSbt3zqd6l/I0voT9NHbwkrO5cp3sew
        c9ERDjQSakn10mGRB4nc4eOgLJxx3z32kp9NOEboPqB47zcnQWh6a7xesmCSix4P
        qUZczgcP3tBOjqFQPLU+v9ziCVI4zjlsH8w2LYCl3SPwNVEtRD/XsnoTQgRVkW26
        7JeK/3TWkHyusYcA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89a64f80 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 3 Aug 2018 00:24:15 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id y207-v6so6802860oie.13;
        Thu, 02 Aug 2018 17:35:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlHzboHArem5XgBShuHL75RhCx+Sx4vazhlu60czMWpyo8upcMRD
        G6HtRuonL/t6taj1BTN4DfVOyPw8ezURp9z4yOc=
X-Google-Smtp-Source: AAOMgpevyhDOK9wzs+IEpzzALerPlQg7+rcsFn0BeFrrwFKGDgeIpFyj9YukHepXBaXZVHjZIzUH+xR0+QUZmsyUecQ=
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr1134299oif.22.1533256552275;
 Thu, 02 Aug 2018 17:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180731191102.2434-1-Jason@zx2c4.com> <20180731191102.2434-4-Jason@zx2c4.com>
 <20180731132701.522b55e2@xeon-e3>
In-Reply-To: <20180731132701.522b55e2@xeon-e3>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 3 Aug 2018 02:35:40 +0200
X-Gmail-Original-Message-ID: <CAHmME9oWYD7TUSkbqAFRFk9kwSWDfC2h-J72gpdxJiw5i1yrXw@mail.gmail.com>
Message-ID: <CAHmME9oWYD7TUSkbqAFRFk9kwSWDfC2h-J72gpdxJiw5i1yrXw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> I just gave this patch to checkpatch.pl...
On Tue, Jul 31, 2018 at 10:22 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Please break lines at something reasonable like 100 characters.

If the long lines really truly are dreadful, I have no problem fixing
that up for v2.

On Tue, Jul 31, 2018 at 10:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > +static __always_inline void swap_endian(u8 *dst, const u8 *src, u8 bits)
> There is a general preference to not force the compile to
> inline. Leave it to decide.

I'm aware this is for the most part the case, and I've read the
variety of threads and documentation of folks explaining why this is a
good policy. In the particular instance of that function, inlining is
in fact always the right thing to do. But I'll give it a double check
to see if the compiler is already figuring that out on its own.

>
> > +#define push(stack, p, len) ({ \
> > +     if (rcu_access_pointer(p)) { \
> > +             BUG_ON(len >= 128); \
> > +             stack[len++] = rcu_dereference_protected(p, lockdep_is_held(lock)); \
> > +     } \
> > +     true; \
> > +})
>
> > +#undef push
> > +
>
> > +#define push(p) ({ BUG_ON(len >= 128); stack[len++] = p; })
>
> This is going to lead to bugs, coders thinking push() does one thing,
> when it actually does something else. I would suggest making these
> helper functions, with useful names.

Good suggestion. Fixed up already for v2.

On Wed, Aug 1, 2018 at 3:21 AM Shawn Landden <shawn@git.icu> wrote:
> Does ratelimiter_selftest still always fail on slow CPUs?

No.

On Tue, Jul 31, 2018 at 10:27 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> This looks like you are doing traversal to free a tree.  The stack is there so that you do the rcu callbacks
> in the proper order. Won't this create an lot of RCU work at once?

Nice observation; you're right. I've fixed this now so that it does
the traversal inside a single RCU callback, and have it queued up for
v2.

Thanks for the suggestions! Keep 'em coming, and I'll keep making modifications.

Thanks,
Jason
