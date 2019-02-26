Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EABC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A88521872
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmoYLBNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfBZUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:20:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34009 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfBZUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:20:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6781086plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PeRP/XIXjJeB+bcHpX3990hPAkvD/JerCJnp/tHeftA=;
        b=NmoYLBNfdnmt1EUHhicIBe38EqYKKbaDuZZ4+LPdG6y9hRxlCUGIH5lyJCA6qwLrek
         rx11IDVvbiNoUSDJ3ftZaKmH406vdzOBv1G9sD+i4MkoMCQcSiDR489iIb+5tQthp/hW
         hd7Ufw/qv7C1GicODr9zwRRSKzd9ONt207aYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PeRP/XIXjJeB+bcHpX3990hPAkvD/JerCJnp/tHeftA=;
        b=myecPWfgK/FoeqT7eE6y0mMSZUnaWd0ayDmN/uIhBJAQ8XGb50PhkZHob2ZfQGUwll
         y39J3787mtBUsfdfDHaQVTYv/A/dm/RxvLu+DerWv7f2Qf7w3BUvmRMMaYUw9E7OIHgb
         naGVy+S2HSKXfIySUqUzMyKuWbw+RJOHfQZfJONRPYWcVxVzCUuInheVVcikzG+cFxKE
         wyphu0CuuzqyXI5Ij6b//hKcQI7/5BKfYQLOydqyVjb9TnkQpWlpDCdQ5JprN54IWahQ
         r3WvYGLaxkDD2dEn6a0bEJJqYXun6cnAK0eG1oCEt20NY9K4KlH41GU7B2HVkBUuqH83
         GnYw==
X-Gm-Message-State: AHQUAuZWHP6kMABLEthaIeIYGdmo7Bzvs4EPOcsM/5ePb3hnm6WLsZTj
        fLhFJE8n/0yk0gK3HKBXg0fT+A==
X-Google-Smtp-Source: AHgI3IZPLGt8vnpBeSS7ZCFHcXIj/Bo0ffuAWLuhr7lFbiQtgOdjVzwNguYqtKHWTdHfUQqaxO6eTQ==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr28066773plb.169.1551212407108;
        Tue, 26 Feb 2019 12:20:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z185sm23972560pfb.17.2019.02.26.12.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 12:20:06 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:20:06 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] hci_qca: Reduce delay after sending baudrate request
 for WCN3990
Message-ID: <20190226202006.GA155681@google.com>
References: <20190226200848.154216-1-mka@chromium.org>
 <20190226200848.154216-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226200848.154216-3-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:08:48PM -0800, Matthias Kaehlcke wrote:
> The current 300ms delay after a baudrate change is extremely long.
> For WCM3990 it is sufficient to wait 10ms after the baudrate change
> request has been sent over the wire.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 703e099515f24..fd018cc5605c6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -59,8 +59,7 @@
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
> -#define POWER_PULSE_TRANS_TIMEOUT_MS	100
> +#define CMD_TRANS_TIMEOUT_MS		100
>  
>  /* susclk rate */
>  #define SUSCLK_RATE_32KHZ	32768
> @@ -964,6 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  {
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
> +	struct qca_serdev *qcadev;
>  	struct sk_buff *skb;
>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>  
> @@ -985,11 +985,25 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	skb_queue_tail(&qca->txq, skb);
>  	hci_uart_tx_wakeup(hu);
>  
> -	/* wait 300ms to change new baudrate on controller side
> -	 * controller will come back after they receive this HCI command
> -	 * then host can communicate with new baudrate to controller
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +
> +	/* Wait for the baudrate change command to be sent and
> +	 * processed by the controller.
>  	 */
> -	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
> +	if (qcadev->btsoc_type == QCA_WCN3990) {
> +		while (!skb_queue_empty(&qca->txq))
> +			usleep_range(100, 200);
> +
> +		serdev_device_wait_until_sent(hu->serdev,
> +			      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));

note: the above could also be in the common path, personally I don't
have a strong preference.

> +
> +		/* Make sure there is enough time for the BT
> +		 * controller to process the baudrate change
> +		*/
> +		msleep(10);
> +	} else {
> +		msleep(300);

I wonder if the non-wcn3990 delay could be reduced too, 300ms seems an
eternity, however I don't have hardware to validate such a change.

That raises a question: how many different chips are actually
supported by this driver? In earlier reviews we were frequently
talking about the ROME family and I assumed it must be a larger
number, however there are only compatible strings for the qca6174 and
the wcn3990. If there is only one other controller (or a low number
of very similar ones that use the same compatible string?) maybe
Qualcomm could help with testing?

Thanks

Matthias
