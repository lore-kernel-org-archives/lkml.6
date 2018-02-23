Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBWNrL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:47:11 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28496 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751317AbeBWNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:47:08 -0500
Subject: Re: [PATCH] dt-bindings: iio: adc: sd-modulator: fix io-channel-cells
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
References: <1519384041-23782-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <c221e43d-c7fb-c33b-6fd1-bbf8aca6fa49@st.com>
Date: Fri, 23 Feb 2018 14:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519384041-23782-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Regards,
Arnaud

On 02/23/2018 12:07 PM, Fabrice Gasnier wrote:
> io-channel-cells should be <0> since sigma delta modulator exports only
> one channel, as described in ../iio/iio-bindings.txt "IIO providers"
> section. Only the phandle is necessary for IIO consumers in this case.
> 
> Fixes: af11143757b7 ("IIO: Add DT bindings for sigma delta adc modulator")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> index e9ebb8a..ba24ca7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -3,11 +3,11 @@ Device-Tree bindings for sigma delta modulator
>  Required properties:
>  - compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
>  	as a generic SD modulator if modulator not specified in compatible list.
> -- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
>  
>  Example node:
>  
>  	ads1202: adc@0 {
>  		compatible = "sd-modulator";
> -		#io-channel-cells = <1>;
> +		#io-channel-cells = <0>;
>  	};
> 
