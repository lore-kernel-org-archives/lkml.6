Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999B6ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9C208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="al+vHY9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A9C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeIPTdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 15:33:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37409 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeIPTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 15:33:45 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so9492869iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AjGGWq5tS557RcNcS95QB4LLiVqGwuSHOSTUDvFij4Q=;
        b=al+vHY9UtWNw94E+Pah251il8TO3T4OBwMNCtgVnSgYFOVMiOqU64zShV0ada+7kIC
         bWVCWEMeOuv7X3aYZlm+PW126+OFoQnBhnPB5s7mKyL3QaXPCYPz10520J34Wc/vOfqq
         TOCmwRcN39Y6+Y+Txlh7tfNCrxWZ8FZ7icwvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjGGWq5tS557RcNcS95QB4LLiVqGwuSHOSTUDvFij4Q=;
        b=IApSHiE9Y+VDI33bge6ZbdIcJQg1VNJokBT/kTCzDORZd7J29mXuBEJM++tcgJbBJK
         6jUPI/7V44WPCQ0yzsAl73AXv7ubAL86/WQmXrVlJCf1H2BU3TFf5LRT0O/Gla51zRkl
         f7AM8Us3vbuIHNDI4T7sXqMl1pyg/7y+VvoihDhqHwsfJJnwxLjAsQppaHGhR1Irx4f7
         pwaihy9j0BP5E/bC2TPiN5Zu7gkgN4NbiAcmO/yaioOo3ZmlRl9L1rSipkxxlj4qDj6J
         IX/RLqc1bmBOF5NN4MFa80hVwMVzyNyS/ePcbSvqaclCtBZTaTVv+5KQ7fwpOVxfBKXZ
         +I+A==
X-Gm-Message-State: APzg51DoH0yS58BpZC26QuEaBsN/8ODqc3q/Y4z8VmK3BVkxrVpQxMTO
        MRqp7zlVtJDZt8QCVfuzvyKaM7bnjkB2mw==
X-Google-Smtp-Source: ANB0VdatYXZXDWsQpEzdMECDa0EUeet6tFFM4B2DMD/FkXDpmp0AiocIunNtqqk/c8fVO/LxACpCig==
X-Received: by 2002:a6b:5505:: with SMTP id j5-v6mr17789795iob.106.1537107039217;
        Sun, 16 Sep 2018 07:10:39 -0700 (PDT)
Received: from [10.199.96.233] ([209.82.80.116])
        by smtp.googlemail.com with ESMTPSA id w196-v6sm2168199itb.9.2018.09.16.07.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 07:10:38 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware
 driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
 <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
Date:   Sun, 16 Sep 2018 15:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few minor Nits...

I remember asking about this in the last review!

On 04/09/18 10:52, Nava kishore Manne wrote:
> This patch adds zynqmp nvmem firmware driver to access the
> SoC revision information from the hardware register.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> new file mode 100644
> index 0000000..e377900
> --- /dev/null
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +#define SILICON_REVISION_MASK 0xF
> +
> +static int zynqmp_nvmem_read(void *context, unsigned int offset,
> +			     void *val, size_t bytes)
> +{
> +	int ret;
> +	int idcode, version;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_chipid)
> +		return -ENXIO;
> +
> +	ret = eemi_ops->get_chipid(&idcode, &version);
> +	if (ret < 0)
> +		return ret;
> +
> +	pr_debug("Read chipid val %x %x\n", idcode, version);
> +	*(int *)val = version & SILICON_REVISION_MASK;

Use dev_dbg here.
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config econfig = {
> +	.name = "zynqmp-nvmem",
> +	.owner = THIS_MODULE,
> +	.word_size = 1,
> +	.size = 1,
> +	.read_only = true,
> +};
> +
> +static const struct of_device_id zynqmp_nvmem_match[] = {
> +	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
> +
> +static int zynqmp_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem;
> +
> +	econfig.dev = &pdev->dev;
> +	econfig.reg_read = zynqmp_nvmem_read;
> +
> +	nvmem = nvmem_register(&econfig);
You can use devm_ variant and remove the zynqmp_nvmem_remove() totally

> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
> +	platform_set_drvdata(pdev, nvmem);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_nvmem_remove(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> +
> +	return nvmem_unregister(nvmem);
> +}
> +
