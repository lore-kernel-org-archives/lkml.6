Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgQG7b/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4D7A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeFFJQz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:16:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36567 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbeFFJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:16:54 -0400
X-Google-Smtp-Source: ADUXVKIpq/dgmMIy/1ASsZECiZV2pXD91SNV/T3NTfqw8pM1HbMSWmcyGAfdBdGN+JwlLWEyil6I0w==
Subject: Re: [PATCH] ASoC: qcom: apq8096: set card as device drvdata
To: Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <27a8b03f-a276-e3fd-7921-1fde47284237@linaro.org>
Date: Wed, 6 Jun 2018 10:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/18 09:55, Rohit kumar wrote:
> snd_soc_card is retrieved as device drvdata during unbind().
> Set it as drvdata during bind() to avoid memory corruption during
> unbind().
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Thanks for the patch,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/qcom/apq8096.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
> index 561cd42..239b8cb 100644
> --- a/sound/soc/qcom/apq8096.c
> +++ b/sound/soc/qcom/apq8096.c
> @@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
>   
>   	component_bind_all(dev, card);
>   	card->dev = dev;
> +	dev_set_drvdata(dev, card);
>   	ret = apq8096_sbc_parse_of(card);
>   	if (ret) {
>   		dev_err(dev, "Error parsing OF data\n");
> 
