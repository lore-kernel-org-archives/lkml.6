Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75B52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfAJHUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:20:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46937 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfAJHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:20:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so9311842edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04sXTkd6sRKOSgeR2c47cKAb3i4QE3PSZS9p6K8aZA0=;
        b=WgNjnY+r8uvY1YqB2xDN5zae9zdXwhAz4eImPkPpYrtMQ4ldSvMjlZ7NSRbGYTY/ck
         g5e9Hsq7PbRXSkP7ZCU7uxYZFWLMQNlZxFXMcMyteXXlNqSiDb8rPNBsmIypOIW1tDFq
         6bLVByQPza9ieyyIVMF9jDRsuK2nwieObI3Ig97/2Oop9okyHZV5Y9n4plwstrufOqeh
         hb9EM0Y+Dj+VK6JlHGN32aPh2ZCfJR3ABuvIZJNX45dThY6rBb6g4emu+snsr6doc+3x
         JA1oMiJE05bLOwF4mOAPvgfL+xqHNOyepj+SzeMUBPfd4b/74crtxti0kivlsruNyNpa
         r6HQ==
X-Gm-Message-State: AJcUukcWTFqmI37i5T+97WjwOS+3MmGHQAPjvaa2GtY29FcOVQCGth/E
        4Ty7lp70K7EHKvq0E6VL6cA6aQ==
X-Google-Smtp-Source: ALg8bN7ALasDseIg0yj7Q8C9sGnPPHpXFEI13KtijQB3C3Slsb6lnWCqvET/KUkxcQj9hGXDW9/60Q==
X-Received: by 2002:a17:906:430f:: with SMTP id j15-v6mr7725191ejm.224.1547104807924;
        Wed, 09 Jan 2019 23:20:07 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r8-v6sm1286930ejb.52.2019.01.09.23.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 23:20:07 -0800 (PST)
Subject: Re: [PATCH -next v2] ASoC: Intel: bytcht_es8316: use correct drvdata
 in snd_byt_cht_es8316_mc_remove()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7d35c9d9-f244-d010-68e9-e68d58331172@redhat.com>
Date:   Thu, 10 Jan 2019 08:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-01-19 02:43, Wei Yongjun wrote:
> The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
> of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe()
> set it to 'struct snd_soc_card', as suggested by Dan Carpenter, fix
> the usage in snd_byt_cht_es8316_mc_remove().
> 
> Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thank you for catching this, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> v1 -> v2: fix snd_byt_cht_es8316_mc_remove() instead, suggested by Dan.
> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index cdf2061..fa9c4cf 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   
>   static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
>   {
> -	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
>   
>   	gpiod_put(priv->speaker_en_gpio);
>   	return 0;
> 
> 
> 
