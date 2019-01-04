Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E23C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F3021871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FnIRViIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfADPBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:01:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38541 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfADPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:01:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so40622277qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLewqQGrNYItvO4cRiFY8Ssj9+TLsDHclnipT9JP80A=;
        b=FnIRViIVvRtROW3JIczTBbjyoQHiYw+Ru900wUTNq7BzB/9iQ/D40B6iiTdhBlx+xA
         3JBPA8KP3J7gAZWBSSS5dcviOKAuTPSSAkIKcgdvZX3xctqMwlPUQkAtjLtQZ6Bk5jbY
         vs3z/JSw6UQ1pkKfS1qxfH6a98JkaaP9w9BFr7ScQGi0REpn2Ra1XIGDN1os3bOeWGiv
         D5gRXoPXE0M7oIapLm3nDYX1q+XnsspL4INY0JWpIQA848Q3iA9Pou9xd4WA9RDMenU6
         mxnBGDo7/Wn3YaPT8Pv2l584DLtOlywn+Fky1IN6jY3FTY5O7VRR+hte/OjqqgCRfMoV
         23Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLewqQGrNYItvO4cRiFY8Ssj9+TLsDHclnipT9JP80A=;
        b=P7cFoaB5nEaABk7KbAvO5YqvXs+qGtBdZiAad0RX4Fl0y12DzwynpN7nmMLkUMvwy6
         mYlfHN52u0o4AHotZsvIoz7D1uinrRJHxqeAnBzuv7OIL8gxhf5xnKsNVF50XETSorSP
         yqQsifLyBprGsjtBhJRHBnIM9efT0W55pW3XX69aiiYzc3f3pi9eTH2h09JA1IqhBrt2
         H+BkLAu5DBsmYk0+QpmlFM8OBH/2EUcNH0VnFKJnFYDyVneP0k5+Rdj7JBf+sYBtwPrM
         hP4+TdtNBzl9JdK+b6X+qVQWixIPyGWywsodseL/jEGXOR2ZZ6OgqJjj1Rkaqb0U8wFP
         IltA==
X-Gm-Message-State: AJcUukdQIZ/Gtu9kFOW/iFvYKvafwIwnTLhX/knu5MTRou8U99NJMPbz
        d7m4ah4OMIZzV9dOK2+uz/0YU7E29eFJyg==
X-Google-Smtp-Source: ALg8bN4Ci+pP+C4w2ygRvQ4TjV1dbQwNPPn1bgBMJDjBmfL6je0S9yZHi1jl0k18si1qi+G/A6TveA==
X-Received: by 2002:a0c:a2c5:: with SMTP id g63mr51417757qva.52.1546614102088;
        Fri, 04 Jan 2019 07:01:42 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 186sm5907514qke.10.2019.01.04.07.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 07:01:41 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw> <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
Date:   Fri, 4 Jan 2019 10:01:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104130906.GO31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 8:09 AM, Michal Hocko wrote:
>> Here is the number without DEFERRED_STRUCT_PAGE_INIT.
>>
>> == page_ext_init() after page_alloc_init_late() ==
>> Node 0, zone DMA: page owner found early allocated 0 pages
>> Node 0, zone DMA32: page owner found early allocated 7009 pages
>> Node 0, zone Normal: page owner found early allocated 85827 pages
>> Node 4, zone Normal: page owner found early allocated 75063 pages
>>
>> == page_ext_init() before kmemleak_init() ==
>> Node 0, zone DMA: page owner found early allocated 0 pages
>> Node 0, zone DMA32: page owner found early allocated 6654 pages
>> Node 0, zone Normal: page owner found early allocated 41907 pages
>> Node 4, zone Normal: page owner found early allocated 41356 pages
>>
>> So, it told us that it will miss tens of thousands of early page allocation call
>> sites.
> 
> This is an answer for the first part of the question (how much). The
> second is _do_we_care_?

Well, the purpose of this simple "ugly" ifdef is to avoid a regression for the
existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected that would
start to miss tens of thousands early page allocation call sites.

The other option I can think of to not hurt your eyes is to rewrite the whole
page_ext_init(), init_page_owner(), init_debug_guardpage() to use all early
functions, so it can work in both with DEFERRED_STRUCT_PAGE_INIT=y and without.
However, I have a hard-time to convince myself it is a sensible thing to do.
