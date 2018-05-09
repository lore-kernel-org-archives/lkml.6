Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrbMTY+WwYi065Ut2pYCpJ8SGGF/X2UxgoiPlzpZGL5vDbqVtwRc5ntpHXLV8XsKeafBbbs
ARC-Seal: i=1; a=rsa-sha256; t=1525856191; cv=none;
        d=google.com; s=arc-20160816;
        b=RH61hv7gluJWKghcN7fwcY5QVlV99hMk6XRzyKONTslhfPZT6jRYX58orCsnUh5Yy2
         C2ifUQPP/GM4U35t1/6xJ9XKkLiWsaSYbnlUp5uhbBlG7IfFniHp0UyE9nIODCei8g+7
         dLrToxT6tOQ+9PMrxER15g8/4+xc8Fink62dZ+7oueWDznoKX/hmQJAFG6+dZFDeYRsa
         kQ0CDDAssGUSCf6McuCRIoG5Qty8SVWmU1jVp12dzMC92JfTm3wS9Te2AZWJ1D5OLUxI
         7lZLbKTHU64BqUXKgadgIvn6bHCP/7LD/sTqsorApVrJf/jqa3geDnFIWNUN0Q+q7VfQ
         SWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=zekxLcJdyVqqkiO1mj0FAWPgSSEPqoSlvJtUgYM7wJ8=;
        b=VpThSmcHTYVMZy9F8yBN1idNqzrDI0S+tGOBidQOMWKFNRm2CIlvaw57uPmFzxV12S
         wI0g7RSIpMG1kTOm6Lm0/kFJTWcfoiju3sBA8cKqFfEj1/cWKPwmMJRM/81TttnK5jrO
         NVf1IGab5JhzYha8pgWjzOGFts5RW3p6oFshAgtwzmP9EzHYVW4JD6QDzQrnvaXBQxgQ
         0p1IdgEWpdcDT7u1n1zKIj/D7UHPwB4j5IScCC9L8p4YMbT5XiUwp5GJpYHrMUZIIuYt
         VDYuvrwndBV/8bU6hPTjFSlDXzkQ26U/SWh8WsB0+MT6S2IxVCYmx/I0Z6r0QzIQX18B
         u2cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aHOeTr7S;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jQYo79Nk;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=aHOeTr7S;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jQYo79Nk;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E502601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 17/24] ASoC: qdsp6: q6routing: Add q6routing driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-18-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <bf93d6d6-ba10-21b9-4bbe-224bb39f56f2@codeaurora.org>
