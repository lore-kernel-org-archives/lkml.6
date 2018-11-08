Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C3ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006372081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hewHlj9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006372081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeKHXcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:32:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKHXcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:32:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so1286530wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=txjLiC+aP0bfqYgIiLa2T0PzpbJf/2RzYY9B6yfgCa0=;
        b=hewHlj9sOOqbOmbqUFqHH6JTl+AETb3ckpklNLzw12/qCzBwv2D+8QabOZBwpXcQdb
         SnZgAzHEs0jJ5ieFVVb7no8UvvVFBCGwDrOSlFwRGVuPbmid54vU+zzwuv5gXmZDjpWU
         Qa/sr7ZO+oAnXgyzIXPAtrJbp91yXQs37lrZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txjLiC+aP0bfqYgIiLa2T0PzpbJf/2RzYY9B6yfgCa0=;
        b=uK4QGjoY2NGXCQf0r2vIKGm9ZWPzcTtCu/zUvD3X68N1+0QOcd3Fm24h3cUPbk9gKb
         8yPz0HVWVMepP5/X3aB6kZpiHNrdb1KhgMKkLPW9849d4UU2oURMGKgeZohatklIs7Lp
         AwJyEvzWPiS6Kxyyhb0CUSpVBPuaylSnj5ikvqKTfJJ7O+KiYHrjrV1uVKJRHEu0HogQ
         +F7sZivi0qfCdzLjelvKsQq54nRQUlH+KtRT5q3iTQwLlMqPHHExlFXeNCqWt+HYJFst
         xF/IrAvT1L9RGHFVdMKKm1dvHCOg3MiKMLBEnirhsN1SNJO91CKIJkG31NNTf+VqI/Nf
         OzBA==
X-Gm-Message-State: AGRZ1gKbD5Cx5eO0sD/cpSnT9jTWcN3d7gysGU2yn7/g2L94aHTxn/v9
        Hd/5dLjRhKBkyZzQKKIhyByJBQ==
X-Google-Smtp-Source: AJdET5d/zgpePGRu97qPpnUVbpgQw7E0nzSAp4dUJHkJ9QDjjdTCPL2j7dFrjFKJCVOjRPMXl4S0mg==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr1323708wmf.143.1541685397466;
        Thu, 08 Nov 2018 05:56:37 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w11-v6sm3831363wrr.96.2018.11.08.05.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:56:36 -0800 (PST)
Subject: Re: [PATCH] ASoC: qcom: Set dai_link id to each dai_link
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
References: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9eb276ed-5b4c-9926-a885-2cfd08d4d126@linaro.org>
Date:   Thu, 8 Nov 2018 13:56:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

On 08/11/18 13:41, Rohit kumar wrote:
> Frontend dai_link id is used for closing ADM sessions.
> During concurrent usecase when one session is closed,
> it closes other ADM session associated with other usecase
> too. Dai_link->id should always point to Frontend dai id.
> Set cpu_dai id as dai_link id to fix the issue.
> 
Nice catch! thanks for fixing this!

> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/common.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index eb1b9da..4715527 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -13,6 +13,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   	struct device_node *cpu = NULL;
>   	struct device *dev = card->dev;
>   	struct snd_soc_dai_link *link;
> +	struct of_phandle_args args;
>   	int ret, num_links;
>   
>   	ret = snd_soc_of_parse_card_name(card, "model");
> @@ -47,12 +48,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   			goto err;
>   		}
>   
> -		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> -		if (!link->cpu_of_node) {
> +		ret = of_parse_phandle_with_args(cpu, "sound-dai",
> +					"#sound-dai-cells", 0, &args);
> +		if (ret) {
>   			dev_err(card->dev, "error getting cpu phandle\n");
> -			ret = -EINVAL;
>   			goto err;
>   		}
> +		link->cpu_of_node = args.np;
> +		link->id = args.args[0];
>   
>   		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
>   		if (ret) {
> 
