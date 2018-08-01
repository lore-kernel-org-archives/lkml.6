Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9547AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B82083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5CpSO0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6B82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbeHANOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:14:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41714 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbeHANOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:14:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so7702097pfn.8;
        Wed, 01 Aug 2018 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=axBW+C2qhs8KpcwuTnehyg1qCt8MA3c1BUtzovIwVUg=;
        b=a5CpSO0X/ZQnZPLY8PG4ROm89i91XAcfX15i1cF8F2Hs2M7jt/A0qwgW+gbi9DsoK4
         nWqBFrgBulJ6rt5FIKhBaRdg9/RFF/s0DxAhC+LWlTPNk2yZHgcNUaNv/bkGXCkdwE9M
         pWlYwvioJFRF3+IroSyJVxB/G16ktewcKCuyYNS3WbkaIT8XK55U1W7Q0on1/4kI+QCX
         L49bfO9Ml2GPYtcKq8QM3uC4mgBud4BpAoUEAcEd294oJ7juEf04xza+6RAHU9YM/Sn0
         FBRkMyEFht1+JTd1E+J28odFWsCORC14OzotXmiWMAzqtiqXaKwZXbtDGumyjFWhdB+B
         NtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=axBW+C2qhs8KpcwuTnehyg1qCt8MA3c1BUtzovIwVUg=;
        b=my6YMK7LS6VLynXB2Bv2+uwOaEsmZLOIbju8TuvA4riytoCMbf0As9XN+iGuaEjW/c
         e2sr253XCvbBSrh5wEJOSGzTHdjzwDrK82av11AY+z2gQeeJWIZPoN9WjgPIpb4zWQId
         GXCt7/nFcS+8WVlNGCp22SyLDJ1a9z2dCL6XZ3phXiY8LZA6HNOnid3oXhx6F5IhHK8j
         EahKBsvWpY+PVTUSD4L/WJEncW6weVYM3xZPhsxz5uI3sP61yiIN1MSDLsSbe96t8gI9
         c9OhdZpR3m+iCAYW384dBErYk/odKJ2Xvf6qQs+nnyteAAiqufPdpsA4EUNjYQs46kpE
         O0MQ==
X-Gm-Message-State: AOUpUlGeqnN4sTRQYXgM8RwgmGOLMhWXMlI9GUzdclLqmIbeGVEU5t6O
        vJ6Foj4IJMvhyz8sK0gH28w=
X-Google-Smtp-Source: AAOMgpc0R8PJVaoVe1RaOP8S2utyZ1TgD6zQuFqQy3p5oLj6rgX16a7l9EWGbk/x9dgRrbD6VypPGw==
X-Received: by 2002:a62:234d:: with SMTP id j74-v6mr2592232pfj.106.1533122929996;
        Wed, 01 Aug 2018 04:28:49 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 5-v6sm24652882pgc.86.2018.08.01.04.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 04:28:49 -0700 (PDT)
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
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
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com>
 <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <cf751136-c459-853a-0210-abf16f54ad17@gmail.com>
Date:   Wed, 1 Aug 2018 04:28:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 03:34 AM, Dmitry Vyukov wrote:
> On Wed, Aug 1, 2018 at 12:23 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>> On 08/01/2018 02:03 AM, Andrey Ryabinin wrote:
>>
>>> I can't think of any advantage in not having the constructor.
>>
>> I can't see any advantage adding another indirect call,
>> in RETPOLINE world.
> 
> Can you please elaborate what's the problem here?
> If slab ctor call have RETPOLINE, then using ctors more does not
> introduce any security problems and they are not _that_ slow.

They _are_ slow, when we have dozens of them in a code path.

I object "having to add" yet another indirect call, if this can be avoided [*]

If some people want to use ctor, fine, but do not request this.

[*] This can be tricky, but worth the pain.
