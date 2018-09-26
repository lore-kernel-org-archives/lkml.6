Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C752C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7B20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OZBW4vSB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CR/U6T9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F7B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeIZPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:44:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIZPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:44:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F73360128; Wed, 26 Sep 2018 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537954322;
        bh=DPj76OluzGNOjFKHZM9PbiAyfPw9oqiwQg0MVE/QBxM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OZBW4vSBpIYzvoEVp0dbvNUsut/pEFlYJ5WroC3VF0J3MUht3JxDbnpiOr/toreSz
         dcrSx9vBE/4OcNOW6EcTdqK+HeMS3XxxSyt5kEF+wUatIG/+WYMOsmbcujThRBW2bZ
         ZLgMkAhmBNkRHArJFSS+ttHm0RY2CZwA4OfdYIdY=
Received: from [10.110.31.71] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgoswami@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 164786053C;
        Wed, 26 Sep 2018 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537954320;
        bh=DPj76OluzGNOjFKHZM9PbiAyfPw9oqiwQg0MVE/QBxM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CR/U6T9Xu1gtoSxCV9F2Vrzl70OtvKdfrP9VFcJUTjBoFlCxMAziPsFwfWlGiilBL
         d7Qg4JUv9lTrJWmMTyMUFxtKROcHmpCAgBYYt8O4nGr1Xi5m32LXcYRFLJFiEDnGCm
         c8ubhjmXCpe3corx+NuuwSkY2AhWaKEehtOh8sNA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 164786053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v4 11/14] ASoC: wcd9335: add mbhc support
To:     srinivas.kandagatla@linaro.org, lee.jones@linaro.org,
        robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
From:   Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
Date:   Wed, 26 Sep 2018 02:31:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2018 5:57 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/codecs/wcd9335.c | 268 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 266 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index efbb698..6c95cff 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c

> @@ -89,12 +90,18 @@
>   #define  CF_MIN_3DB_75HZ		0x1
>   #define  CF_MIN_3DB_150HZ		0x2
>   
> +#define WCD9335_MBHC_MAX_BUTTONS	(8)
Though MBHC HW supports button detection up to 8, we are only supporting 
4 buttons in SW, right ?

> +
>   #define WCD9335_SLIM_RX_CH(p) \
>   	{.port = p + WCD9335_RX_START, .shift = p,}
>   
>   #define WCD9335_SLIM_TX_CH(p) \
>   	{.port = p, .shift = p,}

> @@ -3988,6 +4003,131 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
>   	return ret;
>   }
>   
> +static irqreturn_t wcd9335_mbhc_sw_irq(int irq, void *data)
Are we supporting only headset and headphone detection for now ? 
Extension cable and electrical detection will be supported later ?
And how about cases for slow insertion scenarios ?

> +{
> +	struct wcd9335_codec *wcd = data;
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

