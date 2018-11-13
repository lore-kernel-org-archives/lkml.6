Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E468DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997712243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997712243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeKMR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:56:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41634 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeKMR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:56:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAD7xZGe062180;
        Tue, 13 Nov 2018 01:59:35 -0600
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAD7xZZo126190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 01:59:35 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 01:59:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 01:59:34 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAD7xUNi022222;
        Tue, 13 Nov 2018 01:59:31 -0600
Subject: Re: [PATCH v3 0/7] spi: add support for octo mode
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
Date:   Tue, 13 Nov 2018 13:30:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh

On 23/10/18 3:07 PM, Yogesh Narayan Gaur wrote:
> Add support for octo mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octo mode flags and parsing of same in spi driver.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add opcodes for octo I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add mode bit required for octo mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 

You may have to rebase this series to avoid conflicts with recent spi.h
changes. Also, I suggest merging patches in [1] with this series if you
plan to post another version so that all bits are at one place.

Regards
Vignesh

> Cherry pick below 2 patches (from: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git):
>     c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted logic in op sanity check
>     db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra sanity checks on the op param
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
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=72181
> 
> Yogesh Gaur (7):
>   spi: add support for octo mode I/O data transfer
>   spi: spi-mem: add support for octo mode I/O data transfer
>   mtd: spi-nor: add opcodes for octo Read/Write commands
>   mtd: spi-nor: add octo read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octo mode I/O transfer
>   spi: nxp-fspi: add octo mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
> Changes for v3:
> - Add octo mode support in spi_setup().
> - Rename all patches with 'octal' string modified as 'octo'.
> Changes for v2:
> - Incorporated review comments of Boris and Vignesh.
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>  drivers/spi/spi.c                                 | 12 ++++++++++--
>  include/linux/mtd/spi-nor.h                       |  8 ++++++++
>  include/linux/spi/spi.h                           |  2 ++
>  8 files changed, 56 insertions(+), 7 deletions(-)
> 

-- 
Regards
Vignesh
