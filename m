Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780772190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6AjWxHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeLUHYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:24:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40029 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbeLUHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:24:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so4136132wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3xfIhCetTPt9MM31UR71gg+pBr1wSQiYTk8T45dQb9Y=;
        b=h6AjWxHhkwNTVW52KLwpdchAVZvaMiuuU5/wYble1vxxAumtO/38ZUQKwsL50U27Xt
         QyaqSDjykZIHRurNqjtYuXdMTVy7L1ubRr2+QMnSl1Iv3+Dq7gdxj3Qq+hUlOI2IhFyF
         9rRHrFW6dx1p9BzZo9DCTLzWtFl/6dLe8Vo8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3xfIhCetTPt9MM31UR71gg+pBr1wSQiYTk8T45dQb9Y=;
        b=FZwsXTCQYYwN4wpzgJXRqp748VqClrdJYlgWnnfwLup3nIeY2tTUuNsztng+4xhSZp
         A8Lx27T3CIirAeJ/DYB6VVuYUZxz5NXI8oY/W/p2BEWwT1g2qL2PUnrpEVYJBW5tQXBr
         i5PguKXKO7bi+FrTYt7vM6prc6sBfTF6QSjZZzq+eGQlN+uNsaZOYwa5OmPrrR76/Bnf
         A5WFbFKEY+/gP1u5tyRpzSiub8fkENkf1fZhrrMw2yAJgHuQ2bXZ1TcfMPkzUUe14gLX
         2bURT24ahUJzsX51+sNSX+NY+pGILgz3aTHLZsBhI4bHSut1WHNJ14LI4gb1mRMBDNLh
         i+Kg==
X-Gm-Message-State: AJcUukdA0kHlG0BgxFstW4Vr7pvbN/LGMvC84mnzK1b9umjM5FSHTBqG
        SibeX+dDLSinDJFcSJOEIG/sQg==
X-Google-Smtp-Source: ALg8bN44t5xya5ldTX8aPENQN1GxZEQtPLxSpT/e4+wtBy+mFPlOTcBvZE5WFcemdG2sHDoK9F4C8A==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr1248386wrs.75.1545377086921;
        Thu, 20 Dec 2018 23:24:46 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id z9sm8798003wrs.63.2018.12.20.23.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:24:45 -0800 (PST)
Date:   Fri, 21 Dec 2018 07:24:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     egranata@google.com
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@google.com>,
        Brian Norris <briannorris@google.com>,
        Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
Message-ID: <20181221072444.GM4497@dell>
References: <20181207222223.GA240898@google.com>
 <20181221002933.747-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221002933.747-1-egranata@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, egranata@google.com wrote:

> From: Enrico Granata <egranata@chromium.org>
> 
> The ChromeOS EC has support for signaling to the host that
> a single IRQ can serve multiple MKBP events.
> 
> Doing this serves an optimization purpose, as it minimizes the
> number of round-trips into the interrupt handling machinery, and
> it proves beneficial to sensor timestamping as it keeps the desired
> synchronization of event times between the two processors.
> 
> This patch adds kernel support for this EC feature, allowing the
> ec_irq to loop until all events have been served.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---

What is this?

