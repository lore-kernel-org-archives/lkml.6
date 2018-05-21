Return-Path: <vkoul@kernel.org>
X-Google-Smtp-Source: AB8JxZq14zGVxgqzkdc+FVLsT98avQO37srvH9qr0T8ppcWGUYsdp1f9Pdds39iSKCmLRA2q/FKm
ARC-Seal: i=1; a=rsa-sha256; t=1526902399; cv=none;
        d=google.com; s=arc-20160816;
        b=CqOw3aGxz15E4+vpzgGwaQ3ccrRvCSq6DwQ7WW+OCUOVb+NOgeGGyxvqOsmDEXu3rT
         1v5E6XYn1GirLY4NCKgJ3LFkYcokMi52gQgxdtKB6ifs/Lr38TxcwwAuQXj9QAGMXCwj
         +4IgM+6nR4dD6pjoWRNGoEhuN9R61xzZisrqhL6WY3hPaB4x+OP3Jl7tIQUZP7tsIRfs
         ZuaJqEISmPHeSZ8gqOxMDNiu95L7UzEvksiJGYs0vIO895zxd96Cq9ypk1mvILf1OeNF
         gFqPA2Ig0ZW08ZPkFQkETUSJ5C8sNNp5ehrSXU14zLS2WSm6PlPGz/ZSTaoG90I/sLpe
         nTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MIc25OFHAcFp641OgJ7BTXRVKtJIwZbXwBbmmMZ/sdI=;
        b=GaXXkXcpSg0hv+4h/EnDyWLdQOT2gcsS+vUAYyVGr1s/zLvyKG6CPlHGcyTZQgUQ2w
         CnIWnvsDKXu5YzwKhiLB+gHWz1rtcDYi863nnfIG8fPHOqNUcxzy4lOxXzjYBP9W9eaU
         oTmg6ZF3Ness2CkdEgib2TUO6MkbGqXiqDCEiyIfKA1j5Uk6NGhoS8/akPCMBRIp6oiH
         gmJzlSXOa/es38KWhJl93Y+esS7Xro4aWfSHMDcrhDzfxjAPjwF3vgWzx4Dr8ttv56ys
         Mu7lEajTtAuMJqLu+Oz9qrH/8GgHpHZo4+1E7MCQcKObOq/iIawBQ9v3VMV/eDZF3Bj0
         10WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RD8wZt4G;
       spf=pass (google.com: domain of vkoul@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=vkoul@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RD8wZt4G;
       spf=pass (google.com: domain of vkoul@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=vkoul@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 21 May 2018 17:03:14 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, kramasub@codeaurora.org,
	sdharia@quicinc.com, girishm@quicinc.com,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	bgoswami@codeaurora.org, devicetree@vger.kernel.org,
	broonie@kernel.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] slimbus: ngd: Add qcom SLIMBus NGD driver
Message-ID: <20180521113314.GC14654@vkoul-mobl>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516165118.16551-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640410451742727?=
X-GMAIL-MSGID: =?utf-8?q?1601073210653849994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16-05-18, 17:51, Srinivas Kandagatla wrote:
> This patch adds suppor to Qualcomm SLIMBus Non-Generic Device (NGD)

/s/suppor/support

> +/* NGD (Non-ported Generic Device) registers */
> +#define	NGD_CFG			0x0
> +#define	NGD_CFG_ENABLE		BIT(0)
> +#define	NGD_CFG_RX_MSGQ_EN	BIT(1)
> +#define	NGD_CFG_TX_MSGQ_EN	BIT(2)
> +#define	NGD_STATUS		0x4
> +#define NGD_LADDR		BIT(1)
> +#define	NGD_RX_MSGQ_CFG		0x8
> +#define	NGD_INT_EN		0x10
> +#define	NGD_INT_RECFG_DONE	BIT(24)
> +#define	NGD_INT_TX_NACKED_2	BIT(25)
> +#define	NGD_INT_MSG_BUF_CONTE	BIT(26)
> +#define	NGD_INT_MSG_TX_INVAL	BIT(27)
> +#define	NGD_INT_IE_VE_CHG	BIT(28)
> +#define	NGD_INT_DEV_ERR		BIT(29)
> +#define	NGD_INT_RX_MSG_RCVD	BIT(30)
> +#define	NGD_INT_TX_MSG_SENT	BIT(31)
> +#define	NGD_INT_STAT		0x14
> +#define	NGD_INT_CLR		0x18
> +#define DEF_NGD_INT_MASK (NGD_INT_TX_NACKED_2 | NGD_INT_MSG_BUF_CONTE | \
> +				NGD_INT_MSG_TX_INVAL | NGD_INT_IE_VE_CHG | \
> +				NGD_INT_DEV_ERR | NGD_INT_TX_MSG_SENT | \
> +				NGD_INT_RX_MSG_RCVD)
> +
> +/* Slimbus QMI service */
> +#define SLIMBUS_QMI_SVC_ID 0x0301
> +#define SLIMBUS_QMI_SVC_V1 1
> +#define SLIMBUS_QMI_INS_ID 0
> +#define SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01 0x0020
> +#define SLIMBUS_QMI_SELECT_INSTANCE_RESP_V01 0x0020
> +#define SLIMBUS_QMI_POWER_REQ_V01 0x0021
> +#define SLIMBUS_QMI_POWER_RESP_V01 0x0021
> +#define SLIMBUS_QMI_CHECK_FRAMER_STATUS_REQ 0x0022
> +#define SLIMBUS_QMI_CHECK_FRAMER_STATUS_RESP 0x0022
> +#define SLIMBUS_QMI_POWER_REQ_MAX_MSG_LEN 14
> +#define SLIMBUS_QMI_POWER_RESP_MAX_MSG_LEN 7
> +#define SLIMBUS_QMI_SELECT_INSTANCE_REQ_MAX_MSG_LEN 14
> +#define SLIMBUS_QMI_SELECT_INSTANCE_RESP_MAX_MSG_LEN 7
> +#define SLIMBUS_QMI_CHECK_FRAMER_STAT_RESP_MAX_MSG_LEN 7
> +/* QMI response timeout of 500ms */
> +#define SLIMBUS_QMI_RESP_TOUT 1000

