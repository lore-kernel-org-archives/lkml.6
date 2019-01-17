Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD92220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IYESefHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAQJCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:02:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAQJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:02:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0H92STX026197;
        Thu, 17 Jan 2019 03:02:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547715748;
        bh=NxgcnM+Jzy5pQx4pfUAWdUrkK8Agpy/FVUdVOVlbPL0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IYESefHydpKlsKvsdggFS+FhIY436XuQUgDEKS2FZvUTltAIJM3cGowu1/CF11QIp
         YO9KDXd3trdHpDonHhtdLw8Ac6iyyqPhVomlGOQOn8VnMcJloCCDtEWw4mzLEKMYHp
         M4ueoENYEwzb/d5P5LI7s95sY2wrYccUOrE1YGw8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0H92SNR015652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 03:02:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 03:02:28 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 03:02:27 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0H92PGF029423;
        Thu, 17 Jan 2019 03:02:25 -0600
Subject: Re: [PATCH v2 0/2] Support for eMMC in AM65x-evm
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
 <20190115142948.3fq2i6vav7jn4ulq@kahuna>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <488c457b-efc0-1006-ad2d-a29cd455d979@ti.com>
Date:   Thu, 17 Jan 2019 14:35:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115142948.3fq2i6vav7jn4ulq@kahuna>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 15/01/19 7:59 PM, Nishanth Menon wrote:
> On 13:03-20190110, Faiz Abbas wrote:
>> The following patches add eMMC support on TI's AM65x-evm.
>>
>> v2:
>>  1. The SD card node is under debug for some usecases.
>>     Only upstreaming eMMC support for now.
>>  2. Rebased to latest mainline.
>>  3. Removed status = "disabled" from dtsi patch
>>  4. Fixed node name to not include '_'s
>>
>> Faiz Abbas (2):
>>   arm64: dts: ti: k3-am654: Add Support for MMC/SD
>>   arm64: dts: ti: k3-am654-base-board: Add MMC/SD support
> 
> Once the $subject changes in the above two patches (should be emmc
> instead of MMC/SD):
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> 

Ok. Sending next version with fixes.

Thanks,
Faiz
