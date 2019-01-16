Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2034EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79E220675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3/DMABm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfAPXIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:08:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44256 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387956AbfAPXIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:08:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so3483403pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNtoC5c+2YT8QEQeFenQ+Gr8RS5xW2AkUGFuDXVHCZY=;
        b=m3/DMABmDqIGq6dA1cgQZV76a4RAkojPOq/bhMtJ7HKfIF//gvaQGe/isvAKiLeYns
         DdcCfE/MHSstsI9xpXsNH62OuCeFtPXIW/Cwi3SQfoQm+43LmS6/A3SVzEmgByn5XxkX
         7E1E9KmvkNTHgAFLtyp5+4DyzNqqQrLxYI1AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNtoC5c+2YT8QEQeFenQ+Gr8RS5xW2AkUGFuDXVHCZY=;
        b=cqHFMdj9/UGeYD2nisW+ibWEESncwP8qEDrqqOxRfdqWMxqCi7I65uMzbp7vzIrxug
         RUNKx919GwSnT8sXtPt+Wvfc5Pl6kQt5INto03XdI83mY9dzYtvjeihaYRBWZTWZw8Ft
         7ARM4i3TR37YTW4X9eQTrz2T3aJe+F9TISQzCYIg9H6TOkHP3G3eb0Ub3ckN6tuXf2aH
         KiapPDUyxuA95r24ISeVp+Qs3mu3DM0/vacUj8mBMWfcxTtXIX7JClaqXj8sOKfEQbWO
         GJ4YbN/B4xoy9Ux256H7H1/AhFnwEspNuouR+y8rJT6lRnC7QbLBkErexGTW2AouhDCu
         Fttw==
X-Gm-Message-State: AJcUukd0q85YFQ/PZAj6tBHxMzdY7KcTTyz4u6mfLa+asGAeaWwkov6z
        XlEebVkmzaMm/3VgUOavPyNW/w==
X-Google-Smtp-Source: ALg8bN6Am5nT8i39NRPY8BzcfaGxa+8CSRc0ja/otbCRzYOL62H+zmoWB5whiwhRLwlLhC8rtw9sqA==
X-Received: by 2002:a63:b543:: with SMTP id u3mr11106658pgo.420.1547680083440;
        Wed, 16 Jan 2019 15:08:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x7sm7899802pga.68.2019.01.16.15.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 15:08:02 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:08:01 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/3] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
Message-ID: <20190116230801.GT261387@google.com>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116114603.500-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:16:03PM +0530, Balakrishna Godavarthi wrote:
> During hci down we observed IBS sleep commands are queued in the Tx
> buffer and hci_uart_write_work is sending data to the chip which is
> not required as the chip is powered off. This patch will disable IBS
> and flush the Tx buffer before we turn off the chip.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7e4afcf40da2..7330ba71ada4 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1275,6 +1275,14 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> +	struct qca_data *qca = hu->priv;
> +
> +	/* From this point we go into power off state. But serial port is
> +	 * still open, stop queueing the IBS data and flush all the buffered
> +	 * data in skb's.
> +	 */
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	qca_flush(hu);
>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);

Due to a race-condition there could be an IBS sleep command queued
even after clearing the bit and flushing the queue.

In qca_enqueue() we have this:

static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
{
        ...

        /* Don't go to sleep in middle of patch download or
         * Out-Of-Band(GPIOs control) sleep is selected.
         */
        if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
                skb_queue_tail(&qca->txq, skb);
                return 0;
        }

        spin_lock_irqsave(&qca->hci_ibs_lock, flags);
}

With process X executing qca_power_shutdown() and process Y running
qca_enqueue() this could happen:

[X] test_bit(STATE_IN_BAND_SLEEP_ENABLED)  => set
[Y] clear_bit(STATE_IN_BAND_SLEEP_ENABLED)
[Y] qca_flush(hu);
[X] skb_queue_tail(&qca->txq, skb);

The following should fix this race:

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -770,16 +770,17 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
 	 */
 	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
 		skb_queue_tail(&qca->txq, skb);
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 		return 0;
 	}
 
-	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
-
 	/* Act according to current state */
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_AWAKE:
@@ -1275,13 +1276,17 @@ static const struct qca_vreg_data qca_soc_data = {
 static void qca_power_shutdown(struct hci_uart *hu)
 {
 	struct qca_data *qca = hu->priv;
+	unsigned long flags;
 
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
 	 * data in skb's.
 	 */
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 	qca_flush(hu);
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);

Cheers

Matthias
