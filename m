Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F242D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfBSBvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:51:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732932AbfBSBvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:51:01 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03BE68D2004CDAD464E7;
        Tue, 19 Feb 2019 09:50:59 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 09:50:51 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>, Mark Rutland <mark.rutland@arm.com>,
        "Binghui Wang" <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
To:     Rob Herring <robh@kernel.org>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-2-chenyu56@huawei.com> <20190218201824.GA23724@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <a944cd27-f7d5-eece-1ef5-c7dc5dbc311b@huawei.com>
Date:   Tue, 19 Feb 2019 09:50:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190218201824.GA23724@bogus>
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

On 2019/2/19 4:18, Rob Herring wrote:
> On Mon, Feb 18, 2019 at 07:23:01PM +0800, Yu Chen wrote:
>> This patch adds binding documentation for supporting the hi3660 usb
>> phy on boards like the HiKey960.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>> v1:
>> * Fix some format error as suggested by Rob.
>> v2:
>> * Change hi3660 usb PHY to hi3660 USB PHY
>> ---
>> ---
>>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>> new file mode 100644
>> index 000000000000..f9a3d56cfdd2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
>> @@ -0,0 +1,21 @@
>> +Hisilicon hi3660 USB PHY
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
>> +
>> +Example:
>> +	usb-phy {
>> +		compatible = "hisilicon,hi3660-usb-phy";
>> +		#phy-cells = <0>;
>> +		hisilicon,pericrg-syscon = <&crg_ctrl>;
>> +		hisilicon,pctrl-syscon = <&pctrl>;
>> +		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> 
> Are most of the registers within one of these blocks? If so, make this 
> node a child of that node.
I met a problem when I made this node a child of the syscon node,
the driver "phy-hi3660-usb3" was not probed.
Do you have any idea about how to make it probed when it is a child node?
> 
>> +		hisilicon,eye-diagram-param = <0x22466e4>;
>> +	};
>> -- 
>> 2.15.0-rc2
>>
> 
> .
> 

Thanks
Yu Chen

