Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1F120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHDkbp9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:43:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33239 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfBTXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:43:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so13112773plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldQV+7cvcgQs4sP19GE3owVebaTvY/rnv0Xul8FKOfo=;
        b=nHDkbp9smsWwN3dUxxZy16KA+A7pjpo5vpXb87AFELVsBRq+l141ENEDbWsIaKwD3a
         79HJ+LbzSKEfDpSKijKHSS7PC787YRYUU+I2Myb62JHy4ph9HnLp0OXlAFpN2y4tlaId
         jH/41GQjDq5cFsUYT8FjQtwNvFDeXH1/FM44M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldQV+7cvcgQs4sP19GE3owVebaTvY/rnv0Xul8FKOfo=;
        b=JyJ78+7jSaiWyAJxkt9eWz5qhCU8ZWIwz7ULBO7b+fyUXGSGQnQLos2E9u408ycmdD
         9zdWNfzgeMDY89FUe6EiBltWkaH5XAvJRSzsTAovQuC1yuLmkHSQq0fSJdMgu7aNtiKK
         4jRJSSB2xwtYWzwJr3sDQUWOaSXLymyYJYPzTf2U1GHDe6h8iBlrOP+x9IUwdz+NDLC9
         zxVEhy22gHY4SYMibDX2+eBm4XQywDuj9Xey/7qrj0MLVeDxMea8Y+7f840brWfjP7Wb
         LoNb3ZUg4dMr/pA7aouOOAEFsgFRJwZNr7GUf9TWdiivMEh/gB7UyG4MtsA6xQ1RuVAL
         uglg==
X-Gm-Message-State: AHQUAua09ueDRCe4O/ZOYY1b7bHNWea+yGZe6AL0Fv9jb27BIHrxVI6a
        4RAlCCDLZo/F3O+KnPLNl8gV6g==
X-Google-Smtp-Source: AHgI3IZ69O/K53F4DXzdUln16/M1xSAkfxlFKzy4C3aYxY9dxqNkiPSrCwqJjFCzqIJ1oDQCcExhmQ==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr39713320pla.339.1550706183477;
        Wed, 20 Feb 2019 15:43:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r130sm40042029pfr.48.2019.02.20.15.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 15:43:02 -0800 (PST)
Date:   Wed, 20 Feb 2019 15:43:02 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Update baudrate change wait time
 for wcn3990
Message-ID: <20190220234302.GB116191@google.com>
References: <20190220112516.19179-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220112516.19179-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

On Wed, Feb 20, 2019 at 04:55:16PM +0530, Balakrishna Godavarthi wrote:
> This patch will update the baudrate change request wait time from
> 300 ms to 100 ms. When host sends the change baudrate request to
> the controller, controller sets its clock and wait until the
> clocks settle down. Here the Wait time is required for both
> host and controller to be on sync.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 5e03504c4e0c..22f3c983f868 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -59,7 +59,8 @@
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define ROME_BD_SETTLE_TIMEOUT_MS	300
> +#define WCN3990_BD_SETTLE_TIMEOUT_MS	100

nit: _BR_ instead of _BD_?

>  #define POWER_PULSE_TRANS_TIMEOUT_MS	100
>  
>  /* susclk rate */
> @@ -965,8 +966,11 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
>  	struct sk_buff *skb;
> +	struct qca_serdev *qcadev;
> +	unsigned int bd_settling_timeout;

nit: from the context the purpose of the variable is fairly clear,
calling it just 'timeout' (or 'settling_time', it's not really a
timeout) should be fine.

That said, I have a similar change in my pipeline, which further
reduces the time to the 'strictly necessary'. It's slightly more code
though. I guess I'll send it and we can discuss/let Marcel decide
what to adopt.

Cheers

Matthias
