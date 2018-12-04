Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA834C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A2206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeLDNgN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:36:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24917 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbeLDNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:36:13 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-132-rdQhZ9jlO_2W-z45-YPVBg-1; Tue, 04 Dec 2018 13:36:05 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 4 Dec 2018 13:36:14 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 4 Dec 2018 13:36:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qian Cai' <cai@gmx.us>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Thread-Topic: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Thread-Index: AQHUiPZzm15/Gh5shkauSCyHDLkHIqVumidA
Date:   Tue, 4 Dec 2018 13:36:14 +0000
Message-ID: <2f2a3bb6b0b9473687628f936db71c4f@AcuMS.aculab.com>
References: <20181130214803.3119-1-cai@gmx.us>
In-Reply-To: <20181130214803.3119-1-cai@gmx.us>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: rdQhZ9jlO_2W-z45-YPVBg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai
> Sent: 30 November 2018 21:48
> To: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com
> Cc: yisen.zhuang@huawei.com; salil.mehta@huawei.com; john.garry@huawei.com; linuxarm@huawei.com;
> iommu@lists.linux-foundation.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Qian Cai
> Subject: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
> 
> The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
> so it could trigger "DMA-API: debugging out of memory - disabling".
> 
> hnae_get_handle [1]
>   hnae_init_queue
>     hnae_init_ring
>       hnae_alloc_buffers [2]
>         debug_dma_map_page
>           dma_entry_alloc
> 
> [1] for (i = 0; i < handle->q_num; i++)
> [2] for (i = 0; i < ring->desc_num; i++)
> 
> Also, "#define HNS_DSAF_MAX_DESC_CNT 1024"
> 
> On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
> already,
> 
> 4 (NICs) x 16 (queues) x 1024 (port descption numbers) = 65536
> 
> Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
> for users to deal with special cases like this.

Ugg. That is worse than a module parameter.

The driver needs to automatically reduce the number of mapping requests.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

