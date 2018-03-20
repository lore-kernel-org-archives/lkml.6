Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCTP6a convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:58:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43341 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:58:28 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180320032331.29865-3-thierry.escande@linaro.org>
Date: Tue, 20 Mar 2018 16:58:25 +0100
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

> Add binding document for serial bluetooth chips using Qualcomm protocol.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
> 
> v5:
> - Rename 'bt-disable-n' gpio as 'enable'
> 
> v4:
> - Move bt-disable-n-gpios to required properties section
> - Add clocks and pinctrl-0 as required properties
> 
> v3: no change
> v2: no change
> 
> .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> new file mode 100644
> index 000000000000..bbc2973634b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -0,0 +1,34 @@
> +Qualcomm Bluetooth Chips
> +---------------------
> +
> +This documents the binding structure and common properties for serial
> +attached Qualcomm devices.
> +
> +Serial attached Qualcomm devices shall be a child node of the host UART
> +device the slave device is attached to.
> +
> +Required properties:
> + - compatible: should contain one of the following:
> +   * "qcom,qca6174-bt"
> + - enable-gpios: gpio specifier used to enable chip
> + - pinctrl-0: pin phandle for bt_en gpio
> + - clocks: clock phandle for SUSCLK_32KHZ

if I compare this with broadcom-bluetooth.txt or ti-bluetooth.txt then besides compatible, everything else is optional. The nokia-bluetooth.txt has everything required, but that is also a really specific platform.

Can we be less restrictive for a QCA general purpose chip?

> +
> +Example:
> +
> +serial@7570000 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp1_uart1_default>;
> +	pinctrl-1 = <&blsp1_uart1_sleep>;
> +
> +	bluetooth {
> +		compatible = "qcom,qca6174-bt";
> +
> +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en_pin_a>;

This one I do not understand and you might want to shed some light into why this is done that way.

> +
> +		clocks = <&divclk4>;

No clock-names?

Regards

Marcel
