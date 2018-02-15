Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033225AbeBOOZF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:25:05 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:49042 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033071AbeBOOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:25:03 -0500
Subject: Re: [PATCH 5/8] arm64: dts: renesas: r8a77995: Add LVDS support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-6-git-send-email-kbingham@kernel.org>
 <1558036.KTdDODi8F6@avalon>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <095ac482-8117-4b39-f770-3941053b3dc0@ideasonboard.com>
Date: Thu, 15 Feb 2018 14:24:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1558036.KTdDODi8F6@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 14:10, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 15 February 2018 10:38:20 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> The r8a77995 D3 platform has 2 LVDS channels connected to the DU.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 52 ++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
>> a57d5fecf79c..7851e37cfff1 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> @@ -773,18 +773,70 @@
>>  				port@1 {
>>  					reg = <1>;
>>  					du_out_lvds0: endpoint {
>> +						remote-endpoint = <&du_out_lvds0>;
>>  					};
>>  				};
>>
>>  				port@2 {
>>  					reg = <2>;
>>  					du_out_lvds1: endpoint {
>> +						remote-endpoint = <&du_out_lvds1>;
> 
> It's interesting how the DU ports reference themselves :-)

Ah, yes - that's ...  that's a feature...

--
Kieran



>>  					};
>>  				};
>>  			};
>>  		};
>>  	};
>>
>> +	lvds0: lvds@feb90000 {
>> +		compatible = "renesas,lvds-r8a77995";
>> +		reg = <0 0xfeb90000 0 0x20>;
>> +		clocks = <&cpg CPG_MOD 727>;
>> +		status = "disabled";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +				lvds0_in: endpoint {
>> +					remote-endpoint = <&du_out_lvds0>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +				lvds0_out: endpoint {
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	lvds1: lvds@feb90100 {
>> +		compatible = "renesas,lvds-r8a77995";
>> +		reg = <0 0xfeb90100 0 0x20>;
>> +		clocks = <&cpg CPG_MOD 727>;
>> +		status = "disabled";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +				lvds1_in: endpoint {
>> +					remote-endpoint = <&du_out_lvds1>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +				lvds1_out: endpoint {
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>  	timer {
>>  		compatible = "arm,armv8-timer";
>>  		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
>> IRQ_TYPE_LEVEL_LOW)>,
> 
