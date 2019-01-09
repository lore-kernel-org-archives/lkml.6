Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E66C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2A20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfAIJdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:33:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42532 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfAIJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:33:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so6703664edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+d9BGL8FVIKODB6bUlmZfwVugvKfJ4ytA7V3AsdLAVs=;
        b=VoOiq0KtHaCuQyRsOTceLtkmH4om75y45npgj36lgzRbjobyuOwZ635k7fvZSYuPeI
         xPwK+U5K8gQHmX5FNhsyZWjYXOmNDo1KSs76mQ7wE1JJS9DpviOZXAB2bEHY+p3dvSmv
         CS4RTHpaUCQCYavpQkhJLPeYmdLlIOrd0eQ3u8JnlkzshjD1YkrGQZhYjMHirRNqBgma
         aH0txv9qgBzfJDt66D3lUvjIuJVvwtvqhaAKzDHDhbPIs9Ba2zvav4usK2Jdvwepspaf
         J20aQWyQIiscAnLP/Kr3+YtXOcyzDZryn3tUt55kYk7njC+Y6RlDbZ4c8N1Qi/CBCD5S
         Mfrw==
X-Gm-Message-State: AJcUukceG6SAGujZkV6R/Ddb3O1IPDPJBQ2L+7K5JA52/4fXAo4UKSls
        p7NATuCt5N8yKIkeU6pxvTm+Jg==
X-Google-Smtp-Source: ALg8bN5unfccJpLcS2IfdZcysgre3IL8vL4+CyFwrvVe3IMPMOcxQa2wuluO6GWjzLhHYA9jUgTf8g==
X-Received: by 2002:a17:906:f108:: with SMTP id gv8-v6mr4835784ejb.173.1547026419902;
        Wed, 09 Jan 2019 01:33:39 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z2sm1029357edd.4.2019.01.09.01.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:33:39 -0800 (PST)
Subject: Re: [PATCH -next] ASoC: Intel: bytcht_es8316: Set correct platform
 drvdata in snd_byt_cht_es8316_mc_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <20190109092924.GB1743@kadam>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
Date:   Wed, 9 Jan 2019 10:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109092924.GB1743@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-01-19 10:29, Dan Carpenter wrote:
> I think the correct fix is actually this (untested):

Right, I'm pretty sure the soc framework depends on dev_get_drvdata
returning the snd_soc_card and I forgot about this when adding
the remove function.

Wei Yongjun, thank you for catching this.

Dan, thank you for the correct version of the patch :)

Dan, can you do an official submission of the correct version of the
patch, with a Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
or shall I submit your version upstream ?

Regards,

Hans


> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index cdf2061e7613..fa9c4cf97686 100644
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
