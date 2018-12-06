Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002762146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002762146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeLFHmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:42:07 -0500
Received: from mx.socionext.com ([202.248.49.38]:33393 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbeLFHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:42:07 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Dec 2018 16:42:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9231760062;
        Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 6 Dec 2018 16:42:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5D715403E6;
        Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 40696120304;
        Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
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
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
 <20181204230354.GA26204@bogus>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <230f9c6d-afc1-7e24-eb26-0bc7d1fee333@socionext.com>
Date:   Thu, 6 Dec 2018 16:42:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204230354.GA26204@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/12/05 8:03, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut M10V timer.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> new file mode 100644
>> index 0000000..ddb1b31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> @@ -0,0 +1,17 @@
>> +Milbeaut SoCs Timer Controller
>> +
>> +Required properties:
>> +
>> +- compatible : should be "socionext,milbeaut-m10v-timer"
>> +- reg : Specifies base physical address and size of the registers.
> 
> How many register ranges? Looks like 2.

Yes, has two ranges.
So add the description about it.

> 
>> +- interrupts : The interrupt of the first timer
>> +- clocks: should be "rclk"
>> +
>> +Example:
>> +
>> +timer {
> 
> timer@1e000050

Okay.

Thanks
Sugaya Taichi

> 
>> +	compatible = "socionext,milbeaut-m10v-timer";
>> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
>> +	interrupts = <0 91 4>;
>> +	clocks = <&rclk>;
>> +};
>> -- 
>> 1.9.1
>>

