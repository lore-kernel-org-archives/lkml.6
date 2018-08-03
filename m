Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD6421723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD6421723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeHCKG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:06:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20871 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727680AbeHCKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:06:26 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w7389ODB022539;
        Fri, 3 Aug 2018 10:10:54 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kmhwwgect-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 03 Aug 2018 10:10:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50FF531;
        Fri,  3 Aug 2018 08:10:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE5A32802;
        Fri,  3 Aug 2018 08:10:48 +0000 (GMT)
Received: from [10.129.6.107] (10.75.127.49) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Aug
 2018 10:10:47 +0200
Subject: Re: [PATCH 17/46] dmaengine: stm32-mdma: use
 dmaenginem_async_device_register to simplify the code
To:     Huang Shijie <sjhuang@iluvatar.ai>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dave.jiang@intel.com>, <radhey.shyam.pandey@xilinx.com>,
        <appana.durga.rao@xilinx.com>, <jmkrzyszt@gmail.com>,
        <gomonovych@gmail.com>, <peter.ujfalusi@ti.com>,
        <keescook@chromium.org>, <horms+renesas@verge.net.au>,
        <geert+renesas@glider.be>, <shawnguo@kernel.org>,
        <baoyou.xie@linaro.org>, <michal.simek@xilinx.com>,
        <baohua@kernel.org>, <ludovic.desroches@microchip.com>,
        <linus.walleij@linaro.org>, <david.brown@linaro.org>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-18-sjhuang@iluvatar.ai>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <6826c0d6-5d44-631e-ff5e-d67e90a5a848@st.com>
Date:   Fri, 3 Aug 2018 10:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-18-sjhuang@iluvatar.ai>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

On 08/03/2018 09:19 AM, Huang Shijie wrote:
> Use dmaenginem_async_device_register to simplify the code:
> 	remove dma_async_device_unregister.
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  drivers/dma/stm32-mdma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 06dd1725375e..390e4cae0e1a 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1656,7 +1656,7 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = dma_async_device_register(dd);
> +	ret = dmaenginem_async_device_register(dd);
>  	if (ret)
>  		return ret;
>  
> @@ -1674,8 +1674,6 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_unregister:
> -	dma_async_device_unregister(dd);
> -
>  	return ret;
>  }
>  
> 
