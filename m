Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE29C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B562085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B562085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJZLHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 07:07:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34345 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 07:07:52 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gFrvW-00024Y-FW from Jiada_Wang@mentor.com ; Thu, 25 Oct 2018 19:32:42 -0700
Received: from [172.30.112.85] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Oct
 2018 19:32:38 -0700
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for
 AVB Counter Clock
To:     Rob Herring <robh@kernel.org>
CC:     <geert+renesas@glider.be>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-3-jiada_wang@mentor.com> <20181025214925.GA5197@bogus>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <d6053012-85b1-3fbf-c35b-c5c5816e9fa8@mentor.com>
Date:   Fri, 26 Oct 2018 11:32:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025214925.GA5197@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob


On 2018/10/26 6:49, Rob Herring wrote:
> On Thu, Oct 25, 2018 at 04:23:47PM +0900, jiada_wang@mentor.com wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> Add device tree bindings for avb counter clock for Renesas
>> R-Car Socs.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   .../bindings/clock/renesas,avb-clk.txt        | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
>> new file mode 100644
>> index 000000000000..03bf50b5830c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
>> @@ -0,0 +1,19 @@
>> +* Renesas AVB Counter Clock
>> +
>> +The AVB Counter Clocks are provided by avb_counter8 Clock Generator,
>> +avb_counter8 has dividers which operates with S0D1ϕ clock and has
>> +8 output clocks.
>> +
>> +Required Properties:
>> +  - compatible: Must be "renesas,clk-avb"
> Should be SoC specific?
yes, avb counter clock is SoC specific, I will move avb clock node to 
Soc .dtsi in next version
>
> If the h/w block is called "AVB Counter" then use "avb-counter" in the
> compatible string.
will update compatible string
>> +  - reg: Base address and length of the memory resource used by the AVB
>> +  - #clock-cells: Must be 1
>> +
>> +Example
>> +-------
>> +
>> +	clk_avb: avb-clock@ec5a011c {
> clock-controller@...
will replace with "clock-controller"

Thanks,
Jiada
>
>> +		compatible = "renesas,clk-avb";
>> +		reg = <0 0xec5a011c 0 0x24>;
>> +		#clock-cells = <1>;
>> +	};
>> -- 
>> 2.17.0
>>

