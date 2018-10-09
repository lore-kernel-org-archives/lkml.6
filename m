Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A5B213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sbArQtaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A5B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJINr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:47:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52398 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeJINr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:47:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w996Vt87120976;
        Tue, 9 Oct 2018 01:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539066715;
        bh=Er/MBcaeuFLJasm863Bj1/1RxgbQU99z8TS5Ke1LNTw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sbArQtaREIKRGikM9ZUrpDmL3F/Qk969qH16+HvLSjq26E/iEinmBJLuwxZxNuycb
         bYGVC2In7pBSRgLbofkBlMEezr7rMozLW3truBP3O2aykB9kEt7hzaPq44rn/eszqi
         na/GJLDn15CdgtJ/vyLkDVd8T+3SIbLilSL6einM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w996VtpI022493;
        Tue, 9 Oct 2018 01:31:55 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 01:31:54 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 01:31:54 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w996VplM013595;
        Tue, 9 Oct 2018 01:31:52 -0500
Subject: Re: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy
 bindings
To:     "Andrew F. Davis" <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <catalin.marinas@arm.com>, <adrian.hunter@intel.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
 <20181004111451.9539-2-faiz_abbas@ti.com>
 <ad9945db-de08-36fc-47b8-499ce2079d92@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <92ff5e6a-455f-bd26-4f26-c5ff24ab6134@ti.com>
Date:   Tue, 9 Oct 2018 12:04:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad9945db-de08-36fc-47b8-499ce2079d92@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Friday 05 October 2018 09:28 PM, Andrew F. Davis wrote:
> On 10/04/2018 06:14 AM, Faiz Abbas wrote:
>> Add information to document bindings for the MMC PHY
>> on TI's AM654 devices.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  .../devicetree/bindings/phy/am654-mmc-phy.txt | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
>> new file mode 100644
>> index 000000000000..766921612758
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
> 
> 
> Name ti,am654-mmc-phy.txt might be more consistent name.

Ok.

> 
> 
>> @@ -0,0 +1,42 @@
>> +TI AM654 MMC PHY
>> +-------------------
>> +
>> +Required properties:
>> + - compatible: ti,am654-emmc-phy
>> + - #phy-cells: must be 0
>> + - reg: PHY registers address offset and size
>> + - clocks: must be phandle of the clock provider which is the host
>> +	   controller
>> + - clock-names: must be "mmcclk"
>> + - ti,otap-del-sel: Output Tap Delay select.
>> + - ti,trm-icp: DLL trim select.
>> + - ti,driver-strength-ohm: driver strength in ohms.
>> +			   Valid values are 33, 40, 50, 66, and 100 ohms.
>> +
>> +Example:
>> +			mmc_phy1: mmc_phy@10100 {
>> +				compatible = "ti,am654-mmc-phy";
>> +				reg = <0x10100 0x34>;
>> +				clocks = <&sdhci1>;
>> +				clock-names = "mmcclk";
>> +				#phy-cells = <0>;
>> +				ti,otap-del-sel = <0x2>;
>> +				ti,trm-icp = <0x8>;
>> +				status = "disabled";
> 
> 
> No need for disabled in the example case. 

Ok.

> Also not sure the host
> controller example below needs to be here, there are already examples
> for that binding in mmc/arasan,sdhci.txt.
> 

I had added it because it is a clock source in clocks=<&sdhci1> so it
should have #clock-cells and clock-output-names. I suppose I can just
reference it here.

Thanks,
Faiz
