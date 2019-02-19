Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEBF21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfBSILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:11:32 -0500
Received: from mx.socionext.com ([202.248.49.38]:34024 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfBSILc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:11:32 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Feb 2019 17:11:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 7C2ED6117D;
        Tue, 19 Feb 2019 17:11:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 19 Feb 2019 17:11:30 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 12ECB1A04E1;
        Tue, 19 Feb 2019 17:11:30 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EDEA0121B6C;
        Tue, 19 Feb 2019 17:11:29 +0900 (JST)
Subject: Re: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
To:     Rob Herring <robh@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
 <20190218195713.GA18625@bogus>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <04726ec4-4ee5-3aa8-8b46-2e1293f773f5@socionext.com>
Date:   Tue, 19 Feb 2019 17:11:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218195713.GA18625@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/19 4:57, Rob Herring wrote:
> On Fri, Feb 08, 2019 at 09:27:29PM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut serial driver.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> new file mode 100644
>> index 0000000..8f61c38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> @@ -0,0 +1,21 @@
>> +Socionext Milbeaut UART controller
>> +
>> +Required properties:
>> +- compatible: should be "socionext,milbeaut-usio-uart".
>> +- reg: offset and length of the register set for the device.
>> +- interrupts: two interrupts specifier.
>> +- clocks: phandle to the input clock.
>> +- interrupt-names: should be "rx", "tx".
> 
> Put this next to 'interrupts'
> 

OK, change the order.

>> +
>> +Optional properties:
>> +- uart-flow-enable: flow control enable.
> 
> We already have a standard property for this: auto-flow-control
> 

Okay, I change the property name to "auto-flow-control"

>> +
>> +Example:
>> +	usio1: usio_uart@1e700010 {
> 
> serial@...
> 

I got it.

Thanks,
Sugaya Taichi

>> +		compatible = "socionext,milbeaut-usio-uart";
>> +		reg = <0x1e700010 0x10>;
>> +		interrupts = <0 141 0x4>, <0 149 0x4>;
>> +		interrupt-names = "rx", "tx";
>> +		clocks = <&clk 2>;
>> +		uart-flow-enable;
>> +	};
>> -- 
>> 1.9.1
>>

