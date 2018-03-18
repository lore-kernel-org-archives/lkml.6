Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521377365; cv=none;
        d=google.com; s=arc-20160816;
        b=ervs00CpP7/uC6pNT1dlaaocpubc1JK06MUm+ZAQF0doK/AG3OXBJiMlc9jpjvX/H6
         rVTFVa/ugumHuNSn1yf6LSaZj7USSaz2tMiYhdHy43h/zVfhVqh018yxYdfQ2W4/NyG2
         r7SMPMZbskrihFj1XHgbW1XnA5+a/1TlXYbogVVBb4ubP1Wcv7hwRuBTZE9yzIkjKeva
         leHvlsE0/zyl17XzaCh1bFdN/KqM4Rl+IxUSNviPNasnphk/EUgqvB5kzBlncq6LZaCh
         5u+hYMBGyQVvfexmGpYU7K53v7Qgmw6FSks9wJ0xxC4XlOpJZA7oJaxGZoqV3gFRbeeI
         wssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Wy3UI3U+IMH1nYrLW5Xf4PViSZcveJ+E6DdTfGFJ0LY=;
        b=saqqCQ4N4834QA6UGjOZrxai7GlDa5UXRpg45BzlOTQoQiB1lEBa4E4keOcskxmL08
         xBir9VpIPV0R9/pvygmucOD+C/f5Ao60eVvvW4VcOkEb3sSBnNVp53Qm0veX3fkLnGYi
         1CfUaHgcWzmvU9+SZV9oO7n6z0SbLtVia3snFnKKP18eoFsqx1rj3gFxlKxXgY1y/3IK
         UCVVovXtalI4/sAY8Rh+dfHNcgNpx3VMgZ60fXmEnRRl6yhUr1CR3kR6su3RvEcylaIJ
         WJb2pzs56Rc3w1pLuvdXGpX6be1NzVhZ6LLg9mZ5tWCvWtKg1zleGH0pNbQpd/PMOref
         XdgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELus+fDDeOL6xWlRURKsiPH4/Bad+5u3Eg0gnliGmcOeT9+pOSAFKCsyTOPzRliCHQ2/CehZfg==
Date: Sun, 18 Mar 2018 07:49:22 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: Update documentation for
 Qualcomm DWC3 driver
Message-ID: <20180318124922.kxa5q2vmhvydfp25@rob-hp-laptop>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594818429134822245?=
X-GMAIL-MSGID: =?utf-8?q?1595279791944092688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 04:06:00PM +0530, Manu Gautam wrote:
> Existing documentation has lot of incorrect information as it
> was originally added for a driver that no longer exists.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.txt          | 87 +++++++++++++++-------
>  1 file changed, 59 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> index bc8a2fa..df312f7 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> @@ -1,54 +1,85 @@
>  Qualcomm SuperSpeed DWC3 USB SoC controller
>  
>  Required properties:
> -- compatible:	should contain "qcom,dwc3"
> -- clocks:		A list of phandle + clock-specifier pairs for the
> -				clocks listed in clock-names
> -- clock-names:	Should contain the following:
> -  "core"		Master/Core clock, have to be >= 125 MHz for SS
> -				operation and >= 60MHz for HS operation
> -
> -Optional clocks:
> -  "iface"		System bus AXI clock.  Not present on all platforms
> -  "sleep"		Sleep clock, used when USB3 core goes into low
> -				power mode (U3).
> +- compatible:		should contain "qcom,dwc3"
> +- reg:			offset and length of register set for QSCRATCH wrapper
> +- reg-names:		should be "qscratch"

reg-names is pointless for a single range.

> +- power-domains:	specifies a phandle to PM domain provider node
> +- clocks:		list of phandle + clock-specifier pairs

How many clocks and what are they?

> +- assigned-clocks:	should be:
> +				MOCK_UTMI_CLK
> +				MASTER_CLK
> +- assigned-clock-rates: should be:
> +                                19.2Mhz (192000000) for MOCK_UTMI_CLK
> +                                >=125Mhz (125000000) for MASTER_CLK in SS mode
> +                                >=60Mhz (60000000) for MASTER_CLK in HS mode
> +
> +Optional properties:
> +- resets:		list of phandle and reset specifier pairs
> +- interrupts:		specifies interrupts from controller wrapper used
> +			to wakeup from low power/susepnd state.	Must contain
> +			one or more entry for interrupt-names property
> +- interrupt-names:	Must include the following entries:
> +			- "hs_phy_irq": The interrupt that is asserted when a
> +			   wakeup event is received on USB2 bus
> +			- "ss_phy_irq": The interrupt that is asserted when a
> +			   wakeup event is received on USB3 bus
> +			- "dm_hs_phy_irq" and "dp_hs_phy_irq": Separate
> +			   interrupts for any wakeup event on DM and DP lines
> +- qcom,select-utmi-as-pipe-clk: if present, disable USB3 pipe_clk requirement.
> +				Used when dwc3 operates without SSPHY and only
> +				HS/FS/LS modes are supported.
>  
>  Required child node:
>  A child node must exist to represent the core DWC3 IP block. The name of
>  the node is not important. The content of the node is defined in dwc3.txt.
>  
>  Phy documentation is provided in the following places:
> -Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
> +Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
> +Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY
