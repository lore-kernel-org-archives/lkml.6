Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B68C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62DB2064E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62DB2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeJKXwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:52:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59084 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbeJKXwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:52:46 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAdlL-0001QI-0m; Thu, 11 Oct 2018 10:24:35 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>, linux-sh@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, linux-mm@kvack.org,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
Date:   Thu, 11 Oct 2018 10:24:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011133730.GB7276@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, michaeljclark@mac.com, linux-riscv@lists.infradead.org, olof@lixom.net, linux-mm@kvack.org, zong@andestech.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, linux-sh@vger.kernel.org, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/5] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-11 7:37 a.m., Christoph Hellwig wrote:
>> +/*
>> + * Log2 of the upper bound of the size of a struct page. Used for sizing
>> + * the vmemmap region only, does not affect actual memory footprint.
>> + * We don't use sizeof(struct page) directly since taking its size here
>> + * requires its definition to be available at this point in the inclusion
>> + * chain, and it may not be a power of 2 in the first place.
>> + */
>> +#define STRUCT_PAGE_MAX_SHIFT	6
> 
> I know this is copied from arm64, but wouldn't this be a good time
> to move this next to the struct page defintion?
> 
> Also this:
> 
> arch/arm64/mm/init.c:   BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
> 
> should move to comment code (or would have to be duplicated for riscv)

Makes sense. Where is a good place for the BUILD_BUG_ON in common code?

I've queued up changes for your other feedback.

Thanks,

Logan
