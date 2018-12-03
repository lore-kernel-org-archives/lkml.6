Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OqrtZN3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED4E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLCRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:23:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50850 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543857826; x=1575393826;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4EqweSzMdWtekz2FYxHTJ7tD2RlVzKJ2fl3ssPAyUoc=;
  b=OqrtZN3xd4qTxwZnnUeE0L8CyfeUDSSaL2hkMDSHFXflMbrH1vogBujN
   2uYte5IjlOw1XWOjpjM4nT0xpkHTtdpfZXbDhwaYSSSUNiCjE2Ibn5+Lf
   fe86mWaVCC1zIY8FcAL2r6jx7DuxElAGbKj42LYNVn/48xVeo4srCCHUN
   pqoGG3NV021a28IS0nbbc8RytZEQv5uEJGOlSzUgzX/DkfVcTkfiGoFuL
   rWdKhZIfn6WHzAF3DwZgvHsgRDmvIPTEA5Ysu8YDrU/rpbRdQIpID/iGz
   CPik/BZpEeBi+pruZBinIRbF+0RKaEtondu3tLDkG/q7EctT5vdp0MK3t
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="97413904"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 01:23:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 03 Dec 2018 09:06:35 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 09:23:43 -0800
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181203165521.GB17883@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
Date:   Mon, 3 Dec 2018 09:23:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203165521.GB17883@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 8:55 AM, Sudeep Holla wrote:
> On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
>> cpu-map binding can be used to described cpu topology for both
>> RISC-V & ARM. It makes more sense to move the binding to document
>> to a common place.
>>
>> The relevant discussion can be found here.
>> https://lkml.org/lkml/2018/11/6/19
>>
> 
> Looks good to me apart from a minor query below in the example.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>>   1 file changed, 67 insertions(+), 14 deletions(-)
>>   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> similarity index 86%
>> rename from Documentation/devicetree/bindings/arm/topology.txt
>> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> index 66848355..1de6fbce 100644
>> --- a/Documentation/devicetree/bindings/arm/topology.txt
>> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> 
> [...]
> 
>> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
>> +
>> +cpus {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	compatible = "sifive,fu540g", "sifive,fu500";
>> +	model = "sifive,hifive-unleashed-a00";
>> +
>> +	...
>> +
>> +	cpu-map {
>> +		cluster0 {
>> +			core0 {
>> +				cpu = <&L12>;
>> +		 	};
>> +			core1 {
>> +				cpu = <&L15>;
>> +			};
>> +			core2 {
>> +				cpu0 = <&L18>;
>> +			};
>> +			core3 {
>> +				cpu0 = <&L21>;
>> +			};
>> +		};
>> + 	};
>> +
>> +	L12: cpu@1 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x1>;
>> +	}
>> +
>> +	L15: cpu@2 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x2>;
>> +	}
>> +	L18: cpu@3 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x3>;
>> +	}
>> +	L21: cpu@4 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x4>;
>> +	}
>> +};
> 
> The labels for the CPUs drew my attention. Is it intentionally random
> (or even specific) or just chosen to show anything can be used as labels ?

SiFive generates the device tree from RTL directly. So I am not sure if 
they assign random numbers or a particular algorithm chooses the label. 
I tried to put the exact ones that is available publicly.

https://github.com/riscv/riscv-device-tree-doc/blob/master/examples/sifive-hifive_unleashed-microsemi.dts 


Regards,
Atish
> The reason I ask is people tend to copy from existing DT or examples
> like here and so want to make sure if it can be kept as generic as
> possible in the example. Just my opinion and I am fine if you want to
> keep it as is, thought of checking the intentions here.
> 



> --
> Regards,
> Sudeep
> 

