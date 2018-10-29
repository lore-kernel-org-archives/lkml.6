Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAEB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAEB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeJ2VNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:13:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728772AbeJ2VNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:13:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A64C5E47DD94;
        Mon, 29 Oct 2018 20:25:18 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 29 Oct 2018
 20:25:11 +0800
CC:     <wangbinghui@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 03/10] dt-bindings: misc: Add bindings for HiSilicon usb
 hub and data role switch functionality on HiKey960
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-4-chenyu56@huawei.com>
 <4872a689-bfdd-a8c1-f2cf-a2bba9e91fa9@cogentembedded.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <644437e0-fa67-e3c5-ed57-48ae9f10b046@huawei.com>
Date:   Mon, 29 Oct 2018 20:25:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <4872a689-bfdd-a8c1-f2cf-a2bba9e91fa9@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/28 2:06, Sergei Shtylyov wrote:
> On 27.10.2018 12:58, Yu Chen wrote:
>
>> This patch adds binding documentation to support usb hub and usb
>> data role switch of Hisilicon HiKey&HiKey960 Board.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>>  .../bindings/misc/hisilicon-hikey-usb.txt          | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> new file mode 100644
>> index 000000000000..f94e990362c9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> @@ -0,0 +1,24 @@
>> +Support usb hub and usb data role switch of Hisilicon HiKey&HiKey960 Board.
>> +
>> +-----------------------------
>> +
>> +Required properties:
>> +- compatible: "hisilicon,gpio_hubv1","hisilicon,hikey960_usb"
>> +- typc_vbus_int_gpio,typec-gpios: gpio to control the vbus of typeC port
>> +- typc_vbus_enable_val: gpio value that enable the vbus of typeC port
>
>    The part of the prop name preceding the comma is supposed to be vendor prefix.
> Also hyphens are preferred to underscores.

I will fix the name of properties. Thanks!


>
>> +- otg_gpio: gpio to switch DP&DM between the hub and typeC port
>> +- hub_vdd33_en_gpio: gpio to enable the power of hub
>> +- pinctrl-0: pinctrl config
> [...]
>
> MBR, Sergei
>
>
>
> .
>


