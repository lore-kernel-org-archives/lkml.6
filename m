Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE72C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01B6243D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01B6243D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeGCWPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:15:50 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41962 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCWPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:15:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so1329672ybe.8;
        Tue, 03 Jul 2018 15:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUwz0IAekWLmI1HA88JDAcWny7bD2xXzDOpUla2CsRo=;
        b=CAwRCPZ5L+qu9aGhK+XaYxhP41Ss+08bfvqrF7WunTYEFZEHz3zwUIenmAzorn6CWA
         zelA3jknAwQfIkriUcKlPgcnqgEPVWV2/iqNFSf/LcNp0bATgpdkiBQzBSk919+gYICe
         jY0GLw3gjhs0GHnbau21bpgWfk9fQs9djz74npn47t+HkJXtJIIWK+CW7ZndkUcxK5e4
         s5kC9xKd0U2fkYVAFexv4DEzKp6HjukvcPmHplocSF6aYb+e/N1EowmTlKyc2UyodOBS
         vRtIVg2AnCs/WBBeFPIbZSs3mL0LZKWsR0ot16hF/xLRZp5LyNu+ZWlqWBz7QXF2sY9r
         /Fqg==
X-Gm-Message-State: APt69E1yOKSJA0DvHFYfYRttj69rQvj/ICAmt19UUJuTHdjuTVI6k44A
        wA3IMK3fTeA/ompkuVzm2g==
X-Google-Smtp-Source: AAOMgpcWef/M7AaXjfmyJRkbUIxsB1wmPVw1c1za2xxfsh47vJKlF3YABtxSsso8oulStTf1QLXKRw==
X-Received: by 2002:a5b:48:: with SMTP id e8-v6mr4093670ybp.257.1530656148354;
        Tue, 03 Jul 2018 15:15:48 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d11-v6sm768204ywd.1.2018.07.03.15.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:15:47 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:15:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] dt-bindings: arm: ti: Add bindings for AM654 SoC
Message-ID: <20180703221546.GA12606@rob-hp-laptop>
References: <20180626162615.19194-1-nm@ti.com>
 <20180626162615.19194-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626162615.19194-2-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:26:11AM -0500, Nishanth Menon wrote:
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
> * Flash subsystem with OSPI and Hyperbus interfaces
> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>   GPIO
> 
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
>  * Picked up Tony's reviewed-by
>  
> V1: https://patchwork.kernel.org/patch/10475327/
> previous RFC: https://patchwork.kernel.org/patch/10447643/
> 
>  Documentation/devicetree/bindings/arm/ti/k3.txt | 23 +++++++++++++++++++++++
>  MAINTAINERS                                     |  7 +++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt

Reviewed-by: Rob Herring <robh@kernel.org>
