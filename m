Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DBCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C3720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktbOt4rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C3720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLKJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:49:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39810 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLKJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:49:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so11958901edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fHshz6dG9q5FjalI+yNJYMa2+98nNn+rLuJ4jSiPoZw=;
        b=ktbOt4rEZWauE4Rh+G/pmsASgkh3z7G4CoCAkw5WP6vJOQwzaEHsAxuFp0rfMAaNbK
         9z4yCBXfHnU+pSlYQMpEA8k9uJrzYTudk6I5I0bTyF4XN8O3zH1FWXjL13QhuuW36EVy
         o6j1RyprtdBuLw9xzKemQ3tn6mBgQztcDMVSfXZl8Jf7/GG0RjTB4G49FqgBHIxcWt8X
         o5HDH9kwKl3JuvxMhG+TNTgRIbv0h4zZd5iAJoqjNFtqRvPNo8YazOUcFGSeEIsq3Kh4
         0CFjLgdOAja6okhQOgRqt809PocQWPbzsHCQQImkRxkoFOVIrDXN51EnNaxWxct4Zh0j
         qAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fHshz6dG9q5FjalI+yNJYMa2+98nNn+rLuJ4jSiPoZw=;
        b=A3i8j6pcqNLLA58XZV30iMcyrb/zCzPwW2GQ8/9S86qWwhr1cGjxfDpgfaXHTTTivb
         I6frg0z2oZrYOQ53OPgIuHJtvrihasf0L8KrD5QIUiQTVtAaHICGfyinB7SxyErbdiUD
         SiUJYayD5bQR/Q8FnVJbt1iM1dFRbqLyGyasEa0QPbc1k5kBzGQHmv5KXKfmgxJb5q4V
         wxeOJjE1DJT9H4zZJ8KkocVA8OOJ51rp2mjZzPrHXvH80O9bJ5b+J7VhS+kerNxdrgOY
         WtVpAtV1BXZYGqU06p8pvewruxUKBB24ifiBpmEp3FedGNBf1TKO19McTWO3J5J/ezSA
         Q5DQ==
X-Gm-Message-State: AA+aEWbrENu7pD0ZAWojNyuotlku8cBk3Gs6HTORwDbNhikawA9pohZo
        7oonk8fM+zr8BB33o8D3LcA=
X-Google-Smtp-Source: AFSGD/VEvtmDvCAs48scYgs3t0ZI5x7x1B6C5hJOb4QBZhjczkmmbOwOXZELZ0fpN7/tnYgbFmxM9g==
X-Received: by 2002:a17:906:4e14:: with SMTP id z20-v6mr2721916eju.187.1544521779587;
        Tue, 11 Dec 2018 01:49:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z6-v6sm2203357ejq.63.2018.12.11.01.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 01:49:38 -0800 (PST)
Date:   Tue, 11 Dec 2018 09:49:38 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181211094938.3mykr3n3tp6rfz4p@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
 <20181210132451.GO1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210132451.GO1286@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:24:51PM +0100, Michal Hocko wrote:
>On Mon 10-12-18 14:07:12, Mikhail Zaslonko wrote:
>> If memory end is not aligned with the sparse memory section boundary, the
>> mapping of such a section is only partly initialized.
>
>It would be great to mention how you can end up in the situation like
>this(a user provided memmap or a strange HW). 
>
>> This may lead to
>> VM_BUG_ON due to uninitialized struct page access from
>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>> memory_hotplug sysfs handlers:
>> 
>>  page:000003d082008000 is uninitialized and poisoned
>>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>  Call Trace:
>>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>   [<00000000003e4194>] seq_read+0x204/0x480
>>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>>   [<00000000003b55b2>] vfs_read+0x82/0x138
>>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>  Last Breaking-Event-Address:
>>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>>  Kernel panic - not syncing: Fatal exception: panic_on_oops
>> 
>> Fix the problem by initializing the last memory section of the highest zone
>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>> end.
>
>Why do we need to restrict this to the highest zone? In other words, why
>cannot we do what I was suggesting earlier [1]. What does prevent other
>zones to have an incomplete section boundary?
>
>[1] http://lkml.kernel.org/r/20181105183533.GQ4361@dhcp22.suse.cz
>

I tried to go through the original list and make myself familiar with
the bug.

Confused why initialize the *last* end_pfn could fix this, since
is_mem_section_removable() will iterate on each page of a section. This
means we need to initialize all the pages left in the section.

One way to fix this in my mind is to record the last pfn in mem_section.
This could be done in memory_preset(), since after that we may assume
the section is full. Not sure whether you would like it.

-- 
Wei Yang
Help you, Help me
