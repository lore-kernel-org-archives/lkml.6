Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F693C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A222081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B8+gGTgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfBDRbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:31:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37518 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfBDRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:31:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so241565plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Wj0EGT2OP/kRNudZ+wyxGfn6HfdnxB95RrENoCt6aw=;
        b=B8+gGTgD0DN08+mrCvjx6Px4iCEJp+qy8RpNuCMndn3Wg54kDcrwSBV2OmukJVtdg9
         oRGrfgg6RlIXatt+3M5KPs41oqWDQ7FoO/dOZ/rf8G3C1Uk+ZPBKfjLrKcqv7vcXgPkR
         CFEjOGee/p7sWVkrlcwuJK8r26vlfkNowHnaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Wj0EGT2OP/kRNudZ+wyxGfn6HfdnxB95RrENoCt6aw=;
        b=FVf7psziVrCqvW/Q5W4FxKrTXXF0Wp+0mBxY8jpy4zDIQ1usz8mCJnZgavqoqBj/S4
         QsMt2d/hlamxxqdqD6ofvtAJZ2tvI//mSE1KsLyJQQ/q5aMO+qHxKgbvZj9vHwCpDAva
         s5bkmeNbgRVGQjBa9xDP8IgmeiFXNRf339Qj4+qSTl4CuIfa9z6p5KSBa/f9WIjsD/GX
         z30O/oRllpVESbKrmkPrlqpy3XrNfEwi31ZEB4FNd1u6fGv88hnhlyUyldRKUYYRe+mQ
         91911TpiWjfNKj4wrC7YBf8XfMFhOQ2p3sXzB4RuvWg4rAWit7TX6qrTdZnVsWb87ui5
         byRw==
X-Gm-Message-State: AHQUAuZO43w5pGRMCHpiaprMDcnzEdU7rKNVHpUxWd9zQNTGD7WIQsPM
        xJpQZ76WnmKctz3Beyk6lxireQ==
X-Google-Smtp-Source: AHgI3IZvZ4DvB3VRMmkEfcUTMPg6u6ez8NEioZU0+sjBV2CqlVERTBHtTrDU8qOluEJVAElg0xjOWQ==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr498983pln.340.1549301490167;
        Mon, 04 Feb 2019 09:31:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p13sm677685pgs.89.2019.02.04.09.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:31:29 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:31:28 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v11 3/3] Bluetooth: hci_qca: Disable IBS state machine
 and flush Tx buffer
Message-ID: <20190204173128.GC117604@google.com>
References: <20190204150643.25165-1-bgodavar@codeaurora.org>
 <20190204150643.25165-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204150643.25165-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:36:43PM +0530, Balakrishna Godavarthi wrote:
> During hci down we observed IBS sleep commands are queued in the Tx
> buffer and hci_uart_write_work is sending data to the chip which is
> not required as the chip is powered off. This patch will disable IBS
> and flush the Tx buffer before we turn off the chip.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e3cf0dbfc89d..5e03504c4e0c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -771,16 +771,17 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>  
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
>  	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
>  	}
>  
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -
>  	/* Act according to current state */
>  	switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_AWAKE:
> @@ -1275,6 +1276,18 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> +	struct qca_data *qca = hu->priv;
> +	unsigned long flags;
> +
> +	/* From this point we go into power off state. But serial port is
> +	 * still open, stop queueing the IBS data and flush all the buffered
> +	 * data in skb's.
> +	 */
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	qca_flush(hu);
> +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +
>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
