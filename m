Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DE6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EmGf34C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBUNL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:11:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39776 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:11:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LDAOij121403;
        Thu, 21 Feb 2019 07:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550754624;
        bh=hugBsHCAGaJB7Qsx+c9P3n+DXVu2tvNWYRAeH/J9ITM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EmGf34C9U7doGwkP8RYrfPTTsN+yyNUsgeHSg7eRqQ5wuE69NfsFHWmNoVxNd/3Cg
         zhXf4Yf/YzHEOgrVQgBsU9dimDP96Y5TqpmqsZPbsw8NK7XD4ECVF7BOYH3Rh7zBem
         FoinaDhU+hP64BAqeEHDyzkYDLoM9plcGdvd2x04=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LDAOBo025156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 07:10:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 07:10:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 07:10:24 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LDALhE026078;
        Thu, 21 Feb 2019 07:10:21 -0600
Subject: Re: [EXT] [PATCH v6 2/2] mtd: spi-nor: cadence-quadspi: Add support
 for Octal SPI controller
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
References: <20190212083809.6534-1-vigneshr@ti.com>
 <20190212083809.6534-3-vigneshr@ti.com>
 <BYAPR08MB453362F4253ADA149D05315FDB7E0@BYAPR08MB4533.namprd08.prod.outlook.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <b459f797-d24c-5501-76a0-057ec1df594d@ti.com>
Date:   Thu, 21 Feb 2019 18:41:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR08MB453362F4253ADA149D05315FDB7E0@BYAPR08MB4533.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/19 4:11 PM, Bean Huo (beanhuo) wrote:
> Hi, Vignesh
> 
>>
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines), It also has an
>> integrated PHY. IP register layout is very similar to existing QSPI IP except for
>> additional bits to support Octal and Octal DDR mode. Therefore, extend
>> current driver to support Octal mode. Only Octal SDR read (1-1-8)mode is
>> supported for now.
> 
> Does this your Cadence OSPI controller support 8-8-8 IO mode, if yes,
> Why not directly enable 8-8-8 mode? 
> 

Yes.. IP also supports 8-8-8 DTR mode. But supporting those modes
require enabling, configuring and calibrating OSPI PHY module within the
IP.
I am planning to do that, after moving driver over to spi-mem layer.


>> Tested with mt35xu512aba Octal flash on TI's AM654 EVM.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

-- 
Regards
Vignesh
