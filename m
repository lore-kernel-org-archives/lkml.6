Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD0C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF845218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bM1+Hdhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfBFLSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:18:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34838 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfBFLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:18:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16BIQF9105556;
        Wed, 6 Feb 2019 05:18:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549451906;
        bh=6KLtT6t2MhwFlIQe4mzX9zJaY6RcA71GnYnsQ6Rnvgc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bM1+HdhrNKm315kjSkS7qVxOWu7Gqw+Q8IIn2g+dKU1ZLXTQUJZYtEDL1AdNwHjfL
         J7B3IsCu3slnWom0/CLtCw4E+hwK9YiwST6xx9nJQytH62AR05K0crY9PAETQy2lZz
         7x+J9HwC3fw85lwEbBwvZ2FXI6QzwUjFan8RC0FU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16BIQng024728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:18:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:18:25 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:18:25 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16BIHdF022104;
        Wed, 6 Feb 2019 05:18:19 -0600
Subject: Re: [PATCH v5 0/7] Add Armada 3700 COMPHY support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
 <20190206095743.5eed3584@xps13>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <300b86e7-1d00-da92-2203-a7cfeb2d7aa8@ti.com>
Date:   Wed, 6 Feb 2019 16:47:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190206095743.5eed3584@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/19 2:27 PM, Miquel Raynal wrote:
> Hi Kishon,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue,  8 Jan 2019
> 17:31:17 +0100:
> 
>> Hello,
>>
>> This series adds a new driver to support Armada 3700 COMPHY IP.
>> The series has been tested on an ESPRESSObin with SATA, PCIe
>> and USB3 host. For this purpose, patch 1 enumerates the SATA PHY
>> mode. The SGMII PHY mode that is supported by the IP has been written
>> (uses SMC calls anyway) but could not be tested on this platform.
>>
>> Three series will follow to add PHY support (or at least a PHY nodes
>> in the A3700/ESPRESSObin device trees) to the MVEBU AHCI driver, the
>> Aardvark PCI controller driver and the MVEBU xHCI driver. All this is
>> needed in order to achieve suspend to RAM on this platform.
>>
>> Thanks,
>> Miquèl
>>
> 
> Any inputs on this series? It is important for me because it impacts
> SATA, PCIe and USB changes I plan to get merge.

merged now, thanks.

-Kishon
> 
> Thanks,
> Miquèl
> 
>>
>> Changes since v4:
>> =================
>> * Fixed error in the driver probe where PHY_INTERFACE_MODE_NA was
>>   assigned to lane->mode instead of lane->submode.
>> * Compile-in the driver by default (depends on ARCH_MVEBU).
>> * Add dependency on HAVE_ARM_SMCC in Kconfig.
>>
>> Changes since v3:
>> =================
>> * Added Rob's Reviewed-by tag on bindings.
>> * Rebased on top of phy -next as of the 12th of December, 2018.
>> * Adapted the driver to support SGMII/1000BASEX and
>>   HS_SGMII/2500BASEX.
>>
>> Changes since v2:
>> =================
>> * Remove redundant check on lane->port/args->arg[0] at the end of the
>>   ->xlate() callback. Do it on both armada-cp110 and armada-a3700  
>>   COMPHY drivers.
>> * Put my SoB as author of the patch first when a patch is co-developed.
>>
>> Changes since v1:
>> =================
>> * Fix wrong check in ->xlate().
>> * Apply the same fix to the cp110 comphy driver from which the a3700
>>   driver is based.
>> * Added credit to Gregorz Jaszczyk for his work.
>> * Added Suggested-by tag to the patch adding the COMPHY DT node.
>>
>>
>> Grzegorz Jaszczyk (1):
>>   phy: enumerate SATA PHY mode
>>
>> Miquel Raynal (6):
>>   phy: mvebu-cp110-comphy: fix port check in ->xlate()
>>   phy: add A3700 COMPHY support
>>   dt-bindings: phy: mvebu-comphy: extend the file to describe a3700
>>     bindings
>>   MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
>>   ARM64: dts: marvell: armada-37xx: fix SATA node scope
>>   ARM64: dts: marvell: armada-37xx: declare the COMPHY node
>>
>>  .../bindings/phy/phy-mvebu-comphy.txt         |  65 +++-
>>  MAINTAINERS                                   |   6 +
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  31 +-
>>  drivers/phy/marvell/Kconfig                   |  12 +
>>  drivers/phy/marvell/Makefile                  |   1 +
>>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c  | 318 ++++++++++++++++++
>>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |   2 -
>>  include/linux/phy/phy.h                       |   1 +
>>  8 files changed, 421 insertions(+), 15 deletions(-)
>>  create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c
>>
