Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A143C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32629218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq0p2CRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBHSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:07:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41564 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBHSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:07:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id k15so2044192pls.8;
        Fri, 08 Feb 2019 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MzDQmN4pDdHV8yZHM6tWbaNysuBFr2DjwHYnpLG/xvg=;
        b=iq0p2CRrhsvbbQpRh1Okxh9BI69PU8FyOEGYqDuHX4vha6S+RdBzLyooJFUE0OpvgL
         m9XswWPZmtVPMPsBp7NZFSmhsPXA3SfTCrNOTrBZtRhLsZmNss07U2wabmpNNgbQo5c9
         K9VpfNGCW25LfVgvdI8Fra8626X5NrX3Fh+NILRDdHNh1eV+zTdAfAXWozTMIZ57ohOI
         UGto3RyxGWyKluXtYwxlZohr9H7pR3bEZ7pkjdzwR8KgBgzZobG6qBSg0KpPE0p/kosU
         Y1Lbf0rv9N4Bm+9NMpLhDAtDUwZ/JBJSSU0CLPqzXGvEYKi7x2lop6uj7pl189HzKVPW
         t2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzDQmN4pDdHV8yZHM6tWbaNysuBFr2DjwHYnpLG/xvg=;
        b=tHCwx0MAnu+YGiDBdR2ZQUnNZTh5Gev0IQFkZQq6U3XxWtydJX3rbHIziDACKX0VcK
         ljGrAmPMU/2HntCDt3JYroP4a9BhJ9t4RLWK10I1W2F44uM4pUR9gKqV18AkkBdz3cqT
         GXF7nMuMR2EkZf189p8IOw1Y1uYWF6V7OlDlS2ZxwMD2TF3ld+4IsCrvDnAsmA0s+q/G
         XvLdc8M59wewI0wF4PYTylJZxbV3c5GVnEnBF831brCIdH+z9jeToPlR21+fel2i8hR+
         rlLSKEFTzPFmoPqak6GcSv+/QI63wYVileMS5SzSY0lt6tu49c6o7nZym2SyS09ogXpw
         /h6w==
X-Gm-Message-State: AHQUAuYy7Elhp75fXRTFeThl+NYkKyqjKcI1a0tDpzWuisiQtWQRPTTE
        WW2dMETnj4Des0QYcPF7kJPcSQRs
X-Google-Smtp-Source: AHgI3IZhxkYqTSLh5WUBz4t6NKAt8VzROUXAMOCQGL1dyfBkSk8TrY2EqMmE2n7NONYN63n6MbZwhQ==
X-Received: by 2002:a17:902:9b97:: with SMTP id y23mr22894290plp.329.1549649224838;
        Fri, 08 Feb 2019 10:07:04 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w6sm3582050pga.72.2019.02.08.10.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:07:04 -0800 (PST)
Subject: Re: [PATCH V17 3/6] i2c: tegra: fix maximum transfer size
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     wsa@the-dreams.de, peda@axentia.se, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        stable@vger.kernel.org
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
Date:   Fri, 8 Feb 2019 21:06:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 20:49, Sowjanya Komatineni пишет:
> Tegra194 supports maximum 64K bytes transfer per packet.
> Tegra186 and prior supports maximum 4K bytes transfer per packet.
> 
> This includes 12 bytes of packet header and this limit is
> applicable irrespective of PIO or DMA mode transfers.
> 
> This patch fixes max write length to account for packet header size
> for transfers.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V16/V17] : I2C core max message size is 65536. So, max_read_len of 65535 is NOP.
> 	  Removed it leaving max_write_len
>  [V15]	: This is new patch in this series.
> 
> 
>  drivers/i2c/busses/i2c-tegra.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 3758c7a2c781..e4bf85e8dc14 100644
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
> @@ -899,12 +902,13 @@ static const struct i2c_algorithm tegra_i2c_algo = {
>  /* payload size is only 12 bit */
>  static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>  	.flags = I2C_AQ_NO_ZERO_LEN,
> -	.max_read_len = 4096,
> -	.max_write_len = 4096,
> +	.max_read_len = SZ_4K,
> +	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE,
>  };
>  
>  static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>  	.flags = I2C_AQ_NO_ZERO_LEN,
> +	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,

Ideally it should be SZ_64K - I2C_PACKET_HEADER_SIZE to not miss the one byte, otherwise good to me:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

