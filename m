Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeDRHM3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:12:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbeDRHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:12:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB29360246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [v5,08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
To: Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
References: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
 <1724020.V9x0kZZp2B@bentobox>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4e687302-6c42-315b-e76d-2274131da3a0@codeaurora.org>
Date: Wed, 18 Apr 2018 12:42:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1724020.V9x0kZZp2B@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On 4/18/2018 12:29 PM, Sven Eckelmann wrote:
> On Freitag, 23. März 2018 15:48:51 CEST Sricharan R wrote:
>> Add the common data for all dk07 based boards.
>>
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 69 +++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
> 
> The no-map reserved-memory for tz and smem are missing. Linux doesn't have 
> control over these regions and they are placed in the middle of the ram before 
> Linux even starts. And u-boot is also not adding these ranges automatically.
> 
>     	reserved-memory {
>     		#address-cells = <0x1>;
>     		#size-cells = <0x1>;
>     		ranges;
>     
>     		smem@87e00000 {
>     			reg = <0x87e00000 0x080000>;
>     			no-map;
>     		};
>     
>     		tz@87e80000 {
>     			reg = <0x87e80000 0x180000>;
>     			no-map;
>     		};
>     	};
> 
> This can either (depending on HW/SW configuration) lead to a failed boot [1] 
> or to runtime crashes like:
> 
>     root@OpenWrt:/# /tmp/memory-allocator-test
>     main 0
>     [  571.758058] Unhandled fault: imprecise external abort (0xc06) at 0x01715ff8
>     [  571.758099] pgd = cebec000
>     [  571.763826] [01715ff8] *pgd=8e7fa835, *pte=87e7f75f, *ppte=87e7fc7f
>     Bus error
> 
> I would not know how to disable QSEE on these boards and thus would assume 
> that it should be part of this dtsi.

 As we discussed offline, i agree that the smem and tz reserved memory nodes need to
 be added. It still boots today without that, but would abort when that memory
 region is allocated and written. I will add the reserved-memory node for that
 in V6 along with other comments.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
