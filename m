Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3204C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F052145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggnoXW65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F052145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbeKVHU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:20:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40161 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVHU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:20:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so4971166lfe.7;
        Wed, 21 Nov 2018 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XoLzKOMYMpvhfX9iLjV1f8bylSNS2Gb+5zk9Yy13474=;
        b=ggnoXW65X2rPBJWLPbsDWh1UvQy4k1PO3FNRaMQTXsX9CrZ0jfDa5kpLxsFMFxwNiy
         hT4T4kNbYRQgrKtKtdmme+FNoCiKDE5nhxFhczlQhsN+kBIYcm+isjB9X12GR2Z+vGzm
         X37498OgtRrrr4zlj9FH4XoZAkZuAvxCEGQ5rCZH0b6ffxVbB9ZxYsygkFDX7kzXmlxe
         F4VEuPjpGMJFHhmxyTRe2eoOiLWUJTjKt5rQfgm0numBA5IRhpvLqUBiVgdxU79LdKCa
         gUyiaG9WA6Halwzb+ShDYz7lxQg+s6ObUMfiDHsX6cxA6lIgjQAZ8U4xCojV5mGsROp0
         gK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XoLzKOMYMpvhfX9iLjV1f8bylSNS2Gb+5zk9Yy13474=;
        b=XtfCwSKTpCp/uCf6vWfWjjW0qaUcruEb+FPRJjQT8eT8VWrWsgof3rk3MF+8ip0AiP
         oNlo6+dFDc0HMdN3HgZP6wKc+ELYsqb8G4oTK4jAKziKXVlCy60hNGvdAffkwxxetXnO
         7c7QZV0lwCj8T3Zk+GREU2hdZwBOqbolJOwal45nmf5PU82y7ujda5BNqs/ItDYVKWIp
         Ol0U18+WfGkWdPu5/UfSn3LfF7/QROLF/DqYuMVdxQyStl0xmkLa9quIlPHHCSwLzge7
         HuM148YlY3kTVdemqPd/Z6vSj/RNPXjpxiYHuXz1Rs6V0o3OKVoZhTVvX9f1ZZDwKryR
         Y4hg==
X-Gm-Message-State: AGRZ1gJeXh7613+vJca0OZ/UAHrqVBKdUdEeNWmoRc3ckTmOg5Jhpwah
        S9q6ERof7eQhuN8Wp+FQnkhN3fB1
X-Google-Smtp-Source: AJdET5cJBViKFFPRiWKS1sW6vsDOVIRh5QKqYDtUNuaLoQUS/kFqqE1EkUT7RnThBfvTiXBk/uohaA==
X-Received: by 2002:a19:d78c:: with SMTP id q12mr4602050lfi.27.1542833101582;
        Wed, 21 Nov 2018 12:45:01 -0800 (PST)
Received: from [192.168.1.18] (dma88.neoplus.adsl.tpnet.pl. [83.24.56.88])
        by smtp.gmail.com with ESMTPSA id r29-v6sm6303381ljd.44.2018.11.21.12.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:45:00 -0800 (PST)
Subject: Re: [PATCH] leds: powernv: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, pavel@ucw.cz,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20181121123138.21870-1-tiny.windzz@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <82ef58c4-1d18-9dd6-71ec-42f799370f33@gmail.com>
Date:   Wed, 21 Nov 2018 21:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121123138.21870-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

Thank you for the patch.

On 11/21/2018 01:31 PM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller.bl_idle_init()
> doesn't do that, so fix it.

s/bl_idle_init/powernv_led_probe/

I suppose that you adopted the commit message from a fix
for drivers/cpuidle/cpuidle-big_little.c.

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/leds/leds-powernv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> index b1adbd70ce2e..0b1540029034 100644
> --- a/drivers/leds/leds-powernv.c
> +++ b/drivers/leds/leds-powernv.c
> @@ -285,6 +285,7 @@ static int powernv_led_probe(struct platform_device *pdev)
>  	struct device_node *led_node;
>  	struct powernv_led_common *powernv_led_common;
>  	struct device *dev = &pdev->dev;
> +	int rc;
>  
>  	led_node = of_find_node_by_path("/ibm,opal/leds");
>  	if (!led_node) {
> @@ -295,15 +296,20 @@ static int powernv_led_probe(struct platform_device *pdev)
>  
>  	powernv_led_common = devm_kzalloc(dev, sizeof(*powernv_led_common),
>  					  GFP_KERNEL);
> -	if (!powernv_led_common)
> -		return -ENOMEM;
> +	if (!powernv_led_common){

missing space:

s/){/) {/

> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
>  	mutex_init(&powernv_led_common->lock);
>  	powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>  
>  	platform_set_drvdata(pdev, powernv_led_common);
>  
> -	return powernv_led_classdev(pdev, led_node, powernv_led_common);
> +	rc = powernv_led_classdev(pdev, led_node, powernv_led_common);
> +out:
> +	of_node_put(led_node);
> +	return rc;
>  }
>  
>  /* Platform driver remove */
> 

I've fixed those trivial problems and applied the patch
to the for-next branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
