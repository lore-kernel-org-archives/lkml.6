Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903E520672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeLTBwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:52:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbeLTBwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:52:14 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA5036EA85EA4;
        Thu, 20 Dec 2018 09:52:10 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 09:52:03 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v1 02/12] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
To:     Rob Herring <robh@kernel.org>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-3-chenyu56@huawei.com> <20181219141419.GA17302@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <3b7cef2e-b39a-b410-dfb5-395da6f24efd@huawei.com>
Date:   Thu, 20 Dec 2018 09:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181219141419.GA17302@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/19 22:14, Rob Herring wrote:
> On Mon, Dec 03, 2018 at 11:45:05AM +0800, Yu Chen wrote:
>> This patch adds binding documentation for supporting the hi3660 usb
>> phy on boards like the HiKey960.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> --
>> v1: Fix some format error as suggested by Rob.
>> --
>> ---
>>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>> new file mode 100644
>> index 000000000000..8ea52d51aa13
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>> @@ -0,0 +1,21 @@
>> +Hisilicon hi3660 usb PHY
> 
> s/usb/USB/

OK.
> 
>> +-----------------------
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hi3660-usb-phy"
>> +- #phy-cells: must be 0
>> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
>> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
>> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
>> +- hisilicon,eye-diagram-param: parameter set for phy
>> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> 
> Doesn't a phy need some clocks?
> 
Yes, the clocks of USB phy currently is enabled by config the
pctrl-syscon registers and pericrg-syscon.
>> +
>> +Example:
>> +	usb-phy {
>> +		compatible = "hisilicon,hi3660-usb-phy";
>> +		#phy-cells = <0>;
>> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
>> +		hisilicon,pctrl-syscon = <&pctrl>;
>> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> 
> Is one of these the "main" registers for the phy? If so, then make this 
> a child of that syscon node.
> 
Ok, the usb3-otg-bc-syscon is the "main" registers for the phy.

>> +		hisilicon,eye-diagram-param = <0x22466e4>;
>> +	};
>> -- 
>> 2.15.0-rc2
>>
> 
> .
> 

