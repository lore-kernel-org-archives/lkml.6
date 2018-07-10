Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7152C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67758208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XMO0dS5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67758208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeGJSVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:21:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52737 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbeGJSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531246873; x=1562782873;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jmihC36F+iYYCODOceHXNgNSGIYkSW0HINSAs/sg9rE=;
  b=XMO0dS5n/fdCTH08Q12DWpCnnY9qJcUA8tDKcOadKkc2pIWaNyUV+rH7
   hiEl4KqvmhhQMCgLlxhKiQVrbOzOqA1wxEupVCvciPszVFyznsgxNyrp9
   M/bpfdWW3bKxgbiAL8uf+WuW+FRsSUF2Pry6LZKqtsItDoy4OATGkndZA
   jNHb/OW9r07gVIXHlBwBVGKP5qyLM71GfKaLrevBanHwbWP+wudNqR6TC
   kD8RYlkVJbzgl9Zq7q5wV+ebbCLCwxHF3bq0He0VfFC8yZLRBd8o+dCsW
   rYjXC9TAPOu/Tx9EOguD56AWRGbkOHc+sVGuQQfYmkqEltZYKMHtQ0XGn
   w==;
X-IronPort-AV: E=Sophos;i="5.51,335,1526313600"; 
   d="scan'208";a="84941339"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2018 02:12:08 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jul 2018 11:00:57 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.157.210]) ([10.196.157.210])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Jul 2018 11:12:08 -0700
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <20180710180232.GA26285@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <1469c385-a586-3192-6ec8-cb15878acafe@wdc.com>
Date:   Tue, 10 Jul 2018 11:12:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180710180232.GA26285@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 11:01 AM, Christoph Hellwig wrote:
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
> 
Hi Chris,
I have a PR in riscv-pk that can modify the DT in bbl easily. In fact, 
that's how I added the timer node for the interrupt patch.

https://github.com/riscv/riscv-pk/pull/112

Obviously, the best approach would be to update the firmware but that 
may be time consuming sometime.

Regards,
Atish
>>
>> Robin.
>>
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html
>>
>> Robin Murphy (4):
>>    dma-mapping: Generalise dma_32bit_limit flag
>>    ACPI/IORT: Set bus DMA mask as appropriate
>>    of/device: Set bus DMA mask as appropriate
>>    iommu/dma: Respect bus DMA limit for IOVAs
>>
>>   arch/x86/kernel/pci-dma.c | 2 +-
>>   drivers/acpi/arm64/iort.c | 1 +
>>   drivers/iommu/dma-iommu.c | 3 +++
>>   drivers/of/device.c       | 1 +
>>   include/linux/device.h    | 6 +++---
>>   kernel/dma/direct.c       | 2 +-
>>   6 files changed, 10 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.17.1.dirty
> ---end quoted text---
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

