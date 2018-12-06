Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E6214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E6214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeLFI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:29:50 -0500
Received: from mx.socionext.com ([202.248.49.38]:34072 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFI3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:29:49 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Dec 2018 17:29:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 008B860062;
        Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 6 Dec 2018 17:29:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 518C240304;
        Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2475A120304;
        Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <20181204231131.GA7366@bogus>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c71e44af-3a17-884c-78b4-686be8b293b1@socionext.com>
Date:   Thu, 6 Dec 2018 17:29:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204231131.GA7366@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/12/05 8:11, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 10:02:12AM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut M10V pinctrl.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>> new file mode 100644
>> index 0000000..7469189
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>> @@ -0,0 +1,33 @@
>> +Milbeaut SoCs pin controller
>> +
>> +Required properties:
>> +- compatible: should be one of the following:
>> +    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
>> +- reg: offset and length of the register set.
>> +- reg-names: should be "pinctrl", "exiu".
>> +- gpio-cells; should be 2.
> 
> #gpio-cells
> 
> gpio-controller?

Ah yes. I forgot to add it.
Add it.

> 
>> +- interrupt-cells: should be 2.
> 
> #interrupt-cells
> 
> interrupt-controller?

Add it also.

Thanks,
Sugaya Taichi

> 
>> +- clocks: phandle to the input clock.
>> +- interrupts: three interrupts specifer.
>> +- interrupt-names: corresponds "interrupts" factor.
>> +
>> +Example:
>> +	pinctrl: pinctrl@1d022000 {
>> +		compatible = "socionext,milbeaut-m10v-pinctrl";
>> +		reg = <0x1d022000 0x1000>,
>> +			<0x1c26f000 0x1000>;
>> +		reg-names = "pinctrl", "exiu";
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		clocks = <&dummy_clk>;
>> +		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
>> +				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
>> +				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
>> +				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
>> +		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
>> +				"pin-52", "pin-53", "pin-54", "pin-55",
>> +				"pin-56", "pin-57", "pin-58", "pin-59",
>> +				"pin-60", "pin-61", "pin-62", "pin-63";
>> +	}
>> -- 
>> 1.9.1
>>

