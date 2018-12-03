Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98653C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C33C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MGdnQmSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C33C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLCIB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42716 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLCIB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3814CM103384;
        Mon, 3 Dec 2018 02:01:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543824064;
        bh=FJxEOqIxrfdFtne8qvaYFf+/d98SHkdkTN9dmmSKMDc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MGdnQmSIrarWx+Y+blfk5j4uuRRJfvKvyc+TJ9zOeL+jnjIk7hHNgIvmFPm9f3YZ3
         m2WoQUTbhzFZi437/lkZus93EkI74B0r91IW2zfY2WnbuPVDf18waazolHszB2tZWG
         IK5OfLdWW2Y+NsxOEBTzdmQk5X7sHz56tRcx69vE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3814Nb053618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 02:01:04 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 02:01:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 02:01:04 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB38105a007973;
        Mon, 3 Dec 2018 02:01:01 -0600
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am654
To:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-3-faiz_abbas@ti.com>
 <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <e431f6f8-3c8d-3540-3d21-d3e9aa292574@ti.com>
Date:   Mon, 3 Dec 2018 13:33:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 30/11/18 12:48 PM, Michal Simek wrote:
> On 29. 11. 18 17:15, Faiz Abbas wrote:
>> The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
>> this by a deprecated message.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index e2effe17f05e..1edbb049cccb 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -16,6 +16,10 @@ Required Properties:
>>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>>      - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>> +	Note: This binding has been deprecated and moved to [5].
>> +
>> +  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>> +
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>
> 
> I would prefer if you can extend commit message by description you have
> in cover letter which explains reasons. When this is applied and someone
> look at git history none will understand from first read why you have
> done that.
> 

Ok. Will add full explanations to both documentation patches.

Thanks,
Faiz
