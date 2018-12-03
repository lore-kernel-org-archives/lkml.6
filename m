Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A99021473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0RlEEqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A99021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLCCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:04:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37238 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:04:38 -0500
Received: by mail-io1-f68.google.com with SMTP id f14so3625688iol.4;
        Sun, 02 Dec 2018 18:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHyJf/pk3obpSZxlLWLxrLpAd0vNW4Y4iR522ZKJUfo=;
        b=A0RlEEqKQYARSp+BkNkZ4DogDx8OtRE5e/GeShRlult+5dFIB2KVT0E6DyMriNuOM2
         7AOQOaUKXaoclWaSRI9NIFVVA9MXFb3YnoLPAe+QSjs9LBghb+RMm/1/9bJsvG5d/Aat
         BMulRw8NH0cyltWU1AMnfQcIv6BazUsuer2vqoDAyQj1e+hYhSx6NPLqlHGTYNjr5LjS
         3BlHjfU62GPnCF2jgsjDnZ0NsmlOrG/skBi5RXfOzEwqG/Iw4c+gXQt5UJl3fOsvbRm/
         upSqUJff1AODn1CYl1iWS9UnV6qfp2GlEktJibYoPIY+Owm49jhpsqFUMqUOBMEMQrtv
         viCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHyJf/pk3obpSZxlLWLxrLpAd0vNW4Y4iR522ZKJUfo=;
        b=qtPY3rkbD7txNV0LxMwNDoUPoQGDCG8BzXJXQwh8GHJ7saznA1Ws4/u351eq8CD0qZ
         1yFKTMMZfGxBTAjHBovcfClxVeGqBSySuW5ibkut337jTxdx9MYxpOejqzsyoG7/CHab
         txFSyPRrZVRkkzYzh4ByTBwUj7l5/RVDyNoctLekH2rETFUP/JcdgICJyCMpvFlmtAoN
         n3iccX2SuvgiLVnFNqF0GxgRo1CpHzVuD2zXUOimlNd8qBcBMWzBCAhGbWSaP4CpSDWD
         49Lg0wHFGI966B7VswDVWTtA140qk4UkkeR05F0ACMIdTralQpTfdomdHpr2mNbXG76Y
         BfSA==
X-Gm-Message-State: AA+aEWaMyl4J7YZPYeS9J1JcWy48u0hUjEcIio+2328iWtyRXN9ZOPU8
        BZa273sch7w65vIm5JvO1ZM=
X-Google-Smtp-Source: AFSGD/VlRJBwEaD2RnAiePJy7+kF8MV2H1wlgHCJbZy6yTwcqyNRckaqkHaiLxLHB8bAMO0Ct9CnyQ==
X-Received: by 2002:a5d:8597:: with SMTP id f23mr12939255ioj.238.1543802675035;
        Sun, 02 Dec 2018 18:04:35 -0800 (PST)
Received: from ethiopia (c-73-176-50-185.hsd1.il.comcast.net. [73.176.50.185])
        by smtp.gmail.com with ESMTPSA id u5sm3111839itb.33.2018.12.02.18.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 18:04:34 -0800 (PST)
Date:   Sun, 2 Dec 2018 20:04:32 -0600
From:   "Derald D. Woods" <woods.technical@gmail.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org,
        s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/17] Add support for TI PRU ICSS
Message-ID: <20181203020431.GC18592@ethiopia>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:38:56PM +0200, Roger Quadros wrote:
> Hi,
> 
> The Programmable Real-Time Unit and Industrial Communication Subsystem
> (PRU-ICSS) is present on various TI SoCs such as AM335x, AM437x, AM57x,
> Keystone 66AK2G, etc. A PRUSS consists of dual 32-bit RISC cores (Programmable
> Real-Time Units, or PRUs), data and instruction RAMs, shard RAM, and
> interrupt controller and some internal peripheral modules to facilitate
> industrial communication. The programmable nature of the PRUs provide
> flexibility to implement custom peripheral interfaces, fast real-time
> responses, or specialized data handling. The common peripheral modules
> include the following,
>   - an MII_RT module with two MII ports for Ethernet
>   - an MDIO port for external Ethernet PHYs
>   - an Industrial Ethernet Peripheral (IEP) to manage/generate Industrial
>     Ethernet functions
>   - an Enhanced Capture Module (eCAP)
>   - an Industrial Ethernet Timer with 7/9 capture and 16 compare events
>   - a 16550-compatible UART to support PROFIBUS
> 
> A typical usage scenario would be to load the application firmware into
> one or more of the PRU cores, initialize one or more of the peripherals
> and perform I/O through shared RAM (or MSMC RAM) from either a Kernel driver
> or directly from userspace.
> 
> With this two-part series we should be able to use the kernel RPMSG driver
> along with firmware and user-space examples in the
> pru-software-support-package [1].
> 
> We will also be able to get Dual Ethernet functionality using a kernel driver
> which will be posted later.
> 
> The kernel code will be split into the following sections
> 
> 1) soc: pruss_soc_bus: The sole purpose of this driver is to handle platform
> specific Power management quirks and allow the child node (i.e entire PRUSS)
> to be unbound from the default kernel driver and bound to something else. e.g. uio_pruss,
> while allowing to manage PM in the kernel.
> 
> 2) soc: pruss: This is the driver for the entire ICSS. Its main purpose is
> to populate the different modules and handle platform specific quirks.
> It will also manage the interrupt controller and provide kernel APIs to
> change ICSS specific knobs in the CFG space e.g. GP_MUX.
> 
> 3) remoteproc: pru: This provides a remoteproc interface for the PRU cores.
> With this we can load firmware, start/stop PRU from kernel or userspace.
> It adds support for virtio RPMSG. It also provides some kernel APIs
> (e.g. pru_rproc_set_ctable()) that are PRU specific and required for
> in-kernel applications (e.g. ethernet)
> 
> 4) ARM: OMAP: DTS:
> Platform data and device tree files.
> 
> Due to the large number of patches patches are  split this into 2 email threads.
> This thread covers (1), (3) and (4).
> 
> A second thread will cover the remoteproc driver (3).
> 
> The series only adds platform support for AM335x to keep patch count small.
> Support for other platforms (AM43x, AM57x, K2G) will be added later.
> 
> Testing:
> To test the code with example firmware you can try the LAB5 tutorial
> http://processors.wiki.ti.com/index.php/PRU_Training:_Hands-on_Labs#LAB_5:_RPMsg_Communication_between_ARM_and_PRU
> with the pru-software-support package at [2] and the sample rpmsg-client driver.
> NOTE: you no longer need to build and run PRU_Halt example as shown in the tutorial.
> 
> cheers,
> -roger
> 
> [1] https://git.ti.com/pru-software-support-package
> 	NOTE: The repo needs update to the INTC resource data structures
> 	The updates that are required are listed in the below repo with one example fixed.
> [2] https://github.com/rogerq/pru-software-support-package/commits/upstream/pruss
> 


