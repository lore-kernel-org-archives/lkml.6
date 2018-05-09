Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpzdTstHHPjuUuGBT4oUB4QRGx4s/rvmwQpEIIaVx1pheoC4Nbq2fLbHPnu47tZQoU2bZEe
ARC-Seal: i=1; a=rsa-sha256; t=1525836083; cv=none;
        d=google.com; s=arc-20160816;
        b=QA3ug9uTgK7hxws+RBCYKM4kdqBE8FmTvDgnKVWy84PuChGYyQCrUDG1sPVBG2rtaF
         4GBFZr+iBXeh2+5wXqjkelwmmCUKhi/UcJGNQfqonNAJ3O5No1mc/4Tvzy4GxdjFfmdP
         GFfbtni/phfXIHmMs73Sf2DypIn6SEyFRbL/Es7831DskRI2Y60XVSLQ63lKQImlWWq4
         JGRePIJ7D9ENY1cPKNnLED6qdvts7o9T/Mz4urgkvw/JYxgElzyx7e8wNH5bCcheYJT+
         /F/SJH31WNC8ZAv3Zo6qEW4pknjd+wNpzKO2pPxAYg+s80p57rD+L2miuBe2jMhc2wVe
         tjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=0Axx7rSXtlttJOfsettbpvzSBheC43QmUqZogv5EwGI=;
        b=JLnJBDT8OtDBD6YqZNIVA+u4twNOwF/DnoEizQ6yEQgboupfUpjqCZYnDFS0Xvz0iB
         lXdwt+7dBvwwUdkGb/rYAywdsWvo2XeipGpMwYUs4uHuj42lFsQI2uNZC6AMgvn3nU2I
         J9sntEM8ZP+6D83dNX6qy4ZkBlA4X6dhAUwe108SFucCWLy4tPEJeClkVN8K+yEdW+n+
         R4MfSYgH0E837ffNTaP5Pbhu4R4isMcdVX5TW3LEM9yXz+3j2zSQM52dC4jugVd04MPk
         JOKZzNvvqImJOMMeJn/qHEveriZfqQROjS2+aNrB1NZ1oqMybinegqgI+YlP2bDUtZkZ
         RjIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pNEmGYCw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eqGkuqYi;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pNEmGYCw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eqGkuqYi;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82F076019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 11/24] ASoC: qdsp6: q6afe: Add support to MI2S ports
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-12-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
Date: Tue, 8 May 2018 20:21:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-12-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263620627617198?=
X-GMAIL-MSGID: =?utf-8?q?1599955096962708938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to 4 MI2S ports on LPASS.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 224 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h |  13 +++
>   2 files changed, 237 insertions(+)
>
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index be55b3ab045f..ceb18aaa5af4 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -14,6 +14,10 @@
>   #include <linux/spinlock.h>
>   #include <linux/delay.h>
>   #include <linux/soc/qcom/apr.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include <sound/pcm.h>
<snip>

>   union afe_port_config {
>   	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
>   	struct afe_param_id_slimbus_cfg           slim_cfg;
> +	struct afe_param_id_i2s_cfg	i2s_cfg;
>   } __packed;
>   
>   struct q6afe_port {
> @@ -210,6 +264,22 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>   				SLIMBUS_4_RX, 1, 1},
>   	[SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
>   				SLIMBUS_5_RX, 1, 1},
> +	[QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
> +				QUATERNARY_MI2S_RX, 1, 1},
> +	[QUATERNARY_MI2S_TX] = { AFE_PORT_ID_QUATERNARY_MI2S_TX,
> +				QUATERNARY_MI2S_TX, 0, 1},
> +	[SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
> +				SECONDARY_MI2S_RX, 1, 1},
> +	[SECONDARY_MI2S_TX] = { AFE_PORT_ID_SECONDARY_MI2S_TX,
> +				SECONDARY_MI2S_TX, 0, 1},
> +	[TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
> +				TERTIARY_MI2S_RX, 1, 1},
> +	[TERTIARY_MI2S_TX] = { AFE_PORT_ID_TERTIARY_MI2S_TX,
> +				TERTIARY_MI2S_TX, 0, 1},
> +	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
> +				PRIMARY_MI2S_RX, 1, 1},
> +	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
> +				PRIMARY_MI2S_RX, 0, 1},
Can these be added after SLIMBUS_6_RX?
Also, for better arrangement, please add the port_maps from 
PRIMARY_MI2S_RX to QUATERNARY_MI2S_TX in the same sequence of definition 
of AFE ports.
Otherwise LGTM.
Once fixed the above comment add-
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
