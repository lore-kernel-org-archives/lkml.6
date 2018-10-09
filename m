Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D40C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3026A21476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="coYfX45l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3026A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJIHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIHkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:40:23 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99612145D;
        Tue,  9 Oct 2018 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539044765;
        bh=Nx5YmDHUGGAn96ijPkk1bFUNFhEHgpyFsRfTynkp48k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coYfX45lKF/OdUQ6j63mLXQ2rMEw61Tag48sSNUn3f8cgH7yo/jFTPGW1WHV8EAwZ
         nCwEp62VvyKtDSDKK+C2UOAHswi2DwWi51ZlIC/MBMhfmviZB81rdTVpAWetezgM6L
         5cA7BS376vZx+l/IcWWqDFknDAsK/xmIgQz6ZvQo=
Date:   Tue, 9 Oct 2018 08:25:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, frieder.schrempf@exceet.de,
        computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Message-ID: <20181009002537.GV3587@dragon>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1538997103-11152-3-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538997103-11152-3-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:41:40PM +0530, Yogesh Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - Removed node property 'big-endian'.
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..402e2b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,39 @@
> +* NXP Flex Serial Peripheral Interface (FSPI)
> +
> +Required properties:
> +  - compatible : Should be "nxp,lx2160a-fspi"
> +  - reg :        First contains the register location and length,
> +                 Second contains the memory mapping address and length
> +  - reg-names :  Should contain the resource reg names:
> +	         - fspi_base: configuration register address space
> +                 - fspi_mmap: memory mapped address space
> +  - interrupts : Should contain the interrupt for the device
> +
> +Required SPI slave node properties:
> +  - reg :        There are two buses (A and B) with two chip selects each.
> +                 This encodes to which bus and CS the flash is connected:
> +                 - <0>: Bus A, CS 0
> +                 - <1>: Bus A, CS 1
> +                 - <2>: Bus B, CS 0
> +                 - <3>: Bus B, CS 1
> +
> +Example showing the usage of two SPI NOR slave devices on bus A:
> +
> +spi0: flexspi@20c0000 {

It seems that Rob's comment on node name in v3 review gets overlooked?

Shawn

> +	compatible = "nxp,lx2160a-fspi";
> +	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
> +	reg-names = "fspi_base", "fspi_mmap";
> +	interrupts = <0 25 0x4>; /* Level high type */
> +	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +	clock-names = "fspi_en", "fspi";
> +
> +	mt35xu512aba0: flash@0 {
> +		reg = <0>;
> +		....
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		reg = <1>;
> +		....
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
