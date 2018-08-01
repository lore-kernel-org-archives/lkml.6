Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE4208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePCmzjhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AE4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbeHARjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:39:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33438 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbeHARjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:39:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so7838961pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gj4hlaaw5Ugm9054KtpHasbpgZFKdiT/LM0RVQfMkbg=;
        b=ePCmzjhQnt5GdCTiXc5PRxTYa3tFfJes8lq7xYcoLicHLV9vz2xWRHyQ5H6oLAN2LQ
         5qSCosJwP+EUpKkpTuIvTuVYK61aklE9y0WZ4gy1be6kqtXdeaFgs10YI07kbuFZe55Y
         Omi99gDqjsw9yhZxdWHjDAFb7vBeJaWqg6Xg4hR5wPYZq04zEP6jczlD+RXLzyv3GBag
         VJV1++z+KMI14ZDVrFnw9kaNiAS0Z34uT07Nozy55NzVeKpG4NHyTuRwxl5sv40Sj+1R
         gwrH+cZjy86xKRzVCDLkyfFOOrJ/jlR9fF8nokWnPQbPnvNZzcGUsciOuQTJ7I5UkCkF
         V3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gj4hlaaw5Ugm9054KtpHasbpgZFKdiT/LM0RVQfMkbg=;
        b=ifIxgJKH1ScO2cBGimMIPVkJ4yXbAPb6N/yC8eaJZyRM9S8qX34rksNdYCKLWQ4JUG
         32Thk2i0H9Imdp/cldxoiZA09SMMB0KdP8bGvOdkzViqejQ9QoEI4rM3xOdKoDUHb9d/
         d0beZtyW9NL3VtMc03xx7Z4pTr+dywkvN/wzZTaVKz+eF7W2ZqZPNCKzc3KnxhEixJ3a
         GuoK5dV5PgB9cUFYEC6J+ICK1AsAMHf2PcZTDKH8OPoVD8xXqrV8PcTC1+PS8aw/xsks
         nvRSalMD9v4WpUWfvmDYF3Loq4BEzSvjv2KIcCyXCkDkAWt0UXpvPASunqTr1dL2zF4i
         j+nQ==
X-Gm-Message-State: AOUpUlGMF37MwJ2Mj1O8XOeoiTN6tL6Mxwy94/Hd+1khNeOVzHrlLkWH
        o3g90fu6oWWV0O3Xm1atkAWjycZ8r5a99bpw+we6FQ==
X-Google-Smtp-Source: AAOMgpe0H0GUcKasJZS1Sv6rNRRjm8vkG0joqrV1V1cE+aS6L5PvbjGr21AjOrjSb3BoJgysiLDsowKUL+RHyWF0V1g=
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr16576589pgi.114.1533138800969;
 Wed, 01 Aug 2018 08:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:53:00
 -0700 (PDT)
In-Reply-To: <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
 <cf751136-c459-853a-0210-abf16f54ad17@gmail.com> <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
 <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
 <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 17:53:00 +0200
Message-ID: <CACT4Y+axXa3HXG7ZoJSmP-g2QqtnvQ77oUZuioX-V9Ydi-56Dw@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:37 PM, Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Aug 1, 2018 at 8:15 AM Christopher Lameter <cl@linux.com> wrote:
>>
>> On Wed, 1 Aug 2018, Dmitry Vyukov wrote:
>>
>> > But we are trading 1 indirect call for comparable overhead removed
>> > from much more common path. The path that does ctors is also calling
>> > into page alloc, which is much more expensive.
>> > So ctor should be a net win on performance front, no?
>>
>> ctor would make it esier to review the flow and guarantee that the object
>> always has certain fields set as required before any use by the subsystem.
>>
>> ctors are run once on allocation of the slab page for all objects in it.
>>
>> ctors are not called duiring allocation and freeing of objects from the
>> slab page. So we could avoid the intialization of the spinlock on each
>> object allocation which actually should be faster.
>
>
> This strategy might have been a win 30 years ago when cpu had no
> caches (or too small anyway)
>
> What probability is that the 60 bytes around the spinlock are not
> touched after the object is freshly allocated ?
>
> -> None
>
> Writing 60 bytes  in one cache line instead of 64 has really the same
> cost. The cache line miss is the real killer.
>
> Feel free to write the patches, test them,  but I doubt you will have any gain.
>
> Remember btw that TCP sockets can be either completely fresh
> (socket() call, using memset() to clear the whole object),
> or clones (accept() thus copying the parent socket)
>
> The idea of having a ctor() would only be a win if all the fields that
> can be initialized in the ctor are contiguous and fill an integral
> number of cache lines.

Code size can have some visible performance impact too.

But either way, what you say only means that ctors are not necessary
significantly faster. But your original point was that they are
slower.
If they are not slower, then what Andrey said seems to make sense:
some gain on code comprehension front re type-stability invariant +
some gain on performance front (even if not too big) and no downsides.
