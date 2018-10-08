Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94982085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr2I514y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94982085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJHV4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHV4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:56:19 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EA2204EC;
        Mon,  8 Oct 2018 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539009855;
        bh=TugipAl2saPxY93/aeLyf7sHBqG8igNhIjaXpLUsDS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr2I514y8PJVOhtT4Ex7TgUn8bkeOxPA+grIiNHDKyZE4PEFGRt5VL5h9iFat5IMx
         V8FhbN3s3YjzEQ09WxkyRJ0VbQGSZY0Frb/aP2GaHLkR7ljFe9K2NqtKfC7+MdQGwp
         N3VcrfmdmBD7VJcw3Lh7MPoXIFHfc5fz6LAeVfqk=
Date:   Mon, 8 Oct 2018 22:43:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181008144350.GS3587@dragon>
References: <20180927222655.24482-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927222655.24482-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:26:55AM +0200, Lukasz Majewski wrote:
> Add Device Tree binding document for Liebherr's BK4 external SPI bus.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

There should really be a patch series consisting of this one and spidev
change [1].

Since spidev has already been picked up, having a series including this
and dts change would be the second option.  With DT folks' ACK, I can
send bindings change together with DTS using it.

Shawn

[1] https://lkml.org/lkml/2018/9/28/48

> ---
>  Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> new file mode 100644
> index 000000000000..d6a8c188c087
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> @@ -0,0 +1,26 @@
> +* Liebherr's BK4 controller external SPI
> +
> +A device which handles data acquisition from compatible industrial
> +peripherals.
> +The SPI is used for data and management purposes in both master and
> +slave modes.
> +
> +Required properties:
> +
> +- compatible : Should be "lwn,bk4"
> +
> +Required SPI properties:
> +
> +- reg : Should be address of the device chip select within
> +  the controller.
> +
> +- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should be
> +  30MHz at most for the Liebherr's BK4 external bus.
> +
> +Example:
> +
> +spidev0: spi@0 {
> +	compatible = "lwn,bk4";
> +	spi-max-frequency = <30000000>;
> +	reg = <0>;
> +};
> -- 
> 2.11.0
> 
