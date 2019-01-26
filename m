Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31607C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F2F2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWHuwG++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfAZSCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:02:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42394 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAZSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:02:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so9091709lfh.9;
        Sat, 26 Jan 2019 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iMjTmor3W7gktBx6x0djHp6YFK4i4C+B9ypjZYMjmkE=;
        b=FWHuwG++HpVKcD7z0akRfk03KEfb6YsaGDRsakFU4QIGomkbgsCP8ajdBT42g28+9H
         gGaDEVE7yPWUuGf+lCyLPOCGjUjIIgMvU1H+AJ8d3mBVMdVA0ynNrKYQbuUtFq2bm3b/
         ISjeVi0xSCHhmFF2K2CfBBpkqTEzrdSChZJbQTUXVkcCIlTlP7wi6D8S2Y5kT8mfYZPT
         hMVSI92uNgxvJXqBmkq1KUnjjSgMnqVjL++3qGXJKAilGv/bnkPA65FmMC0n8uEJ6zZn
         qB1i/T/cNt5RE/hqskmamaeS8r5eG/FJsZbaFzTzvutuq+Q2EMKfdSbpU1M68jt1qQ7g
         gKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMjTmor3W7gktBx6x0djHp6YFK4i4C+B9ypjZYMjmkE=;
        b=dMlTPc0z9VccF/6J3JxkWYpcByA2Zoc5K4LkCLMSxiAckf5N7DVuY72wDEpWicSlPV
         cO2M0ZaC1FgAGaLWcYSoN3vovAwuq4EQVRSQJUpzJ7WwJSnQFYJTGLjWAbjC2/My5AL7
         YPLeaGHx/G3AtHStVuAJLYMmd37NNGV0JLKaeS9H2jhfxZWtHKsP62O8F6bRpkYtRYsd
         iNVs4jka1NUrnxzg4u0n5t7/JHgUJZ3CEdcmgUeybBs6rYgwe60UEbLnHBvjwrn2Yjml
         TYp6lsFF6fw5TK8sjgFRpk2oLMtDktTuHf8m7HYs9FJvN5qqFPLQA90kGwFH5ON2PQ5T
         +Dsg==
X-Gm-Message-State: AJcUukc1RznQbM6AAJIbOXJ+sq8PtrEuZRXdIMVJFBIEwKazAsr3ux0v
        Xtlr8gWN1SDsFz06/TgZjx9DuPx6
X-Google-Smtp-Source: ALg8bN4LSgNYUnsnP9e6l2uvbu9KndMGw12xXPzLncGQ17LQf8uOSlnXrQGAs2iztMu7ZNom2hXgZw==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr11917589lfe.87.1548525727516;
        Sat, 26 Jan 2019 10:02:07 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p67sm2173784lfe.14.2019.01.26.10.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 10:02:06 -0800 (PST)
Subject: Re: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
Date:   Sat, 26 Jan 2019 21:02:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 6:57, Sowjanya Komatineni пишет:
> Update I2C transfer timeout based on transfer bytes and I2C bus
> rate to allow enough time during max transfer size based on the
> speed.

Could it be that I2C device is busy and just slowly handling the transfer requests? Maybe better to leave the timeout as-is and assume the worst case scenario?

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V3] : Same as V2
>  [V2] : Added this patch in V2 series to allow enough time for data transfer
> 	to happen.
> 	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
> 	takes argument with this patch.
> 
>  drivers/i2c/busses/i2c-tegra.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index aec500ef9a98..3dcbc9960d9d 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -23,7 +23,7 @@
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  
> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
>  #define BYTES_PER_FIFO_WORD 4
>  
>  #define I2C_CNFG				0x000
> @@ -116,6 +116,9 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>  
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfer.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -683,6 +686,17 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	u32 int_mask;
>  	unsigned long time_left;
>  	unsigned long flags;
> +	u16 xfer_time = 100;
> +	size_t xfer_size = 0;

No need to initialize xfer_size to 0.

> +
> +	if (msg->flags & I2C_M_RD)
> +		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD);
> +	else
> +		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> +			    I2C_PACKET_HEADER_SIZE;
> +
> +	xfer_time += DIV_ROUND_CLOSEST((xfer_size * 9) * 1000,
> +					i2c_dev->bus_clk_rate);>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> @@ -739,7 +753,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		i2c_readl(i2c_dev, I2C_INT_MASK));
>  
>  	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -						TEGRA_I2C_TIMEOUT);
> +						TEGRA_I2C_TIMEOUT(xfer_time));
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
>  
>  	if (time_left == 0) {
> 

