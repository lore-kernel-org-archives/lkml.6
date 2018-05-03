Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeECMQr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:16:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5418 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751075AbeECMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:16:43 -0400
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: add cec pins to stm32mp157c
To: yannick fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Kamel Kholti <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
 <1524556449-5262-3-git-send-email-yannick.fertre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <298dd3aa-037c-5f8b-a276-9c9a8bcb67ac@st.com>
Date: Thu, 3 May 2018 14:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524556449-5262-3-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 04/24/2018 09:54 AM, yannick fertre wrote:
> This patch adds cec support on stm32mp157c eval board.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> index 6f044100..67b0349 100644
> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> @@ -14,6 +14,15 @@
>   			ranges = <0 0x50002000 0xa400>;
>   			pins-are-numbered;
>   
> +			cec_pins_a: cec@0 {
> +				pins {
> +					pinmux = <STM32_PINMUX('A', 15, AF4)>;
> +					bias-disable;
> +					drive-open-drain;
> +					slew-rate = <0>;
> +				};
> +			};
> +
>   			gpioa: gpio@50002000 {
>   				gpio-controller;
>   				#gpio-cells = <2>;
> 
Next time, please put pins group after gpio controller and don't use 
cec@0 but cec-0 to declare pins group. I'll change it this time during 
merge.

Thanks
Alex
