Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284B721104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="ozthwT3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284B721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeK0J22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:28:28 -0500
Received: from vern.gendns.com ([98.142.107.122]:51806 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeK0J22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kLhAvp81otpMQeVlz568tDoEPvMvtX0c6fZKpbv555I=; b=ozthwT3elZugD4oZ4yK74VCuGx
        gaIhV1CpBFGxB/P0sN+w5mc1863LyGGP0MBIpRTXzTg52lZTHFTPhqVCzIYMUK5DcVdlWhMArptQB
        1X9hnM+s0EZHugGI9arGqxQgZ6BARnRbDzd20a/ez8cpFKXM+AxZO8ZykMM7poxePAiEDDnfquhdI
        P71H6uPwwNkeV9yk3nxZKYzcabyt8SsBqTIQjoTv3yql8AsXFm7z9l6rjtEH9YQ8VnESuGbaN8/vV
        uG7Vjgn/fD2uRNoe+wCUdn89gNTlz0PrJi03f+Bega/X8eQoOfKbbDG1Pt9S3ui9sdgDp4SHwkd8V
        89X0IuKg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45550 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gRPQ4-0003S3-GM; Mon, 26 Nov 2018 17:31:56 -0500
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-5-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <e63ac3f9-8daf-af84-a200-4c5f40a1a3ed@lechnology.com>
Date:   Mon, 26 Nov 2018 16:32:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543218769-5507-5-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 1:52 AM, Roger Quadros wrote:

> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index ce5d061..88a86cc 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -26,3 +26,4 @@ qcom_wcnss_pil-y			+= qcom_wcnss.o
>   qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>   obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>   obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> +obj-$(CONFIG_PRUSS_REMOTEPROC)		+= pru_rproc.o
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> new file mode 100644
> index 0000000..c35f432
> --- /dev/null
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PRU-ICSS remoteproc driver for various TI SoCs
> + *
> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Suman Anna <s-anna@ti.com>
> + *	Andrew F. Davis <afd@ti.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/remoteproc.h>

alphabetical order?

> +#include <linux/pruss.h>
> +
> +#include "remoteproc_internal.h"

alphabetical order?

> +#include "pru_rproc.h"
> +
> +/* PRU_ICSS_PRU_CTRL registers */
> +#define PRU_CTRL_CTRL		0x0000
> +#define PRU_CTRL_STS		0x0004
> +#define PRU_CTRL_WAKEUP_EN	0x0008
> +#define PRU_CTRL_CYCLE		0x000C
> +#define PRU_CTRL_STALL		0x0010
> +#define PRU_CTRL_CTBIR0		0x0020
> +#define PRU_CTRL_CTBIR1		0x0024
> +#define PRU_CTRL_CTPPR0		0x0028
> +#define PRU_CTRL_CTPPR1		0x002C
> +
> +/* CTRL register bit-fields */
> +#define CTRL_CTRL_SOFT_RST_N	BIT(0)
> +#define CTRL_CTRL_EN		BIT(1)
> +#define CTRL_CTRL_SLEEPING	BIT(2)
> +#define CTRL_CTRL_CTR_EN	BIT(3)
> +#define CTRL_CTRL_SINGLE_STEP	BIT(8)
> +#define CTRL_CTRL_RUNSTATE	BIT(15)
> +
> +/**
> + * enum pru_mem - PRU core memory range identifiers
> + */
> +enum pru_mem {
> +	PRU_MEM_IRAM = 0,
> +	PRU_MEM_CTRL,
> +	PRU_MEM_DEBUG,
> +	PRU_MEM_MAX,
> +};

I am finding the name "mem" here to be confusing. I keep thinking
these are just RAM regions instead of memory mapped I/O. Maybe call
it "iomem" instead of "mem"?

...

> +static int pru_rproc_set_id(struct pru_rproc *pru)
> +{
> +	int ret = 0;
> +	u32 mask1 = 0x34000;
> +	u32 mask2 = 0x38000;

These values are non-obvious and could use some comments. Also,
they could be made into constants or macros.

> +
> +	if ((pru->mem_regions[0].pa & mask1) == mask1)

how about this instead:

	if ((pru->mem_regions[PRU_MEM_IRAM].pa & 0xfffff) == mask1)

The 0xfffff mask will be important on AM18xx where INTC is at 0x34000,
PRU0 IRAM is at 0x38000 and PRU1 IRAM is at 0x3C000.

> +		pru->id = 0;
> +	else if ((pru->mem_regions[0].pa & mask2) == mask2)
> +		pru->id = 1;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}

