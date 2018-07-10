Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4459C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B46C20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B46C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeGJSSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:18:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbeGJSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1191DCB;
        Tue, 10 Jul 2018 11:11:43 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7913F3F5AD;
        Tue, 10 Jul 2018 11:11:40 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
References: <cover.1531239284.git.robin.murphy@arm.com>
 <20180710180232.GA26285@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <89365af4-19fa-1dc2-27d0-37e9145134af@arm.com>
Date:   Tue, 10 Jul 2018 19:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710180232.GA26285@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 19:02, Christoph Hellwig wrote:
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops to catch all possible incarnations of this problem,
>> but this initial RFC is mostly about the impact beyond the dma-mapping
>> subsystem itself.
> 
> Thanks, this looks very nice to me.
> 
> In fact it probably solves the RISC-V/Xiling problem as well if we can
> just add the dma-ranges property to the device tree for the affected
> systems.  Palmer, do you know how easily the DT could be updated for
> that case?

That would indeed be nice, but beware that the way PCI devices are 
bodged through of_dma_configure() only actually works for dma-coherent 
and is busted WRT parsing dma-ranges correctly. Fixing that is my next 
step after getting these basics done ;)

Robin.
