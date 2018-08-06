Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC251C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35C219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE35C219EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHFL2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:28:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:53015 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeHFL2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:28:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 02:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="63815888"
Received: from huama-mobl.gar.corp.intel.com (HELO [10.226.38.40]) ([10.226.38.40])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2018 02:20:38 -0700
Subject: Re: [PATCH v2 04/18] MIPS: dts: Add initial support for Intel MIPS
 SoCs
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-5-songjun.wu@linux.intel.com>
 <4f58b5ee-1e3c-7d39-258e-e4525d78db0b@hauke-m.de>
From:   Hua Ma <hua.ma@linux.intel.com>
Message-ID: <7946b18b-8c95-125a-259d-7047d0300105@linux.intel.com>
Date:   Mon, 6 Aug 2018 17:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4f58b5ee-1e3c-7d39-258e-e4525d78db0b@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2018 7:11 PM, Hauke Mehrtens wrote:
> On 08/03/2018 05:02 AM, Songjun Wu wrote:
>> From: Hua Ma <hua.ma@linux.intel.com>
>>
>> Add dts files to support Intel MIPS SoCs:
>> - xrx500.dtsi is the chip dts
>> - easy350_anywan.dts is the board dts
>>
>> Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - New patch split from previous patch
>> - The memory address is changed to @20000000
>> - Update to obj-$(CONFIG_BUILTIN_DTB) as per commit fca3aa166422
>>
>>   arch/mips/boot/dts/Makefile                      |  1 +
>>   arch/mips/boot/dts/intel-mips/Makefile           |  4 ++
>>   arch/mips/boot/dts/intel-mips/easy350_anywan.dts | 26 ++++++++++
>>   arch/mips/boot/dts/intel-mips/xrx500.dtsi        | 66 ++++++++++++++++++++++++
>>   4 files changed, 97 insertions(+)
>>   create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
>>   create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>>   create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi
>>
>> diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> new file mode 100644
>> index 000000000000..e5e95f90c5e7
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/interrupt-controller/mips-gic.h>
>> +#include <dt-bindings/clock/intel,grx500-clk.h>
>> +
>> +#include "xrx500.dtsi"
>> +
>> +/ {
>> +	model = "EASY350 ANYWAN (GRX350) Main model";
> Main model can be removed, it does not identify the board.
Thanks, will remove.

>> +	compatible = "intel,easy350-anywan";
> I think this should be
> 	compatible = "intel,easy350-anywan", "intel,xrx500";
>
> Are there different revisions of the EASY350 Anywan board or only of the
> EASY550 board?There are at least some differences in the power supply on
> the EASY550 V1 and EASY550 V2 board. I would suggest to be here very
> specific to make it easier when adding more boards.
OK, thanks.

>> +
>> +	aliases {
>> +		serial0 = &asc0;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
> What happens when you remove clk_ignore_unused?
> If it crashes we should probably define some of the clock to be always
> active.
OK, will check and improve if possible.

