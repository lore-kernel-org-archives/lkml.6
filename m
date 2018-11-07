Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666F020862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666F020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeKHFvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:51:24 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49534 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeKHFvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:51:23 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gKUI9-0005jQ-Sq; Wed, 07 Nov 2018 13:19:10 -0700
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com>
Date:   Wed, 7 Nov 2018 13:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: osalvador@suse.de, vbabka@suse.cz, mhocko@suse.com, arnd@arndb.de, hch@lst.de, aou@eecs.berkeley.edu, palmer@sifive.com, sbates@raithlin.com, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-07 1:12 p.m., Andrew Morton wrote:
>> +void __init memblocks_present(void)
>> +{
>> +	struct memblock_region *reg;
>> +
>> +	for_each_memblock(memory, reg) {
>> +		memory_present(memblock_get_region_node(reg),
>> +			       memblock_region_memory_base_pfn(reg),
>> +			       memblock_region_memory_end_pfn(reg));
>> +	}
>> +}
>> +
> 
> I don't like the name much.  To me, memblocks_present means "are
> memblocks present" whereas this actually means "memblocks are present".
> But whatever.  A little covering comment which describes what this
> does and why it does it would be nice.

The same argument can be made about the existing memory_present()
function and I think it's worth keeping the naming consistent. I'll add
a comment and resend shortly.

> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> I can grab both patches and shall sneak them into 4.20-rcX, but feel
> free to merge them into some git tree if you'd prefer.  If I see them
> turn up in linux-next I shall drop my copy.

Sounds good, thanks.

Logan

