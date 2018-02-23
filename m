Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBWIbe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:31:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25137 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750796AbeBWIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:31:32 -0500
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] dt-bindings/display/panel: Add support for Raydium
 rm68200 dsi panel
Thread-Topic: [PATCH v1 1/2] dt-bindings/display/panel: Add support for
 Raydium rm68200 dsi panel
Thread-Index: AQHToOlnBB/5OIBO+UyeJE1O6m7ABKOxrr2A
Date: Fri, 23 Feb 2018 08:31:13 +0000
Message-ID: <7198eeff-d157-5f01-d44c-5aea033a4cde@st.com>
References: <20180208143026.23009-1-philippe.cornu@st.com>
 <20180208143026.23009-2-philippe.cornu@st.com>
In-Reply-To: <20180208143026.23009-2-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EBCDE2A6EC144CA3CE330FACB45D16@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N8VcVV011001

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 02/08/2018 03:30 PM, Philippe Cornu wrote:
> The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
> TFT LCD panel connected using a MIPI-DSI video interface.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   .../bindings/display/panel/raydium,rm68200.txt     | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
> new file mode 100644
> index 000000000000..cbb79ef3bfc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
> @@ -0,0 +1,25 @@
> +Raydium Semiconductor Corporation RM68200 5.5" 720p MIPI-DSI TFT LCD panel
> +
> +The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280 TFT LCD
> +panel connected using a MIPI-DSI video interface.
> +
> +Required properties:
> +  - compatible: "raydium,rm68200"
> +  - reg: the virtual channel number of a DSI peripheral
> +
> +Optional properties:
> +  - reset-gpios: a GPIO spec for the reset pin (active low).
> +  - power-supply: phandle of the regulator that provides the supply voltage.
> +  - backlight: phandle of the backlight device attached to the panel.
> +
> +Example:
> +&dsi {
> +	...
> +	panel@0 {
> +		compatible = "raydium,rm68200";
> +		reg = <0>;
> +		reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
> +		power-supply = <&v1v8>;
> +		backlight = <&pwm_backlight>;
> +	};
> +};
