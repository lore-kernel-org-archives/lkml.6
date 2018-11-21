Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C22147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NICaJ56I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341C22147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKUNhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:37:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37516 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKUNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:37:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so3686576edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JntbjgdbFPN/yGwSQYyS2wscx503lJQG/dLeoweqTN0=;
        b=NICaJ56IbKIMvqkYJV/+RSukHJujOOmanFGLmvW1dL/RxN9B5FSAsuTPCbNkyhwv+Y
         PuswXlBP0gDvupJALlrHOp6oMfDTJ/CrWQ0YRIHDsvkMad5j/nGD1GokAVwk6JKVvKB3
         KEuKFJ7FnMebC9Uy7ps/TI4exLyIivswuRf0yIq29vjPK/a9PZwKIDcs1D5m3ACT3tcQ
         OwG1w/ZbnewIBYC8ebl86ZkBI0rhVgUCpqUdUl9Fc8BzPGuMLhEiU2rNeYi1btfWdxz+
         zj02+MlwKFJm0TQ7Q2r75WokoroFRhfY46Wxo5jquYCH+vNTToceeat1wXXQUbxMUcOA
         oAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JntbjgdbFPN/yGwSQYyS2wscx503lJQG/dLeoweqTN0=;
        b=KLE0mdqE/RggZ2LrnO1QE3zrhFKRUe/vW8VO15Y5fuVabwcph6T1VJ/trVivU9nXdP
         kZ7cv66QB9LDw+08jFbEcA7SQgYnYODmrddDrWnQnxOu/acE3TFDoFt+pC+09Aa1BmQt
         KlV0h7WRAS16Sfe0K6oZHOjT6yRKSFZTP1BNKYAj7DF8Xv4uwVlTp1qCx054dmwt5Kbb
         JdHrvR3Y9O/i8nwrky0VQ0d2P7AxBKHWFY8vvUlmdn1/UmRxJVii2SO7lweJOKjYL06x
         PRe3InvthC7Bxmh2bBBIhPwUvbAWku07u2jA7Hc0DqzCdVzPoz4HrPrpqY/s1Ef0S3d0
         PRYQ==
X-Gm-Message-State: AGRZ1gL5p6sRSSpdkuooNGdl8/cZmDcrhQqH4ffnjAZ8utmXytlsMwvN
        Fe6VllPynfh+vBIMXj3UDek=
X-Google-Smtp-Source: AJdET5fHnVqQYN5yZXRfrXvYxQteETnqOAUe2V5wZNbpuX3SmO0MzqedAq7eeUuABzWUj0+S9S0GcA==
X-Received: by 2002:a17:906:5304:: with SMTP id h4-v6mr3712623ejo.39.1542769505495;
        Tue, 20 Nov 2018 19:05:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l17sm4776089edc.56.2018.11.20.19.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 19:05:04 -0800 (PST)
Date:   Wed, 21 Nov 2018 03:05:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181121030504.ucclpgl62es7lnwf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
 <20181116102405.GF14706@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116102405.GF14706@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:24:05AM +0100, Michal Hocko wrote:
>On Thu 15-11-18 07:50:40, Wei Yang wrote:
>[...]
>> @@ -1193,8 +1196,8 @@ static unsigned int count_free_highmem_pages(void)
>>  	struct zone *zone;
>>  	unsigned int cnt = 0;
>>  
>> -	for_each_populated_zone(zone)
>> -		if (is_highmem(zone))
>> +	for_each_zone(zone)
>> +		if (populated_zone(zone) && is_highmem(zone))
>>  			cnt += zone_page_state(zone, NR_FREE_PAGES);
>
>this should be for_each_managed_zone because we only care about highmem
>zones which have pages in the allocator (NR_FREE_PAGES).
>
>>  
>>  	return cnt;
>> @@ -1239,10 +1242,10 @@ static unsigned int count_highmem_pages(void)
>>  	struct zone *zone;
>>  	unsigned int n = 0;
>>  
>> -	for_each_populated_zone(zone) {
>> +	for_each_zone(zone) {
>>  		unsigned long pfn, max_zone_pfn;
>>  
>> -		if (!is_highmem(zone))
>> +		if (!populated_zone(zone) || !is_highmem(zone))
>>  			continue;
>>  
>>  		mark_free_pages(zone);
>
>I am not familiar with this code much but I strongly suspect that we do
>want for_each_managed_zone here because saveable_highmem_page skips over
>all reserved pages which rules out the bootmem. But this should be
>double checked with Rafael (Cc-ed).
>
>Rafael, does this loop care about pages which are not managed by the
>page allocator?
>

Hi, Rafael

Your opinion on this change and the following one is appreciated :-)

>> @@ -1305,8 +1308,8 @@ static unsigned int count_data_pages(void)
>>  	unsigned long pfn, max_zone_pfn;
>>  	unsigned int n = 0;
>>  
>> -	for_each_populated_zone(zone) {
>> -		if (is_highmem(zone))
>> +	for_each_zone(zone) {
>> +		if (!populated_zone(zone) || is_highmem(zone))
>>  			continue;
>>  
>>  		mark_free_pages(zone);
>> @@ -1399,9 +1402,12 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
>>  	struct zone *zone;
>>  	unsigned long pfn;
>>  
>> -	for_each_populated_zone(zone) {
>> +	for_each_zone(zone) {
>>  		unsigned long max_zone_pfn;
>>  
>> +		if (!populated_zone(zone))
>> +			continue;
>> +
>>  		mark_free_pages(zone);
>>  		max_zone_pfn = zone_end_pfn(zone);
>>  		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
>> @@ -1717,7 +1723,10 @@ int hibernate_preallocate_memory(void)
>>  	saveable += save_highmem;
>>  	highmem = save_highmem;
>>  	size = 0;
>> -	for_each_populated_zone(zone) {
>> +	for_each_zone(zone) {
>> +		if (!populated_zone(zone))
>> +			continue;
>> +
>>  		size += snapshot_additional_pages(zone);
>>  		if (is_highmem(zone))
>>  			highmem += zone_page_state(zone, NR_FREE_PAGES);
>
>ditto for the above.
>
>
>> @@ -1863,8 +1872,8 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
>>  	struct zone *zone;
>>  	unsigned int free = alloc_normal;
>>  
>> -	for_each_populated_zone(zone)
>> -		if (!is_highmem(zone))
>> +	for_each_zone(zone)
>> +		if (populated_zone(zone) && !is_highmem(zone))
>>  			free += zone_page_state(zone, NR_FREE_PAGES);
>>  
>>  	nr_pages += count_pages_for_highmem(nr_highmem);
>
>This one should be for_each_managed_zone (NR_FREE_PAGES)
>
>The rest looks good to me.
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
