Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZquP2b6Xsm1Iv83rg2BMqzOsPG8SWfD3MSANvO/Xc6SIZmxNvW2bZE025blBz1vnDf23ELE
ARC-Seal: i=1; a=rsa-sha256; t=1525852560; cv=none;
        d=google.com; s=arc-20160816;
        b=ZHHDhRlnbflgPbHkvV05RnDe+m00R8tnm4OJrPvysyBVnw4yPr2nOIDVwDwCWyZJw1
         7xCTthRpV+yJFIGrTDkzHPSkFef8NGRxOmrI3vPAYX1+qGNO4i1Rpd2tckS8FQYb3+Zk
         8adjHG69MyJ5DL7W0emfdEqglQg0C7dw6q4qTMLMbxXV1EExs6yX1HwhOxhefKEIq5Mw
         Pj/xsnX0RixaD8U7Niz8HEClgKO9sd32ur9KpZN/7wVpujcff42yibrBoSR/BdXZ24wX
         aHsUwxlbPbNiLatW4l7vWfuHua8u6HaJFmDNL93lUlKAXw9PQ7+Vlv6aPkiQ62xfMMPD
         HkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=qN+mX0wLMlxrlVmq6Ow2AQmJFuqJsnta+fs4KLSc6y4=;
        b=NbsUF7VBsOliALWaej23gYOoQfW3BCHCCMOaXM0eKOvyGyOtQaY+/3v9UEQvkW5NQG
         /rNzKjXEXnimTyKDH0QIkR0alnq1JLqUAjc1kEoAwmmAbJC7S0a8Bk2EyNZ6BjNvZtan
         /v+txuCufFnYojEw0+YnF/xQwf8TOQepbUBV2JYRIAJ6RcJvYSHBHRQQJ+XeW3GqkGHt
         tpzB3+D/YIHC+GQYN54n8IV9/RWp1SVWXBVc3bhb+LDz7xmu1IAQrV6j+UqDm+IxKBdf
         jlKWVkWwyZRmW2cPrMipVKJNwhYUzcr3G3sLg1mkSW9Fr+WxYVukjJl0Lx+SXlgdp8Z4
         Sn1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=N0KrAKVU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvJ8Yjuu;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=N0KrAKVU;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvJ8Yjuu;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27B516022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 13/24] ASoC: qdsp6: q6adm: Add q6adm driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-14-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
