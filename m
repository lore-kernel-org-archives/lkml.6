Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED22C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5872084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfASSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:46:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59000 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfASSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:46:33 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gkvdQ-00075U-Jc; Sat, 19 Jan 2019 11:46:25 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20190119000559.12784-1-logang@deltatee.com>
 <20190119094002.GA21653@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
Date:   Sat, 19 Jan 2019 11:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119094002.GA21653@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: joro@8bytes.org, dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-19 2:40 a.m., Christoph Hellwig wrote:
> Which resources do you plan to map?  At least for PCIe P2P adding
> an address translation seems wrong to me.

It's mapping a PCI BAR but not for PCIe P2P. In this case, we are using
the Intel I/OAT DMA engine to copy data from a PCI BAR to/from memory. See:

http://lkml.kernel.org/r/20190119001001.13087-1-logang@deltatee.com

>>
>> The implementation for intel_map_resource() is nearly identical to
>> intel_map_page(), we just have to re-create __intel_map_single().
>> dma_unmap_resource() uses intel_unmap_page() directly as the
>> functions are identical.
> 
> Instead of having two tiny wrappers I'd just revert
> 964f2311a6862f1fbcc044d0828ad90030928b7f if we need to pass a real
> physical address now.

Ok, I can resubmit this with that cleanup. Should I do it in two commits
(1 revert + 1 new) or is one commit that just restores the original
helper fine?

Thanks,

Logan
