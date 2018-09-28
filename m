Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E01F2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pxatj6AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E01F2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeI1PDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:03:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17526 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeI1PDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:03:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bade8d70000>; Fri, 28 Sep 2018 01:39:51 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 01:40:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Sep 2018 01:40:35 -0700
Received: from [10.24.70.87] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 08:40:31 +0000
Subject: Re: [PATCH v3 2/2] vfio: add edid support to mbochs sample driver
To:     Gerd Hoffmann <kraxel@redhat.com>
CC:     <intel-gvt-dev@lists.freedesktop.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20180921083013.15028-1-kraxel@redhat.com>
 <20180921083013.15028-3-kraxel@redhat.com>
 <4b9847dd-c37d-1d5d-3343-7030e62894fb@nvidia.com>
 <20180928054056.vjqwxvaj7sjmsozh@sirius.home.kraxel.org>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <646427f9-7bed-43aa-6aba-9b5e82eecb68@nvidia.com>
Date:   Fri, 28 Sep 2018 14:10:26 +0530
MIME-Version: 1.0
In-Reply-To: <20180928054056.vjqwxvaj7sjmsozh@sirius.home.kraxel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538123991; bh=hTi86ycULPAwLMVN1+ifkXHO36Ss//Q5AJyRMtIbZFE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pxatj6APEkz5+7mt8HesRN+EmYjfp27aEnmkOXKt8T5PISGVPECaxsQgPoBk3+5L/
         kdJBXU0tfkbhzkdOrJ8sS/4AnouvfdYP7X/JlzXNbuy/7asJG0pfPZDUGBcM+ZqZP2
         c5Hhe/R4VoAXQzyXMpX/KPt+T8RZ+0eizA1Rdsqd71zhyUSMXSJM4Y2AJ3X6Ol9wl6
         8KaI+Fq3fmHKJLkxo2kznLIcXH4rRozwIA3lLH9WcGKU6LDI4CUV1aG4dIvfQz7gOe
         //FJjCU6/mTYpbLdV444/PufT1IKg2rgpdrikMK4flewq4wYpMh3sVpxvTGx9WLtfH
         YdmQf+/r20X8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2018 11:10 AM, Gerd Hoffmann wrote:
>>> +	case MBOCHS_EDID_REGION_INDEX:
>>> +		ext->base.argsz = sizeof(*ext);
>>> +		ext->base.offset = MBOCHS_EDID_OFFSET;
>>> +		ext->base.size = MBOCHS_EDID_SIZE;
>>> +		ext->base.flags = (VFIO_REGION_INFO_FLAG_READ  |
>>> +				   VFIO_REGION_INFO_FLAG_WRITE |
>>> +				   VFIO_REGION_INFO_FLAG_CAPS);
>>
>> Any reason to not to use _MMAP flag?
> 
> There is no page backing this.  Also it is not performance-critical,
> edid updates should be rare, so the extra code for mmap support doesn't
> look like it is worth it.
> 
> Also for the virtual registers (especially link_state) it is probably
> useful to have the write callback of the mdev driver called to get
> notified about the change.
> 
>> How would QEMU side code read this region? will it be always trapped?
> 
> qemu uses read & write syscalls (well, pread & pwrite actually).
> 
>> If vendor driver sets _MMAP flag, will QEMU side handle that case as well?
> 
> The current test branch doesn't, it expects read+write to work.
>   https://git.kraxel.org/cgit/qemu/log/?h=sirius/edid-vfio
> 

Ok.
Can you add a comment in vfio.h that this region is non-mmappable?

>> I think since its blob, edid could be read by QEMU using one memcpy
>> rather than adding multiple memcpy of 4 or 8 bytes.
> 
> From qemu it's a single pwrite syscall actually.  mbochs_write() splits
> it into 4 byte writes and calls mbochs_access() for each of them.  One
> could probably add a special case for the EDID blob to mbochs_write().
> But again: doesn't seem worth the effort given that edid updates should
> be a rare event.
> 

Ok.

Thanks,
Kirti

> cheers,
>   Gerd
> 
