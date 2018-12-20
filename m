Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF35C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03022133F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeLTCDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:03:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbeLTCDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:03:09 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FC4B149AC853;
        Thu, 20 Dec 2018 10:03:05 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 10:02:59 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v1 03/12] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
To:     Rob Herring <robh@kernel.org>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-4-chenyu56@huawei.com> <20181219142118.GA24144@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <f0f570a9-74cb-2554-58e6-1271e69344ff@huawei.com>
Date:   Thu, 20 Dec 2018 10:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181219142118.GA24144@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/19 22:21, Rob Herring wrote:
> On Mon, Dec 03, 2018 at 11:45:06AM +0800, Yu Chen wrote:
>> This patch adds binding documentation to support usb hub and usb
>> data role switch of Hisilicon HiKey&HiKey960 Board.
>>
>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> --
>> v1:
>> 1) Fix some format errors as suggested by Sergei.
>> 2) Modify gpio description to use gpiod API.
>> --
>> ---
>>  .../bindings/misc/hisilicon-hikey-usb.txt          | 36 ++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> new file mode 100644
>> index 000000000000..f3413d851e18
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> @@ -0,0 +1,36 @@
>> +Support usb hub and usb data role switch of Hisilicon HiKey&HiKey960 Board.
> 
> s/&/ & /
> 
OK.
> Some trivial comments below, but this all needs to use the USB connector 
> binding for the OTG and host ports and then we need to figure out how 
> the switching fits into that.
> 
>> +
>> +-----------------------------
>> +
>> +Required properties:
>> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
>> +- typc-vbus-int-gpio: gpio to control the vbus of typeC port
>> +- typc-vbus-enable-val: gpio value that enable the vbus of typeC port
> 
> HiKey at least doesn't have a TypeC port.
>Yes. I will re-check the driver for Hikey.
>> +- otg-gpio: gpio to switch DP&DM between the hub and typeC port
>> +- hub-vdd33-en-gpio: gpio to enable the power of hub
> 
> -gpios for all these.

OK.
> 
>> +- pinctrl-0: pinctrl config
>> +
>> +Example
>> +-----
>> +
>> +	hisi_hikey_usb: hisi_hikey_usb {
>> +		compatible = "hisilicon,hikey960-usb";
>> +		typec-vbus-gpios = <&gpio25 2 0>;
>> +		typc-vbus-enable-val = <1>;
>> +		otg-switch-gpios = <&gpio25 6 0>;
>> +		hub-vdd33-en-gpios = <&gpio5 6 0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usbhub5734_pmx_func>;
>> +
>> +		port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			hikey_usb_ep: endpoint@0 {
>> +				reg = <0>;
>> +				device_type = "usb-role-switch";
> 
> Drop device_type.

Currently the device_type is used for usb-role-switch match, but it
will be removed after Heikki Krogerus's patch.
> 
>> +				remote-endpoint = <&dwc3_role_switch_notify>;
>> +			};
>> +		};
>> +
>> +	};
>> -- 
>> 2.15.0-rc2
>>
> 
> .
> 
Thanks!

