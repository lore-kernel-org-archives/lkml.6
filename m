Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D098BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E23724DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR1u9s8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E23724DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeGCCA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:00:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39380 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeGCCA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:00:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so194956pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=haX6QmtiDZtjBII6V7n5ZZh8GVHhCw23vd3sL1p09Ec=;
        b=YR1u9s8WSs30Z4Erx2y31bez0pjb34ipyUjJ0Ozjikn3LptogmO6Ojvw+4UflDDCyI
         o56zKyuJLZO4xVStpoAX3830JExi6fVS6KS2bGIxY0lyntE/zSUZBHtclCYCMfwQcLmR
         RAGLqQ/TWGyKb9gZkFGPu9EZcC2EqM3lIQTcokx2FnKVgd5UhwplErXjObn+U7lZEElq
         Je4J6XOeNl8kFEHGTTPBfmU22kOan76AS3efXkUDrSCt+oaxHsF2hSs/55zii+LfQA0a
         lBU9AGe3Ny3ZtEhWIrybiH5BLxDKcEaWbc8P9A4mOXdWuckhcIC3w1Tt2w/7QaOs8Ec1
         Kpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=haX6QmtiDZtjBII6V7n5ZZh8GVHhCw23vd3sL1p09Ec=;
        b=rdJFarOxtgs9zaNhxGtKfahyWfQjERMIPVPKU8walJnRzsATiUXb0dFkaMVKVxOyXz
         m1iuKA4dFjjnc2qo/fbuQhILNtyCHgjEEGV6iZI1k28S5XkhBXGrgai3CX5MpQg5GbjC
         YHouboF33lxZFyLvXp1iHCIWQ2DHfDrIVw0YllY7SUCpCQtYA+8BjESfL9R8jiINSaH7
         KQ5gRHQSy0oPcJWT+VnF0tWd8+cF5MsNNFs6A+LwtGvuiWMQp6dAcF1O8mbYm1QsJ7K/
         WJDrH1MsFUR3pEG0Q1lbN5dlvPHmMeAsxLjhi0iOmgOGSTO8Yt7xXb+liuoRHbvno1xu
         KYiQ==
X-Gm-Message-State: APt69E07hE8QZ29Bu9T6ZOijhR+J10r96oJRZ8zfrdqV4ZTjW+Z98kRH
        JMGAvFO5ra0cQqHHDzXQGFw=
X-Google-Smtp-Source: AAOMgpdQKS23RMbTvfN0iG3Ncy3Gjn/M/8Sn+gpXEmLq/lNxljZ/IVcYhaY+lpifCCzqplhwq51ImA==
X-Received: by 2002:a62:2ec1:: with SMTP id u184-v6mr27826859pfu.184.1530583256551;
        Mon, 02 Jul 2018 19:00:56 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id n18-v6sm10779091pge.37.2018.07.02.19.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 19:00:55 -0700 (PDT)
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
Message-ID: <1466b490-76f8-86a4-f39a-3bef3bb0501f@gmail.com>
Date:   Tue, 3 Jul 2018 10:00:34 +0800
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

Hi Michal
Thanks for the comments

On 7/2/2018 7:40 PM, Michal Hocko Wrote:
> On Fri 29-06-18 10:29:17, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") tried to optimize the loop in memmap_init_zone(). But
>> there is still some room for improvement.
> 
> It would be great to shortly describe those optimization from high level
> POV.

Ok

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

hmm.. Currently my answer is no.
But I believe it can shorten the boot time when the memory is larger than n TBs.
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

