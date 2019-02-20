Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C39C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2312089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfBTCea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729797AbfBTCe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:34:28 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D4702ABC975144C685A;
        Wed, 20 Feb 2019 10:34:25 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 10:34:18 +0800
CC:     <liuyu712@hisilicon.com>, <john.stultz@linaro.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <20190218112310.17860-3-chenyu56@huawei.com>
 <22270fce-602e-d9fd-0416-58bfecc40b07@cogentembedded.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <8c217714-381c-f449-4f9e-d398c260a916@huawei.com>
Date:   Wed, 20 Feb 2019 10:34:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <22270fce-602e-d9fd-0416-58bfecc40b07@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/2/19 16:25, Sergei Shtylyov wrote:
> Hello!
> 
> On 18.02.2019 14:23, Yu Chen wrote:
> 
>> This patch adds binding documentation to support usb hub and usb
>> data role switch of Hisilicon HiKey960 Board.
>>
>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>> v1:
>> * Fix some format errors as suggested by Sergei.
>> * Modify gpio description to use gpiod API.
>> v2:
>> * Remove information about Hikey.
>> * Fix gpio description.
>> * Remove device_type of endpoint.
>> ---
>> ---
>>   .../bindings/misc/hisilicon-hikey-usb.txt          | 35 ++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> new file mode 100644
>> index 000000000000..c2b789b515df
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> @@ -0,0 +1,35 @@
>> +Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
>> +
>> +-----------------------------
>> +
>> +Required properties:
>> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
> 
>    Only one of those, looking at your example?
"hisilicon,gpio-hubv1" is similar as "hisilicon,hikey960-usb".

>    Need a space after comma, BTW.
OK. Thanks!

> 
>> +- typec-vbus-gpios: gpio to control the vbus of typeC port
>> +- typec-vbus-enable-val: gpio value that enable the vbus of typeC port
> 
>    Hm, I thought that can be inferred from the GPIO specifier above...
> 
OK. Thanks!

>> +- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
>> +- hub-vdd33-en-gpios: gpio to enable the power of hub
>> +- pinctrl-0: pinctrl config
> 
>    You forgot about "pinctrl-names"...
OK. Thanks!

> 
>> +
>> +Example
>> +-----
>> +
>> +    hisi_hikey_usb: hisi_hikey_usb {
>> +        compatible = "hisilicon,hikey960-usb";
>> +        typec-vbus-gpios = <&gpio25 2 0>;
>> +        typec-vbus-enable-val = <1>;
>> +        otg-switch-gpios = <&gpio25 6 0>;
>> +        hub-vdd33-en-gpios = <&gpio5 6 0>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&usbhub5734_pmx_func>;
>> +
>> +        port {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            hikey_usb_ep: endpoint@0 {
>> +                reg = <0>;
>> +                remote-endpoint = <&dwc3_role_switch_notify>;
>> +            };
>> +        };
>> +
>> +    };
> 
> MBR, Sergei
> 
> .
> 

Thanks
Yu Chen

