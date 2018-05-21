Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526903753; cv=none;
        d=google.com; s=arc-20160816;
        b=kVepOsS+X5jFWahVTyMWTyMu6ZulA3b3lFj5ke4KfEJrK/X5fqnUcCto75eGlS6+qM
         6RbOups+uZOu5Rl1i9pcHjjgAUp4Cx+HlJJETZk7UvDk/DHaaZPZekAyQ7Fmw4q8OAxD
         CKj5O9cH5XScGBMiq1Icc9G/t+OIspMyXtmnaB0AznslTlMqXYzTIgxKGwjulBUEaGRE
         Mfri+TKiarUkORuxOaKTmS6C6B7C93EXL6GWYN0XA7qAnVNI8sbQRye4EFRgM2wHAG5g
         tsm4jNDFjjtQ5ZjhClmMPrCjb6FpW3u8GT6ZEL0Yf9ZIO972c/mrQ3QsRNskXSYkB+EK
         hdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=P+IvVOG0nobarRYvo2X+vy/DzUoremIPg5ep6Cc2/3E=;
        b=TkyKPzgT5mEMiIvQyWkb84Habo0ijp68zY6+aVLyBhYv8/3Cs0GC3Dsufmr/K66kWw
         8DdkjxbhVQIllayG+XkoV3+gI9lSU10pBLTEX0D9vx/sp2zFffywkR8cPb7VGE+ebMlA
         YLyG2RyEBLu/o/7om8086NjnXNR7OFXuXYp3vGpF2ez3/T4G7af6MqL9HPOpFfuP/xvt
         JnvXCkzv3JV+M2omqtYGF8bkTnLn7QEd8r0GbI601GAOWcSgfD26vBWNjb8ocSh5TlCU
         EIrDa4tAn9GRMNZ8HdY78YYydtbzO49ARkU1cazBwJ+raDu/2X/7Pa87en70w/Q3c8pY
         uUMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D06PNA+C;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D06PNA+C;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqmpC2gimUmO5APzgKINilluOvkgPhyJMH8sESlMGYwpqD3K2N3Gw7d/qZE9QjCjc4dPAJsNg==
Subject: Re: [PATCH 2/2] slimbus: ngd: Add qcom SLIMBus NGD driver
To: Vinod <vkoul@kernel.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, kramasub@codeaurora.org,
 sdharia@quicinc.com, girishm@quicinc.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-3-srinivas.kandagatla@linaro.org>
 <20180521113314.GC14654@vkoul-mobl>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b29bf75f-4846-ef73-b1da-509b62488944@linaro.org>
Date: Mon, 21 May 2018 12:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180521113314.GC14654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640410451742727?=
X-GMAIL-MSGID: =?utf-8?q?1601074630132294634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Vinod for the review!

On 21/05/18 12:33, Vinod wrote:
> On 16-05-18, 17:51, Srinivas Kandagatla wrote:
>> This patch adds suppor to Qualcomm SLIMBus Non-Generic Device (NGD)
> 
> /s/suppor/support
> 
Yep, Will fix this in next version.

>> +/* NGD (Non-ported Generic Device) registers */
>> +#define	NGD_CFG			0x0
>> +#define	NGD_CFG_ENABLE		BIT(0)
>> +#define	NGD_CFG_RX_MSGQ_EN	BIT(1)
>> +#define	NGD_CFG_TX_MSGQ_EN	BIT(2)
>> +#define	NGD_STATUS		0x4
>> +#define NGD_LADDR		BIT(1)
>> +#define	NGD_RX_MSGQ_CFG		0x8
>> +#define	NGD_INT_EN		0x10
>> +#define SLIMBUS_QMI_POWER_RESP_MAX_MSG_LEN 7
>> +#define SLIMBUS_QMI_SELECT_INSTANCE_REQ_MAX_MSG_LEN 14
>> +#define SLIMBUS_QMI_SELECT_INSTANCE_RESP_MAX_MSG_LEN 7
>> +#define SLIMBUS_QMI_CHECK_FRAMER_STAT_RESP_MAX_MSG_LEN 7
>> +/* QMI response timeout of 500ms */
>> +#define SLIMBUS_QMI_RESP_TOUT 1000
> 
> Tabs or spaces, take your pick and use one, not both...
I will check for such instances once again before sending v2.

