Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8071FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A869F21475
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A869F21475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHPDib convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:38:31 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:54380
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbeHPDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:38:31 -0400
X-ASG-Debug-ID: 1534380218-093b7e07001f5a0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id rn3pihLu8bxTX7jI (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 16 Aug 2018 08:43:39 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Thu, 16 Aug 2018 08:43:46 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.0847.030; Thu, 16 Aug 2018 08:43:46 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Thread-Topic: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for
 non-strict mode
X-ASG-Orig-Subj: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Thread-Index: AQHULSVfvpgJoo0nvEihhr7Wc+EfZw==
Date:   Thu, 16 Aug 2018 00:43:45 +0000
Message-ID: <96d12fc419bb4fb6b1a83de11621cb93@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com> <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com> <20180814083500.GA28101@arm.com>
 <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
 <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
 <20180815073300.GA2100@arm.com> <20180815073501.GA2375@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.69]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1534380219
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5001 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.55770
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will and Robin,

  Many thanks for your explanations.

Thanks.
Shunyong.

On 2018/8/15 15:35, Will Deacon wrote:
> On Wed, Aug 15, 2018 at 08:33:01AM +0100, Will Deacon wrote:
>> On Wed, Aug 15, 2018 at 01:43:37AM +0000, Yang, Shunyong wrote:
>>> On Tue, 2018-08-14 at 11:02 +0100, Robin Murphy wrote:
>>>> On 14/08/18 09:35, Will Deacon wrote:
>>>>> On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown)
>>>>> wrote:
>>>>>> On 2018/8/6 9:32, Yang, Shunyong wrote:
>>>>>>> On 2018/7/26 22:37, Robin Murphy wrote:
>>>>>>>> Because DMA code is not the only caller of iommu_map/unmap.
>>>>>>>> It's
>>>>>>>> perfectly legal in the IOMMU API to partially unmap a
>>>>>>>> previous mapping
>>>>>>>> such that a block entry needs to be split. The DMA API,
>>>>>>>> however, is a
>>>>>>>> lot more constrined, and thus by construction the iommu-dma
>>>>>>>> layer will
>>>>>>>> never generate a block-splitting iommu_unmap() except as a
>>>>>>>> result of
>>>>>>>> illegal DMA API usage, and we obviously do not need to
>>>>>>>> optimise for that
>>>>>>>> (you will get a warning about mismatched unmaps under dma-
>>>>>>>> debug, but
>>>>>>>> it's a bit too expensive to police in the general case).
>>>>>>>>
>>>>>>>
>>>>>>> When I was reading the code around arm_lpae_split_blk_unmap(),
>>>>>>> I was
>>>>>>> curious in which scenario a block will be split. Now with your
>>>>>>> comments
>>>>>>> "Because DMA code is not the only caller of iommu_map/unmap",
>>>>>>> it seems
>>>>>>> depending on the user.
>>>>>>>
>>>>>>> Would you please explain this further? I mean besides DMA,
>>>>>>> which user
>>>>>>> will use iommu_map/umap and how it split a block.
>>>>>>
>>>>>> I also think that arm_lpae_split_blk_unmap() scenario is not
>>>>>> exist, maybe
>>>>>> we should remove it, and give a warning for this wrong usage.
>>>>>
>>>>> Can't it happen with VFIO?
>>>>
>>>> ...or GPU drivers, or anyone else managing their own IOMMU domain
>>>> directly. A sequence like this is perfectly legal:
>>>>
>>>>     iommu_map(domain, iova, paddr, SZ_8M, prot);
>>>>     ...
>>>>     iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);
>>>>
>>>> where if iova and paddr happen to be suitably aligned, the map will
>>>> lay
>>>> down blocks, and the unmap will then have to split one of them into
>>>> pages to remove half of it. We don't tear our hair out maintaining
>>>> split_blk_unmap() for the fun of it :(
>>>
>>> Thank you for the GPU example. But for VFIO, I remember all memory will
>>> be   pinned in the early stage of emulator (such as qemu) start. So,
>>> the split will occur at which operation? Maybe virtio balloon inflate?
>>
>> My memory is pretty hazy here, but I was fairly sure that VFIO didn't
>> always unmap() with the same granularity as it map()'d, at least for
>> the v1 interface. Either way, split_blk_unmap() was written because it was
>> necessary at the time, rather than just for fun!
>>
>> Will
>> IMPORTANT NOTICE: The contents of this email and any attachments are
>> confidential and may also be privileged. If you are not the intended
>> recipient, please notify the sender immediately and do not disclose the
>> contents to any other person, use it for any purpose, or store or copy the
>> information in any medium. Thank you.
> 
> Urgh, sorry about this threatening disclaimer ^^. Please disregard.
> 
> Will
> 

