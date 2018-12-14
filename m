Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F89C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D042080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D042080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeLNIFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:05:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNIFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:05:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01C07974586CE;
        Fri, 14 Dec 2018 16:05:13 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Dec 2018
 16:05:04 +0800
CC:     <liuyu712@hisilicon.com>, Wangbinghui <wangbinghui@hisilicon.com>,
        "Linux USB List" <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "John Stultz" <john.stultz@linaro.org>
Subject: Re: [PATCH 01/10] dt-bindings: usb: add support for dwc3 controller
 on HiSilicon SoCs
To:     Rob Herring <robh@kernel.org>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-2-chenyu56@huawei.com> <20181112160241.GA14074@bogus>
 <9fce6a58-d986-25e4-1791-ba375e4f075e@huawei.com>
 <CAL_JsqKObFGdf5tPdv=Ss2ZWCPBgimbEUn72rkR2+L7uRbAirg@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <8bd2e47a-5766-3236-2c89-a4eaf343991c@huawei.com>
Date:   Fri, 14 Dec 2018 16:05:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKObFGdf5tPdv=Ss2ZWCPBgimbEUn72rkR2+L7uRbAirg@mail.gmail.com>
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

On 2018/12/4 0:01, Rob Herring wrote:
> On Fri, Nov 16, 2018 at 8:29 PM Chen Yu <chenyu56@huawei.com> wrote:
>>
>> Hi,
>>
>> On 2018/11/13 0:02, Rob Herring wrote:
>>> On Sat, Oct 27, 2018 at 05:58:11PM +0800, Yu Chen wrote:
>>>> This patch adds binding descriptions to support the dwc3 controller
>>>> on HiSilicon SoCs and boards like the HiKey960.
>>>>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>>>> ---
>>>>  .../devicetree/bindings/usb/dwc3-hisi.txt          | 53 ++++++++++++++++++++++
>>>>  1 file changed, 53 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>> new file mode 100644
>>>> index 000000000000..e715e7b1c324
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>> @@ -0,0 +1,53 @@
>>>> +HiSilicon DWC3 USB SoC controller
>>>> +
>>>> +This file documents the parameters for the dwc3-hisi driver.
>>>> +
>>>> +Required properties:
>>>> +- compatible:       should be "hisilicon,hi3660-dwc3"
>>>> +- clocks:   A list of phandle + clock-specifier pairs for the
>>>> +            clocks listed in clock-names
>>>> +- clock-names:      Specify clock names
>>>> +- resets:   list of phandle and reset specifier pairs.
>>>> +
>>>> +Sub-nodes:
>>>> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
>>>> +example below. The DT binding details of dwc3 can be found in:
>>>> +Documentation/devicetree/bindings/usb/dwc3.txt
>>>
>>> If you only have clocks and resets and no glue registers, then you
>>> don't need a sub-node. Just make the controller one node.
>>>
>>
>> In dwc3 glue driver，the controller driver usually probed by call of_platform_populate
>> which will search the child node of glue driver.
>> The code of function of_platform_populate is as below:
>>
>>         for_each_child_of_node(root, child) {
>>                  rc = of_platform_bus_create(child, matches, lookup, parent, true);
>>                  if (rc) {
>>                          of_node_put(child);
>>                          break;
>>                  }
>>          }
>>
>> So I think the controller node should be a sub-node.
> 
> It was done that way, but has changed. See commit fe8abf332b8f ("usb:
> dwc3: support clocks and resets for DWC3 core").
> 
I have read the commit and there is a question. If I make the controller one node,
how can the pm suspend of the glue driver be guaranteed to be called after the pm suspend
of dwc3 controller? And also the order of pm resume.
There are some reset registers that should be configured before the initialization
of dwc3 controller on Hi3660 platform.

> Rob
> 
> .
> 

