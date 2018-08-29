Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62907C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183420856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qPVyAmlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1183420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeH2OXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:23:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43368 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2OXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:23:54 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7TARQJT119939;
        Wed, 29 Aug 2018 05:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535538446;
        bh=MVipR7WqOwTAe2Va08bP9m2goPa7A+GqOF9DoVhbvnw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qPVyAmlrVylx32lBIuspTUT6N16cmPc0QIJqKArLisUwdLho+1680IRo2/qnKSrQ5
         bfeEpemeMGibB4+iR1bBGsuHWxKtve4t1MGU70014GwOvOZsJG6QXKoXoYylrvJptk
         m5C9QK1cDZDr3Ms62zxfCTDp+Kka0U1CxSyPqsmk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TARQN8028389;
        Wed, 29 Aug 2018 05:27:26 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 29
 Aug 2018 05:27:26 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 29 Aug 2018 05:27:25 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TARMSO012323;
        Wed, 29 Aug 2018 05:27:23 -0500
Subject: Re: [PATCH v3 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
To:     Janek Kotas <jank@cadence.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <66C16650-56D0-46A3-8050-A5540E48C702@global.cadence.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <0b273e2e-6d60-ac10-a1d5-78ea2346c1d9@ti.com>
Date:   Wed, 29 Aug 2018 15:57:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <66C16650-56D0-46A3-8050-A5540E48C702@global.cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 August 2018 06:55 PM, Janek Kotas wrote:
> This patch adds a device tree platform driver for
> Cadence UFS Host Controller.
> It can be enabled with SCSI_UFS_CDNS_PLATFORM Kconfig option.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>

[...]

> diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
> new file mode 100644
> index 00000000..5d9e4875
> --- /dev/null
> +++ b/drivers/scsi/ufs/cdns-pltfrm.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform UFS Host driver for Cadence controller
> + *
> + * Copyright (C) 2018 Cadence Design Systems, Inc.
> + *
> + * Authors:
> + *	Jan Kotas <jank@cadence.com>
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/time.h>
> +
> +#include "ufshcd-pltfrm.h"
> +
> +#define CDNS_UFS_REG_HCLKDIV 0xFC
> +
> +/**
> + * Sets HCLKDIV register value based on the core_clk
> + * @hba: host controller instance
> + *
> + * Return zero for success and non-zero for failure
> + */
> +static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
> +{
> +	struct ufs_clk_info *clki;
> +	struct list_head *head = &hba->clk_list_head;
> +	unsigned long core_clk_rate = 0;
> +	u32 core_clk_div = 0;
> +
> +	if (list_empty(head))
> +		return 0;
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (IS_ERR_OR_NULL(clki->clk))
> +			continue;
> +		if (!strcmp(clki->name, "core_clk"))
> +			core_clk_rate = clk_get_rate(clki->clk);
> +	}
> +
> +	if (!core_clk_rate) {
> +		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	core_clk_div = core_clk_rate / USEC_PER_SEC;
> +
> +	ufshcd_writel(hba, core_clk_div, CDNS_UFS_REG_HCLKDIV);
> +	/* Make sure the register was updated */
> +	mb();

Why is it critical to ensure write completed here?

> +
> +	return 0;
> +}
> +

> +/**
> + * cdns_ufs_pltfrm_remove - set driver_data of the device to NULL

This appear to do more than setting driver_data to NULL.

> + * @pdev: pointer to platform device handle
> + *
> + * Always returns 0
> + */
> +static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
> +{
> +	struct ufs_hba *hba =  platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&(pdev)->dev);

This looks suspect. Why do you need this get_sync() on remove() and
where is the corresponding put_sync()?

> +	ufshcd_remove(hba);
> +	return 0;
> +}

Thanks,
Sekhar