Date: Wed, 9 May 2018 01:56:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-18-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263630375020957?=
X-GMAIL-MSGID: =?utf-8?q?1599976182127832390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6 routing driver which configures route
> between ASM and AFE module using ADM apis.
>
> This driver uses dapm widgets to setup the matrix between AFE ports and
> ASM streams.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6routing.c | 393 +++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6routing.h |   9 +
>   4 files changed, 407 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6routing.h
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 941774abd94f..43f9ed85efa8 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
>   config SND_SOC_QDSP6_ADM
>   	tristate
>   
> +config SND_SOC_QDSP6_ROUTING
> +	tristate
> +
>   config SND_SOC_QDSP6_ASM
>   	tristate
>   
> @@ -63,6 +66,7 @@ config SND_SOC_QDSP6
>   	select SND_SOC_QDSP6_CORE
>   	select SND_SOC_QDSP6_AFE
>   	select SND_SOC_QDSP6_ADM
> +	select SND_SOC_QDSP6_ROUTING
>   	select SND_SOC_QDSP6_ASM
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 01d9dcf3375c..0e8e2febb7ec 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -2,4 +2,5 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>   obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
> +obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> new file mode 100644
> index 000000000000..72863672f11f
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/bitops.h>
> +#include <linux/component.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <sound/control.h>
> +#include <sound/asound.h>
> +#include <sound/pcm_params.h>
> +#include "q6afe.h"
> +#include "q6asm.h"
> +#include "q6adm.h"
> +#include "q6routing.h"
> +
> +#define DRV_NAME "q6routing-component"
> +
> +struct session_data {
> +	int state;
> +	int port_id;
> +	int path_type;
> +	int app_type;
> +	int acdb_id;
> +	int sample_rate;
> +	int bits_per_sample;
> +	int channels;
> +	int perf_mode;
> +	int numcopps;
> +	int fedai_id;
> +	unsigned long copp_map;
> +};
> +
> +struct msm_routing_data {
> +	struct session_data sessions[MAX_SESSIONS];
> +	struct session_data port_data[AFE_MAX_PORTS];
> +	struct device *dev;
> +	struct mutex lock;
> +};
> +
> +static struct msm_routing_data *routing_data;
> +
> +/**
> + * q6routing_stream_open() - Register a new stream for route setup
> + *
> + * @fedai_id: Frontend dai id.
> + * @perf_mode: Performance mode.
> + * @stream_id: ASM stream id to map.
> + * @stream_type: Direction of stream
> + *
> + * Return: Will be an negative on error or a zero on success.
> + */
> +int q6routing_stream_open(int fedai_id, int perf_mode,
> +			   int stream_id, int stream_type)
> +{
> +	int j, topology, num_copps = 0;
> +	struct route_payload payload;
> +	int copp_idx;
> +	struct session_data *session, *pdata;
> +
> +	if (!routing_data) {
> +		pr_err("Routing driver not yet ready\n");
> +		return -EINVAL;
> +	}
> +
> +	session = &routing_data->sessions[stream_id - 1];
> +	pdata = &routing_data->port_data[session->port_id];
> +
> +	mutex_lock(&routing_data->lock);
> +	session->fedai_id = fedai_id;
> +
> +	session->path_type = pdata->path_type;
> +	session->sample_rate = pdata->sample_rate;
> +	session->channels = pdata->channels;
> +	session->bits_per_sample = pdata->bits_per_sample;
> +
> +	payload.num_copps = 0; /* only RX needs to use payload */
> +	topology = NULL_COPP_TOPOLOGY;
> +	copp_idx = q6adm_open(routing_data->dev, session->port_id,
> +			      session->path_type, session->sample_rate,
> +			      session->channels, topology, perf_mode,
> +			      session->bits_per_sample, 0, 0);
> +
> +	if (copp_idx < 0) {
> +		mutex_unlock(&routing_data->lock);
> +		return -EINVAL;
> +	}
> +
> +	set_bit(copp_idx, &session->copp_map);
> +
> +	for_each_set_bit(j, &session->copp_map, MAX_COPPS_PER_PORT) {
> +		payload.port_id[num_copps] = session->port_id;
> +		payload.copp_idx[num_copps] = j;
> +		num_copps++;
> +	}
> +
> +	if (num_copps) {
> +		payload.num_copps = num_copps;
> +		payload.session_id = stream_id;
> +		q6adm_matrix_map(routing_data->dev, session->path_type,
> +				 payload, perf_mode);
> +	}
> +	mutex_unlock(&routing_data->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6routing_stream_open);
> +
> +static struct session_data *get_session_from_id(struct msm_routing_data *data,
> +						int fedai_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_SESSIONS; i++) {
> +		if (fedai_id == data->sessions[i].fedai_id)
> +			return &data->sessions[i];
> +	}
> +
> +	return NULL;
> +}
> +/**
> + * q6routing_stream_close() - Deregister a stream
> + *
> + * @fedai_id: Frontend dai id.
> + * @stream_type: Direction of stream
> + *
> + * Return: Will be an negative on error or a zero on success.
> + */
> +void q6routing_stream_close(int fedai_id, int stream_type)
> +{
> +	struct session_data *session;
> +	int idx;
> +
> +	session = get_session_from_id(routing_data, fedai_id);
> +	if (!session)
> +		return;
> +
> +	for_each_set_bit(idx, &session->copp_map, MAX_COPPS_PER_PORT)
> +		q6adm_close(routing_data->dev, session->port_id,
> +			    session->perf_mode, idx);
> +
> +	session->fedai_id = -1;
> +	session->copp_map = 0;
> +}
> +EXPORT_SYMBOL_GPL(q6routing_stream_close);
> +
> +static int msm_routing_get_audio_mixer(struct snd_kcontrol *kcontrol,
> +				       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm =
> +	    snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct soc_mixer_control *mc =
> +	    (struct soc_mixer_control *)kcontrol->private_value;
> +	int session_id = mc->shift;
> +	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
> +	struct msm_routing_data *priv = dev_get_drvdata(c->dev);
> +	struct session_data *session = &priv->sessions[session_id];
> +
> +	if (session->port_id == mc->reg)
> +		ucontrol->value.integer.value[0] = 1;
> +	else
> +		ucontrol->value.integer.value[0] = 0;
> +
> +	return 0;
> +}
> +
> +static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
> +				       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm =
> +				    snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
> +	struct msm_routing_data *data = dev_get_drvdata(c->dev);
> +	struct soc_mixer_control *mc =
> +		    (struct soc_mixer_control *)kcontrol->private_value;
> +	struct snd_soc_dapm_update *update = NULL;
> +	int be_id = mc->reg;
> +	int session_id = mc->shift;
> +	struct session_data *session = &data->sessions[session_id];
> +
> +	if (ucontrol->value.integer.value[0]) {
> +		session->port_id = be_id;
> +		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
> +	} else {
> +		session->port_id = -1;
> +		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
> +	}
> +
> +	return 1;
> +}
> +
> +static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
> +	SOC_SINGLE_EXT("MultiMedia1", HDMI_RX,
> +		       MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0,
At some point in future, when FE DAI IDs become more than "31", 
SOC_DOUBLE_EXT would need to be used with "reg" marked with SND_SOC_NOPM 
and FE DAI and BE DAI IDs passed in shift_left and shift_right. This is 
to avoid having any "shift" operation issue in DAPM code, when reg is 
not marked with SND_SOC_NOPM, and shift value is more than 31.
However, for now, its OK.

Acked-by: Banajit Goswami <bgoswami@codeaurora.org

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
