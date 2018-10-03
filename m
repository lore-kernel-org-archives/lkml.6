Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E605520835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qn76F6Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E605520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJCPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:13:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11132 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:13:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb47d150000>; Wed, 03 Oct 2018 01:25:57 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Oct 2018 01:26:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Oct 2018 01:26:20 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 08:26:18 +0000
Subject: Re: [PATCH] firmware: tegra-bpmp: mark PM function as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Timo Alho <talho@nvidia.com>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181002212208.2971433-1-arnd@arndb.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <64a99db8-85e4-52ab-d0fa-0faa5bb7187a@nvidia.com>
Date:   Wed, 3 Oct 2018 09:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002212208.2971433-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538555157; bh=ZMEWr59Y7Mq8Vp712UNm9Fdc/Y9U+Eu4aQZBqEh4ydg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qn76F6FoQbUDHfZHzzbscjErPL6Xa45AiKLB42u66bpQjvAxjq9vHuKTX0Aa0zHwS
         HKRq5Nbsn8vaTxjMZQNHU6PG7DTgt7UmlstPoC8ofoHTcVh6hTyGkSARGGSjXD9Bb1
         1hm2tg8x0j9kLZtHUvKHupUNXFV7Ygy+aZd9GAW5l7YXRv3vvxUXrBG/GvroQkkeUv
         QdJ3nGatuaH3dup5ZjZ7r4UuhgvXOTwNvEaTiFI0mKm3mrJIbbhES+f06aS+WGjxWM
         m0+dCPWeBgkQUwLDYQ6a9CE/KJTgziVJwnh8JLDP4R1YpVJWUtrXYzT/WypaUO4Tpo
         DYsBWohO71OFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/10/18 22:21, Arnd Bergmann wrote:
> The newly added tegra_bpmp_resume function is unused when CONFIG_PM
> is disabled:
> 
> drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume' defined but not used [-Werror=unused-function]
>  static int tegra_bpmp_resume(struct device *dev)
> 
> Mark it as __maybe_unused to avoid the warning and let the compiler
> drop it silently.
> 
> Fixes: cd40f6ff124c ("firmware: tegra: bpmp: Implement suspend/resume support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/tegra/bpmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> index 41448ba78be9..a3d5b518c10e 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -844,7 +844,7 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int tegra_bpmp_resume(struct device *dev)
> +static int __maybe_unused tegra_bpmp_resume(struct device *dev)
>  {
>  	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
>  	unsigned int i;

Arnd, is this seen with 32-bit ARM configs?

Timo, does it make sense to make BPMP dependent on ARCH_TEGRA_186_SOC
and ARCH_TEGRA_194_SOC instead of just ARCH_TEGRA? For 64-bit Tegra we
have a dependency on PM so this should not be seen for 64-bit Tegra.

Cheers
Jon

-- 
nvpublic