Tabs or spaces, take your pick and use one, not both...

> +static void qcom_slim_qmi_power_resp_cb(struct qmi_handle *handle,
> +					struct sockaddr_qrtr *sq,
> +					struct qmi_txn *txn, const void *data)
> +{
> +	struct slimbus_power_resp_msg_v01 *resp;
> +
> +	resp = (struct slimbus_power_resp_msg_v01 *)data;

you dont need cast away from void

> +	if (resp->resp.result != QMI_RESULT_SUCCESS_V01)
> +		pr_err("%s: QMI power request failed 0x%x\n", __func__,
> +				resp->resp.result);

cant we use dev_err?

> +static int qcom_slim_qmi_send_power_request(struct qcom_slim_ngd_ctrl *ctrl,
> +				struct slimbus_power_req_msg_v01 *req)
> +{
> +	struct slimbus_power_resp_msg_v01 resp = { { 0, 0 } };
> +	struct qmi_txn txn;
> +	int rc;
> +
> +	rc = qmi_txn_init(ctrl->qmi.handle, &txn,
> +				slimbus_power_resp_msg_v01_ei, &resp);
> +
> +	rc = qmi_send_request(ctrl->qmi.handle, NULL, &txn,
> +				SLIMBUS_QMI_POWER_REQ_V01,
> +				SLIMBUS_QMI_POWER_REQ_MAX_MSG_LEN,
> +				slimbus_power_req_msg_v01_ei, req);
> +	if (rc < 0) {
> +		dev_err(ctrl->dev, "%s: QMI send req fail %d\n", __func__, rc);
> +		qmi_txn_cancel(&txn);
> +	}
> +
> +	if (rc < 0)
> +		return rc;

why not add this is prev error check?

> +static int qcom_slim_qmi_init(struct qcom_slim_ngd_ctrl *ctrl,
> +			      bool apps_is_master)
> +{
> +	int rc = 0;

superfluous init

> +static u32 *qcom_slim_ngd_tx_msg_get(struct qcom_slim_ngd_ctrl *ctrl, int len,
> +				     struct completion *comp)
> +{
> +	struct qcom_slim_ngd_dma_desc *desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctrl->tx_buf_lock, flags);
> +
> +	if ((ctrl->tx_tail + 1) % QCOM_SLIM_NGD_DESC_NUM == ctrl->tx_head) {
> +		spin_unlock_irqrestore(&ctrl->tx_buf_lock, flags);
> +		return NULL;
> +	}
> +	desc  = &ctrl->txdesc[ctrl->tx_tail];
> +	desc->base = (u32 *)((u8 *)ctrl->tx_base +
> +				(ctrl->tx_tail * SLIM_MSGQ_BUF_LEN));

too many casts

> +static int qcom_slim_ngd_post_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
> +{
> +	struct qcom_slim_ngd_dma_desc *desc;
> +	struct dma_slave_config conf = {
> +		.direction = DMA_DEV_TO_MEM,
> +	};
> +	int ret, i;
> +
> +	ret = dmaengine_slave_config(ctrl->dma_rx_channel, &conf);

so you are only setting direction for conf, not any other parameters? If not why
bother setting direction

> +	if (ret)
> +		dev_err(ctrl->dev, "Error Configuring rx dma\n");
> +
> +	for (i = 0; i < QCOM_SLIM_NGD_DESC_NUM; i++) {
> +		desc = &ctrl->rx_desc[i];
> +		desc->phys = ctrl->rx_phys_base + i * SLIM_MSGQ_BUF_LEN;
> +		desc->ctrl = ctrl;
> +		desc->base = ctrl->rx_base + i * SLIM_MSGQ_BUF_LEN;
> +		desc->desc = dmaengine_prep_slave_single(ctrl->dma_rx_channel,
> +						desc->phys, SLIM_MSGQ_BUF_LEN,
> +						DMA_DEV_TO_MEM,
> +						DMA_PREP_INTERRUPT);

why issue multiple slave_single to dmaengine, you can bundle them and issue
dmaengine_prep_slave_sg().. 

> +static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_qmi *qmi)
> +{
> +	int ret = 0;

superfluous init here too

> +static int qcom_slim_ngd_runtime_idle(struct device *dev)
> +{
> +	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->state == QCOM_SLIM_NGD_CTRL_AWAKE)
> +		ctrl->state = QCOM_SLIM_NGD_CTRL_IDLE;
> +	pm_request_autosuspend(dev);
> +	return -EAGAIN;
> +}
> +
> +

double empty lines, here
-- 
~Vinod
