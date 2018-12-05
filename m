Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD652C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9792082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wODCqL8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9792082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeLELzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:55:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40680 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeLELzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:55:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5BsdaI022321;
        Wed, 5 Dec 2018 05:54:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544010879;
        bh=zTcwsen6dKsqpjvuZUQeAi9Vv+N6Ocpxs6kGW7Ru/84=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wODCqL8E3W0FicJHzdXw4PQWiSpXuXk9BNUkKrO97CeslBfizs3PAHxqM1Xy2OYdz
         37KOFTEgJCC+fAlQjB4+9BmJEv2dskEjjaQpgPUPySfcRyjBistrUtad7xoTO9KZC6
         gbwJU3yh/LyytVK5V4BgnHUzzsVPOX3iucCnJ/yU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5Bsd9R106778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 05:54:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 05:54:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 05:54:39 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5BsYgD000992;
        Wed, 5 Dec 2018 05:54:35 -0600
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
Date:   Wed, 5 Dec 2018 17:25:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203101937.7b01a0ad@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 03/12/18 2:49 PM, Boris Brezillon wrote:
> Hi Mark,
> 
> On Mon, 3 Dec 2018 08:39:00 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>>
>> Yogesh Gaur (7):
>>   spi: add support for octal mode I/O data transfer
>>   spi: spi-mem: add support for octal mode I/O data transfer
> 
> Can you take those 2 patches in your tree for 4.21/5.0?
> 

>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba

Could you consider merging these two patches alone for v4.21?
These can be applied independent of other patches in the series and
would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.

>>   mtd: m25p80: add support of octal mode I/O transfer
>>   spi: nxp-fspi: add octal mode flag bit for octal support
> 
> I'll queue these ones after 4.21-rc1/5.0-rc1 is out (which means
> they'll appear in 4.22/5.1).
> 
>>   arm64: dts: lx2160a: update fspi node

-- 
Regards
Vignesh
