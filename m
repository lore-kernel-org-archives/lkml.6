Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB980217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvrVIpFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfACXfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:35:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32989 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfACXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:35:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so17382951pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LmZlOlsrLlakeGH5Baje2V9X6AzHhVLhXHJqfHs1lmk=;
        b=KvrVIpFiUIEcN8HYtPWLW0akOF9oUYm13GmNWyWPjJ4RHuvMhh8sLGsSygduhOjMZ6
         mRO9EnJeiQbEgI1VO4aUoAW8ySAmYNeLtR89QpP+lelINzs8EIG+aody5+mP+RhQjqth
         ptqrV/ZXXXsfarDWBKcm2msFNMfjIklb4UwcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LmZlOlsrLlakeGH5Baje2V9X6AzHhVLhXHJqfHs1lmk=;
        b=WeX/CNbojB7rmKJuJn2pPk3HRomwIPirHyr6JcghJrR5KYPyJF3yWIamtZmBjRUDjq
         GFNccWzYsWWRNdbBLgF+tDh+QmYaZmAcJoic0IUu1QpR+ehuZTxTf8A/YgfazN1+BVvE
         soSMmwZlnGdWuZBSEKpuUvgmRhYylMBQE465sANR6VazEWp5dom3eAxkTCaFb3fasDDc
         0xiughgD9NUJ6NrMQnadx7kSOXGf6fij9zTMsgZMwlS0qcst1vGx7P20f1+RcLziPPEV
         gp+VSOuB2W0epBSX7vt6ILTTJoQXCJG/qwL2hofOrOMw0lo54t/bs7WkUqiDSAr1FRLZ
         4uWQ==
X-Gm-Message-State: AA+aEWZ/m93zBXmgbCbmH+mSWTF4Gw/3AH0B5HAs5/n7p1NRovSkRpDg
        r8Jhe1HQKbkSI09IWBW5fO0WQA==
X-Google-Smtp-Source: AFSGD/VsKsDpC2J1/3qNSjQfA6N9bMIhC+hM0NzqrKmymm/LgnvBdUvR287uEzWdu5R2MQ+CfcQxeg==
X-Received: by 2002:a62:d005:: with SMTP id p5mr50233943pfg.175.1546558499841;
        Thu, 03 Jan 2019 15:34:59 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w10sm66880508pgi.81.2019.01.03.15.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:34:58 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:33:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v2 3/4] remoteproc: qcom: Wait for shutdown-ack/ind on
 sysmon shutdown
Message-ID: <20190103233354.GG31596@builder>
References: <20181224084824.25193-1-sibis@codeaurora.org>
 <20181224084824.25193-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224084824.25193-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Dec 00:48 PST 2018, Sibi Sankar wrote:

> After sending a sysmon shutdown request to the SSCTL service on the
> subsystem, wait for the service to send shutdown-ack interrupt or
> an indication message to signal the completion of graceful shutdown.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

I prefer something closer to v1, where you kept the handling of the
interrupt within the sysmon driver.

What I didn't like was the fact that you resolved the mss
platform_device to get to the irq, not that you grabbed the irq from the
parent's DT node from within the sysmon device.


You can get the remoteproc's DT node by rproc->dev.parent->of_node and
use of_irq_get_byname() to get an irq number, which you can request in
the sysmon device - which will work regardless of the remoteproc driver
being a platform_driver or something else.

All the logic looks sound, but by shuffling things around we should get
less coupling of the implementation (DT binding looks good).

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_sysmon.c | 40 +++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index c0d6ee8de995..0da83638ca99 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -36,6 +36,7 @@ struct qcom_sysmon {
>  
>  	struct rpmsg_endpoint *ept;
>  	struct completion comp;
> +	struct completion ind_comp;
>  	struct mutex lock;
>  
>  	bool ssr_ack;
> @@ -139,6 +140,7 @@ static int sysmon_callback(struct rpmsg_device *rpdev, void *data, int count,
>  }
>  
>  #define SSCTL_SHUTDOWN_REQ		0x21
> +#define SSCTL_SHUTDOWN_READY_IND	0x21
>  #define SSCTL_SUBSYS_EVENT_REQ		0x23
>  
>  #define SSCTL_MAX_MSG_LEN		7
> @@ -254,6 +256,29 @@ static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
>  	{}
>  };
>  
> +static struct qmi_elem_info ssctl_shutdown_ind_ei[] = {
> +	{}
> +};
> +
> +static void sysmon_ind_cb(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
> +			  struct qmi_txn *txn, const void *data)
> +{
> +	struct qcom_sysmon *sysmon = container_of(qmi, struct qcom_sysmon, qmi);
> +
> +	complete(&sysmon->ind_comp);
> +}
> +
> +static struct qmi_msg_handler qmi_indication_handler[] = {
> +	{
> +		.type = QMI_INDICATION,
> +		.msg_id = SSCTL_SHUTDOWN_READY_IND,
> +		.ei = ssctl_shutdown_ind_ei,
> +		.decoded_size = 0,
> +		.fn = sysmon_ind_cb
> +	},
> +	{}
> +};
> +
>  /**
>   * ssctl_request_shutdown() - request shutdown via SSCTL QMI service
>   * @sysmon:	sysmon context
> @@ -264,6 +289,7 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
>  	struct qmi_txn txn;
>  	int ret;
>  
> +	reinit_completion(&sysmon->ind_comp);
>  	ret = qmi_txn_init(&sysmon->qmi, &txn, ssctl_shutdown_resp_ei, &resp);
>  	if (ret < 0) {
>  		dev_err(sysmon->dev, "failed to allocate QMI txn\n");
> @@ -285,6 +311,16 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
>  		dev_err(sysmon->dev, "shutdown request failed\n");
>  	else
>  		dev_dbg(sysmon->dev, "shutdown request completed\n");
> +
> +	if (sysmon->q6v5) {
> +		ret = qcom_q6v5_wait_for_shutdown(sysmon->q6v5, 10 * HZ);
> +		if (ret) {
> +			ret = try_wait_for_completion(&sysmon->ind_comp);
> +			if (!ret)
> +				dev_err(sysmon->dev,
> +					"timeout waiting for shutdown ack\n");
> +		}
> +	}
>  }
>  
>  /**
> @@ -462,9 +498,11 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
>  	sysmon->q6v5 = q6v5;
>  
>  	init_completion(&sysmon->comp);
> +	init_completion(&sysmon->ind_comp);
>  	mutex_init(&sysmon->lock);
>  
> -	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
> +	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops,
> +			      qmi_indication_handler);
>  	if (ret < 0) {
>  		dev_err(sysmon->dev, "failed to initialize qmi handle\n");
>  		kfree(sysmon);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
