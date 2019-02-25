Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfBYOh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:37:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBYOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:37:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9044F26048B
Subject: Re: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        rdunlap@infradead.org, ncrews@chromium.org, bleung@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
References: <20190225135405.108052-1-cychiang@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <82fe83ba-b967-66ee-1299-1cd98072089a@collabora.com>
Date:   Mon, 25 Feb 2019 15:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225135405.108052-1-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/2/19 14:54, Cheng-Yi Chiang wrote:
> SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
> Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
> warning.
> 
> Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)

Reported-by: Randy Dunlap <rdunlap@infradead.org>

> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
Enric

> ---
>  sound/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 8f206cb4fcc0..75ceb04d8bf0 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -98,7 +98,7 @@ config SND_SOC_MSM8996
>  
>  config SND_SOC_SDM845
>  	tristate "SoC Machine driver for SDM845 boards"
> -	depends on QCOM_APR
> +	depends on QCOM_APR && MFD_CROS_EC
>  	select SND_SOC_QDSP6
>  	select SND_SOC_QCOM_COMMON
>  	select SND_SOC_RT5663
> 
