Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE12C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFEB216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFEB216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHHF0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:26:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:17443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeHHF0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:26:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 20:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79457375"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.39]) ([10.226.38.39])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 20:08:49 -0700
Subject: Re: [PATCH v2 03/18] dt-bindings: clk: Add documentation of grx500
 clock controller
To:     Rob Herring <robh+dt@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-4-songjun.wu@linux.intel.com>
 <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
Date:   Wed, 8 Aug 2018 11:08:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2018 11:18 PM, Rob Herring wrote:
> On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This patch adds binding documentation for grx500 clock controller.
>>
>> Signed-off-by: YiXin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - Rewrite clock driver's dt-binding document according to Rob Herring's
>>    comments.
>> - Simplify device tree docoment, remove some clock description.
>>
>>   .../devicetree/bindings/clock/intel,grx500-clk.txt | 39 ++++++++++++++++++++++
> Please match the compatible string: intel,grx500-cgu.txt
Will update to use same name.

>
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> new file mode 100644
>> index 000000000000..e54e1dad9196
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>> @@ -0,0 +1,39 @@
>> +Device Tree Clock bindings for grx500 PLL controller.
>> +
>> +This binding uses the common clock binding:
>> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +The grx500 clock controller supplies clock to various controllers within the
>> +SoC.
>> +
>> +Required properties for clock node
>> +- compatible: Should be "intel,grx500-cgu".
>> +- reg: physical base address of the controller and length of memory range.
>> +- #clock-cells: should be 1.
>> +
>> +Optional Propteries:
>> +- intel,osc-frequency: frequency of the osc clock.
>> +if missing, driver will use clock rate defined in the driver.
> This should use a fixed-clock node instead.
Yes, This is a fixed clock node registered in driver code.
The frequency of the fixed clock is designed to be overwritten by device 
tree in case some one verify
clock driver in the emulation platform or in some cases frequency other 
than driver defined one is preferred.
These kinds of cases are very rare. But I feel it would be better to 
have a way to use customized frequency.
The frequency defined in device tree will overwritten driver defined 
frequency before registering fixed-clock node.

>> +
>> +Example: Clock controller node:
>> +
>> +       cgu: cgu@16200000 {
>> +                compatible = "intel,grx500-cgu", "syscon";
>> +               reg = <0x16200000 0x200>;
>> +               #clock-cells = <1>;
>> +       };
>> +
>> +
>> +Example: UART controller node that consumes the clock generated by clock
>> +       controller.
>> +
>> +       asc0: serial@16600000 {
>> +               compatible = "lantiq,asc";
>> +               reg = <0x16600000 0x100000>;
>> +               interrupt-parent = <&gic>;
>> +               interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
>> +                       <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
>> +                       <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
>> +               clock-names = "freq", "asc";
>> +       };
>> --
>> 2.11.0
>>

