Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB214C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3FC2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3FC2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeGEKyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:54:18 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:48738 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753454AbeGEKyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:54:17 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id DFF406C0055;
        Thu,  5 Jul 2018 10:54:15 +0000 (UTC)
Received: from [10.17.20.62] (10.17.20.62) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Thu, 5 Jul
 2018 11:54:10 +0100
Subject: Re: [PATCH 3/3] net: ethernet: sfc: Make subdir logic consistent with
 other vendors
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Bert Kenward <bkenward@solarflare.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180704115013.28078-1-geert+renesas@glider.be>
 <20180704115013.28078-4-geert+renesas@glider.be>
From:   Martin Habets <mhabets@solarflare.com>
Message-ID: <ff513ddb-562f-6244-0560-7c7c80648b31@solarflare.com>
Date:   Thu, 5 Jul 2018 11:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180704115013.28078-4-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.62]
X-ClientProxiedBy: ukex01.SolarFlarecom.com (10.17.10.4) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-11.0.0.1191-8.100.1062-23948.003
X-TM-AS-Result: No--7.290200-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MDID: 1530788056-HDhsCyD2woDs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/07/18 12:50, Geert Uytterhoeven wrote:
> Both SFC and SFC_FALCON depend on NET_VENDOR_SOLARFLARE, hence use the
> latter to decide whether to descend into the sfc subdirectory.
> Move the rule to descend into sfc/falcon to the sfc subdirectory.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Martin Habets <mhabets@solarflare.com>

> ---
>  drivers/net/ethernet/Makefile     | 3 +--
>  drivers/net/ethernet/sfc/Makefile | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index 0c3ab7efff8c9ddb..22555e7fa752c67e 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -80,8 +80,7 @@ obj-$(CONFIG_NET_VENDOR_SAMSUNG) += samsung/
>  obj-$(CONFIG_NET_VENDOR_SEEQ) += seeq/
>  obj-$(CONFIG_NET_VENDOR_SILAN) += silan/
>  obj-$(CONFIG_NET_VENDOR_SIS) += sis/
> -obj-$(CONFIG_SFC) += sfc/
> -obj-$(CONFIG_SFC_FALCON) += sfc/falcon/
> +obj-$(CONFIG_NET_VENDOR_SOLARFLARE) += sfc/
>  obj-$(CONFIG_NET_VENDOR_SGI) += sgi/
>  obj-$(CONFIG_NET_VENDOR_SMSC) += smsc/
>  obj-$(CONFIG_NET_VENDOR_SOCIONEXT) += socionext/
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 3bac58d0f88b20f8..c5c297e78d068f41 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -6,3 +6,5 @@ sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>  sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o siena_sriov.o ef10_sriov.o
>  
>  obj-$(CONFIG_SFC)	+= sfc.o
> +
> +obj-$(CONFIG_SFC_FALCON) += falcon/
> 
