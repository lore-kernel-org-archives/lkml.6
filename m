Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB11C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F733L5cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2432A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJ3BYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:24:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32803 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeJ3BYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:24:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id a15-v6so4310828pfn.0;
        Mon, 29 Oct 2018 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NNILUclF2YksZLNcLmr/Qd5pjkkJZsvpg7fMEBWQxMM=;
        b=F733L5cqxa8KGMzjDWDU4WYgPjsYodctTd5dqg4pVMVFCNDxZHAkjoPXy+4g+YIm62
         NFbUnu57mOAK/4KdHe++seNLsk0g0Ne7yJQWslt1/YZjqa8DqEKIf4zJ4fjO7TAMt6Zy
         sSA5Vdv9BXQDCOybkZOnf03NfmyfHUGaQmKnMg0NwB1GB5rsvsI01ck3nEmn4MJp0VR6
         7H73aDdnq6v5F10zZ0kNsuT5AXMT6zaETWTytFpIHdnFDpdrL96wRXVpDVKu8vNETIuA
         xpQjHi0v4aSq4etthb4VhXSbUk2aHm7EHrJToT0jLX5b0iJO+agr1OckTrcqS4DY7MLy
         50wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NNILUclF2YksZLNcLmr/Qd5pjkkJZsvpg7fMEBWQxMM=;
        b=kd1f5tXqTHhKjrUXX8BWiCi0b6rJynYo+mes39vR09x6UudV92rmH4TuN8+/8nkPVn
         2bBc+QY9VJWQkXdGPn5CfzWC7uIlsnZWECRXkUOc07P/qnXNngmWINGmJbyFRpk9TObz
         0AL3Df1jX80JNfTHP5FlCRARZ4c4gKEhTvRpcjxxppxe6oMmwfSyYBjunyMjcRrxCXA8
         k7rwhOnqNjraBhdwOQCmhl6q+d16/R8Cen52OEn8C+gu8BJY03zPmRn+JwbWpbKvCX2I
         qyz0+/xrvxaFy/8JYSw/Ni/7B3rGEq45joylLoQvtiCHMsthYbqzlZ9FHZdSfRZM5yfs
         v3sw==
X-Gm-Message-State: AGRZ1gKTuy487UYiHD/nkCKPL3g4k23ngqcnskcYKk9Wv9c3MXTfHau0
        nUuHvu4ImwJG2rZBEo0HaDXK8jpqze0=
X-Google-Smtp-Source: AJdET5ceu5KykyL3ENMB6WnLnTyl7Ohx/+tIbnYWtAo5gsakUR5MDtSjLcYJ0R4dWx61kYCcT7wZXQ==
X-Received: by 2002:a62:1c0f:: with SMTP id c15-v6mr15880886pfc.14.1540830920342;
        Mon, 29 Oct 2018 09:35:20 -0700 (PDT)
Received: from [10.211.55.5] ([49.170.189.99])
        by smtp.gmail.com with ESMTPSA id w2-v6sm37608365pfk.140.2018.10.29.09.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:35:18 -0700 (PDT)
Subject: Re: [PATCH] spi: dw: fix buffer end address
From:   Jaewon Kim <jaewon02.kim@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540395437-6623-1-git-send-email-jaewon02.kim@samsung.com>
Message-ID: <762bc63e-7b01-0d77-3939-7b236dbda37f@gmail.com>
Date:   Tue, 30 Oct 2018 01:35:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540395437-6623-1-git-send-email-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=euc-kr; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some side effect on this patch.

So, I revoke this patch.


18. 10. 25. 오전 12:37에 Jaewon Kim 이(가) 쓴 글:
> Buffer address can be NULL, if user does not want to receive TX/RX data.
> In this case, driver should not set the rx/tx_end value with len.
>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>   drivers/spi/spi-dw.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index b705f2b..34e6fca 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -293,9 +293,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>   	dws->dma_mapped = 0;
>   
>   	dws->tx = (void *)transfer->tx_buf;
> -	dws->tx_end = dws->tx + transfer->len;
> +	dws->tx_end = dws->tx;
> +	if (dws->tx)
> +		dws->tx_end += transfer->len;
>   	dws->rx = transfer->rx_buf;
> -	dws->rx_end = dws->rx + transfer->len;
> +	dws->rx_end = dws->rx;
> +	if (dws->rx)
> +		dws->rx_end += transfer->len;
>   	dws->len = transfer->len;
>   
>   	spi_enable_chip(dws, 0);
