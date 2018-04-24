Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756491AbeDXHeA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:34:00 -0400
Received: from verein.lst.de ([213.95.11.211]:57575 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756326AbeDXHd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:33:58 -0400
Date: Tue, 24 Apr 2018 09:35:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, openrisc@lists.librecores.org,
        Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/22] dma-debug: move initialization to common code
Message-ID: <20180424073524.GB18945@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-2-hch@lst.de> <294a1469-01d6-10fb-5de1-b1d4513a066c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <294a1469-01d6-10fb-5de1-b1d4513a066c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:23:43AM +0100, Robin Murphy wrote:
>> -void dma_debug_init(u32 num_entries)
>> +static int dma_debug_init(void)
>>   {
>> +	u32 num_entries;
>
> Maybe initialise it to PREALLOC_DMA_DEBUG_ENTRIES?

We initialize it down in an if/else clause which seems a little more clear
to me, at the cost of two extra lines of code.  But I suspect I should
just go a little further and merge the global req_entries and the local
num_entries into a single variable with a better name.

>> +core_initcall(dma_debug_init);
>
> I think it's worth noting that for most users this now happens much earlier 
> than before. In general that's probably good (e.g. on arm64 it should 
> prevent false-positives from the Arm SMMU drivers under ACPI), and I can't 
> imagine it's high-risk, but it is a behaviour change.

I'll mention this in the changelog, thanks!
