Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA678C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A68A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfAITdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:33:40 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59898 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfAITdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:33:40 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ghJbd-0005Bg-NP; Wed, 09 Jan 2019 12:33:38 -0700
To:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
References: <20190109192233.5752-1-logang@deltatee.com>
 <57aae0aa-fb12-b686-9835-b5dc60d97878@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0096e1a-4256-98e1-57d8-d18f5b01fbae@deltatee.com>
Date:   Wed, 9 Jan 2019 12:33:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <57aae0aa-fb12-b686-9835-b5dc60d97878@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: fancer.lancer@gmail.com, allenbh@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, dave.jiang@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 0/8] Fix breakage caused by the NTB multi-port patchset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-09 12:32 p.m., Dave Jiang wrote:
>> I'm resending this because I've recently found out that the change we
>> made to use the NTB struct device in DMA allocations is wrong and
>> needs to be reverted. Turns out that, when running with an IOMMU,
>> dma_alloc_coherent() will always fail if you pass it the NTB struct
>> device. This is because the device has not been assigned an IOMMU
>> group and the Intel IOMMU at least expect the devices to be on the PCI
>> bus and be able to find a proper bus-dev-fn number through a struct
>> pci device. Therefore, we must revert the change and I've changed
>> patch 2 to do this and remove the no longer necessary DMA mask
>> adjustments.
> 
> For the revert, I think we should cc stable as well.

I agree it should go into stable too. But I thought the fixes tag would
make that happen...

Logan
