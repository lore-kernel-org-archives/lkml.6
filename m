Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754D021473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lz6quGne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754D021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeJDR1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:27:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57986 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:27:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94AYjKU095336;
        Thu, 4 Oct 2018 05:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538649285;
        bh=hu+xnYYzGk2P9gNOGFoNFjwX9zxr3COvS1l5ek5/jzc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Lz6quGnepJa91jMLgfrvsYYos5uFBiE7o+KZ7rRaMmyrCktc2G2TLDAjVptSjV5Nw
         4SCykDwq2amG0gVLhE4vCFLDMytPvSsJD3fplbGF4Q4O3Q7QNtAYpBA+vgqFqlJAz8
         n1VSbO67wKrdQcYmYaCCTn1LsrSmN5Ej01/heBks=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94AYjBR027789;
        Thu, 4 Oct 2018 05:34:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 05:34:45 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 05:34:45 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94AYfwY028400;
        Thu, 4 Oct 2018 05:34:42 -0500
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003212017.653e739f@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
Date:   Thu, 4 Oct 2018 16:05:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003212017.653e739f@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 October 2018 12:50 AM, Boris Brezillon wrote:
> On Wed, 3 Oct 2018 22:26:00 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> This series adds support for octal mode of mt35x flash. Also, adds
>> support for OSPI version of Cadence QSPI controller.
>>
>> Based on top of patches adding basic support for mt35xu512aba here:
>> https://patchwork.ozlabs.org/cover/971437/
>>
>> Vignesh R (3):
>>   mtd: spi-nor: Add Octal mode support for mt35xu512aba
>>   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
>>   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller
> 
> The patchset looks good to me, I'll just wait the next release cycle
> before applying it, since I'd prefer to have it stay a bit longer in
> -next. This should leave enough time to let other people review this
> stuff.
> 

Ok, thats fine...

>>
>>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
> 
> On a slightly different topic, do you plan to convert the Cadence
> driver to spi-mem? And if you don't, is it because you don't have time
> or because some features are missing in spi-mem (I remember you
> mentioned a few things back when you were reviewing the spi-mem series)?
> 

I do not have plans to convert cadence QSPI driver to spi-mem yet,
mainly due to lack of time. Also, not sure if original author Marek and
other altera people are okay with that.

I see couple of issues in the way of conversion:
1. I would wait to know what direction would direct mapping APIs[1] go
before starting spi-mem conversion for Cadence QSPI driver. Else, we
have may to re write again if direct mapping APIs are merged.
2. New Cadence OSPI IP has an integrated PHY to support high throughput
OSPI flashes operating up 200MHz in Octal DDR mode. In order to work
with such flashes, PHY DLLs need to be calibrated. Highly simplified
calibration sequence is as below(See [2] for actual sequence):
-Read flash ID at low speed and store it.
-Enable PHY and set DLLs to a defined initial value
-Increment RX DLL value
-Read flash ID and check for correctness of data read
-repeat above two steps until a band of passing values is obtained for
RX DLL where flash ID is correctly read.
-DLL needs to set to middle of the passing band.

I am trying to figure out how to fit this into the spi-mem framework as
controller would to need to store READ ID opcode and expected JEDEC ID
before starting calibration sequence.


[1]https://patchwork.ozlabs.org/cover/924041/
[2]http://www.ti.com/lit/ug/spruid7a/spruid7a.pdf(12.3.2.4.14 PHY Module
page 9770-9772)

-- 
Regards
Vignesh
