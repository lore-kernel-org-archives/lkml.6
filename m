Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42293C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013CA2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mrdfr0XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLSMn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:43:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54936 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbeLSMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:43:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgoY8098519;
        Wed, 19 Dec 2018 06:42:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545223370;
        bh=hOSSW/Fe3UvUR+FrL7a03PALPLMq3eLz4yJsqFMxDoc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mrdfr0XXm/f5HMraMzJuJQE7P79uLh/2YtX4lv0Z1jl+3bRWN/Um8PdULyHarDG5E
         Dy5yIpCcFLM+W9ihzGe48tHudI5EBvL+puXXzJeT3ejyOt2uwujSNpZL6AHg9dEDY/
         pnBtQuIMXym537Z5o06Z2HnRpbHbZZzYCRqxnKH4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgowT034704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 06:42:50 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:50 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:50 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgjlF004104;
        Wed, 19 Dec 2018 06:42:46 -0600
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
Date:   Wed, 19 Dec 2018 18:13:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/12/18 3:41 PM, Yogesh Narayan Gaur wrote:
> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root@lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root@ls1012ardb:~#
> 
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384&state=*
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer


These two patches are already merged and is now part of linux-next[1].
Its preferred to send patches based on top of latest linux-next so as to
avoid resending patches that have already been picked up by the maintainer.

[1]
commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:06 2018 +0000

    spi: add support for octal mode I/O data transfer

commit b12a084c8729ef423089bb9a5a143eed39cd94e7
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:12 2018 +0000

    spi: spi-mem: add support for octal mode I/O data transfer


Regards
Vignesh

>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
> Changes for v6:
> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> - Rebase on top of v4.20-rc5.
> Changes for v5:
> - Modified string 'octo' as 'octal' in all patches.
> Changes for v4:
> - Rebase on top of v4.20-rc2.
> - Modify octo entries enum value in spi.h.
> Changes for v3:
> - Add octo mode support in spi_setup().
> - Rename all patches with 'octal' string modified as 'octo'.
> Changes for v2:
> - Incorporated review comments of Boris and Vignesh.
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer
>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>  drivers/spi/spi.c                                 | 12 ++++++++++--
>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>  include/linux/spi/spi.h                           |  4 +++-
>  8 files changed, 63 insertions(+), 14 deletions(-)
> 

-- 
Regards
Vignesh
