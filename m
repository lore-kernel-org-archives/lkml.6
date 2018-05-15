Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEOUH7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:07:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:35154 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752002AbeEOUH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:07:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="51107842"
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2] arm64: dts: stratix10: Add QSPI support for Stratix10
To: Dinh Nguyen <dinguyen@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526055052-11371-1-git-send-email-thor.thayer@linux.intel.com>
 <20b33e1d-0609-78dd-dc9c-922658a11f18@kernel.org>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <a61cbfaf-86e9-ec89-5d05-4d6f210aeec8@linux.intel.com>
Date: Tue, 15 May 2018 15:10:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20b33e1d-0609-78dd-dc9c-922658a11f18@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 10:11 AM, Dinh Nguyen wrote:
> 
> On 05/11/2018 11:10 AM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add qspi_clock
>>     The qspi_clk frequency is updated by U-Boot before starting Linux.
>> Add QSPI interface node.
>> Add QSPI flash memory child node.
>>     Setup the QSPI memory in 2 partitions.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2  s/_/-/ in qspi-clk
>>      rename flash node.
>>      use partition child node notation<snip>>> +		qspi: spi@ff8d2000 {
>> +			compatible = "cdns,qspi-nor";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0xff8d2000 0x100>,
>> +			      <0xff900000 0x100000>;
>> +			interrupts = <0 3 4>;
>> +			cdns,fifo-depth = <128>;
>> +			cdns,fifo-width = <4>;
>> +			cdns,trigger-address = <0x00000000>;
>> +			clocks = <&qspi_clk>;
>> +			bus-num = <1>;
> 
> I don't you need "bus-num" anymore right? I don't see it getting used
> anywhere in the driver.
> 
> Dinh
> 

Yes, I missed that holdover. Thanks, I'll correct that.
