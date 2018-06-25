Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69690C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A49C25C59
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A49C25C59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964811AbeFYPR0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:17:26 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36980 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934786AbeFYPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:17:22 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so1083803ybo.4;
        Mon, 25 Jun 2018 08:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uY6sspnp3xrd09967ZnjcxoTTaZJHjU2+gLP9vpHum8=;
        b=Sm6XfcIKte4AtArSBRYGWNwBeXmQhJnTCt+NuWraLnMJLCUkTJh6W4hRCrgIBqdR0u
         XHoEKJzBUS+YYFBXr/RCdoXnhWJyiOe2rwBEofiLP+8+DHJxWhXVbGWrq4PYbo1rjJOD
         dV1WxReE4Aqr5/X3B6bInSIBM8mzUMkHaA2Ql4eU7hXNq6o20rHavgovcHCJF7PiPO/S
         C6fzSHqmAlYuNzrNGoy8q//aXQ2GNZNhg6IgW8atycNAA9Y8f7vIrmlLkyaoSyT0/WzW
         o+YU7K4yl70Ri7GzU4Z17qe/aRPglKQzkRvx1LYITxWXBguDHIFYn3Yf8Z/K3joq4kCp
         UjMQ==
X-Gm-Message-State: APt69E0NpgvC6gMX/S8qDT34Pxrl4GiZnXxdGqTgDRVD302hkF9fGLhg
        jiUAMo0qSB2fDXrp6ik7qQ==
X-Google-Smtp-Source: ADUXVKL07Xj1eMP7philYqlxffYHFfqmqANp3z85lp8SsNikim9PBoHdFZxh/56gUD/1VRaXppXr9Q==
X-Received: by 2002:a25:ca0b:: with SMTP id a11-v6mr6664482ybg.439.1529939841486;
        Mon, 25 Jun 2018 08:17:21 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q62-v6sm5755791ywg.2.2018.06.25.08.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:17:20 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:17:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Message-ID: <20180625151719.GA16723@rob-hp-laptop>
References: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
 <1529680549-22079-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529680549-22079-2-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:15:48PM +0300, Abel Vesa wrote:
> This adds the binding for the i.MX8MQ pin controller, in the same
> fashion as earlier i.MX SoCs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
> new file mode 100644
> index 0000000..e1c405d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
> @@ -0,0 +1,32 @@
> +* Freescale IMX8MQ IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
> +for common binding part and usage.
> +
> +Required properties:
> +- compatible: "fsl,imx8mq-iomuxc"

reg?

> +- fsl,pins: each entry consists of 6 integers and represents the mux and config
> +  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
> +  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> +  imx8mq-pinfunc.h under device tree source folder.  The last integer CONFIG is
> +  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Quad
> +  Reference Manual for detailed CONFIG settings.

Needs to specify this is in sub-nodes.

> +
> +Examples:
> +
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +};
> +
> +iomuxc: iomuxc@30330000 {

pinctrl@...

> +        compatible = "fsl,imx8mq-iomuxc";
> +        reg = <0x0 0x30330000 0x0 0x10000>;
> +
> +        pinctrl_uart1: uart1grp {
> +                fsl,pins = <
> +                        MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX             0x49
> +                        MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX             0x49
> +                >;
> +        };
> +};
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
