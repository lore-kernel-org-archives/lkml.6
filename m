Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3577217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QOqVccZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeLROQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:16:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLROQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:16:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBIEGXB4097641;
        Tue, 18 Dec 2018 08:16:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545142593;
        bh=koW5A0MOKjpLpNAdQ409QHyU+/6NDKapR1otcInDHV4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QOqVccZXVOem8Q+LK4uzSkgZH+U+nnl0NepXOGBIUZeqGQXm0l/gxcjrRnH8LD7Si
         lfuusqLxI/lZxRGZLwXvULAZk1aLShujrokLN8wo9+g2AHTYcv1UgwEMQrGPeWLZdm
         pcL0cy56IX0WcxbiOX5A1HWrjvYvSzKcgI3Vi6n8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBIEGXdL081187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 08:16:33 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 18
 Dec 2018 08:16:32 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 18 Dec 2018 08:16:32 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBIEGT0I031344;
        Tue, 18 Dec 2018 08:16:30 -0600
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com> <20181204060104.GA11391@dragon>
 <20181217003434.GA7208@dragon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c5ccf173-d0f3-70f4-f8e3-777fd3339b68@ti.com>
Date:   Tue, 18 Dec 2018 19:46:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217003434.GA7208@dragon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/18 6:04 AM, Shawn Guo wrote:
> On Tue, Dec 04, 2018 at 02:01:07PM +0800, Shawn Guo wrote:
>> Hi Kishon,
>>
>> On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On 27/11/18 3:37 PM, Shawn Guo wrote:
>>>> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
>>>> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
>>>
>>> Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
>>> (with just changing tuning parameters)? If it could be used by other vendors
>>> then it would make sense to add this PHY driver in synopsys directory.
>>
>> My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
>> @Sriharsha, correct me if I'm wrong.
> 
> Kishon,
> 
> Do you have any further comments on the patches?  We are close the 4.21
> merge window, and I really hope they can hit mainline with 4.21 release.
> Thanks.

Aren't we waiting for feedback from Sriharsha?

-Kishon
