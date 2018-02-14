Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754660AbeBNIjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:39:25 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:55629 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753260AbeBNIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:39:23 -0500
Subject: Re: [PATCH v2 2/4] arm64: dts: renesas: r8a77995: add VSP instances
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
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
References: <1518550237-16753-1-git-send-email-kbingham@kernel.org>
 <1518550237-16753-3-git-send-email-kbingham@kernel.org>
 <1667048.nVWrpUAVXQ@avalon>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <10851181-b3b1-bb07-82e9-487ae51711ba@ideasonboard.com>
Date: Wed, 14 Feb 2018 08:39:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1667048.nVWrpUAVXQ@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for the review,

On 13/02/18 22:03, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Tuesday, 13 February 2018 21:30:35 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> The r8a77995 has a VSPBS to support image processing such as blending of
>> two input images, and has two VSPDs to handle display pipelines with a
>> DU.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> ---
>> v2:
>>  - Fix VSPD register map size
>>  - Squash VSPBS and VSPD patches together
>>
>>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
>> 196a917afea6..19bd8be9926a 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> @@ -692,6 +692,16 @@
>>  			status = "disabled";
>>  		};
>>
>> +		vspbs: vsp@fe960000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfe960000 0 0x4000>;
> 
> The VSPBS also has OSD-CLUT support in its RPFs, so you need to extend the 
> registers range too.
> 

Wait, but I already changed this ...

</me checks tree>

Yup - this change is already in my tree ... which means I must have made the
change *after* calling git format-patch. Not helpful.

Orz




> Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll collect the tag and repost, this time with the correctly updated version.

(And I'll add in that missing vspd3 from the es1 tree too)


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
> 
