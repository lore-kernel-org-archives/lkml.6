Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3020815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgwZ66WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbeLTGcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:32:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42886 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeLTGcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:32:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK6WKfb052050;
        Thu, 20 Dec 2018 00:32:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545287540;
        bh=5lmyEkckv0Aq9P7ICSHxKkDjWSa42rCtOd37oaIZPG4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jgwZ66WFVK2oYngECcGjVj+3hqnCfHpIRXs18BMphnVxD1A/nFFMVHE9xrCN1DV7R
         scTfubWCQLTUnh9GnGIBz60L2IQu5M5ZPefSzekq/ZpGniH4sQTqLIsDH+nBuFs1z9
         bEXtUJiyHVHF3WxDiId8UJPVqgIv5yroEYoSnkCg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK6WKiu097046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 00:32:20 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 00:32:20 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 00:32:20 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK6WFCB021430;
        Thu, 20 Dec 2018 00:32:16 -0600
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
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
 <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
Date:   Thu, 20 Dec 2018 12:03:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/12/18 11:02 AM, Yogesh Narayan Gaur wrote:
[...]
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
>> These two patches are already merged and is now part of linux-next[1].
>> Its preferred to send patches based on top of latest linux-next so as to avoid
>> resending patches that have already been picked up by the maintainer.
>>
>> [1]
>> commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:06 2018 +0000
>>
>>     spi: add support for octal mode I/O data transfer
>>
>> commit b12a084c8729ef423089bb9a5a143eed39cd94e7
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:12 2018 +0000
>>
>>     spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
> I have checked on repo "git://git.infradead.org/linux-mtd.git" on branch "spi-nor/next" and in that kernel version is 4.20.-rc5.
> In this repo above 2 patches are not present and hence has send the patches by moving to top of this repo.
> 

Those patches are applied to spi tree:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next

> Can you please let me know the repo of linux-next and branch to use.
> 

The linux-next tree is the holding area for patches aimed at
the next kernel merge window. This tree includes spi-nor/next as part of mtd/next
as well as many other subsystem specific -next trees:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git branch: master


Regards
Vignesh

> --
> Regards
> Yogesh Gaur
> 
>> Regards
>> Vignesh
>>
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>> Changes for v6:
>>> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
>>> - Rebase on top of v4.20-rc5.
>>> Changes for v5:
>>> - Modified string 'octo' as 'octal' in all patches.
>>> Changes for v4:
>>> - Rebase on top of v4.20-rc2.
>>> - Modify octo entries enum value in spi.h.
>>> Changes for v3:
>>> - Add octo mode support in spi_setup().
>>> - Rename all patches with 'octal' string modified as 'octo'.
>>> Changes for v2:
>>> - Incorporated review comments of Boris and Vignesh.
>>>
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>>>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>>>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>>>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>>>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>>>  drivers/spi/spi.c                                 | 12 ++++++++++--
>>>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>>>  include/linux/spi/spi.h                           |  4 +++-
>>>  8 files changed, 63 insertions(+), 14 deletions(-)
>>>
>>
>> --
>> Regards
>> Vignesh

