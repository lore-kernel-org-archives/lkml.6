Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E3EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB622206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g9VdCkkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB622206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeKNFCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:02:23 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9269 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:02:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5beb1fe90000>; Tue, 13 Nov 2018 11:03:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 11:02:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Nov 2018 11:02:56 -0800
Received: from [10.26.11.248] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 19:02:55 +0000
Subject: Re: [PATCH] soc/tegra: remove duplicated function declaration
To:     Bo Yan <byan@nvidia.com>, <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1542131465-22773-1-git-send-email-byan@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c57a2c48-d247-04f4-2e68-0fecca5b6260@nvidia.com>
Date:   Tue, 13 Nov 2018 19:02:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542131465-22773-1-git-send-email-byan@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542135785; bh=LMK4PEY8r0LYNaG0cV6wA0f0aqs33LQXuNpLXO6C88o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g9VdCkkfB+Bb3GSyIuDlVn5BaT6Y7ci/zfwVck4erdhiFrD2Hcyoqd08ZkTsf10M5
         h8XzyEWj8A1/H/hdGctVUX8geOBy975hwSDxLbtyiNzWwhChoz5iA25kXzuqTICoMv
         k4AOU5ATTWXvHwc7yGf4kBtbg3JipNlxLipICabCfLGneKPm30JEFDPajNB6cGkqUq
         qys4d+NBzdhbsC2ZLj9F72idzqoPE2YITPohTZvgBvyq3Yb6OLQQiT2kGXNHC+KkF9
         SzNzihgffTV97ESeghnVXnVAn/fibAzW0H6Bh8uTKFKHbahnLUYroiUJ8s9WJ+vKEY
         LuIXTj9Q6m3zQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/11/2018 17:51, Bo Yan wrote:
> The function tegra_read_chipid is declared twice in fuse.h. Remove
> the redundant declaration.
> 
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
>  include/soc/tegra/fuse.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
> index 9b6ea0c..8fb2f8a 100644
> --- a/include/soc/tegra/fuse.h
> +++ b/include/soc/tegra/fuse.h
> @@ -60,7 +60,6 @@ struct tegra_sku_info {
>  
>  u32 tegra_read_straps(void);
>  u32 tegra_read_ram_code(void);
> -u32 tegra_read_chipid(void);
>  int tegra_fuse_readl(unsigned long offset, u32 *value);
>  
>  extern struct tegra_sku_info tegra_sku_info;

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
