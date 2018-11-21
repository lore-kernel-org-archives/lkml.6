Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE70214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucoWbM+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE70214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbeKVF7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:59:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35707 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbeKVF7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:59:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id v1-v6so6862715plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qZJ3jp3lfwzcmiHGKUzerWyh35Dz9h1AnA2XoFWXho=;
        b=ucoWbM+1ZdLHn0OErslYaSq1dkaQYpr/QggG5+msqTxoYakzQE1z4mc/hXsnTl9Gb7
         fvyuuFEsH9kikiQX+xs4P9cFt7FwE9+axQTIvDSYlshKzkck2T4qEi8Z3AhHsJ6Ill96
         d4bFbC1Mc1AmRRrNGWT8TVbFu3Xky6ETMIvWcIhXMIzHdW+6tlVEW29I+9+c2+g351YM
         6kcWLwxWv2DUeF/ll/Mv89wE9AdA4ODt7EjKK7jYg5MIsRwY/usdZCJPAJdouRqlg2/7
         PrFgHXJxWfRA9R0hJXkjIMfnVoQEHK8F69UsrqLTcXjnuy0kXnjamYpos0Y4a4pk3Cp1
         1Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9qZJ3jp3lfwzcmiHGKUzerWyh35Dz9h1AnA2XoFWXho=;
        b=Nu/WXQEddFgFYAiwvvcC8qXWtXqalX4tFkR9RgnWs7kfsv55EJsz1a08ruPwvEsCc1
         Uv+jaNoqDe2/rUouIHFRs0Q4Zblgsux6ji18tyzdIM0JKmK2uogtRejhS0wXDZnvBI4p
         Of1Z8/iFMDwrV4qUQrs4cWbc7o78RHsXKg+OdXiuiI8Cg7WlKzZ/RK6vwKBvlQguO/WL
         Tt8NnR9OT/SgnTyPedAkiYnlxCMknqTJ4WI1cmdVnrJAlJN525S3K5Yi3V/8kIaLR5kA
         5EOU9AYLgk4r5fmPTQ48g5X4sPgM9eFCExCw/QGChT75ttAYHQmTqHFjxDpTISEEpKId
         e+sA==
X-Gm-Message-State: AA+aEWY1EuprOMX+fFZYYsTKPC52z2bdyLqdkxdKS8Ia9Qokm0CHdeTn
        UmEfATtwB4il/asdg59DWNINMfl4
X-Google-Smtp-Source: AFSGD/Wvp7hwCXWfIy96Vga/atC7h14gdMgg6NqOVGd3llzQcNLDPhTOLhFgO+9/B3xWxvIJwAtfLg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr7110852pgb.334.1542828234739;
        Wed, 21 Nov 2018 11:23:54 -0800 (PST)
Received: from [10.10.115.154] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id m10-v6sm111154857pfg.180.2018.11.21.11.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:23:53 -0800 (PST)
Subject: Re: [PATCH] soc: bcm: brcmstb: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, computersforpeace@gmail.com,
        gregory.0xf0@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        olof@lixom.net, treding@nvidia.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181121124342.21987-1-tiny.windzz@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <1395243f-2c08-6079-e8a8-79712179fe57@gmail.com>
Date:   Wed, 21 Nov 2018 11:23:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121124342.21987-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2018 4:43 AM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned
> by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.

You probably copied/pasted this from a prior patch, the function name is
soc_is_brcmstb() here, do you mind fixing that and also providing a
Fixes: tag?

Thanks

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/bcm/brcmstb/common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> index 14185451901d..95b777fffee6 100644
> --- a/drivers/soc/bcm/brcmstb/common.c
> +++ b/drivers/soc/bcm/brcmstb/common.c
> @@ -32,12 +32,15 @@ static const struct of_device_id brcmstb_machine_match[] = {
>  bool soc_is_brcmstb(void)
>  {
>  	struct device_node *root;
> +	bool rc;
>  
>  	root = of_find_node_by_path("/");
>  	if (!root)
>  		return false;
>  
> -	return of_match_node(brcmstb_machine_match, root) != NULL;
> +	rc = of_match_node(brcmstb_machine_match, root) != NULL;
> +	of_node_put(root);
> +	return rc;
>  }
>  
>  u32 brcmstb_get_family_id(void)
> 

-- 
Florian