A [RESEND]?  If so, you should s/[PATCH]/[RESEND/ in the subject line.

An updated patch?  If so, you need a Changelog here and a [PATCH v2].

Also, submitting in-reply-to isn't scalable.

Please resubmit this patch.

>  drivers/mfd/cros_ec.c                   | 20 +++++++++++++--
>  drivers/platform/chrome/cros_ec_proto.c | 33 +++++++++++--------------
>  include/linux/mfd/cros_ec.h             |  7 ++++--
>  include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
>  4 files changed, 53 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index fe6f83766144f..17903a378aa1a 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -51,13 +51,16 @@ static const struct mfd_cell ec_pd_cell = {
>  	.pdata_size = sizeof(pd_p),
>  };
>  
> -static irqreturn_t ec_irq_thread(int irq, void *data)
> +static bool ec_handle_event(struct cros_ec_device *ec_dev)
>  {
> -	struct cros_ec_device *ec_dev = data;
>  	bool wake_event = true;
>  	int ret;
> +	bool ec_has_more_events = false;
>  
>  	ret = cros_ec_get_next_event(ec_dev, &wake_event);
> +	if (ret > 0)
> +		ec_has_more_events =
> +			ec_dev->event_data.event_type & EC_MKBP_HAS_MORE_EVENTS;
>  
>  	/*
>  	 * Signal only if wake host events or any interrupt if
> @@ -70,6 +73,19 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
>  	if (ret > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
>  					     0, ec_dev);
> +
> +	return ec_has_more_events;
> +}
> +
> +static irqreturn_t ec_irq_thread(int irq, void *data)
> +{
> +	struct cros_ec_device *ec_dev = data;
> +	bool ec_has_more_events;
> +
> +	do {
> +		ec_has_more_events = ec_handle_event(ec_dev);
> +	} while (ec_has_more_events);
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b6fd4838f60f3..bb126d95b2fd4 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  	ret = cros_ec_get_host_command_version_mask(ec_dev,
>  						    EC_CMD_GET_NEXT_EVENT,
>  						    &ver_mask);
> -	if (ret < 0 || ver_mask == 0)
> +	if (ret < 0 || ver_mask == 0) {
>  		ec_dev->mkbp_event_supported = 0;
> -	else
> -		ec_dev->mkbp_event_supported = 1;
> +		dev_info(ec_dev->dev, "MKBP not supported\n");
> +	} else {
> +		ec_dev->mkbp_event_supported = fls(ver_mask);
> +		dev_info(ec_dev->dev, "MKBP support version %u\n",
> +			ec_dev->mkbp_event_supported - 1);
> +	}
>  
>  	/*
>  	 * Get host event wake mask, assume all events are wake events
> @@ -530,28 +534,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>  {
>  	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
>  	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> -	static int cmd_version = 1;
> -	int ret;
> +	const int cmd_version = ec_dev->mkbp_event_supported - 1;
>  
>  	if (ec_dev->suspended) {
>  		dev_dbg(ec_dev->dev, "Device suspended.\n");
>  		return -EHOSTDOWN;
>  	}
>  
> -	if (cmd_version == 1) {
> -		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> -				sizeof(struct ec_response_get_next_event_v1));
> -		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> -			return ret;
> -
> -		/* Fallback to version 0 for future send attempts */
> -		cmd_version = 0;
> -	}
> -
> -	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> +	if (cmd_version == 0)
> +		return get_next_event_xfer(ec_dev, msg, 0,
>  				  sizeof(struct ec_response_get_next_event));
>  
> -	return ret;
> +	return get_next_event_xfer(ec_dev, msg, cmd_version,
> +				sizeof(struct ec_response_get_next_event_v1));
>  }
>  
>  static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> @@ -607,11 +602,13 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
>  
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  {
> +	u32 event_type =
> +		ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>  	u32 host_event;
>  
>  	BUG_ON(!ec_dev->mkbp_event_supported);
>  
> -	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
> +	if (event_type != EC_MKBP_EVENT_HOST_EVENT)
>  		return 0;
>  
>  	if (ec_dev->event_size != sizeof(host_event)) {
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index e44e3ec8a9c7d..cb07ee95a6eb8 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -119,7 +119,9 @@ struct cros_ec_command {
>   *            code.
>   * @pkt_xfer: Send packet to EC and get response.
>   * @lock: One transaction at a time.
> - * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
> + * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
> + *                        the maximum supported version of the MKBP host event
> + *                        command + 1.
>   * @event_notifier: Interrupt event notifier for transport devices.
>   * @event_data: Raw payload transferred with the MKBP event.
>   * @event_size: Size in bytes of the event data.
> @@ -152,7 +154,8 @@ struct cros_ec_device {
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
>  	struct mutex lock;
> -	bool mkbp_event_supported;
> +	/* 0 == not supported, otherwise it supports version x - 1 */
> +	u8 mkbp_event_supported;
>  	struct blocking_notifier_head event_notifier;
>  
>  	struct ec_response_get_next_event_v1 event_data;
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 9a9631f0559e2..3f013593d0107 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2146,6 +2146,14 @@ struct ec_result_keyscan_seq_ctrl {
>   */
>  #define EC_CMD_GET_NEXT_EVENT 0x67
>  
> +#define EC_MKBP_HAS_MORE_EVENTS_SHIFT 7
> +
> +/* EC can provide more MKBP events to host */
> +#define EC_MKBP_HAS_MORE_EVENTS (1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT)
> +
> +/* The mask to apply to get the raw event type */
> +#define EC_MKBP_EVENT_TYPE_MASK ((1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT) - 1)
> +
>  enum ec_mkbp_event {
>  	/* Keyboard matrix changed. The event data is the new matrix state. */
>  	EC_MKBP_EVENT_KEY_MATRIX = 0,
> @@ -2173,6 +2181,13 @@ enum ec_mkbp_event {
>  
>  	/* Number of MKBP events */
>  	EC_MKBP_EVENT_COUNT,
> +
> +	/*
> +	 * Maximum possible event type
> +	 * The most significant bit of event type is used to indicate that
> +	 * the EC has multiple events for the AP to serve
> +	 */
> +	EC_MKBP_EVENT_MAX_TYPE = EC_MKBP_EVENT_TYPE_MASK,
>  };
>  
>  union ec_response_get_next_data {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
