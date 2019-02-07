Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6721C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DDF21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl7tDhdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGWJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:09:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45469 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:09:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so1232492ljd.12;
        Thu, 07 Feb 2019 14:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TwJWzWxGLqBA0tFyujDZdOi+tWFrbYyVTkH1jMcd6g=;
        b=Dl7tDhdnp3zKK4uRIQfXZIOoPgBLtS/g2mgcDuMWW9kgcgNpZ0EsYO0y6ifsGxE0rG
         0jZSK9vAG4Tp2Tcg3/87I7Clw6d1k97DAe6omfV+WLvozCXygP7FtTfvH0KGcPy0wpMM
         NOgBayEUY7AvmcwPVoES87XGw9CGdWp/eA6ZYF0+gqjD6q+DZqltPwBbV0Z9eCQDHPed
         uLPm4Moj43s7pssHQj9jLqjxWqTrJH9NcxKoqPF77egsNmYJ+P45LL+dT6R/lm5Np45F
         nBFp+c6EAtnGyURZdN38hKkyTpxllJ539SUDr9nMAT14C9fYsxbyQWWytMhVtNFBFmAE
         EfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TwJWzWxGLqBA0tFyujDZdOi+tWFrbYyVTkH1jMcd6g=;
        b=gyM5CQFX3kVPGUIZZUqK/qyVdaOE3qIbqDZQe7+kValRzN+8U4lUUaAjCnN6lwY27Q
         XHEAzi/8/KEvH3rLtEPURSkfWqlbzEfip0Cfk4w5HQvGXDA+pgbVdXmyG3fZJeoQfQJa
         mn2N9Ttpb9toDiMl3ML5EQ0FHsIfgt0KJYSzHkXhLxcRbYMv+wD++52ZiFQEDMmC8zNh
         bJqDxeYyFmn52YucHY8NZL42JITJE24YuD2n8phxyONt5cJTfzeVVtknqC0nQDcaSsIZ
         FXK6myH5EMc2uoORNYExqsG15lKWb/RJofwH5U50ssnD5Zo6OzgNM+wzwiypAU9PMJtA
         E6Pw==
X-Gm-Message-State: AHQUAuba//whVAjSJEU2ED7v08Chvr0Ezn6OSGWsbgewWw6rdZ6bWITR
        sZPxWKPbBK8mRSZ8z/CLu4SOyb2m
X-Google-Smtp-Source: AHgI3IYW1aQ0n1bytoXNoBx+ByawbPVNGW2mWTZArfvFLUTDtMD94haKW6gU0BMYkx/01qJFHFge1Q==
X-Received: by 2002:a2e:9a50:: with SMTP id k16-v6mr3793041ljj.3.1549577393892;
        Thu, 07 Feb 2019 14:09:53 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m18sm29894lfh.43.2019.02.07.14.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 14:09:52 -0800 (PST)
Subject: Re: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
Date:   Fri, 8 Feb 2019 01:09:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 0:47, Sowjanya Komatineni пишет:
> Tegra194 supports maximum 64K bytes transfer per packet.
> Tegra186 and prior supports maximum 4K bytes transfer per packet.
> This includes 12 bytes of packet header.
> 
> This patch fixes max write length to account for packet header size
> for transfers.

The commit message isn't accurate. We are not actually fixing anything here, this patch is just a preparation for adding DMA support that require the packet-header size to be excluded from the overall TX size-quirk because the packet-header is the part of the DMA transfer.

Given how small this change is, it's probably not really worth to factor out it into a separate patch, let's just squash it to to the DMA-patch.

> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V15]	: This is new patch in this series.
> 
>  drivers/i2c/busses/i2c-tegra.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 3758c7a2c781..ab474cc86e0a 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -125,6 +125,9 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>  
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfer.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -900,11 +903,13 @@ static const struct i2c_algorithm tegra_i2c_algo = {
>  static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>  	.flags = I2C_AQ_NO_ZERO_LEN,
>  	.max_read_len = 4096,
> -	.max_write_len = 4096,
> +	.max_write_len = 4096 - I2C_PACKET_HEADER_SIZE,
>  };
>  
>  static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>  	.flags = I2C_AQ_NO_ZERO_LEN,
> +	.max_read_len = 65535,
> +	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,
>  };

This is wrong, 65535 = 64 * 1024 - 1.

Let's just use size-constants provided by kernel:

static const struct i2c_adapter_quirks tegra_i2c_quirks = {
	.flags = I2C_AQ_NO_ZERO_LEN,
	.max_read_len = SZ_4K,
	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE,
};

static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
	.flags = I2C_AQ_NO_ZERO_LEN,
	.max_read_len = SZ_64K,
	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE,
};


I'll take a look at other patches later today, no need to send out new version right now.