Date: Wed, 9 May 2018 00:55:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-14-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263623773893739?=
X-GMAIL-MSGID: =?utf-8?q?1599972375223395198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to Q6ADM (Audio Device Manager) module in
> q6dsp. ADM performs routing between audio streams and AFE ports.
> It does Rate matching for streams going to devices driven by
> different clocks, it handles volume ramping, Mixing with channel
> and bit-width. ADM creates and destroys dynamic COPP services
> for device-related audio processing as needed.
>
> This patch adds basic support to ADM.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6adm.c  | 636 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6adm.h  |  25 ++
>   4 files changed, 666 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index bb0a2afb0563..971127edbc23 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -50,12 +50,16 @@ config SND_SOC_QDSP6_CORE
>   config SND_SOC_QDSP6_AFE
>   	tristate
<snip>
> +}
> +
> +static int q6adm_callback(struct apr_device *adev, struct apr_resp_pkt *data)
> +{
> +	struct aprv2_ibasic_rsp_result_t *result = data->payload;
> +	int port_idx, copp_idx;
> +	struct apr_hdr *hdr = &data->hdr;
> +	struct q6copp *copp;
> +	struct q6adm *adm = dev_get_drvdata(&adev->dev);
> +
> +	if (!data->payload_size)
> +		return 0;
> +
> +
> +	copp_idx = (hdr->token) & 0XFF;
> +	port_idx = ((hdr->token) >> 16) & 0xFF;
> +	if (port_idx < 0 || port_idx >= AFE_MAX_PORTS) {
> +		dev_err(&adev->dev, "Invalid port idx %d token %d\n",
> +		       port_idx, hdr->token);
> +		return 0;
> +	}
> +	if (copp_idx < 0 || copp_idx >= MAX_COPPS_PER_PORT) {
> +		dev_err(&adev->dev, "Invalid copp idx %d token %d\n",
> +			copp_idx, hdr->token);
> +		return 0;
> +	}
> +
> +	switch (hdr->opcode) {
> +	case APR_BASIC_RSP_RESULT: {
> +		if (result->status != 0) {
> +			dev_err(&adev->dev, "cmd = 0x%x return error = 0x%x\n",
> +				result->opcode, result->status);
> +		}
> +		switch (result->opcode) {
> +		case ADM_CMD_DEVICE_OPEN_V5:
> +		case ADM_CMD_DEVICE_CLOSE_V5:
> +			copp = adm_find_copp(adm, port_idx, copp_idx);
> +			if (!copp)
> +				return 0;
> +
> +			copp->result = *result;
> +			wake_up(&copp->wait);
> +			break;
> +		case ADM_CMD_MATRIX_MAP_ROUTINGS_V5:
> +			adm->result = *result;
> +			wake_up(&adm->matrix_map_wait);
> +			break;
> +
> +		default:
> +			dev_err(&adev->dev, "Unknown Cmd: 0x%x\n",
> +				result->opcode);
> +			break;
> +		}
> +		return 0;
> +	}
> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {
> +		struct adm_cmd_rsp_device_open_v5 {
> +			u32 status;
> +			u16 copp_id;
> +			u16 reserved;
> +		} __packed * open = data->payload;
> +
> +		open = data->payload;
Isn't this repetition of previous line from struct definition?


> +
> +	return c;
> +}
> +
> +static int q6adm_apr_send_copp_pkt(struct q6adm *adm, struct q6copp *copp,
> +				   struct apr_pkt *pkt, uint32_t rsp_opcode)
> +{
> +	struct device *dev = adm->dev;
> +	uint32_t opcode = pkt->hdr.opcode;
> +	int ret;
> +
> +	mutex_lock(&adm->lock);
> +	copp->result.opcode = 0;
> +	copp->result.status = 0;
> +	ret = apr_send_pkt(adm->apr, pkt);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to send APR packet\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* Wait for the callback with copp id */
> +	if (rsp_opcode)
> +		ret = wait_event_timeout(copp->wait,
> +					 (copp->result.opcode == opcode) ||
> +					 (copp->result.opcode == rsp_opcode),
> +					 msecs_to_jiffies(TIMEOUT_MS));
> +	else
> +		ret = wait_event_timeout(copp->wait,
> +					 (copp->result.opcode == opcode),
> +					 msecs_to_jiffies(TIMEOUT_MS));
> +
> +	if (!ret) {
> +		dev_err(dev, "ADM copp cmd timedout\n");
> +		ret = -EINVAL;
ret = -ETIMEDOUT;

> +	} else if (copp->result.status > 0) {
> +		dev_err(dev, "DSP returned error[%d]\n",
> +			copp->result.status);
> +		ret = -EINVAL;
> +	}
> +
> +err:
> +	mutex_unlock(&adm->lock);
> +	return ret;
> +}
> +
> +static int q6adm_device_close(struct q6adm *adm, struct q6copp *copp,
> +			      int port_id, int copp_idx)
> +{
> +	struct apr_pkt close;
> +
> +	close.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +					APR_HDR_LEN(APR_HDR_SIZE),
> +					APR_PKT_VER);
> +	close.hdr.pkt_size = sizeof(close);
> +	close.hdr.src_port = port_id;
> +	close.hdr.dest_port = copp->id;
> +	close.hdr.token = port_id << 16 | copp_idx;
> +	close.hdr.opcode = ADM_CMD_DEVICE_CLOSE_V5;
> +
> +	return q6adm_apr_send_copp_pkt(adm, copp, &close, 0);
> +}
> +
> +static void adm_free_copp(struct kref *ref)
> +{
> +	struct q6copp *c = container_of(ref, struct q6copp, refcount);
> +	struct q6adm *adm = c->adm;
> +	int port_idx = c->afe_port;
> +	int copp_idx = c->copp_idx;
> +	unsigned long flags;
> +	int ret;
> +
> +	ret = q6adm_device_close(adm, c, port_idx, copp_idx);
> +	if (ret < 0)
> +		dev_err(adm->dev, "Failed to close copp %d\n", ret);
> +
> +	clear_bit(c->copp_idx, &adm->copp_bitmap[port_idx]);
> +	spin_lock_irqsave(&adm->copps_list_lock, flags);
> +	list_del(&c->node);
> +	spin_unlock_irqrestore(&adm->copps_list_lock, flags);
> +	kfree(c);
> +}
> +
> +static struct q6copp *adm_find_matching_copp(struct q6adm *adm,
> +					   int port_id, int topology,
> +					   int mode, int rate, int channel_mode,
> +					   int bit_width, int app_type)
> +{
> +	unsigned long flags;
> +	struct q6copp *c;
> +
> +	spin_lock_irqsave(&adm->copps_list_lock, flags);
> +
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_id == c->afe_port) && (topology == c->topology) &&
> +		    (mode == c->mode) && (rate == c->rate) &&
> +		    (bit_width == c->bit_width) && (app_type == c->app_type)) {
> +			spin_unlock_irqrestore(&adm->copps_list_lock, flags);
> +			kref_get(&c->refcount);
> +			return c;
> +		}
> +	}
> +	spin_unlock_irqrestore(&adm->copps_list_lock, flags);
> +
> +	c = adm_alloc_copp(adm, port_id);
> +	if (IS_ERR_OR_NULL(c))
> +		return ERR_CAST(c);
> +
> +	kref_init(&c->refcount);
> +	c->topology = topology;
> +	c->mode = mode;
> +	c->rate = rate;
> +	c->channels = channel_mode;
> +	c->bit_width = bit_width;
> +	c->app_type = app_type;
> +
> +	spin_lock_irqsave(&adm->copps_list_lock, flags);
> +	list_add_tail(&c->node, &adm->copps_list);
> +	spin_unlock_irqrestore(&adm->copps_list_lock, flags);
> +
> +	return c;
> +
Remove extra blank line at end of function.

