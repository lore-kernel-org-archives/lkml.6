Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3F24ED6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnMUzK3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3F24ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeGCCLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:11:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40909 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbeGCCLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:11:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id x5-v6so201814pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nJUZscMeKQrggcqKta+WGqF6SYBZdjagsGq4adu1RW0=;
        b=mnMUzK3hF7EWIdifK0jSdFw2JZsrkLFb1lXcuYbajVO++pGRX7BBRNmT2WbxapsyXE
         RRNKuCxs5KOLBVimCKU0o7DzYmWDZVaaiod5UQhnzowittRAcLFjSY/Pce1Lqkv7AR7b
         9+1xB+yMPsq7wGknhrboq0ktZgnKF5pQLJa+fgbCBvVDT0jFQCY6HIaGtSg9nwlrBCqY
         uhvlYikrW+7vM0PEWnUXADzaPyH8C6kELN0zyOp6DlNgV2oNzGOryil7lar/qqgUK3YP
         nyVlAP/eK6fOLAf7cXKn4ldXPQg6YtALKvB67AvhyoijnkxdAdW3jOXvPSoAXjM6dubs
         pWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nJUZscMeKQrggcqKta+WGqF6SYBZdjagsGq4adu1RW0=;
        b=iA44IGwMkkhSei3iKzXiNtAN272liIqsDOohb/tOsVqRV2fdeFztxa6BPA38WBmohy
         RlCqauH3eluXWNay7Ca0midZodk5nAl/ufz1KjJUHDRYfeoabPn18fsa8YMHbw1e9CCh
         i99298fP649MNsB0/j2MLJkONeg977Onn+0daBflcrjcs6TCJeuYWkfeIHKy1bPjfJqd
         XP3q1xTd/X6jJUyYWMBL7ZguYl/+Vl9oerf2nyQdzk1uFyvyGROWHAbt6DhwyfTkzU/n
         mw/xh46xaJSh0jlSYyNYuxFAcH4sHwod5p0SlUw0jaQK+UnWkV4FqxQjn2zNOq8m1UUV
         gdFg==
X-Gm-Message-State: APt69E2Pmr63TGckma6TLoW3ekHHRGGdu//5Mi+AmkvSjP/3YP+Ke45h
        Oq2luPl5NPnEVMWZzWNkFro=
X-Google-Smtp-Source: AAOMgpd2QhUoxCwcFmCiyM3UVf2/ktFvpr4CxkKXc7xrCAKA0TBOHnL35f64yCLSfSKMnMpFDUxyRA==
X-Received: by 2002:a65:520d:: with SMTP id o13-v6mr12422443pgp.282.1530583891472;
        Mon, 02 Jul 2018 19:11:31 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id j5-v6sm8855pfc.56.2018.07.02.19.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 19:11:30 -0700 (PDT)
Subject: Re: [PATCH v9 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <20180702114037.GJ19043@dhcp22.suse.cz>
From:   Jia He <hejianet@gmail.com>
Message-ID: <779be6bf-db64-9175-f4c0-2baa0ea6defd@gmail.com>
Date:   Tue, 3 Jul 2018 10:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702114037.GJ19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2018 7:40 PM, Michal Hocko Wrote:
> On Fri 29-06-18 10:29:17, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") tried to optimize the loop in memmap_init_zone(). But
>> there is still some room for improvement.
> 
> It would be great to shortly describe those optimization from high level
> POV.
> 
>>
>> Patch 1 introduce new config to make codes more generic
>> Patch 2 remain the memblock_next_valid_pfn on arm and arm64
>> Patch 3 optimizes the memblock_next_valid_pfn()
>> Patch 4~6 optimizes the early_pfn_valid()
>>
>> As for the performance improvement, after this set, I can see the time
>> overhead of memmap_init() is reduced from 27956us to 13537us in my
>> armv8a server(QDF2400 with 96G memory, pagesize 64k).
> 
> So this is 13ms saving when booting 96G machine. Is this really worth
> the additional code? Are there any other benefits?
Sorry, Michal
I missed one thing.
This 13ms optimization is merely the result of my patch 3~6
Patch 1 is originated by Paul Burton in commit b92df1de5d289.
In its description,
===
James said "I have tested this patch on a virtual model of a Samurai CPU
    with a sparse memory map.  The kernel boot time drops from 109 to
    62 seconds. "
===

-- 
Cheers,
Jia
> [...]
>>  arch/arm/Kconfig          |  4 +++
>>  arch/arm/mm/init.c        |  1 +
>>  arch/arm64/Kconfig        |  4 +++
>>  arch/arm64/mm/init.c      |  1 +
>>  include/linux/early_pfn.h | 79 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/memblock.h  |  2 ++
>>  include/linux/mmzone.h    | 18 ++++++++++-
>>  mm/Kconfig                |  3 ++
>>  mm/memblock.c             |  9 ++++++
>>  mm/page_alloc.c           |  5 ++-
>>  10 files changed, 124 insertions(+), 2 deletions(-)
>>  create mode 100644 include/linux/early_pfn.h
> 


