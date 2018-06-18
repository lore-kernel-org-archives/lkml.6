Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B9208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4B9208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeFRH6m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:58:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11914 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932612AbeFRH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:58:38 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5I7sDaA011198;
        Mon, 18 Jun 2018 09:57:36 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jn0cj93h6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 09:57:36 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B80F538;
        Mon, 18 Jun 2018 07:57:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 585BC5751;
        Mon, 18 Jun 2018 07:57:31 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 09:57:29 +0200
Subject: Re: [PATCH v3 24/27] devicetree: fix a series of wrong file
 references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <93406d06-69c3-01b9-71d3-06f3db8d0370@st.com>
Date:   Mon, 18 Jun 2018 09:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/14/2018 06:09 PM, Mauro Carvalho Chehab wrote:
> As files got renamed, their references broke.
> 
> Manually fix a series of broken refs at the DT bindings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

For stm32 part:

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks
Alex


>   .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>   Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-
>   .../devicetree/bindings/pci/hisilicon-pcie.txt       |  2 +-
>   Documentation/devicetree/bindings/pci/kirin-pcie.txt |  2 +-
>   .../devicetree/bindings/pci/pci-keystone.txt         |  4 ++--
>   .../devicetree/bindings/sound/st,stm32-i2s.txt       |  2 +-
>   .../devicetree/bindings/sound/st,stm32-sai.txt       |  2 +-
>   MAINTAINERS                                          | 12 ++++++------
>   8 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> index f2c30c8b725d..9afffbdf6e28 100644
> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> @@ -12,7 +12,7 @@ Additional documentation for F11 can be found at:
>   http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
>   
>   Optional Touch Properties:
> -Description in Documentation/devicetree/bindings/input/touch
> +Description in Documentation/devicetree/bindings/input/touchscreen
>   - touchscreen-inverted-x
>   - touchscreen-inverted-y
>   - touchscreen-swapped-x-y
> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> index 4d21ffdb0fc1..daa091c2e67b 100644
> --- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
> @@ -8,7 +8,7 @@ Required properties:
>    - reg: The PRCM registers range
>   
>   The prcm node may contain several subdevices definitions:
> - - see Documentation/devicetree/clk/sunxi.txt for clock devices
> + - see Documentation/devicetree/bindings/clock/sunxi.txt for clock devices
>    - see Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt for reset
>      controller devices
>   
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index 7bf9df047a1e..0dcb87d6554f 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -3,7 +3,7 @@ HiSilicon Hip05 and Hip06 PCIe host bridge DT description
>   HiSilicon PCIe host controller is based on the Synopsys DesignWare PCI core.
>   It shares common functions with the PCIe DesignWare core driver and inherits
>   common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pci.txt.
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
>   
>   Additional properties are described here:
>   
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> index 6e217c63123d..6bbe43818ad5 100644
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> @@ -3,7 +3,7 @@ HiSilicon Kirin SoCs PCIe host DT description
>   Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
>   It shares common functions with the PCIe DesignWare core driver and
>   inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pci.txt.
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
>   
>   Additional properties are described here:
>   
> diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
> index 7e05487544ed..3d4a209b0fd0 100644
> --- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
> @@ -3,9 +3,9 @@ TI Keystone PCIe interface
>   Keystone PCI host Controller is based on the Synopsys DesignWare PCI
>   hardware version 3.65.  It shares common functions with the PCIe DesignWare
>   core driver and inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pci.txt
> +Documentation/devicetree/bindings/pci/designware-pcie.txt
>   
> -Please refer to Documentation/devicetree/bindings/pci/designware-pci.txt
> +Please refer to Documentation/devicetree/bindings/pci/designware-pcie.txt
>   for the details of DesignWare DT bindings.  Additional properties are
>   described here as well as properties that are not applicable.
>   
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
> index 4bda52042402..58c341300552 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
> @@ -18,7 +18,7 @@ Required properties:
>       See Documentation/devicetree/bindings/dma/stm32-dma.txt.
>     - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
>     - pinctrl-names: should contain only value "default"
> -  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>   
>   Optional properties:
>     - resets: Reference to a reset controller asserting the reset controller
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> index f301cdf0b7e6..3a3fc506e43a 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> @@ -37,7 +37,7 @@ SAI subnodes required properties:
>   	"tx": if sai sub-block is configured as playback DAI
>   	"rx": if sai sub-block is configured as capture DAI
>     - pinctrl-names: should contain only value "default"
> -  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>   
>   SAI subnodes Optional properties:
>     - st,sync: specify synchronization mode.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67641f5bb373..69c9e9924902 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6965,7 +6965,7 @@ IIO MULTIPLEXER
>   M:	Peter Rosin <peda@axentia.se>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> +F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
>   F:	drivers/iio/multiplexer/iio-mux.c
>   
>   IIO SUBSYSTEM AND DRIVERS
> @@ -9695,7 +9695,7 @@ MXSFB DRM DRIVER
>   M:	Marek Vasut <marex@denx.de>
>   S:	Supported
>   F:	drivers/gpu/drm/mxsfb/
> -F:	Documentation/devicetree/bindings/display/mxsfb-drm.txt
> +F:	Documentation/devicetree/bindings/display/mxsfb.txt
>   
>   MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
>   M:	Chris Lee <christopher.lee@cspi.com>
> @@ -10884,7 +10884,7 @@ M:	Will Deacon <will.deacon@arm.com>
>   L:	linux-pci@vger.kernel.org
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/controller-generic-pci.txt
> +F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
>   F:	drivers/pci/controller/pci-host-common.c
>   F:	drivers/pci/controller/pci-host-generic.c
>   
> @@ -11065,7 +11065,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
>   M:	Binghui Wang <wangbinghui@hisilicon.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
> +F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
>   F:	drivers/pci/controller/dwc/pcie-kirin.c
>   
>   PCIE DRIVER FOR HISILICON STB
> @@ -12456,7 +12456,7 @@ L:	linux-crypto@vger.kernel.org
>   L:	linux-samsung-soc@vger.kernel.org
>   S:	Maintained
>   F:	drivers/crypto/exynos-rng.c
> -F:	Documentation/devicetree/bindings/crypto/samsung,exynos-rng4.txt
> +F:	Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
>   
>   SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
>   M:	Łukasz Stelmach <l.stelmach@samsung.com>
> @@ -13570,7 +13570,7 @@ F:	drivers/*/stm32-*timer*
>   F:	drivers/pwm/pwm-stm32*
>   F:	include/linux/*/stm32-*tim*
>   F:	Documentation/ABI/testing/*timer-stm32
> -F:	Documentation/devicetree/bindings/*/stm32-*timer
> +F:	Documentation/devicetree/bindings/*/stm32-*timer*
>   F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
>   
>   STMMAC ETHERNET DRIVER
> 
