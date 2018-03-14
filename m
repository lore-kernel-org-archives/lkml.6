Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCNQNv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:13:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59538 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:13:50 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180314155514.3374-3-thierry.escande@linaro.org>
Date: Wed, 14 Mar 2018 17:13:47 +0100
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
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
> index 000000000000..cdb14b96c229
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
> + - bt-disable-n-gpios: gpio specifier, used to enable chip during probe
> + - pinctrl-0: pin phandle for bt_en gpio
> + - clocks: clock phandle for SUSCLK_32KHZ
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
> +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;

can we use a common name here. I think that Nokia and Broadcom drivers define one. And if this is the enable/shutdown GPIO, we should name it consistently across all manufacturers. It essentially does the same on Bluetooth UART chips no matter what chip is behind them.

Regards

Marcel
