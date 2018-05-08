Return-Path: <sergei.shtylyov@cogentembedded.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525768290; cv=none;
        d=google.com; s=arc-20160816;
        b=LylUEXW5LdTgAeuCup4MSB2D3O39JfSXWLbDQmvRfLbxBii42ssLsjxAfxco1bTOd+
         QY9nWEf5NLdmT998K/+iqhYAq182LxSZ13a7UHzvYrdFFANHx/PiCJUepjUyLJ7wphIs
         ctO69EXmw5fU0lETpsL6muroK8R73QG0uQMHy5FQPTj37OmL4iI3V+XhzpvcfGtFkkNj
         xLQXE44vl4ScXm1WR/7fgVPyu7r0kUpcukQNZHQ1q8/4OgAhg1Y/QPNgPiVbmHZma62A
         I+pqGjctuMukGpTrVPGnxw7pTfzTQs9vGb1cuCWdaytPu8ZeaXFb+6NbbFMpnr6Ygotl
         XpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=e9bPxWfmv6Ax1SDdsJ2rOKS8HUkZaWbSB93LIuG6/PM=;
        b=tmLh3ZPur5mJloFvBdUuF9X82uoyROsVZ9Y8oeC1c7oFUiHXSbi9xJzMu9sXiz9YWe
         dMRwRngJ4rhafff99TRur9YzFkpJBLAwBbNfqkhnk7GZdeC55i9fJ0GDSuoaeoGu7BSg
         FHMyc237CU8pDQIVHKLfAWVSmoKGxtqmg9D6fStxLMKIUpMK0GhE3ycd11trSUgYipmP
         VJg123xZhggytSm9Dl2fk22/o4Rmhh5C0tFkBTeNbcrBTUF7tVh+lZ+S7g55Z6P2GG7K
         QbXFDkDCWFArK2+NBhNc7RnT6YqQuS9rZNWxK+qE6UbmzunhxEovJcYkNys39jLTmYNO
         oFMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=n3rJvIe1;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=n3rJvIe1;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
X-Google-Smtp-Source: AB8JxZpBGRxWf5aYYBIRP6jloILNwI0wtHOxzHtaMQOqhXrAzWbelXHg56S3FWvab+RomlvW1XghOA==
Subject: Re: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
To: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-sunxi@googlegroups.com
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-5-icenowy@aosc.io>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
Date: Tue, 8 May 2018 11:31:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507151817.55663-5-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599819472154502557?=
X-GMAIL-MSGID: =?utf-8?q?1599884011072242230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 5/7/2018 6:18 PM, Icenowy Zheng wrote:

> Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
> a custom PHY.
> 
> Add device tree nodes for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index c72da8cd9ef5..9564c938717c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -174,6 +174,44 @@
>   			status = "disabled";
>   		};
>   
> +		usb3: usb@5200000 {

    I don't think <unit-address> is allowed for a node having no "reg" prop...

> +			compatible = "allwinner,sun50i-h6-dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&ccu CLK_BUS_XHCI>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_XHCI>;
> +			reset-names = "bus";
> +			status = "disabled";
> +
> +			dwc3: dwc3 {

    Contrariwise, need <unit-address> here...

> +				compatible = "snps,dwc3";
> +				reg = <0x5200000 0x10000>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +				/*
> +				 * According to Wink from Allwinner, the
> +				 * USB3 port on H6 is not capable of OTG;
> +				 * the datasheet doesn't mention OTG at all
> +				 * either, so the dr_mode is default to
> +				 * "host" here.
> +				 */
> +				dr_mode = "host";
> +				phys = <&usb3phy>;
> +				phy-names = "usb3-phy";
> +				status = "disabled";
> +			};
> +		};
[...]

MBR, Sergei
