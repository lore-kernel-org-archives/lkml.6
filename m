Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426314AbeBOQmF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:42:05 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:52065 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423914AbeBOQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:42:04 -0500
Subject: Re: [PATCH v3 2/5] arm64: dts: renesas: r8a77995: add VSP instances
To: Simon Horman <horms@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1518602108-1724-1-git-send-email-kbingham@kernel.org>
 <1518602108-1724-3-git-send-email-kbingham@kernel.org>
 <20180215163342.4evihm3uts3lfu5c@verge.net.au>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <7db13491-f4f6-4c7c-e9e3-c1e91b0054b6@ideasonboard.com>
Date: Thu, 15 Feb 2018 16:41:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180215163342.4evihm3uts3lfu5c@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 15/02/18 16:33, Simon Horman wrote:
> On Wed, Feb 14, 2018 at 09:55:05AM +0000, Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> The r8a77995 has a VSPBS to support image processing such as blending of
>> two input images, and has two VSPDs to handle display pipelines with a
>> DU.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> ---
>> v2:
>>  - Fix VSPD register map size
>>  - Squash VSPBS and VSPD patches together
>>
>> v3:
>>  - Fix VSPBS register map size too :-)
>>
>>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> index 196a917afea6..0db242114bc5 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> @@ -692,6 +692,16 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		vspbs: vsp@fe960000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfe960000 0 0x8000>;
>> +			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 627>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 627>;
>> +			renesas,fcp = <&fcpvb0>;
>> +		};
>> +
>>  		fcpvb0: fcp@fe96f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfe96f000 0 0x200>;
>> @@ -701,6 +711,16 @@
>>  			iommus = <&ipmmu_vp0 5>;
>>  		};
>>  
>> +		vspd0: vsp@fea20000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea20000 0 0x8000>;
>> +			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 623>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 623>;
>> +			renesas,fcp = <&fcpvd0>;
>> +		};
>> +
>>  		fcpvd0: fcp@fea27000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea27000 0 0x200>;
>> @@ -710,6 +730,16 @@
>>  			iommus = <&ipmmu_vi0 8>;
>>  		};
>>  
>> +		vspd1: vsp@fea80000 {
> 
> The above should be:
> 
> 		vspd1: vsp@fea28000 {

Good spot.

</me looks to datasheet> That is correct.

Would you like me to resubmit this patch ? Or will you fix this up locally?

--
Regards

Kieran


> 
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea28000 0 0x8000>;
>> +			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 622>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 622>;
>> +			renesas,fcp = <&fcpvd1>;
>> +		};
>> +
>>  		fcpvd1: fcp@fea2f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea2f000 0 0x200>;
>> -- 
>> 2.7.4
>>
