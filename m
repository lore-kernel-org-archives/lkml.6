Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeEBQLX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:11:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeEBQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:11:20 -0400
Subject: Re: [PATCH v2 4/5] dt-bindings: devfreq: rk3399_dmc: remove
 interrupts as is not required.
To: Rob Herring <robh@kernel.org>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180424083742.14042-1-enric.balletbo@collabora.com>
 <20180424083742.14042-5-enric.balletbo@collabora.com>
 <20180427200029.elq3drn46nkwbvf2@rob-hp-laptop>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <66622ef7-6b8a-c524-1f6e-e71ccbc72011@collabora.com>
Date: Wed, 2 May 2018 18:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427200029.elq3drn46nkwbvf2@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On 27/04/18 22:00, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 10:37:41AM +0200, Enric Balletbo i Serra wrote:
>> In ATF we already wait for DDR dvfs finish, so don't need to do this in
>> kernel, so remove the interrupts properties as is not longer required.
> 
> If the hardware has an interrupt, then the DT should have one. The 
> partitioning with ATF shouldn't matter.
> 
> Now, if you want to make ATF remove the interrupt, then maybe that is 
> okay. But it's not clear to me why you'd expose some of the h/w and not 
> all.
> 

Ok, sounds good if I move interrupts to be optional then?

Best regards,
 Enric

>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>
>> Changes in v2:
>> - [4/6] Add Reviewed-by Chanwoo Choi.
>>
>>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> index 834637c7bae7..e7f0ef9548b7 100644
>> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>> @@ -5,10 +5,6 @@ Required properties:
>>  - devfreq-events:	 Node to get DDR loading, Refer to
>>  			 Documentation/devicetree/bindings/devfreq/event/
>>  			 rockchip-dfi.txt
>> -- interrupts:		 The CPU interrupt number. The interrupt specifier
>> -			 format depends on the interrupt controller.
>> -			 It should be a DCF interrupt. When DDR DVFS finishes
>> -			 a DCF interrupt is triggered.
>>  - clocks:		 Phandles for clock specified in "clock-names" property
>>  - clock-names :		 The name of clock used by the DFI, must be
>>  			 "pclk_ddr_mon";
>> @@ -172,7 +168,6 @@ Example:
>>  	dmc: dmc {
>>  		compatible = "rockchip,rk3399-dmc";
>>  		devfreq-events = <&dfi>;
>> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>>  		clocks = <&cru SCLK_DDRCLK>;
>>  		clock-names = "dmc_clk";
>>  		operating-points-v2 = <&dmc_opp_table>;
>> -- 
>> 2.17.0
>>
