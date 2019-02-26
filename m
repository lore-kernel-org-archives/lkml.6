Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65388C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8BE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfBZKE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:04:59 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:6487 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfBZKE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:04:59 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id ECB5D13F8EA;
        Tue, 26 Feb 2019 11:04:41 +0100 (CET)
Subject: Re: +
 of-fix-kmemleak-crash-caused-by-imbalance-in-early-memory-reservation.patch
 added to -mm tree
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <CGME20190213201413epcas4p37007ef959fd240caea9283c083c67f9b@epcas4p3.samsung.com>
 <20190213201341.FhuVo%akpm@linux-foundation.org>
 <f1fb5579-785f-2c4d-3801-8fb2dde4bc08@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Prateek Patel <prpatel@nvidia.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <cc410fcb-fc31-3a7c-a8d3-26387d607478@free.fr>
Date:   Tue, 26 Feb 2019 11:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f1fb5579-785f-2c4d-3801-8fb2dde4bc08@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 12:13, Marek Szyprowski wrote:

> On 2019-02-13 21:13, akpm@linux-foundation.org wrote:
> 
>> --- a/drivers/of/of_reserved_mem.c~of-fix-kmemleak-crash-caused-by-imbalance-in-early-memory-reservation
>> +++ a/drivers/of/of_reserved_mem.c
>> @@ -34,22 +34,15 @@ int __init __weak early_init_dt_alloc_re
>>  
>>  	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>>  	align = !align ? SMP_CACHE_BYTES : align;
>> -	base = memblock_phys_alloc_range(size, align, 0, end);
>> +	base = memblock_find_in_range(size, align, start, end);
> 
> The parameters for memblock_find_in_range() are not in the correct
> order. The proper call should be:
> 
> 	memblock_find_in_range(start, end, size, align)

How is it possible that calling memblock_find_in_range() with incorrect parameters
"fixed" the crash? o_O

Regards.