Per Roger's instructions, I was able test both patch series on the
am335x-pocketbeagle, based on linux v4.20-rc4, with the following
additional 'rpmsg_pru' patches:

https://github.com/beagleboard/linux/commit/2b013313cae8659f2cbd659c314e471a71f1623c
https://github.com/beagleboard/linux/commit/b894d492a35aa43a7b54512b971a04b9aec17814

Tested-by: Derald D. Woods <woods.technical@gmail.com>


> Andrew F. Davis (1):
>   soc: ti: pruss: add pruss_{request,release}_mem_region() API
> 
> Roger Quadros (2):
>   soc: ti: pruss: add pruss_cfg_read()/update() API
>   soc: ti: pruss: export pruss_intc_configure/unconfigure APIs
> 
> Suman Anna (13):
>   dt-bindings: remoteproc: Add TI PRUSS bindings
>   soc: ti: pruss: Define platform data for PRUSS bus driver
>   soc: ti: pruss: Add pruss_soc_bus platform driver
>   soc: ti: pruss: Fix system suspend/MStandby config issues
>   soc: ti: pruss: Configure SYSCFG properly during probe/remove
>   soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
>   soc: ti: pruss: enable OCP master ports in SYSCFG always
>   soc: ti: pruss: Add a PRUSS irqchip driver for PRUSS interrupts
>   soc: ti: pruss_intc: Add API to trigger a PRU sysevent
>   ARM: OMAP2+: use pdata quirks for PRUSS reset lines on AM335x
>   ARM: dts: AM33xx: Add the PRU-ICSS DT nodes
>   ARM: dts: AM33xx: Add PRU system events for virtio
>   ARM: dts: am335x-*: Enable PRU-ICSS nodes
> 
> Tero Kristo (1):
>   soc: ti: pruss: add pruss_get()/put() API
> 
>  .../devicetree/bindings/soc/ti/ti,pruss.txt        | 360 ++++++++++++
>  arch/arm/boot/dts/am335x-bone-common.dtsi          |   8 +
>  arch/arm/boot/dts/am335x-evm.dts                   |   8 +
>  arch/arm/boot/dts/am335x-evmsk.dts                 |   8 +
>  arch/arm/boot/dts/am335x-icev2.dts                 |   8 +
>  arch/arm/boot/dts/am33xx.dtsi                      |  78 +++
>  arch/arm/mach-omap2/pdata-quirks.c                 |  11 +
>  drivers/soc/ti/Kconfig                             |  12 +
>  drivers/soc/ti/Makefile                            |   1 +
>  drivers/soc/ti/pruss.c                             | 306 +++++++++++
>  drivers/soc/ti/pruss.h                             |  36 ++
>  drivers/soc/ti/pruss_intc.c                        | 604 +++++++++++++++++++++
>  drivers/soc/ti/pruss_soc_bus.c                     | 279 ++++++++++
>  include/linux/platform_data/ti-pruss.h             |  25 +
>  include/linux/pruss.h                              | 235 ++++++++
>  15 files changed, 1979 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>  create mode 100644 drivers/soc/ti/pruss.c
>  create mode 100644 drivers/soc/ti/pruss.h
>  create mode 100644 drivers/soc/ti/pruss_intc.c
>  create mode 100644 drivers/soc/ti/pruss_soc_bus.c
>  create mode 100644 include/linux/platform_data/ti-pruss.h
>  create mode 100644 include/linux/pruss.h
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
