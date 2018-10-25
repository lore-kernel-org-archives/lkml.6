Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BDBC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0907F2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuCH3M+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0907F2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeJZF2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:28:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34185 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZF2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:28:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id c21-v6so3653660ljj.1;
        Thu, 25 Oct 2018 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=EWU+DMnWQo8TjpoUKtT4KbxdOWtfme8ZyaFJEKj2sYA=;
        b=XuCH3M+wqzuBmB6+F/kn+zYMofl1vVMBRe/b2KzOLCC892m5DdOAp/jSbOQy/zPY3u
         +EaUv9f9+AwEMfXK6up2/cnnz3te+zN+h045fqgpyh0AsXC5UlVrQ5laQgFMWVGCfzq4
         rMXOdgKNMv31d1kOWwKe8JiAAbgD0gRkQjY6HiVxlwdzqIyzPLRnisrUqi+1QYPfLzMx
         MOKDEy0apAeaworYM37EwRmNF+qKGsSZVUXf5mBASZegvF8aoxuZk8TmHYSaUdhZSS0M
         WkWjJz+y9HfQMB8N8Zf8qFbY4MPBUzVNEYS221BRn6wZs62MfVcZW5CDo0w5oYeSp1w9
         Z/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EWU+DMnWQo8TjpoUKtT4KbxdOWtfme8ZyaFJEKj2sYA=;
        b=eX27z3z/DQUqONYTMJ3lqqLj7t2+CfLcIwbBEcvMK/XLE3xXlRx4UHkOqc64J89ffA
         j+nqmyR+i8TlNXfybxpO9GTURsZQC6OHo2ia0tKHSem/ixCtJJ2ZfzXc3WEjC4f9Fivv
         p/9v2qto8/rPX29z/3QK49BoPVT+rDFy/F8fZCw9dngnBsvioO1ngAfMJ8FdAZrGZfWF
         OwnbmPSJWkHrPT8B4o0d9nRnNx6B0OjA+t1ugz19wystzphchUcJ2uIGjUkvx8EHMs5k
         QKAbDygBCoEqT0dmo+AcF/PD5FU/Bt6BaZlkhmH3SIq/LR2JCNpsXU5JdpJepkab1B6a
         URBA==
X-Gm-Message-State: AGRZ1gK/9bgEGqixNi5o6r4Ug+PvF6qUX1kcXZarrTY7w+/GA5UrK+U+
        UW8j8ALF3hnVzX4JJ09sp7E=
X-Google-Smtp-Source: AJdET5cv+HYPg/UlTQX0vH8QZesxftTfwBHFEvupgFhtKmvhUqFsdOI7hCX8Hk+iU3adIkP31uFqvA==
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr444846ljg.138.1540500839571;
        Thu, 25 Oct 2018 13:53:59 -0700 (PDT)
Received: from ?IPv6:2001:14ba:8017:3300:313a:d550:4603:9163? (dtynxhybvjnm1yvtdwgvt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:313a:d550:4603:9163])
        by smtp.googlemail.com with ESMTPSA id h26-v6sm512870lfc.40.2018.10.25.13.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:53:58 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
To:     Nava kishore Manne <nava.manne@xilinx.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
References: <20181026122424.30831-1-nava.manne@xilinx.com>
 <20181026122424.30831-4-nava.manne@xilinx.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <437c1bc9-8d5b-7b2a-f612-993151c23f7c@gmail.com>
Date:   Thu, 25 Oct 2018 23:53:56 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026122424.30831-4-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some comments below.

On 26/10/2018 15.24, Nava kishore Manne wrote:
> Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> The zynqmp reset-controller has the ability to reset lines
> connected to different blocks and peripheral in the Soc.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-Fixed some minor coding issues as suggested
> 		 by philipp.
>
> Changes for v1:
> 		-None.
>
> Changes for RFC-V3:
> 		-None.
>
> Changes for RFC-V2:
> 		-Moved eemi_ops into a priv struct as suggested
> 		 by philipp.
>
>   drivers/reset/Makefile       |   1 +
>   drivers/reset/reset-zynqmp.c | 114 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 115 insertions(+)
>   create mode 100644 drivers/reset/reset-zynqmp.c
>
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4243c38..eb315d1 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -24,4 +24,5 @@ obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>   obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>   obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
>   obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>   
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> new file mode 100644
> index 0000000..cff63d9
> --- /dev/null
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
Probably should be:

+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 1)

or if START is moved one forward:

+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)

> +#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
If you move start forward then you don't need +1 here. Or you can get 
rid of the define altogether and just use ZYNQMP_PM_RESET_START in it's 
place..

Thanks,
Vesa Jääskeläinen
