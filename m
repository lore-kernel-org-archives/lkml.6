Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981720C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2981720C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeGKSJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:09:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeGKSJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:09:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680E580D;
        Wed, 11 Jul 2018 11:03:58 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7A53F589;
        Wed, 11 Jul 2018 11:03:56 -0700 (PDT)
Subject: Re: [RFC PATCH 2/4] ACPI/IORT: Set bus DMA mask as appropriate
To:     Christoph Hellwig <hch@lst.de>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <cover.1531239284.git.robin.murphy@arm.com>
 <c604b3eae4103ee0ad6da84baa1bc893a81ef5f8.1531239284.git.robin.murphy@arm.com>
 <20180710180458.GC26285@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <da218bdf-198e-b064-356d-3354869a670a@arm.com>
Date:   Wed, 11 Jul 2018 19:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710180458.GC26285@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 19:04, Christoph Hellwig wrote:
> On Tue, Jul 10, 2018 at 06:17:17PM +0100, Robin Murphy wrote:
>> When an explicit DMA limit is described by firmware, we need to remember
>> it regardless of how drivers might subsequently update their devices'
>> masks. The new bus_dma_mask field does that.
> 
> Shouldn't we also stop presetting the dma mask after this?

I guess initialising the device masks here only really has any effect if 
drivers fail to set their own, so if we're getting stricter about that 
then it would make sense to stop; I'll add a couple of patches on top to 
clean that up.

Robin.
