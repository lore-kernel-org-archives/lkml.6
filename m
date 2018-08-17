Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E205C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA7F20898
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj4MVkXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA7F20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeHQEjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:39:41 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35172 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeHQEjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:39:40 -0400
Received: by mail-yb0-f193.google.com with SMTP id o17-v6so1394756yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 18:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=drs5m/Z7it3VsVydjSOV5B8rjYYc2WvfDiZhnSn+YGM=;
        b=aj4MVkXbf5V3Ra9A1JFwanXjKcqBT5LioL3X75ypz70VRwUZy8HJvY5njUn9tAbi5H
         0zWmbY01a56XbN5pwcgXRv26sEmRvT0ux6phrFhX2X603M5zyoB9CEFHOqNLHIOKkPFm
         ZoMAFNDr5puTJmwmASEs5u+vgaraZvRYnKLNUtk99kCOMo5XKeB54znX9kaSSrrS6rtN
         KIhVoLnl/kmK+VVNGoQhS11Ll+2/UktrxszoqMBgL1PaibqV75+DJ79rb7Ydm2P4SquD
         qkblXhukP6Vxm0Y+j37TWiBMAyR6059pr6nn+YvKkdi1ogAPuHXkfBg0qID1QqI1r+30
         SKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drs5m/Z7it3VsVydjSOV5B8rjYYc2WvfDiZhnSn+YGM=;
        b=qmPCzMH9P18d9Q1a3NaU1C6hOAj92S6LV2iJxkjS4nxh+86KyTzUURkj7HSg2u1HTj
         t/ZRq6ylPQadb2J7zhWuBeTQijGaTYANtcO+ZxKrcVRTREk7y7oUIcClJiaGXka9zCDb
         oyTGhCVUcAN6RLU3tcIhGrv/owuieyDHul5RZl3vZDD9DI9s730BvfkWt7oZm+J6W6Ru
         uD/bE/3HEQwRWerOSUd2dnrmBjoUU+qRYiUNUOxo+cXVuL0NTM7j2B40eFik13W/safz
         9foMudD7uF+bzMO5gOz6tzmihD3uXcbKj9k0WoHmoRxk7mqH93mwMLK3AtNhEcVd+gCn
         o7zg==
X-Gm-Message-State: AOUpUlEm/EqIPpwTXU/IVgxEMgJGOFwrK3I+kBwhDOtYt4dx/d9396GS
        g2Zqstfg9c3ylJ+ptzEWcCY=
X-Google-Smtp-Source: AA+uWPyfhhVUqYYNrK7lRnC3gmgdygauLLwpIeRQicPf1pRhoZF7vdSLVBr6+rrWo5erswEtfXoj8Q==
X-Received: by 2002:a25:b106:: with SMTP id g6-v6mr7793033ybj.42.1534469898733;
        Thu, 16 Aug 2018 18:38:18 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x19-v6sm1420286ywg.72.2018.08.16.18.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 18:38:18 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Jia He <hejianet@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        pavel.tatashin@microsoft.com,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jia He <jia.he@hxt-semitech.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-7-git-send-email-hejianet@gmail.com>
 <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <831be9a1-6401-3af0-b68b-b3e25db806f9@gmail.com>
Date:   Thu, 16 Aug 2018 21:38:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/18 9:35 PM, Pasha Tatashin wrote:
> 
> 
> On 7/6/18 5:01 AM, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. in early_pfn_valid(), if pfn and
>> pfn+1 are in the same memblock region, we can record the last returned
>> memblock region index and check whether pfn++ is still in the same
>> region.
>>
>> Currently it only improve the performance on arm/arm64 and will have no
>> impact on other arches.
>>
>> For the performance improvement, after this set, I can see the time
>> overhead of memmap_init() is reduced from 27956us to 13537us in my
>> armv8a server(QDF2400 with 96G memory, pagesize 64k).
> 
> This series would be a lot simpler if patches 4, 5, and 6 were dropped.
> The extra complexity does not make sense to save 0.0001s/T during not.
s/not/boot

> 
> Patches 1-3, look OK, but without patches 4-5 __init_memblock should be
> made local static as I suggested earlier.
s/__init_memblock/early_region_idx