> 
>> +static void qcom_slim_qmi_power_resp_cb(struct qmi_handle *handle,
>> +					struct sockaddr_qrtr *sq,
>> +					struct qmi_txn *txn, const void *data)
>> +{
>> +	struct slimbus_power_resp_msg_v01 *resp;
>> +
>> +	resp = (struct slimbus_power_resp_msg_v01 *)data;
> 
> you dont need cast away from void
It's a const void * so the compiler keeps complaining about this without 
cast.

> 
>> +	if (resp->resp.result != QMI_RESULT_SUCCESS_V01)
>> +		pr_err("%s: QMI power request failed 0x%x\n", __func__,
>> +				resp->resp.result);
> 
> cant we use dev_err?
I will have a look!
> 
>> +static int qcom_slim_qmi_send_power_request(struct qcom_slim_ngd_ctrl *ctrl,
>> +				struct slimbus_power_req_msg_v01 *req)
>> +{
>> +	struct slimbus_power_resp_msg_v01 resp = { { 0, 0 } };
>> +	struct qmi_txn txn;
>> +	int rc;
>> +
>> +	rc = qmi_txn_init(ctrl->qmi.handle, &txn,
>> +				slimbus_power_resp_msg_v01_ei, &resp);
>> +
>> +	rc = qmi_send_request(ctrl->qmi.handle, NULL, &txn,
>> +				SLIMBUS_QMI_POWER_REQ_V01,
>> +				SLIMBUS_QMI_POWER_REQ_MAX_MSG_LEN,
>> +				slimbus_power_req_msg_v01_ei, req);
>> +	if (rc < 0) {
>> +		dev_err(ctrl->dev, "%s: QMI send req fail %d\n", __func__, rc);
>> +		qmi_txn_cancel(&txn);
>> +	}
>> +
>> +	if (rc < 0)
>> +		return rc;
> 
> why not add this is prev error check?
Yes, we should move this to previous check, Will fix this in v2.
> 
>> +static int qcom_slim_qmi_init(struct qcom_slim_ngd_ctrl *ctrl,
>> +			      bool apps_is_master)
>> +{
>> +	int rc = 0;
> 
> superfluous init
> 
>> +static u32 *qcom_slim_ngd_tx_msg_get(struct qcom_slim_ngd_ctrl *ctrl, int len,
>> +				     struct completion *comp)
>> +{
>> +	struct qcom_slim_ngd_dma_desc *desc;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ctrl->tx_buf_lock, flags);
>> +
>> +	if ((ctrl->tx_tail + 1) % QCOM_SLIM_NGD_DESC_NUM == ctrl->tx_head) {
>> +		spin_unlock_irqrestore(&ctrl->tx_buf_lock, flags);
>> +		return NULL;
>> +	}
>> +	desc  = &ctrl->txdesc[ctrl->tx_tail];
>> +	desc->base = (u32 *)((u8 *)ctrl->tx_base +
>> +				(ctrl->tx_tail * SLIM_MSGQ_BUF_LEN));
> 
> too many casts
> 
>> +static int qcom_slim_ngd_post_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
>> +{
>> +	struct qcom_slim_ngd_dma_desc *desc;
>> +	struct dma_slave_config conf = {
>> +		.direction = DMA_DEV_TO_MEM,
>> +	};
>> +	int ret, i;
>> +
>> +	ret = dmaengine_slave_config(ctrl->dma_rx_channel, &conf);
> 
> so you are only setting direction for conf, not any other parameters? If not why
> bother setting direction
Nice hint, I will remove this!
> 
>> +	if (ret)
>> +		dev_err(ctrl->dev, "Error Configuring rx dma\n");
>> +
>> +	for (i = 0; i < QCOM_SLIM_NGD_DESC_NUM; i++) {
>> +		desc = &ctrl->rx_desc[i];
>> +		desc->phys = ctrl->rx_phys_base + i * SLIM_MSGQ_BUF_LEN;
>> +		desc->ctrl = ctrl;
>> +		desc->base = ctrl->rx_base + i * SLIM_MSGQ_BUF_LEN;
>> +		desc->desc = dmaengine_prep_slave_single(ctrl->dma_rx_channel,
>> +						desc->phys, SLIM_MSGQ_BUF_LEN,
>> +						DMA_DEV_TO_MEM,
>> +						DMA_PREP_INTERRUPT);
> 
> why issue multiple slave_single to dmaengine, you can bundle them and issue
> dmaengine_prep_slave_sg()..
Am reusing the descriptors here, My plan is to issue multiple 
descriptors with callback for each, and in each callback queue it back.

> 
>> +static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_qmi *qmi)
>> +{
>> +	int ret = 0;
> 
> superfluous init here too
> 
Yep.
>> +static int qcom_slim_ngd_runtime_idle(struct device *dev)
>> +{
>> +	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +	if (ctrl->state == QCOM_SLIM_NGD_CTRL_AWAKE)
>> +		ctrl->state = QCOM_SLIM_NGD_CTRL_IDLE;
>> +	pm_request_autosuspend(dev);
>> +	return -EAGAIN;
>> +}
>> +
>> +
> 
> double empty lines, here
Sure, will fix this in v2.
> 

thanks,
srini
