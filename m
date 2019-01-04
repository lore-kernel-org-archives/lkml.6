Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4130CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dNTfuQ8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfADPZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:25:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45193 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:25:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so40655937qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYOcWXy0F9YBGiJA1eHhgaL7fYNPhHeIoXVhFk3hkWE=;
        b=dNTfuQ8cShnB7GnuBaHSQe74JJFr+HwzmNJrJDXbzszwTvyhLtVk+bm2yUrnRKGgw0
         f4t9kXxt/nF9MkW/q/0VqIm4cGyPmYbFMBGKeyJk4+nwu9SsRPPt+1PZQcanSTwBT8hp
         76tlKMolRmoxeS887AAc53eHVYLpK0kx8bY5xcsukwPaijoilOnTyGzmDm8vjroHUrvD
         Rojc7F6FBu3nZTU/6LLQUD15gRgZYsZ6OmlCJHGZrJugQe1lgX1vSVH+ucqP3BJ2cgnC
         jSzJUpyHUtgxXRgPYk+ZuUujTvWRvuvFMVif1D9dIXdqz7I7ejyry4Qu8RV83ga6gWVV
         R2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYOcWXy0F9YBGiJA1eHhgaL7fYNPhHeIoXVhFk3hkWE=;
        b=FVN5TAiiKv3lUMDYbC1tEiVSKceiGdtYoGudtSe7dtjm0AjWECj2u+9xu36LgYRg8F
         O/6CJhZme+q2YcTY+cuvJu5GnLRLv1osPDF0ouUABoiGQylwi8OooOytfVPDw1BBZ+Uh
         hKgt6bj8gavAMXferuWCDYbTAsCnprTZA/ZoDtIv0oT+tOJfYXx9UD7RnNbR6mpVQZ5f
         Uc/usN4KbaCpLpx74Nmxs4ouEMmSJo4fO0QXyd9+LMApUIKLyYaKjSWXsFpKEs2sZm/R
         eCDyx/4iH05+1JVBwLrEgwMySusAFWY9lWIkqzvFk1giPrQyqp8K01xFzUrns6BPIfHm
         WUVw==
X-Gm-Message-State: AA+aEWa+G+JiYcedSUJI/CVZvYdXVV15CVLved7fxc2zvuozEL1MwkQj
        BsnWDk+jqNRq2V/oxdD7BKmcavk6FXGExQ==
X-Google-Smtp-Source: AFSGD/VVTEEFI/OLWjeTx1zUUjg6kADZkqBH6tDmWLFKZnnumqyJGR9vKkALDOkxhzCkQwOgkSjvfQ==
X-Received: by 2002:ac8:354e:: with SMTP id z14mr50798788qtb.272.1546615513838;
        Fri, 04 Jan 2019 07:25:13 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w15sm31376181qta.16.2019.01.04.07.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 07:25:13 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
 <20190104151737.GT31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
Date:   Fri, 4 Jan 2019 10:25:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104151737.GT31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 10:17 AM, Michal Hocko wrote:
> On Fri 04-01-19 10:01:40, Qian Cai wrote:
>> On 1/4/19 8:09 AM, Michal Hocko wrote:
>>>> Here is the number without DEFERRED_STRUCT_PAGE_INIT.
>>>>
>>>> == page_ext_init() after page_alloc_init_late() ==
>>>> Node 0, zone DMA: page owner found early allocated 0 pages
>>>> Node 0, zone DMA32: page owner found early allocated 7009 pages
>>>> Node 0, zone Normal: page owner found early allocated 85827 pages
>>>> Node 4, zone Normal: page owner found early allocated 75063 pages
>>>>
>>>> == page_ext_init() before kmemleak_init() ==
>>>> Node 0, zone DMA: page owner found early allocated 0 pages
>>>> Node 0, zone DMA32: page owner found early allocated 6654 pages
>>>> Node 0, zone Normal: page owner found early allocated 41907 pages
>>>> Node 4, zone Normal: page owner found early allocated 41356 pages
>>>>
>>>> So, it told us that it will miss tens of thousands of early page allocation call
>>>> sites.
>>>
>>> This is an answer for the first part of the question (how much). The
>>> second is _do_we_care_?
>>
>> Well, the purpose of this simple "ugly" ifdef is to avoid a regression for the
>> existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected that would
>> start to miss tens of thousands early page allocation call sites.
> 
> I am pretty sure we will hear about that when that happens. And act
> accordingly.
> 
>> The other option I can think of to not hurt your eyes is to rewrite the whole
>> page_ext_init(), init_page_owner(), init_debug_guardpage() to use all early
>> functions, so it can work in both with DEFERRED_STRUCT_PAGE_INIT=y and without.
>> However, I have a hard-time to convince myself it is a sensible thing to do.
> 
> Or simply make the page_owner initialization only touch the already
> initialized memory. Have you explored that option as well?

Yes, a proof-of-concept version is v1 where ends up with more ifdefs due to
dealing with all the low-level details,

https://lore.kernel.org/lkml/20181220060303.38686-1-cai@lca.pw/


