Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7F21837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mp2Fbrwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D7F21837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeFURWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:22:46 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:49055 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbeFURWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:22:39 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5LHMXnA016563;
        Thu, 21 Jun 2018 12:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529601753;
        bh=Q375M+zkA37glW67dQzcyQgiyNYJp94IuMxWQGYZKeg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mp2FbrwjqmG0DI6dKpo/EvhXlXJx2gZNDXgH6MmRA8ENeXsVC2OikgwQPGSTZzykx
         dML+Z+QpMGX37weK6KLGvvAqiwXe19g2x2r7Ckd87SwmtoqlE08VrPulIS83lEfqzQ
         fbqhAhJCDFsHMFkIWF7XwphIiX73AuGInj8MrSBE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5LHMXdH010428;
        Thu, 21 Jun 2018 12:22:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 12:22:32 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 12:22:32 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5LHMW9n021940;
        Thu, 21 Jun 2018 12:22:32 -0500
Subject: Re: [PATCH] net: ethernet: ti: davinci_cpdma: make function
 cpdma_desc_pool_create static
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180621171645.29734-1-colin.king@canonical.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <187d0436-0b04-dd9e-98bd-3cb812fa8bd6@ti.com>
Date:   Thu, 21 Jun 2018 12:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621171645.29734-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, add netdev@vger.kernel.org for the future

On 06/21/2018 12:16 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function cpdma_desc_pool_create is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> warning: symbol 'cpdma_desc_pool_create' was not declared. Should it
> be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> index cdbddf16dd29..4f1267477aa4 100644
> --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> @@ -205,7 +205,7 @@ static void cpdma_desc_pool_destroy(struct cpdma_ctlr *ctlr)
>    * devices (e.g. cpsw switches) use plain old memory.  Descriptor pools
>    * abstract out these details
>    */
> -int cpdma_desc_pool_create(struct cpdma_ctlr *ctlr)
> +static int cpdma_desc_pool_create(struct cpdma_ctlr *ctlr)
>   {
>   	struct cpdma_params *cpdma_params = &ctlr->params;
>   	struct cpdma_desc_pool *pool;
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
