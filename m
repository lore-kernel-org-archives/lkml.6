Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C06520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSYS+cP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C06520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeHaIDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:03:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37040 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeHaIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:03:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id d12-v6so4800693pls.4;
        Thu, 30 Aug 2018 20:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwH4d6DYvPm84NYvC1ok9Eg2SYNgKHTGR+CF3VmQ/LM=;
        b=lSYS+cP+kIjwy39d3ubY2YHQ3BJxqC0Og8lf9fOOMOzX93K8ImPIWxrRJgd9QUwRlh
         cbSe0ttZFS55wCCZhei1yMcvRdOICfu6coSSr5KRRRQfxRmQfEhru/Qu0Dpjylut4THl
         VsFJVr8HolIa7HTfcWID+daExQwsBBDzhKYw4dZICGoztEAWSTQmYqQ861D9KyAZjVTd
         /e8otaoNqDxWoWKXJ2tUb5O9b44God5xwnZRMk/pb4B+5485IUsWjDGZM3VgFgYGkumL
         9JbD+qrokzBQr6XUZ9A2PhTocdBChD1rNYOXtxr9DIosfYpmzps7G4LCP6zdDyV88s8Y
         bHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwH4d6DYvPm84NYvC1ok9Eg2SYNgKHTGR+CF3VmQ/LM=;
        b=cQQ/BQzxlyS5Rnbh/18Obz9RiW0RESylgNKmsyTuCITJZqYN0h9vRvwrRM1wOCMPdA
         1ijS+XqAMKaNIt7KTooy2PahhmyNXU7L8NbdoiIyedQlEZ12AMM9luZtvTdWq2v5Cljf
         OkhKioUKyRvJMsC270M0QVQf6AAR5HEMPSwptAeCaH3Uo21RCpAzcCghLXy5MjPcJc9q
         2NcLAQnA9qJyCscpeRbrr90qJ+4OfCwizeYrW2WcU9HfyVDe71kzl57zzSl/EtoJSMs3
         mtWBa+OkGWquB5ftM7dgma9B/UHwEK10M+r7IvF99k5lcaBL3Pj4P6tHE4dXCq/H6Ek4
         am4w==
X-Gm-Message-State: APzg51DfayhTc+iKRLFEUe6sxir7Y0DwHNEJBHWfKyXchKuEp5a2ovbY
        txlxSvVSJOQEm5okgVWgB4w=
X-Google-Smtp-Source: ANB0VdbZO/fK612eYb+Cfk5lOFkrazdw6FhwRuG53JrF5GWwzTOYX5h9ntJKjlH4RqiRVv7CZfgkIw==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12-v6mr13076726plo.94.1535687879692;
        Thu, 30 Aug 2018 20:57:59 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y69-v6sm16783509pfd.36.2018.08.30.20.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 20:57:59 -0700 (PDT)
Subject: Re: [PATCH v3] rpmsg: qcom_smd: Access APCS through mailbox framework
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20180420011757.22389-1-bjorn.andersson@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c6e2e87c-e2fd-c0ea-dbb9-5246b8694272@gmail.com>
Date:   Thu, 30 Aug 2018 20:57:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180420011757.22389-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 04/19/18 18:17, Bjorn Andersson wrote:
> Attempt to acquire the APCS IPC through the mailbox framework and fall
> back to the old syscon based approach, to allow us to move away from
> using the syscon.
> 
> Reviewed-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Added comment about mbox_send_message() return value.
> 
>  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 ++-
>  drivers/rpmsg/Kconfig                              |  1 +
>  drivers/rpmsg/qcom_smd.c                           | 67 ++++++++++++++++------
>  3 files changed, 56 insertions(+), 20 deletions(-)

This patch in the mainline Linux kernel as commit ab460a2e72dabecfdabd45eb7e3ee2d73fc876d4
causes a problem with the APQ8074 Dragonboard.  The mmc device is not set up
with the patch applied, thus I do not have the block device my root file system
is located on.

Testing on v4.18, if I revert this commit the mmc device is available.

I'll reply to this email with the console messages for 4.18 and for 4.18 with
this commit reverted.

-Frank


> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> index ea1dc75ec9ea..234ae2256501 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
> @@ -22,9 +22,15 @@ The edge is described by the following properties:
>  	Definition: should specify the IRQ used by the remote processor to
>  		    signal this processor about communication related updates
>  
> -- qcom,ipc:
> +- mboxes:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> +	Definition: reference to the associated doorbell in APCS, as described
> +		    in mailbox/mailbox.txt
> +
> +- qcom,ipc:
> +	Usage: required, unless mboxes is specified
> +	Value type: <prop-encoded-array>
>  	Definition: three entries specifying the outgoing ipc bit used for
>  		    signaling the remote processor:
>  		    - phandle to a syscon node representing the apcs registers
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 0fe6eac46512..2e4fb4ffd562 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -39,6 +39,7 @@ config RPMSG_QCOM_GLINK_SMEM
>  
>  config RPMSG_QCOM_SMD
>  	tristate "Qualcomm Shared Memory Driver (SMD)"
> +	depends on MAILBOX
>  	depends on QCOM_SMEM
>  	select RPMSG
>  	help
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index bc0b30657230..3ff271a44bef 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
> @@ -107,6 +108,8 @@ static const struct {
>   * @ipc_regmap:		regmap handle holding the outgoing ipc register
>   * @ipc_offset:		offset within @ipc_regmap of the register for ipc
>   * @ipc_bit:		bit in the register at @ipc_offset of @ipc_regmap
> + * @mbox_client:	mailbox client handle
> + * @mbox_chan:		apcs ipc mailbox channel handle
>   * @channels:		list of all channels detected on this edge
>   * @channels_lock:	guard for modifications of @channels
>   * @allocated:		array of bitmaps representing already allocated channels
> @@ -129,6 +132,9 @@ struct qcom_smd_edge {
>  	int ipc_offset;
>  	int ipc_bit;
>  
> +	struct mbox_client mbox_client;
> +	struct mbox_chan *mbox_chan;
> +
>  	struct list_head channels;
>  	spinlock_t channels_lock;
>  
> @@ -366,7 +372,17 @@ static void qcom_smd_signal_channel(struct qcom_smd_channel *channel)
>  {
>  	struct qcom_smd_edge *edge = channel->edge;
>  
> -	regmap_write(edge->ipc_regmap, edge->ipc_offset, BIT(edge->ipc_bit));
> +	if (edge->mbox_chan) {
> +		/*
> +		 * We can ignore a failing mbox_send_message() as the only
> +		 * possible cause is that the FIFO in the framework is full of
> +		 * other writes to the same bit.
> +		 */
> +		mbox_send_message(edge->mbox_chan, NULL);
> +		mbox_client_txdone(edge->mbox_chan, 0);
> +	} else {
> +		regmap_write(edge->ipc_regmap, edge->ipc_offset, BIT(edge->ipc_bit));
> +	}
>  }
>  
>  /*
> @@ -1326,27 +1342,37 @@ static int qcom_smd_parse_edge(struct device *dev,
>  	key = "qcom,remote-pid";
>  	of_property_read_u32(node, key, &edge->remote_pid);
>  
> -	syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
> -	if (!syscon_np) {
> -		dev_err(dev, "no qcom,ipc node\n");
> -		return -ENODEV;
> -	}
> +	edge->mbox_client.dev = dev;
> +	edge->mbox_client.knows_txdone = true;
> +	edge->mbox_chan = mbox_request_channel(&edge->mbox_client, 0);
> +	if (IS_ERR(edge->mbox_chan)) {
> +		if (PTR_ERR(edge->mbox_chan) != -ENODEV)
> +			return PTR_ERR(edge->mbox_chan);
>  
> -	edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
> -	if (IS_ERR(edge->ipc_regmap))
> -		return PTR_ERR(edge->ipc_regmap);
> +		edge->mbox_chan = NULL;
>  
> -	key = "qcom,ipc";
> -	ret = of_property_read_u32_index(node, key, 1, &edge->ipc_offset);
> -	if (ret < 0) {
> -		dev_err(dev, "no offset in %s\n", key);
> -		return -EINVAL;
> -	}
> +		syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
> +		if (!syscon_np) {
> +			dev_err(dev, "no qcom,ipc node\n");
> +			return -ENODEV;
> +		}
>  
> -	ret = of_property_read_u32_index(node, key, 2, &edge->ipc_bit);
> -	if (ret < 0) {
> -		dev_err(dev, "no bit in %s\n", key);
> -		return -EINVAL;
> +		edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
> +		if (IS_ERR(edge->ipc_regmap))
> +			return PTR_ERR(edge->ipc_regmap);
> +
> +		key = "qcom,ipc";
> +		ret = of_property_read_u32_index(node, key, 1, &edge->ipc_offset);
> +		if (ret < 0) {
> +			dev_err(dev, "no offset in %s\n", key);
> +			return -EINVAL;
> +		}
> +
> +		ret = of_property_read_u32_index(node, key, 2, &edge->ipc_bit);
> +		if (ret < 0) {
> +			dev_err(dev, "no bit in %s\n", key);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	ret = of_property_read_string(node, "label", &edge->name);
> @@ -1452,6 +1478,8 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
>  	return edge;
>  
>  unregister_dev:
> +	if (!IS_ERR_OR_NULL(edge->mbox_chan))
> +		mbox_free_channel(edge->mbox_chan);
>  	put_device(&edge->dev);
>  	return ERR_PTR(ret);
>  }
> @@ -1480,6 +1508,7 @@ int qcom_smd_unregister_edge(struct qcom_smd_edge *edge)
>  	if (ret)
>  		dev_warn(&edge->dev, "can't remove smd device: %d\n", ret);
>  
> +	mbox_free_channel(edge->mbox_chan);
>  	device_unregister(&edge->dev);
>  
>  	return 0;
> 

