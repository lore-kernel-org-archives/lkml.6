Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C483B208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxxqE1WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C483B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbeHAMI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:08:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38167 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbeHAMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:08:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so7633125pfh.5;
        Wed, 01 Aug 2018 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihbM6kR3tBb3FxEBjAUMtN10+okD3vIaQ/ZVp6XGKaA=;
        b=DxxqE1WG8H8D1EhAkscuVWenXMrVBZ8lQiuEDUGwEv78uZvAIucPmlFnOIW+YE+UDS
         Ika5jx+vFPLcCCJ1LbK/X37obaiAhTy/ymFUi4e3uVBIB1D7QSU6sNS98ph0dmkw8XBr
         IUvsibshbU8nsL+5beSKnda0aoQI2MebZA7dLHrg1TkZwkXcT12u5cBGN6JWpCVu0EOr
         t5Gy3D0YMv3glma6mW9ID0aqY0UXqWybRqkBXiTiCUTYplgn5fXn8WAcTe8ERRnFWziy
         wCuLBViFbkn7MlHwGHyGmm+yluk+lZJkh4GZtSTtlYoC/BPdyPqlwdTz2z01wiouriZD
         1IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihbM6kR3tBb3FxEBjAUMtN10+okD3vIaQ/ZVp6XGKaA=;
        b=JgBYIqz9GcpU2Lw1QhRjcCKjCziwIENKCG6FlRanUF25uxw9jkcch6MgBaO0OszlD1
         0jvQs7Ey0G1Kaic2ejEhzc0MYjt7Xi4BVWgrjbz3Hwbn/r91Qezjl8bZBdQYDGCkM2E8
         r0Vj1/EJ+T2Tkb/KNmcTSB4DjVnBDFej8cSXtJ4PHqp4/CwoTdyc22YBJJfEsOruLrxH
         8+YlvxL2zt4YpK25HTarJqquLgBi1E6t3TjDPu12SOP2bZkGP/HX3yfr+Cdyv5QIG3u5
         honzQM2kZCj75q4j/ANBc7gIUSoWNv/fQCRcLQsqpmaOCoaouQvz4NdDtNHpLv6JPIBa
         pCLA==
X-Gm-Message-State: AOUpUlHj4qrBoyxyYyPLwakSRJfREOafnbaojCv77hR+gJGoSCznjilW
        mpP3hMqVtRsm8u7Tuxg8ovZriM0h
X-Google-Smtp-Source: AAOMgpeKMGgcPxq+VpMUBQH7S/zq3ouOQBXIY0qva+JwxqP9moRXRMWMvjAJ8iN9JHIgMszUBz6gtw==
X-Received: by 2002:a63:5922:: with SMTP id n34-v6mr24064285pgb.113.1533119000446;
        Wed, 01 Aug 2018 03:23:20 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id l84-v6sm26438120pfg.3.2018.08.01.03.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:23:19 -0700 (PDT)
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
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
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
Date:   Wed, 1 Aug 2018 03:23:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 02:03 AM, Andrey Ryabinin wrote:

> I can't think of any advantage in not having the constructor. 
> 


I can't see any advantage adding another indirect call,
in RETPOLINE world.

