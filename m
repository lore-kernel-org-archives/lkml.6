Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C835206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+dsZPC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C835206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeKSTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:50:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44953 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbeKSTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:50:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so14289907plq.11;
        Mon, 19 Nov 2018 01:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nHgLj3H6aplFrMy9lAcygR0tn1NgIPoUeUueftYeCIA=;
        b=V+dsZPC47gYFTvBGhAyO3f39A1nYjQvaI35+YbLge3YSzSzH6P7zOl7BKisWAV6Iuo
         4oL5ylwzsbuUd3wn076uS1F1t6o7vIR3rBY8fL1P02igy3ionki0aUCXDvU7kj/DqTJ8
         +6RiQf3Jop6gZq7+A46MromUwG5RG/pQ+GveRvjZUoKDbn5LqtmeT6mAL6vAonYR9rgs
         JFsIPT+ZCyfxVG2FzaF2L41EaDITTxKe9sn0YnxUj+OFYXkl6Qc5ZhI2eTRNSIbBzzyr
         eWPvHXWs2dRZSjP26cusBI7gH8gd5/Quax5EcI25nFowRieBYlnQ/0QPnEym3Uj2r/L1
         tC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nHgLj3H6aplFrMy9lAcygR0tn1NgIPoUeUueftYeCIA=;
        b=SOQAbMPnnrqCV7CscumO71LsjcrNbQoEUbt1rj1DBkpbjSPek+XhpLz65Uwtcdk2H5
         wgO3mXh6Ws6hLb762oujgCqXYOBVgUhWzcAYAYBzf93VxM6fg6mogKvHvbPeAPGjFcuO
         gC13Ib/Ts9hs7HoQAhZW+iScAplz/te25ZyqvCmIF7+y0FfONA/t24D72N9zaPuidomf
         73CwWLQQO8pW1ytm41+mny5/WTJj8ShklA2dyXzZtVGHgDXEFNBqFGCLwwck9DByEjmz
         knkk20s6Vt0NHgXREnl18lxC/0JOjq65553ImlsDKL7qOr2ghWlK0nGhEZHEkAj5nFxT
         jZYQ==
X-Gm-Message-State: AA+aEWY2qIhtGRyBEcm+pUm+7l67AU69TDR0gb9KOymULlQbBbNTeBwU
        tMC+pTxUNPMjajTHX87g7H4=
X-Google-Smtp-Source: AFSGD/WCrMqJiOWTSm2LlcaJexhQRdhZyqIEP88mHOQfR2jiXOn/0RI4IlGqEh1YWpiMtmjZPK90fA==
X-Received: by 2002:a17:902:8d8f:: with SMTP id v15-v6mr7853645plo.98.1542619617479;
        Mon, 19 Nov 2018 01:26:57 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id z127-v6sm55437060pfz.135.2018.11.19.01.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 01:26:56 -0800 (PST)
Subject: Re: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
To:     CK Hu <ck.hu@mediatek.com>, matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        airlied@linux.ie, mturquette@baylibre.com, sboyd@codeaurora.org,
        ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
Date:   Mon, 19 Nov 2018 10:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542605939.32082.12.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2018 06:38, CK Hu wrote:
> Hi, Matthias:
> 
> On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> It can happen that the mmsys clock drivers aren't probed before the
>> platform driver gets invoked. The platform driver used to print a warning
>> that the driver failed to get the clocks. Omit this error on
>> the defered probe path.
> 
> This patch looks good to me, but you have not modified the sub driver in
> HDMI path. We could let HDMI path print the warning and someone send
> another patch later, or you modify for HDMI path in this patch.

Sure, I'll add this in v6. After inspecting the code, I think we will need to
also check for not initialized clocks in mtk_mdp_comp_init, as the driver for
now does not even check if the clocks are present. What do you think?

I'll address the coding style issue you metioned below as well.

Regards,
Matthias

>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 4 +++-
>>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 4 +++-
>>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c  | 4 +++-
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c    | 3 ++-
>>  drivers/gpu/drm/mediatek/mtk_dsi.c        | 6 ++++--
>>  5 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
>> index f609b62b8be6..1ea3178d4c18 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
>> @@ -126,7 +126,9 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
>>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>>  				&mtk_disp_color_funcs);
>>  	if (ret) {
>> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to initialize component: %d\n",
>> +					ret);
> 
> I would like one more blank line here.
> 
>>  		return ret;
>>  	}
>>  
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> index 28d191192945..5ebbcaa4e70e 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> @@ -293,7 +293,9 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>>  				&mtk_disp_ovl_funcs);
>>  	if (ret) {
>> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to initialize component: %d\n",
>> +					ret);
> 
> I would like to align to the right of '('.
> 
> Regards,
> CK
> 
>>  		return ret;
>>  	}
>>  
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> index b0a5cffe345a..59a08ed5fea5 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> @@ -295,7 +295,9 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>>  				&mtk_disp_rdma_funcs);
>>  	if (ret) {
>> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to initialize component: %d\n",
>> +					ret);
>>  		return ret;
>>  	}
>>  
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
>> index b06cd9d4b525..b76a2d071a97 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
>> @@ -566,7 +566,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>>  
>>  	ddp->clk = devm_clk_get(dev, NULL);
>>  	if (IS_ERR(ddp->clk)) {
>> -		dev_err(dev, "Failed to get clock\n");
>> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to get clock\n");
>>  		return PTR_ERR(ddp->clk);
>>  	}
>>  
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 90109a0d6fff..cc6de75636c3 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -1103,14 +1103,16 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>>  	if (IS_ERR(dsi->engine_clk)) {
>>  		ret = PTR_ERR(dsi->engine_clk);
>> -		dev_err(dev, "Failed to get engine clock: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to get engine clock: %d\n", ret);
>>  		return ret;
>>  	}
>>  
>>  	dsi->digital_clk = devm_clk_get(dev, "digital");
>>  	if (IS_ERR(dsi->digital_clk)) {
>>  		ret = PTR_ERR(dsi->digital_clk);
>> -		dev_err(dev, "Failed to get digital clock: %d\n", ret);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to get digital clock: %d\n", ret);
>>  		return ret;
>>  	}
>>  
> 
> 
