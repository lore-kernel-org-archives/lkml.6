Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E49C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574821798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D574821798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeHMVNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:13:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8316 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:13:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b71ce370000>; Mon, 13 Aug 2018 11:30:15 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Aug 2018 11:30:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Aug 2018 11:30:33 -0700
Received: from [10.2.160.156] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 Aug
 2018 18:30:31 +0000
Subject: Re: [PATCH] drivers/thermal/tegra: fix a doule free devce node
To:     zhong jiang <zhongjiang@huawei.com>, <ezequiel@collabora.com>,
        <daniel.lezcano@linaro.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <312fcf2a-ab47-9aa4-3b1f-bca5f6a4d58c@nvidia.com>
Date:   Mon, 13 Aug 2018 19:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/08/18 14:40, zhong jiang wrote:
> Device node iterators will get the return node. Meawhile, It is
> also put the previous device node. An explicit put will cause
> a double put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110..3aa55c9 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -980,7 +980,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  		tcd = thermal_of_cooling_device_register(np_stcc,
>  							 (char *)name, ts,
>  							 &throt_cooling_ops);
> -		of_node_put(np_stcc);
>  		if (IS_ERR_OR_NULL(tcd)) {
>  			dev_err(dev,
>  				"throttle-cfg: %s: failed to register cooling device\n",
> 

Thanks!

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
