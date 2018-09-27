Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CC9215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CC9215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeI1B3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:29:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45936 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI1B3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:29:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id d63-v6so3127826oic.12;
        Thu, 27 Sep 2018 12:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EP9YX8YqdIKs3x1p0MV3ThwGjj1SLpGJJ/Ri2WQm6Y=;
        b=AQAkOTiLeGMgIQ0AglL4g+PKyZdqZudcMiBeMV891nzywejSWIn/jud0XhgYSQLUHw
         RNuAL+BJ6I+sk8P/Ms9QEuXV2ZmMnAfoMilGjwmyuj6bEQe2SbOeGw1RBGSJAUA+fuOf
         hNQqwj4pwU+sZEeQd7G4SUZEm2usxvEwOhq229Gb4TcGELbDLcJelijkJh56i+BEYiR/
         EgiEbx2pnsXEwMsgmf+UdkLvRDld07E5Qso5xq4LclCq+qvAcDWuvqlrl63YDjyV3ppA
         oOKqpwWtSW1VnzTC8VZ3JiY5FnatFiV9YE1GSWJCn2laWD91m5Jy/qN7jqB7wTrRTLo/
         K2nA==
X-Gm-Message-State: ABuFfogFeH5SSnTVYORFXDAUr5Axu3SEY2N2pvwFWgb66svs0D8fgyp1
        4xrkC83d4sJN6lqHx9DR0w==
X-Google-Smtp-Source: ACcGV608yzbN0B0RZYjuYDqum8+bSt1AnqCiMaapToZHha3/28mtKdyIJLgReMJOmNFhf3lE9U6v2w==
X-Received: by 2002:aca:3546:: with SMTP id c67-v6mr4080887oia.249.1538075402570;
        Thu, 27 Sep 2018 12:10:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5-v6sm1001357otc.54.2018.09.27.12.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:10:01 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:10:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Message-ID: <20180927191000.GA18549@bogus>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537525323-20730-3-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537525323-20730-3-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:52:00PM +0530, Yogesh Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v3:
> - None
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..94b5203
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,42 @@
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
> +Optional properties:
> +  - big-endian : See common-properties.txt.
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
> +fspi@0: flexspi@20c0000 {

Use standard node names.

spi@...

> +	compatible = "nxp,lx2160a-fspi";
> +	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
> +	reg-names = "fspi_base", "fspi_mmap";
> +	interrupts = <0 25 0x4>; /* Level high type */
> +	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +	clock-names = "fspi_en", "fspi";
> +
> +	flash@0: mt35xu512aba@0 {

You've got the label and node name reversed. Drop the '@' in the label. 
That should be reserved for node names.

> +		reg = <0>;
> +		....
> +	};
> +
> +	flash@1: mt35xu512aba@1 {
> +		reg = <1>;
> +		....
> +	};
> +};
> -- 
> 2.7.4
> 
