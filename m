Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2531EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39392086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39392086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933834AbeFLVFY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:05:24 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36156 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754325AbeFLVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:05:22 -0400
Received: by mail-yb0-f195.google.com with SMTP id x128-v6so147742ybg.3;
        Tue, 12 Jun 2018 14:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+Q55BzZmxEiD4ZEIKrKxKAPAzV7wkKyDZHjMPL4K2Q=;
        b=HNcP1KtEXst95LKbPEIpjJUEm2nL0KE0jm8r1DhamXVeW0KB5tcSnG5HiMWjDunMCc
         FT6+B4cxwHDdaTkEQnzyve4n/E062wwqIZ5CUN002fWC87GNKxebXMirtjw1eOR2lLsW
         PsEQLcbZzUS3uWxRPbbQx4xmFbbP/d12UX7lRPqlCXsNTpLW+05PPNOp5LBWGwamEaR7
         q3xXBvn5AOOgPpusgnok1+2l6QNB5rGl8n52n8po9xTv+7I55Dkoi5MCBTR9aOabo9GV
         JIFbg9UBKJ/gY8gqzC29/Se2eVowTImnAnmgPQPOuzyYOfV2PeatGfFJlBxLEH6doeK3
         QN+w==
X-Gm-Message-State: APt69E0oVfpLyaeEKzpPXBvDzNTk+OXvs3Do1q3ECLkTwd8Bt45Tqh5Z
        vKpfN0N7c5EYHQz/CCRw6w==
X-Google-Smtp-Source: ADUXVKJ/w0JgtYXq6uAFjSwCTIE9m1yV0s+cJB4NnkGHbEr5N32ZLJPu3gprlyiHWyRMgZeW9sE1+w==
X-Received: by 2002:a25:3622:: with SMTP id d34-v6mr1061093yba.389.1528837521893;
        Tue, 12 Jun 2018 14:05:21 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f185-v6sm422436ywd.94.2018.06.12.14.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:05:21 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:05:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 1/6] Documentation: arm: ti: Add bindings for AM654
 SoC
Message-ID: <20180612210519.GA17653@rob-hp-laptop>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605060125.9518-2-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:01:20AM -0500, Nishanth Menon wrote:
> The AM654 SoC is a lead device of the K3 Multicore SoC architecture
> platform, targeted for broad market and industrial control with aim to
> meet the complex processing needs of modern embedded products.
> 
> Some highlights of this SoC are:
> * Quad ARMv8 A53 cores split over two clusters
> * GICv3 compliant GIC500
> * Configurable L3 Cache and IO-coherent architecture
> * Dual lock-step capable R5F uC for safety-critical applications
> * High data throughput capable distributed DMA architecture under NAVSS
> * Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>   PRUs and dual RTUs
> * Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
> * Centralized System Controller for Security, Power, and Resource
>   management.
> * Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
> * Flash subystem with OSPI and Hyperbus interfaces
> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>   GPIO
> 
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.txt | 33 +++++++++++++++++++++++++
>  MAINTAINERS                                     |  7 ++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
> new file mode 100644
> index 000000000000..cbabb1b89f6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
> @@ -0,0 +1,33 @@
> +Texas Instruments K3 Multicore SoC architecture device tree bindings
> +--------------------------------------------------------------------
> +
> +Boards based on K3 Multicore SoC architecture shall have the following property:
> +- compatible: Every hardware block introduced in K3 Multicore SoC
> +  architecture shall be of the form:
> +  "ti,XXX-YYY", where:
> +     'XXX' represents the specific SoC part for which the support is added.
> +     'YYY' represents the corresponding peripheral in SoC being supported.

No need to explain standard DT convention here. (But I don't think we 
have this convention documented anywhere, so patches welcome. :))

> +
> +  NOTE: Generic devices such as GIC or legacy devices shall use the specified
> +  compatible for those devices.
> +
> +  Example:
> +    compatible = "ti,am654-i2c";
> +
> +SoCs
> +-------------------------------------------
> +
> +Each device tree root node must specify which exact SoC in K3 Multicore SoC
> +architecture it uses, using one of the following compatible values:
> +
> +- AM654
> +  compatible = "ti,am654";
> +
> +Boards
> +-------------------------------------------
> +
> +In addition, each device tree root node must specify which one or more
> +of the following board-specific compatible values:
> +
> +- AM654 EVM
> +  compatible = "ti,am654-evm", "ti,am654";
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f39a8de1bbd7..cfb35b252ac7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2086,6 +2086,13 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/memory/*emif*
>  
> +ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
> +M:	Tero Kristo <t-kristo@ti.com>
> +M:	Nishanth Menon <nm@ti.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Supported
> +F:	Documentation/devicetree/bindings/arm/ti/k3.txt
> +
>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>  M:	Santosh Shilimkar <ssantosh@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.15.1
> 
