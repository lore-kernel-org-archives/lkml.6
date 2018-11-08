Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2709B20684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2709B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeKIDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:41:17 -0500
Received: from foss.arm.com ([217.140.101.70]:46844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIDlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:41:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F59EBD;
        Thu,  8 Nov 2018 10:04:38 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43A43F5CF;
        Thu,  8 Nov 2018 10:04:35 -0800 (PST)
Date:   Thu, 8 Nov 2018 18:04:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Message-ID: <20181108180432.GH144107@arrakis.emea.arm.com>
References: <20181107205433.3875-1-logang@deltatee.com>
 <20181107205433.3875-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107205433.3875-2-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 01:54:32PM -0700, Logan Gunthorpe wrote:
> This define is used by arm64 to calculate the size of the vmemmap
> region. It is defined as the log2 of the upper bound on the size
> of a struct page.
> 
> We move it into mm_types.h so it can be defined properly instead of
> set and checked with a build bug. This also allows us to use the same
> define for riscv.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
