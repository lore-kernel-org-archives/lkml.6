Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A457F2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A457F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756941AbeFSKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:08:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5206 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755946AbeFSKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:08:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b28d5ee0000>; Tue, 19 Jun 2018 03:07:42 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Jun 2018 03:08:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Jun 2018 03:08:08 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Jun
 2018 10:08:01 +0000
Subject: Re: [PATCH v3] usb: xhci: remove the code build warning
To:     Dongjiu Geng <gengdongjiu@huawei.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <thierry.reding@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180617023018.7952-1-gengdongjiu@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <44d08036-c147-ea05-90af-47e0836a0f0b@nvidia.com>
Date:   Tue, 19 Jun 2018 11:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617023018.7952-1-gengdongjiu@huawei.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/06/18 03:30, Dongjiu Geng wrote:
> Initialize the 'err' variate to remove the build warning,
> the warning is shown as below:
> 
> drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
> drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
> drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> change since v1:
> 1. Add 'Acked-by: Thierry Reding <treding@nvidia.com>'
> 
> How to reproduce:
> 1. make defconfig ARCH=arm
> 2. make -j100 CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm
> 
> Then you can see below warnings:
> drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
> drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
> drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here
> ---
>  drivers/usb/host/xhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index a8c1d07..d50549f 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -481,7 +481,7 @@ static void tegra_xusb_mbox_handle(struct tegra_xusb *tegra,
>  	unsigned long mask;
>  	unsigned int port;
>  	bool idle, enable;
> -	int err;
> +	int err = 0;
>  
>  	memset(&rsp, 0, sizeof(rsp));

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
