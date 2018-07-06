Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787EFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249C52401E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWhfwuFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249C52401E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeGFBiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:38:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40749 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeGFBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:38:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so6945767pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wW1J0B36vMqTKWbd66RzDYIjkOL92Jca6cQu4ExdRdk=;
        b=pWhfwuFPZYhrLtDw5jaR7rvVzJs/32cgOP4LlUeR8xpTq9OOwFapIqYguUU5L2JAnW
         TCHkqW/q7y/yo+oDEvtQkqPc2ZoorW2Q5H0GZK8DVKiUHT2K95Tsa99xiPsBK2aZADN4
         oXfnYPFBIopm4JsJLguX1062Vy3pz75yQ+dmSjjR82FxmhoJFZ6fwCWKeDlpKxhs4b5u
         MO+DQ8nBCdjCBQG25zFqnMtUL7+AOdYi4Ukt+c4DZfzVlRG9BB5Gx2pgQAEuSp/NH6yD
         r1nLi83mcPNBGx+qC4/j78Krjo5Y7XG1BrrJ+wj8bFlDKuJ8kBCWtfibnphWhySUg5wa
         GSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wW1J0B36vMqTKWbd66RzDYIjkOL92Jca6cQu4ExdRdk=;
        b=gSesCLtPvEtL0xwPJnMQUNCNumYd48lw9HYUiNf6WK53Nt0kbOpueOFwdwjFPV3S2y
         yxW1xZOi27E4vJbhYJE007BRvH+f60v7kLP3/a4B5Yg17DetXpLEpy+YO2rCTp6CxlvP
         6Wa9cy1CNLvt855N1IjhcDv3vrybjEABsVv75Jjd4ScoC+Qm5Yw5E1kgno8qtgfJtPdk
         GEnh3lsu9LLXEhXn0a2JPOZ4htEX6BLChCIc9OJ0G59E5ITSidydfmB1qttCoikVJCc5
         u2eoM5P4H2hU1hvtUZxViUjMYpsd9Xq2Fr8NI+SngP+r0zc7lJxziwPN9v4kxG2cdEH5
         7+OA==
X-Gm-Message-State: APt69E0QFM90ATBaauBJzVEYrmrrruTyIyOCZd6ZVtZRVLfXkEUT2US+
        z5zfiejA7e4xRI7dkG6xrXs=
X-Google-Smtp-Source: AAOMgpct79aWzRWD14KUeAHZFVGAF8xqronXfLOa2ds9XB4huahypkP5e/V2hHtjgFDz5qBEbiH7aQ==
X-Received: by 2002:a62:3687:: with SMTP id d129-v6mr8607775pfa.137.1530841128396;
        Thu, 05 Jul 2018 18:38:48 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id e5-v6sm9633912pgs.59.2018.07.05.18.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 18:38:47 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
Subject: Re: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm/arm64
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     linux@armlinux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>, will.deacon@arm.com,
        mark.rutland@arm.com, hpa@zytor.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>, neelx@redhat.com,
        erosca@de.adit-jv.com, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        james.morse@arm.com, ard.biesheuvel@linaro.org,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Johannes Weiner <hannes@cmpxchg.org>,
        kemi.wang@intel.com, ptesarik@suse.com, yasu.isimatu@gmail.com,
        aryabinin@virtuozzo.com, nborisov@suse.com,
        Wei Yang <richard.weiyang@gmail.com>, jia.he@hxt-semitech.com
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <1530239363-2356-3-git-send-email-hejianet@gmail.com>
 <CAGM2reZ3zYdrYBEGTdy+LLm_HPREyqYeUqqQnU1GCPd3k98z3Q@mail.gmail.com>
Message-ID: <f3de1c65-c706-710f-4088-48f4b711bac5@gmail.com>
Date:   Fri, 6 Jul 2018 09:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGM2reZ3zYdrYBEGTdy+LLm_HPREyqYeUqqQnU1GCPd3k98z3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel, sorry for the late reply

On 6/30/2018 1:07 AM, Pavel Tatashin Wrote:
> On Thu, Jun 28, 2018 at 10:30 PM Jia He <hejianet@gmail.com> wrote:
>>
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But it causes
>> possible panic bug. So Daniel Vacek reverted it later.
>>
>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>>
>> On arm and arm64, memblock is used by default. But generic version of
>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>> not always return the next valid one but skips more resulting in some
>> valid frames to be skipped (as if they were invalid). And that's why
>> kernel was eventually crashing on some !arm machines.
> 
> Hi Jia,
> 
> Is this a bug? Should we make other arches that support memblock to
> use memblock_is_map_memory() ? it is more expensive, but if the
> default is broken, maybe it makes sense to change?
> 
IIUC, the bug is in memblock_next_valid_pfn instead of pfn_valid.
memblock_next_valid_pfn will return the incorrect next valid pfn on
!arm arches (e.g. X86). Please refer to b92df1de5.

Currently only arm/arm64 use MEMBLOCK_NOMAP, it is really beyond my
power to implement it on all other arches ;-)


-- 
Cheers,
Jia