> +}
> +
> +static int q6adm_device_open(struct q6adm *adm, struct q6copp *copp,
> +			     int port_id, int path, int topology,
> +			     int channel_mode, int bit_width, int rate)
<snip>
> +
> +/**
> + * q6adm_matrix_map() - Map asm streams and afe ports using payload
> + *
> + * @dev: Pointer to adm child device.
> + * @path: playback or capture path.
> + * @payload_map: map between session id and afe ports.
> + * @perf_mode: Performace mode.
> + *
> + * Return: Will be an negative on error or a zero on success.
> + */
> +int q6adm_matrix_map(struct device *dev, int path,
> +		     struct route_payload payload_map, int perf_mode)
> +{
> +	struct q6adm *adm = dev_get_drvdata(dev->parent);
> +	struct q6adm_cmd_matrix_map_routings_v5 *route;
> +	struct q6adm_session_map_node_v5 *node;
> +	struct apr_pkt *pkt;
> +	uint16_t *copps_list;
> +	int pkt_size, ret, i, copp_idx;
> +	void *matrix_map = NULL;
> +	struct q6copp *copp;
> +
> +	/* Assumes port_ids have already been validated during adm_open */
> +	pkt_size = (APR_HDR_SIZE + sizeof(*route) +  sizeof(*node) +
> +		    (sizeof(uint32_t) * payload_map.num_copps));
> +
> +	matrix_map = kzalloc(pkt_size, GFP_KERNEL);
> +	if (!matrix_map)
> +		return -ENOMEM;
> +
> +	pkt = matrix_map;
> +	route = matrix_map + APR_HDR_SIZE;
> +	node = matrix_map + APR_HDR_SIZE + sizeof(*route);
> +	copps_list = matrix_map + APR_HDR_SIZE + sizeof(*route) + sizeof(*node);
> +
> +	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +					   APR_HDR_LEN(APR_HDR_SIZE),
> +					   APR_PKT_VER);
> +	pkt->hdr.pkt_size = pkt_size;
> +	pkt->hdr.token = 0;
> +	pkt->hdr.opcode = ADM_CMD_MATRIX_MAP_ROUTINGS_V5;
> +	route->num_sessions = 1;
> +
> +	switch (path) {
> +	case ADM_PATH_PLAYBACK:
> +		route->matrix_id = ADM_MATRIX_ID_AUDIO_RX;
> +		break;
> +	case ADM_PATH_LIVE_REC:
> +		route->matrix_id = ADM_MATRIX_ID_AUDIO_TX;
> +		break;
> +	default:
> +		dev_err(dev, "Wrong path set[%d]\n", path);
> +		break;
> +	}
> +
> +	node->session_id = payload_map.session_id;
> +	node->num_copps = payload_map.num_copps;
> +
> +	for (i = 0; i < payload_map.num_copps; i++) {
> +		int port_idx = payload_map.port_id[i];
> +
> +		if (port_idx < 0) {
> +			dev_err(dev, "Invalid port_id 0x%x\n",
> +				payload_map.port_id[i]);
> +			kfree(pkt);
> +			return -EINVAL;
> +		}
> +		copp_idx = payload_map.copp_idx[i];
> +
> +		copp = adm_find_copp(adm, port_idx, copp_idx);
> +		if (!copp) {
> +			kfree(pkt);
> +			return -EINVAL;
> +		}
> +
> +		copps_list[i] = copp->id;
> +	}
> +
> +	mutex_lock(&adm->lock);
> +	adm->result.status = 0;
> +	adm->result.opcode = 0;
> +
> +	ret = apr_send_pkt(adm->apr, pkt);
> +	if (ret < 0) {
> +		dev_err(dev, "routing for syream %d failed ret %d\n",

"stream" typo


> +		       payload_map.session_id, ret);
> +		goto fail_cmd;
> +	}
> +	ret = wait_event_timeout(adm->matrix_map_wait,
> +				 adm->result.opcode == pkt->hdr.opcode,
> +				 msecs_to_jiffies(TIMEOUT_MS));
> +	if (!ret) {
> +		dev_err(dev, "routing for stream %d failed\n",
> +		       payload_map.session_id);
> +		ret = -ETIMEDOUT;
> +		goto fail_cmd;
> +	} else if (adm->result.status > 0) {
> +		dev_err(dev, "DSP returned error[%d]\n",
> +			adm->result.status);
> +		ret = -EINVAL;
> +		goto fail_cmd;
> +	}
> +
> +fail_cmd:
> +	mutex_unlock(&adm->lock);
> +	kfree(pkt);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(q6adm_matrix_map);
> +
> +/**
> + * q6adm_close() - Close adm copp
> + *
> + * @dev: Pointer to adm child device.
> + * @port_id: afe port id.
> + * @perf_mode: perf_mode mode
> + * @copp_idx: copp index to close
> + *
> + * Return: Will be an negative on error or a zero on success.
> + */
> +int q6adm_close(struct device *dev, int port_id, int perf_mode, int copp_idx)
perf_mode unused param. Remove for now. Can be added back when needed.

Otherwise LGTM.
Once fixed above, add acked-by
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
