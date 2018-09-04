Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A6BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B1kBEp2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0312D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeIEAmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:42:00 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:47722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIEAl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:41:59 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 39CBF10C05D1;
        Tue,  4 Sep 2018 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536092118; bh=KCul7grDSUH8CnEW6Rtb/SZ8Q6E1LBIiGSQ6wFs3BzU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=B1kBEp2OeW0xNX+XFLKN36j8MtNsHhVSaXq8Pz20jGnx87PU130fNxf/qXbhiSX4d
         edU8GM4iait4T7gZIARcaq9hdiQUTG8PdmSlduuXCCX919HLIt4zQ4C14iLfv0LmUm
         BDyHpKmTDHyRf1DgOCE2TVcgSFFU9WEFCNIK6h8cAe2Dp5dyhV/1z4I2yo9bXR5kYs
         /4GdxpJMVWGQJz95r02vAFpKDq1QVNPO1ivB9qK7H44Dhjr6Y8/+Z/sCoblFpJjk1r
         mCXFfuzeniiv+bbqYQEcfxRwxDmso2iqTih/KzZ1lHYYlkB6Lt6tWN4vhHtueBEy9J
         I7cQX9wo4YI2g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2AC6D3793;
        Tue,  4 Sep 2018 13:15:18 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 4 Sep 2018 13:15:00 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 5 Sep 2018 01:44:57 +0530
Received: from [10.10.161.63] (10.10.161.63) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 5 Sep 2018 01:44:57 +0530
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>, <hch@lst.de>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc,gmane.linux.kernel.cross-arch
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
Date:   Tue, 4 Sep 2018 13:14:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.63]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:
> The ARC HS processor provides an IOC port (I/O coherency bus
> interface) that allows external devices such as DMA devices
> to access memory through the cache hierarchy, providing
> coherency between I/O transactions and the complete memory
> hierarchy.
> 
> Some recent SoC with ARC HS (like HSDK) allow to select bus
> port (IOC or non-IOC port) for connecting DMA devices in runtime.
> 
> With this patch we can use both HW-coherent and regular DMA
> peripherals simultaneously.
> 
> NOTE:
> This patch series was stress tested on HSDK with iperf3 (ethernet)
> and bonie++ (usb and sdio) in three configurations:
>  * IOC enabled globaly
>  * IOC disabled globaly
>  * IOC enabled partially (USB & SDIO are connected via IOC AXI port,
>    ethernet is connected to DDR AXI port (non-IOC port) 
> 
> NOTE:
> If you want to test some device without IOC it is not enough
> to remove "dma-coherent" property from dts. You had to remap this
> device to regular DDR AXI port intead of IOC AXI port.
> You also need to apply 3 following patches firstly:
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03865.html
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03889.html
> https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03887.html
> 
> NOTE:
> We don't touch any aperture configuration in this patch series. So we
> don't switch any devices between IOC and non-IOC AXI ports on any board.
> It can be done later if it is required.
> 
> Changes v1->v2 (Thanks to Christoph):
>  * Don't select DMA_DIRECT_OPS explicitly as it is already selected by
>    DMA_NONCOHERENT_OPS
>  * Remove check for HIGHMEM pages from arch_dma_{alloc, free}
> 
> Eugeniy Paltsev (4):
>   ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
>   ARC: allow to use IOC and non-IOC DMA devices simultaneously
>   ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
>   ARC: don't check for HIGHMEM pages in arch_dma_alloc
> 
>  arch/arc/boot/dts/axc003.dtsi      | 26 ++++++++++++++++
>  arch/arc/boot/dts/axc003_idu.dtsi  | 26 ++++++++++++++++
>  arch/arc/boot/dts/hsdk.dts         |  4 +++
>  arch/arc/include/asm/dma-mapping.h | 13 ++++++++
>  arch/arc/mm/cache.c                | 30 +++++++++---------
>  arch/arc/mm/dma.c                  | 62 +++++++++++++++++++-------------------
>  6 files changed, 115 insertions(+), 46 deletions(-)
>  create mode 100644 arch/arc/include/asm/dma-mapping.h

Apologies for the delay in getting to this - series applied and pushed to for-curr

Thx,
-Vineet


