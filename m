Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519837;
	bh=jk7dStaLnevS4ItVkjXgz3VlBb3HBNES4G+9BqUVKdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHNgqaDc03/Rm5I7A6ykBomOC1djWSlXpVEvnNKv/672F4w9tnx+G522nEV9LavuM
	 h9AXEbdvNvg4mgSVv1yrKNCfX+D78MU0kA9xfcgyfKDvf2drcOvvds5DpZ90wjunB2
	 5H1u6WO8zJiQVV7OTtG1Ayf94Gmvi7EyFDeLXDKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBRT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:57:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39475 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfBRT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:57:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so30298534otl.6;
        Mon, 18 Feb 2019 11:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuL8M/buYU86p5J9UP9rJFLjnhT7S5iFxpf0dcOOp04=;
        b=KIQMKIOO4S/2nzwYHwSgslnGdDXAB0bFBYOPIH2i8aGrw8HFfgOdNgFiS54ug09zfD
         0uZiodqIqcslVYQyGTH5QnYrTYhQt0OkL+jT0+NRli86O8Pxzk5YqWxsCbNUJzkaZuAg
         Jefqa8ls2FjDqEOjxCJLIL96LKZIbQTf1/Gu1iIUkB71IiyFf3Q4Ea9BF7Js/uYFkLRN
         gLakiIqfUWMyi+rath+CFNJyN00hBhjcWeQEOkYdeB/1EzCHb/h+halsaQfQmQtmLh8a
         rM7rKYSHk9cBOna7mqQ8cPI2NIRZLAnXGDqeUDciy1A+YiMQBTKgmokuysQaN7sdpcr8
         npjg==
X-Gm-Message-State: AHQUAuaBzwL5B+w+Jir7tKiWoCbP1fEdpTud0Whgx1gti/rpRf/kmJWP
        TxzH4RksLQNijLKYk5l/ig==
X-Google-Smtp-Source: AHgI3Iac3+nO3BWxXRLG68RaLv+2bzPmd2cppsflZs6ky7GttF4E0zcVaOBbIKnVfXfigURaAPNgng==
X-Received: by 2002:aca:ed06:: with SMTP id l6mr321892oih.7.1550519834438;
        Mon, 18 Feb 2019 11:57:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129sm6421789oif.17.2019.02.18.11.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:57:13 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:57:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190218195713.GA18625@bogus>
References: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:27:29PM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> new file mode 100644
> index 0000000..8f61c38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> @@ -0,0 +1,21 @@
> +Socionext Milbeaut UART controller
> +
> +Required properties:
> +- compatible: should be "socionext,milbeaut-usio-uart".
> +- reg: offset and length of the register set for the device.
> +- interrupts: two interrupts specifier.
> +- clocks: phandle to the input clock.
> +- interrupt-names: should be "rx", "tx".

Put this next to 'interrupts'

> +
> +Optional properties:
> +- uart-flow-enable: flow control enable.

We already have a standard property for this: auto-flow-control

> +
> +Example:
> +	usio1: usio_uart@1e700010 {

serial@...

> +		compatible = "socionext,milbeaut-usio-uart";
> +		reg = <0x1e700010 0x10>;
> +		interrupts = <0 141 0x4>, <0 149 0x4>;
> +		interrupt-names = "rx", "tx";
> +		clocks = <&clk 2>;
> +		uart-flow-enable;
> +	};
> -- 
> 1.9.1
> 
