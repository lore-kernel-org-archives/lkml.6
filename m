Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4952146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lgwIc/S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBKExA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:53:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41052 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:53:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1B4qlpv066476;
        Sun, 10 Feb 2019 22:52:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549860767;
        bh=TtFnIV9B2FuN7s37b6pmhfZ5UAL4/FpSlIfLtJpA2sQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lgwIc/S4rchC9OqGcxRKWECSYTC+r0h82JAvSF6bc4X3ABoAho14j/9NwT0AEVmO7
         Xx1WMVBmtY+f/80HeQsYRc9VSOkrhok9I04ix5zSsYGjzlwa3HoN85Ot52YlqpmxO4
         7rZwkQ4cgUbj6uKxKDvr+InOdyPiDD4zQ9rXEdg4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1B4qllA069564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Feb 2019 22:52:47 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 10
 Feb 2019 22:52:47 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 10 Feb 2019 22:52:47 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1B4qhYu017341;
        Sun, 10 Feb 2019 22:52:45 -0600
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190128054935.4972-1-vigneshr@ti.com>
 <20190128054935.4972-3-vigneshr@ti.com>
 <2efbca08-c4ab-34ea-0e34-05aed7168df8@microchip.com>
 <daa35c21-195e-eeb5-8aa2-cf42eff6a554@ti.com>
 <20190210141912.1da19db6@kernel.org>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <fd245dc9-6d3c-8075-a684-d4fe6cb85849@ti.com>
Date:   Mon, 11 Feb 2019 10:23:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210141912.1da19db6@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/19 6:49 PM, Boris Brezillon wrote:
> On Tue, 5 Feb 2019 11:43:46 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>>>>  static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>>>  {
>>>> -	const struct spi_nor_hwcaps hwcaps = {
>>>> -		.mask = SNOR_HWCAPS_READ |
>>>> -			SNOR_HWCAPS_READ_FAST |
>>>> -			SNOR_HWCAPS_READ_1_1_2 |
>>>> -			SNOR_HWCAPS_READ_1_1_4 |
>>>> -			SNOR_HWCAPS_PP,
>>>> -	};
>>>>  	struct platform_device *pdev = cqspi->pdev;
>>>>  	struct device *dev = &pdev->dev;
>>>> +	const struct cqspi_driver_platdata *ddata;
>>>> +	struct spi_nor_hwcaps hwcaps;
>>>>  	struct cqspi_flash_pdata *f_pdata;
>>>>  	struct spi_nor *nor;
>>>>  	struct mtd_info *mtd;
>>>>  	unsigned int cs;
>>>>  	int i, ret;
>>>>  
>>>> +	ddata = of_device_get_match_data(dev);
>>>> +	if (!ddata)
>>>> +		hwcaps.mask = CQSPI_BASE_HWCAPS_MASK;  
>>>
>>> Now that .data is set in all cqspi_dt_ids[], maybe it's better to print a
>>> message and return an error here. But I guess it's a matter of taste, so not a
>>> show stopper.  
>>
>> Since, driver data is kernel internal field, I guess there is little
>> help in printing out the error to the user when its missing. I prefer to
>> keep this as is, as basic Quad mode is supported by all versions of the IP.
> 
> Well, if all compat entries have an associated platdata instance we
> don't need to support the !ddata case, right? I think enforcing the
> presence of such a platdata is actually is a sane thing to do (which
> implies returning an error when ddata is NULL).
> 

Ok, will respin with a dev_err() and return -EINVAL when ddata is NULL.

-- 
Regards
Vignesh
