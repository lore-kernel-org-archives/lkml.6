Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59845C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE3208DE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="odxUMXry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BE3208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeHQExR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:53:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35786 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeHQExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:53:16 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7H1ppk8002066;
        Thu, 16 Aug 2018 20:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534470711;
        bh=Zlw8linRzN/asc/p5OK+2HOSSwv6lp+H2DN8oF1pbFM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=odxUMXry5qKn292v/WWUkJjFAN3OL4Q59oWxWnDiE73aIc+CP3wDhFZYYWd8x6o6E
         suE33AAGrTkzVe6N6vIzczKrBfmqk4NW1TtWgyO7V9VKJ+RfcWkePC1jZHQoAk/+Wf
         Qhb3kHVa4/2t2+Jai/dAJuITp6p4Cz4KuR75TEdY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H1ppc7000330;
        Thu, 16 Aug 2018 20:51:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 16
 Aug 2018 20:51:51 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 16 Aug 2018 20:51:51 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H1pptb017055;
        Thu, 16 Aug 2018 20:51:51 -0500
Subject: Re: [PATCH] remoteproc/davinci: Use %zx for formating size_t
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180817004919.10805-1-bjorn.andersson@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <88c4934b-6ac8-0f15-1757-9a5152f30dd1@ti.com>
Date:   Thu, 16 Aug 2018 20:51:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817004919.10805-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 07:49 PM, Bjorn Andersson wrote:
> da8xx_rproc_mem size is of type size_t, so use %zx to format the debug
> print of it to avoid a compile warning.
> 

Thanks for the improvement,

Acked-by: Suman Anna <s-anna@ti.com>

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index e230bef71be1..d200334577f6 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -226,7 +226,7 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
>  				res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
>  		drproc->mem[i].size = resource_size(res);
>  
> -		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
> +		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %p da 0x%x\n",
>  			mem_names[i], &drproc->mem[i].bus_addr,
>  			drproc->mem[i].size, drproc->mem[i].cpu_addr,
>  			drproc->mem[i].dev_addr);
> 

