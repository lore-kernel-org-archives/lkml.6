Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA44C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D2217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeLRI0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:26:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39488 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbeLRI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:26:19 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBI8LJeU010259;
        Tue, 18 Dec 2018 09:26:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pcsckxt4d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Dec 2018 09:26:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B8FB38;
        Tue, 18 Dec 2018 08:26:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26CC21C45;
        Tue, 18 Dec 2018 08:26:16 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Dec
 2018 09:26:15 +0100
Subject: Re: [PATCH v2 18/19] mailbox: stm32-ipcc: Use device-managed
 registration API
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-19-thierry.reding@gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <e342d360-8b3e-f9a1-fef4-4e53b346cf5e@st.com>
Date:   Tue, 18 Dec 2018 09:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217150217.32435-19-thierry.reding@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/18 4:02 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
> 
> Cc: Fabien Dessenne <fabien.dessenne@st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>

Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

Regards,
Ludo

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mailbox/stm32-ipcc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
> index 533b0da5235d..a338bd4cd7db 100644
> --- a/drivers/mailbox/stm32-ipcc.c
> +++ b/drivers/mailbox/stm32-ipcc.c
> @@ -299,7 +299,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
>   	for (i = 0; i < ipcc->controller.num_chans; i++)
>   		ipcc->controller.chans[i].con_priv = (void *)i;
>   
> -	ret = mbox_controller_register(&ipcc->controller);
> +	ret = devm_mbox_controller_register(dev, &ipcc->controller);
>   	if (ret)
>   		goto err_irq_wkp;
>   
> @@ -329,8 +329,6 @@ static int stm32_ipcc_remove(struct platform_device *pdev)
>   {
>   	struct stm32_ipcc *ipcc = platform_get_drvdata(pdev);
>   
> -	mbox_controller_unregister(&ipcc->controller);
> -
>   	if (ipcc->wkp)
>   		dev_pm_clear_wake_irq(&pdev->dev);
>   
> 
