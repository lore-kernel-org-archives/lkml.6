Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2DEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3402087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpMXnv+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3402087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbeKQCL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:11:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37380 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:11:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so15277215edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9QfZ/Yw+4fN5/J9kjVur5sXg3qsFZ+oxUY0Pe4KXb5c=;
        b=OpMXnv+f91+CL2lCDjDXvamspzWkG4nwleucSuR0PvpFP3dCsWHR5vJgyjxDlwRQ00
         0HzbbuunwVc4YCVP0uYosygZ8yNqwrK6OZIZ+4NR/o/9f5bPIWrqWW08U0MM9RTm+N6x
         TlBZKB0RoVr53gFNiBC3d38AVnoI/ir6XcAaDOGZT3kknxXI9Gp7HTuIi3emOB0czVk0
         pUV6D2yNPI0w18cwlXkQnR77IEtybmjwkEUf0gbhJnoU9EVkDEIK0SQRK1l3j1Lu595B
         eRw0uBkShNK6XSIKxZ/YP2uaL8ZU0wZnDxKVObMj/g/QNUMSh11GEI1J8sPSuFXT5ID6
         AAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9QfZ/Yw+4fN5/J9kjVur5sXg3qsFZ+oxUY0Pe4KXb5c=;
        b=OFAGuXqYd9sRft38ifNVSYOJ9VdQF4etcFYIrKnTSSklBd/xvMVs9036XqNpGSmDfU
         VQBXRh5RO9zXdttxYxlqlFJd73++taUnEehIn/0lPHYs6JmxcaLThudlYcYg/VPDFVx1
         JJSc0UdZzG0RbDGePF0o5/KhnXRA/SqkmUMclL+e68kf16+W9u4r5EDhVGTx1FfwmniZ
         ilc/faT7wtvrJqhmkgEeLj+JBnLDz5ju/2KKbdQUUKwNxpq5k6pGN/Ce7qXq0dTNI05Z
         5Q8Yn+VyAGygSz9XGwkr2pu2hm9ZGlLVIBgVgFrCRb40CIM2Rr2HPYcRf3qQ+v3bcv3Y
         2I+Q==
X-Gm-Message-State: AGRZ1gK/9SYs7LQYZHoOufZL/7woTW0Z9ilKAvcE7oYi4sOR+TiM/MHQ
        Hvvm01zGhEZuAQrTJkpKZy6q8L1Q
X-Google-Smtp-Source: AJdET5f7OXZNBUKu+bLlYoKQyCAj3xbsjz19MR5CGAEvgHmtHybtuDj97t8vPQYqMrtpzPgslIpdcQ==
X-Received: by 2002:a17:906:bb02:: with SMTP id jz2-v6mr8862879ejb.59.1542383909279;
        Fri, 16 Nov 2018 07:58:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x47sm2399100eda.91.2018.11.16.07.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:58:28 -0800 (PST)
Date:   Fri, 16 Nov 2018 15:58:28 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     osalvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181116155828.strdglxqgqe4jqkr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
 <20181115133735.bb0313ec9293c415d08be550@linux-foundation.org>
 <20181116095720.GE14706@dhcp22.suse.cz>
 <1542366304.3020.15.camel@suse.de>
 <20181116112603.GI14706@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116112603.GI14706@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:26:03PM +0100, Michal Hocko wrote:
>On Fri 16-11-18 12:05:04, osalvador wrote:
>> On Fri, 2018-11-16 at 10:57 +0100, Michal Hocko wrote:
>[...]
>> > E.g. memory hotplug decreases both managed and present counters. I
>> > am actually not sure that is 100% correct (put on my TODO list to
>> > check). There is no consistency in that regards.
>> 
>> We can only offline non-reserved pages (so, managed pages).
>
>Yes
>
>> Since present pages holds reserved_pages + managed_pages, decreasing
>> both should be fine unless I am mistaken.
>
>Well, present_pages is defined as "physical pages existing within the zone"
>and those pages are still existing but they are offline. But as I've
>said I have to think about it some more

I may not catch up with your discussions, while I'd like to share what I
learnt.

online_pages()
    online_pages_range()
    zone->present_pages += onlined_pages;

__offline_pages()
    adjust_managed_page_count()
    zone->present_pages -= offlined_pages;

The two counters: present_pages & managed_pages would be adjusted during
online/offline.

While I am not sure when *reserved_pages* would be adjusted. Will we add
this hot-added memory into memblock.reserved? and allocate memory by
memblock_alloc() after system bootup?

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
