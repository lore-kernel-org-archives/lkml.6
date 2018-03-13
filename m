Return-Path: <rohitkr@codeaurora.org>
X-Google-Smtp-Source: AG47ELson2KkH2KzOkchL0vNJ19cPNMR/7DZ6BG8S9Q5C2SScm4CnNoHEZLpYNHkbI1i3prKBFXc
ARC-Seal: i=1; a=rsa-sha256; t=1520940580; cv=none;
        d=google.com; s=arc-20160816;
        b=trAhokOPwnyowV6G7f+9WebOxAZMgfzp3j3FJwig6pLRUoih9aJa5mu2rVHgfu54PF
         GVchlzwSgdXQue58xYbkIxSljfLfo82ULyLnxw4PTjuWI62vRrSt2sgUJRLRhvCFp2o/
         zXV57qr01O5U07ZJ4z7hqLelbWctdF4c4aFiZkuraEdEUAP3aktgf0K3rEJMRPD/WcK9
         bAU+j1ATRk0X6OW4T2Zm8skz0T78cdZhPUgEPy2tKzVEee2qlSR3ogVadW6u3xWWfaqW
         dxkj+GxzbfdT/zFSoWxKUd9M+gw2nLqmK+FUggasupekY7oSGDtgixR/uFiWDV2CnJgq
         6fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=T5PQ6REEUduGnoR1cNEG0VyhRQ5FUTF41Yn+3v5Lgl4=;
        b=M0EE2M3xyesQp5LuUquWmv6TgtSmfW4FTF1fBFemiM8xZYmh7iuep3XIlOA876D3Pd
         vMnVVA9DHACzPVpoRCrByRLGD6lrGFu/8zF3YPPG2An6i+QubeRmUwKnJppnsA+ctN/t
         buuwYyLeQA0VVOOF8MceBptU8fCroZRB62ock+oEjQcAu1kmLi+q3NfVQDZjqH6BzsG1
         GOT78/rHbCvFwopo4ML5T7HxcqjmUKMZRW+2rN9kCoJqNj+ehsBdgt5JgmnSG058ki1G
         gDKttmKMqXaOoVtKZROwLadmfw13oTQmFFJoZJg/g1PA9C83viY40MO1caAQWG7/T1Xy
         HM1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cfDQZSVL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hNtOawPt;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cfDQZSVL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hNtOawPt;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA76260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 07/24] ASoC: qdsp6: q6afe: Add q6afe
 driver
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
 gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com,
 tiwai@suse.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
Date: Tue, 13 Mar 2018 16:59:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515911539130697?=
X-GMAIL-MSGID: =?utf-8?q?1594821790191467357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>
[..]
> +		if (res->status) {
> +			dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
> +				res->opcode, res->status);
> +		}
> +		switch (res->opcode) {
> +		case AFE_PORT_CMD_SET_PARAM_V2:
> +		case AFE_PORT_CMD_DEVICE_STOP:
> +		case AFE_PORT_CMD_DEVICE_START:

case AFE_SVC_CMD_SET_PARAM: needs to be added
> +			port = afe_find_port(afe, data->token);
> +			if (port) {
> +				port->result = *res;
> +				wake_up(&port->wait);
> +			}
[..]
> +
> +static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
> +				   int param_id, int psize)
> +{
> +	struct apr_hdr *hdr;
> +	struct afe_port_cmd_set_param_v2 *param;
> +	struct afe_port_param_data_v2 *pdata;
> +	struct q6afe *afe = port->afe;
> +	u16 port_id = port->id;
> +	int ret;
> +
> +	hdr = data;
> +	param = data + sizeof(*hdr);
> +	pdata = data + sizeof(*hdr) + sizeof(*param);
> +
> +	hdr->hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +					      APR_HDR_LEN(APR_HDR_SIZE),
> +					      APR_PKT_VER);
> +	hdr->pkt_size = sizeof(*hdr) + sizeof(*param) +
> +			sizeof(*pdata) + psize;
> +	hdr->src_port = 0;
> +	hdr->dest_port = 0;
> +	hdr->token = port->token;
> +	hdr->opcode = AFE_PORT_CMD_SET_PARAM_V2;
> +	param->port_id = port_id;
> +	param->payload_size = sizeof(*pdata) + psize;
> +	param->payload_address_lsw = 0x00;
> +	param->payload_address_msw = 0x00;
> +	param->mem_map_handle = 0x00;
> +	pdata->module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
> +	pdata->param_id = param_id;
> +	pdata->param_size = psize;
> +
> +	ret = afe_apr_send_pkt(afe, data, port);
> +	if (ret)
> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",

we should add %s to distinguish different functions with similar error 
logs. Also, q6afe_port_set_param_v2() can be called for different 
purpose.  AFE enable for port 0x%x failed is suitable only for port 
start failure. Error message needs to be updated here.

> +		       port_id, ret);
> +
> +
> +	return ret;
> +}
> +
