Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19660C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87B20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvHy5Go5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE87B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbeHANUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:20:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43941 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbeHANUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:20:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so8666064plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FfvoXD7OaVSvOjt2M8lrFhDxZxuL1Bak7ODj3z6jiGI=;
        b=QvHy5Go5Sr+QhpIVYwBfSkb8+TOKaOgFMSW60ef/kaz2wa5Xb7qgeEm43cuDB8GFlU
         lJSepFnVe5UvwNgYKTPyO8HwfDc4kXYSFYHoi96awn2smR3R39UERavldfwVUAakSJKW
         LBItghsRd3SYK2+/RoigxsuK7f9CVgIv5xQr6DGp+2/HIqw2oxrA9RMRYvuORcxJ9xxb
         mW0N7wSO7hlFQQD/xQtEGJ62dWjq+XKE3Jlt/bjb7jYYWiG9TkRNjE/ndbUbH5c91x1z
         pR+FFFrlAOrpod9WpdN/QMSZ4EqlIClJixJyXU/cLQRy+lirnuyYf7+9HHbHvGyCYT+R
         T4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FfvoXD7OaVSvOjt2M8lrFhDxZxuL1Bak7ODj3z6jiGI=;
        b=sNUg8ziMxLmKnqgVuMQPMsthoLRzwUiZDNvll08AGQKG2279uhOZTH1vXG3UYd9waf
         Kay7WEJFCPl0/CDf8n/XbfZlhPdbX1qjJokgoCWmFvFki5Kg3II+re4yI6f8xviXiLt1
         TYabm9bf6AYK2sIWcl0zneEMDc5keW/PChdqjgQZEbt7KmhFJISvA0VlWwj7BSkA0F1w
         L2+X47oKNU0DfMChcfZtw1r4TDZLaBTDXgekkmxR/Fwei7i7HOItBEFmnZEUpMG8Fuv/
         sDlv9QzhTe72S0Vj/Z+zIx5MT868nqTtI4c0ihzX89Ue57FNUYNbur+q6W1tHcskZJwW
         +wzw==
X-Gm-Message-State: AOUpUlF8Ld+QWLTOqNQVh9I2Ng8Qs056BxkK90mdnhV2KJeFfzPr3YCc
        E/lLVr9TKBy6wH//JuD1Zt/MEhy9X1t+nQHBndNESw==
X-Google-Smtp-Source: AAOMgpcfli7GQNJeAM4s7JvfmAboMXEV6Q6t/Vk17Hsbj35x/QhwSDXIJu+aKJG7gOPP8dPI7O5/qbc19aORpY3VeAw=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr23793795plr.264.1533123330163;
 Wed, 01 Aug 2018 04:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 04:35:09
 -0700 (PDT)
In-Reply-To: <cf751136-c459-853a-0210-abf16f54ad17@gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com> <cf751136-c459-853a-0210-abf16f54ad17@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 13:35:09 +0200
Message-ID: <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
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
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:28 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 08/01/2018 03:34 AM, Dmitry Vyukov wrote:
>> On Wed, Aug 1, 2018 at 12:23 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>> On 08/01/2018 02:03 AM, Andrey Ryabinin wrote:
>>>
>>>> I can't think of any advantage in not having the constructor.
>>>
>>> I can't see any advantage adding another indirect call,
>>> in RETPOLINE world.
>>
>> Can you please elaborate what's the problem here?
>> If slab ctor call have RETPOLINE, then using ctors more does not
>> introduce any security problems and they are not _that_ slow.
>
> They _are_ slow, when we have dozens of them in a code path.
>
> I object "having to add" yet another indirect call, if this can be avoided [*]
>
> If some people want to use ctor, fine, but do not request this.
>
> [*] This can be tricky, but worth the pain.

But we are trading 1 indirect call for comparable overhead removed
from much more common path. The path that does ctors is also calling
into page alloc, which is much more expensive.
So ctor should be a net win on performance front, no?
