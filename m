Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA207C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993322184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Y3JgxTQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfBZS2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:28:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34370 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfBZS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:28:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so11685691lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLpnNHAsXYeTMUo78HRM2QnmksqH5fmT7cGzmEMRAOI=;
        b=Y3JgxTQHu9gHW/Gn4f+FyhRmBRRVr5YeaJ1hu+s+XHpndpcvccBgy+HntzAob+cbq7
         oXJ437K+PAgR75PEj4GBYHd9UeTgh69NoKGkZhdwoIWQoHWNtMEckokK7YY1WOH1svJt
         CrGj/Ezhmh/s0v3UGbGMaxDT8mxHe7FTEGDuu9/vSahRs1snt5CnwfsnmfNXizHC67aC
         NsrZGKf/zkyoKYzzK339ZHuIXzWjmgdrG9almFsUx7wuJBSO847kIVCTDqYnw0C5apHx
         1OdHF2HUH6Mi9O3L++NeH8Mu3z1qWihxhAhsiVOzgECnJ/1zwl7nQiDgGuYb/SR57tp+
         4Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bLpnNHAsXYeTMUo78HRM2QnmksqH5fmT7cGzmEMRAOI=;
        b=X46wLzg6g+Cqu+e0E2525/+82/t34W3GhTK0EmNmNM741M2gYGoEoNhWw2shwptfOa
         azTjl7Q3SZ1IUjTG9GJVHICKdmPCNAFv3OzIx1OOGyxmAKQZmj1lVYctZI1cN6Spiwyn
         nFmmQ+t7XOWtHyal2o5HrL1sX6A4YG2Ij+d9s5Qxjvmzw5eNZAANUSeAtJ17jg4cmfNr
         SuZERpho6Bt6c1onOoX8YRiZmeOWWmTCJvEWxhCPqvVn5fDOKqbdEV0pUZYf/D6tdsyF
         Qs5T4rxETtQxx7tPhLbUreVLyYp00O8zNXRC9W+4miYxwvbRS3/Osj7kBwEvYtQuAzo9
         5F0Q==
X-Gm-Message-State: AHQUAub8G1v+BPFUM5eiHv/YQ2WX89nfVwwcf0uxPOE7yYkcnuSmOKxl
        QcQ2eh5SvgiE6sLqmFUePrTlAg==
X-Google-Smtp-Source: AHgI3IZENB2wSiagUzwcZqG0Fd7+YIzsH6UcxiSQ6DwQ4zPeLlqHuDiNNUXmGASynfjHrC5gtR5dUQ==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr14223743lja.9.1551205699070;
        Tue, 26 Feb 2019 10:28:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.110])
        by smtp.gmail.com with ESMTPSA id d25sm3413914lji.9.2019.02.26.10.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:28:18 -0800 (PST)
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4d2e31e3-0130-14a1-ab06-e6ffeae1cd22@cogentembedded.com>
Date:   Tue, 26 Feb 2019 21:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh R <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hb_device hbdev;
> +	void __iomem	*regbase;

   Isn't regbase a controller's data, not a slave device's?

[...]

MBR, Sergei
