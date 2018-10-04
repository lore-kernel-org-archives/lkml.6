Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F32C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A07D21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y+xyOyon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJDSEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:04:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:04:39 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BBVST065554;
        Thu, 4 Oct 2018 06:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651491;
        bh=9LtAvV0CNSiR0O9TIkd3I0B/k8fmCE3t/O8uRCVXdXY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y+xyOyonk8TsIZnVDsb/cQlXIpFWdps84a6frGALasjy63wmCxXtEqLs7zOVW0rmf
         QWatlZuxFtP0aUbtQSra62WHBd5K++cSbNv9D/ChVhBU/ZIy0KmjLKrqMWzXVLw7P5
         qxqEVvrC/SImuH25W6NUdoRr3UzUofyr7BhfSawg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BBVRH014471;
        Thu, 4 Oct 2018 06:11:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:11:31 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:11:31 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BBSOM026852;
        Thu, 4 Oct 2018 06:11:28 -0500
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-2-vigneshr@ti.com> <20181004114535.3a5dba05@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <904391ba-5a12-aee9-966a-17346dded080@ti.com>
Date:   Thu, 4 Oct 2018 16:42:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004114535.3a5dba05@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 04 October 2018 03:15 PM, Boris Brezillon wrote:
> On Wed, 3 Oct 2018 22:26:01 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines. It
>> supports read/write over 8 IO lines simulatenously. Add support for
>> Octal read mode for Micron mt35xu512aba.
>> Unfortunately, this flash is only complaint to SFDP JESD216B and does not
>> seem to support newer JESD216C standard that provides auto detection of
>> Octal mode capabilities and opcodes. Therefore, this capability is
>> manually added using new SPI_NOR_OCTAL_READ flag.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 11 ++++++++++-
>>  include/linux/mtd/spi-nor.h   |  2 ++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index aff5e6ff0b2c..4926e805a8cb 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -90,6 +90,7 @@ struct flash_info {
>>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
>>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>>  #define USE_CLSR		BIT(14)	/* use CLSR command */
>> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
> 
> Hm, we'll need to clarify what OCTAL means. I see at least 3 different
> modes using 8 IO lines (1-1-8, 1-8-8 and 8-8-8) and all of them could
> be qualified as "octal" modes.
> So how about renaming this macro SPI_NOR_1_1_8_READ.
> 

My understanding is that, if a flash is Octal IO capable, then it
supports all mode of Octal IO (1-1-8, 1-8-8 and 8-8-8). At least in the
current code, I see SPI_NOR_QUAD_READ seems to imply 1-1-4, 1-4-4 and
4-4-4 modes.
Moreover, these capabilities should be auto discoverable once flash
start populating SFDP JESD216C tables (IIRC, JESD216B already takes care
of QUAD IO modes). So, I don't think we need different flags for 1-1-8,
1-8-8 and 8-8-8. Please let me if that's not the case.

For this patch, I wanted to start small and support only 1-1-8 mode
which is the easiest.


> Also, I fear we'll soon run out of bits in ->flags if we keep adding
> one flag per mode which is why I proposed a solution to let flash
> chips tweak the flash parameters as they wish [1][2]. I'm not saying we
> should do it now, but we should definitely plan for something like that.
> 
> [1]https://github.com/bbrezillon/linux/commit/9c672e4c85a91f1b0803c9c6e4b8f3aae5d79ffb
> [2]https://github.com/bbrezillon/linux/commit/3a5515c8821314c06a3d84f9861aefe476bb711e
> 

Hmm, it almost seems like Macronix flash warrants its own driver now.

-- 
Regards
Vignesh
