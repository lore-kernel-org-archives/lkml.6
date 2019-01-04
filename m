Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1C620665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfADIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:07:27 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbfADIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:07:27 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0485tJ9003055;
        Fri, 4 Jan 2019 09:06:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2psx6msdvx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 04 Jan 2019 09:06:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3C3631;
        Fri,  4 Jan 2019 08:06:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8FF6267B;
        Fri,  4 Jan 2019 08:06:49 +0000 (GMT)
Received: from [10.129.7.168] (10.75.127.47) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 4 Jan
 2019 09:06:48 +0100
Subject: Re: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
To:     Aditya Pakki <pakki001@umn.edu>
CC:     Alexandre Torgue <alexandre.torgue@st.com>, <kjlu@umn.edu>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181228192641.9713-1-pakki001@umn.edu>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <8412ac64-cd6d-7390-87a1-24f5e7cdf87a@st.com>
Date:   Fri, 4 Jan 2019 09:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228192641.9713-1-pakki001@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Regards

On 12/28/18 8:26 PM, Aditya Pakki wrote:
> In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
> second call is not checked for failure. This time of check to time of use
> case of "count" error is sent upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/dma/stm32-mdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 390e4cae0e1a..485dea177704 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1579,9 +1579,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>  
>  	dmadev->nr_channels = nr_channels;
>  	dmadev->nr_requests = nr_requests;
> -	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
> +	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>  				       dmadev->ahb_addr_masks,
>  				       count);
> +	if (ret)
> +		return ret;
>  	dmadev->nr_ahb_addr_masks = count;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
