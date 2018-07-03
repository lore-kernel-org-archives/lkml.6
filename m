Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D35C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B942469A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B942469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934234AbeGCRWH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:22:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:5549 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933568AbeGCRWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:22:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 10:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="213138491"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2018 10:21:58 -0700
Subject: Re: [PATCH linux-next v6 07/13] dt-bindings: mfd: Add a document for
 PECI client MFD
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194054.20897-1-jae.hyun.yoo@linux.intel.com>
 <20180703165835.GA18160@rob-hp-laptop>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <88cab816-3bc1-5e0b-7282-4ca05f458a9a@linux.intel.com>
Date:   Tue, 3 Jul 2018 10:21:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180703165835.GA18160@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review. Please see my inline answer.

On 7/3/2018 9:58 AM, Rob Herring wrote:
> On Thu, Jun 21, 2018 at 12:40:54PM -0700, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document for PECI client MFD.
> 
> This and the next patch still have the same issues I've outlined in at
> least 2 prior versions.
>   

Okay. I think the next patch (9/13) for hwmon dt-bindings document
is not needed anymore because those were already added in MFD driver
implementation in the patch 8/13. Please correct me if it's not
you pointed.

>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: James Feist <james.feist@linux.intel.com>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
>> ---
>>   .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/intel-peci-client.txt b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
>> new file mode 100644
>> index 000000000000..cb341e363add
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
>> @@ -0,0 +1,34 @@
>> +* Intel PECI client bindings
>> +
>> +PECI (Platform Environment Control Interface) is a one-wire bus interface that
>> +provides a communication channel from PECI clients in Intel processors and
>> +chipset components to external monitoring or control devices. PECI is designed
>> +to support the following sideband functions:
>> +
>> +- Processor and DRAM thermal management
>> +- Platform Manageability
>> +- Processor Interface Tuning and Diagnostics
>> +- Failure Analysis
>> +
>> +Required properties:
>> +- compatible : Should be "intel,peci-client".
>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients starts from 0x30 based on PECI specification.
>> +
>> +Example:
>> +	peci-bus@0 {
>> +		compatible = "vendor,soc-peci";
>> +		reg = <0x0 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		peci-client@30 {
>> +			compatible = "intel,peci-client";
>> +			reg = <0x30>;
>> +		};
>> +
>> +		peci-client@31 {
>> +			compatible = "intel,peci-client";
>> +			reg = <0x31>;
>> +		};
>> +	};
>> -- 
>> 2.17.1
>>
> 
