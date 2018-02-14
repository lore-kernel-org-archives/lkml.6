Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967486AbeBNLfH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:35:07 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:56589 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967355AbeBNLfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:35:05 -0500
Subject: Re: [PATCH v2 6/7] arm64: tegra: Add Tegra194 chip device tree
To: Marc Zyngier <marc.zyngier@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org, mark.rutland@arm.com
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-7-git-send-email-mperttunen@nvidia.com>
 <458ba9f9-d703-9edf-8e7b-bc9d0f0ef0cc@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <d860ee1a-d69d-2d45-ce36-71f2b726ec3f@kapsi.fi>
Date: Wed, 14 Feb 2018 13:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <458ba9f9-d703-9edf-8e7b-bc9d0f0ef0cc@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.209.167.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2018 12:21, Marc Zyngier wrote:
> Hi Mikko,
>
> On 06/02/18 07:22, Mikko Perttunen wrote:
>> Add the chip-level device tree, including binding headers, for the
>> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
>> are initially available, enough to boot to UART console.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 342 +++++++++++++
>>  include/dt-bindings/clock/tegra194-clock.h     | 664 +++++++++++++++++++++++++
>>  include/dt-bindings/gpio/tegra194-gpio.h       |  59 +++
>>  include/dt-bindings/power/tegra194-powergate.h |  49 ++
>>  include/dt-bindings/reset/tegra194-reset.h     | 166 +++++++
>>  5 files changed, 1280 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> new file mode 100644
>> index 000000000000..dda28d758cab
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>
> [...]
>
>> +		gic: interrupt-controller@3881000 {
>> +			compatible = "arm,gic-400";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			reg = <0x03881000 0x1000>,
>> +			      <0x03882000 0x2000>;
>
> You're missing the GICH and GICV regions here.
>
>> +			interrupts = <GIC_PPI 9
>> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +			interrupt-parent = <&gic>;
>> +		};
> Thanks,
>
> 	M.
>

Thanks, fixed.

Mikko
