Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB1EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0080021386
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0080021386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeGCRBx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:01:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:19254 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752997AbeGCRBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:01:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 10:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="52356691"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2018 10:01:50 -0700
Subject: Re: [PATCH linux-next v6 04/13] dt-bindings: Add a document of PECI
 adapter driver for ASPEED AST24xx/25xx SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     Jason M Biils <jason.m.bills@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Milton Miller II <miltonm@us.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194024.20771-1-jae.hyun.yoo@linux.intel.com>
 <20180703165148.GA11628@rob-hp-laptop>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <7f7d1045-ca1f-6086-8fce-ceab53568bcd@linux.intel.com>
Date:   Tue, 3 Jul 2018 10:01:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180703165148.GA11628@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks a lot for the review. Please check my inline answer.

On 7/3/2018 9:51 AM, Rob Herring wrote:
> On Thu, Jun 21, 2018 at 12:40:24PM -0700, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for ASPEED
>> AST24xx/25xx SoCs.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Milton Miller II <miltonm@us.ibm.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
>> ---
>>   .../devicetree/bindings/peci/peci-aspeed.txt  | 57 +++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> new file mode 100644
>> index 000000000000..8c35f905589d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> @@ -0,0 +1,57 @@
>> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
>> +
>> +Required properties:
>> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
>> +		      - aspeed,ast2400-peci: ASPEED AST2400 family PECI
>> +					     controller
>> +		      - aspeed,ast2500-peci: ASPEED AST2500 family PECI
>> +					     controller
> 
> Just this is sufficient:
> 
> Should be one of:
> 	"aspeed,ast2400-peci"
> 	"aspeed,ast2500-peci"
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks! I'll change it as you commented out.

Jae

>> +- reg               : Should contain PECI controller registers location and
>> +		      length.
>> +- #address-cells    : Should be <1> required to define a client address.
>> +- #size-cells       : Should be <0> required to define a client address.
>> +- interrupts        : Should contain PECI controller interrupt.
>> +- clocks            : Should contain clock source for PECI controller. Should
>> +		      reference the external oscillator clock in the second
>> +		      cell.
>> +- resets            : Should contain phandle to reset controller with the reset
>> +		      number in the second cell.
>> +- clock-frequency   : Should contain the operation frequency of PECI controller
>> +		      in units of Hz.
>> +		      187500 ~ 24000000
>> +
>> +Optional properties:
>> +- msg-timing        : Message timing negotiation period. This value will
>> +		      determine the period of message timing negotiation to be
>> +		      issued by PECI controller. The unit of the programmed
>> +		      value is four times of PECI clock period.
>> +		      0 ~ 255 (default: 1)
>> +- addr-timing       : Address timing negotiation period. This value will
>> +		      determine the period of address timing negotiation to be
>> +		      issued by PECI controller. The unit of the programmed
>> +		      value is four times of PECI clock period.
>> +		      0 ~ 255 (default: 1)
>> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
>> +		      time will be divided into 16 time frames. This value will
>> +		      determine the time frame in which the controller will
>> +		      sample PECI signal for data read back. Usually in the
>> +		      middle of a bit time is the best.
>> +		      0 ~ 15 (default: 8)
>> +- cmd-timeout-ms    : Command timeout in units of ms.
>> +		      1 ~ 60000 (default: 1000)
>> +
>> +Example:
>> +	peci0: peci-bus@0 {
>> +		compatible = "aspeed,ast2500-peci";
>> +		reg = <0x0 0x60>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interrupts = <15>;
>> +		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
>> +		resets = <&syscon ASPEED_RESET_PECI>;
>> +		clock-frequency = <24000000>;
>> +		msg-timing = <1>;
>> +		addr-timing = <1>;
>> +		rd-sampling-point = <8>;
>> +		cmd-timeout-ms = <1000>;
>> +	};
>> -- 
>> 2.17.1
>>
