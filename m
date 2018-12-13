Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B93C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="DWfUfBh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3046A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeLMTsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:48:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40303 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeLMTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:48:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so2489930lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pWKbsIdfu6FrnU6d0cazKNK450zlM8oBtt4BJcYKBfg=;
        b=DWfUfBh+jiP94xaM4kBaBv3xFhHvqRP0kN3XdSwvltNbGAMR2qUlE6P98D6yDZnqPN
         xjUHhC7qoyaXuOBAC4sXQtxJHUeH19zrhdZit+FRPHqvrATdqG3TlyynOZVxmenaSH5i
         nFc7pi123Ak/+9j/hGcZ461ldN7kfbXMjtvnzdq5xfHy1E9YasuofNEtdG5YE5tzFqg/
         RpPj/aJ0JCJQFdb2Zce6Rw7HDuUui+ytbazJiB8SWsekJk1PKGZcJOuY8QNzpagZAJRQ
         fc4TPjqsBwvgPe3oQKSjGzKt+/9Cp3Che1R4j39qDcHgh6SXYscZ5Z/Rzp0nx83wjxP3
         rYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pWKbsIdfu6FrnU6d0cazKNK450zlM8oBtt4BJcYKBfg=;
        b=Z5snj0kbU2GUebvaIo6ceHCLK+k9ihOKchahaK6TpwjM+LC3vYqX5HVHjU+4GRLmRD
         V6jvEFkggfDEYv5qafi5C7shxRYUT+uMovBu8kqYQTKE9Yq+fW5FQNZ3CcSPxR3Xdrx/
         GT9ydtAAb0Pgc1bDK5avoBzDSyOr9aGxJxgyJrfQzothH2R6SdpHSIridY+ayhP7uRzP
         6/wDvC5BoE40G4Dm057EBoQu8QbVhWmHHROypczq9vlP2IvFhY2gmGkibYpzmYg1FHr8
         SxNw6ljGY7y1yYotjCDXyghObH4zT6ejzAv4Hsb6vhmAgO+qg8WS5JbG2NUnPyD79gRE
         tyjA==
X-Gm-Message-State: AA+aEWaDmERZuD8Yuer/6yUke7GAIFpShnKCQSHQPLc77gqXUJmUDj08
        FPtFQVjpg+m1gS/b4FDQOlIWiQ==
X-Google-Smtp-Source: AFSGD/XDmcv0CdsbqBfu5WASkcuMsIUKXk1cZxfx/jZCNdVDK/AduxnFz4nnCucD3gqrjlCgkxKMlw==
X-Received: by 2002:a19:c801:: with SMTP id y1mr55097lff.53.1544730484903;
        Thu, 13 Dec 2018 11:48:04 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.245])
        by smtp.gmail.com with ESMTPSA id r4sm510710lfe.60.2018.12.13.11.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:48:04 -0800 (PST)
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
Date:   Thu, 13 Dec 2018 22:48:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 02:13 PM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 776 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 783 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7d3a5c9..54b40f8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..cec5669
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,776 @@
[...]
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +	int ret;
> +
> +	ret = reset_control_reset(rpc->rstc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

   This degrades to:

{
	return reset_control_reset(rpc->rstc);
}

   So, we hardly need this function now...

[...]
> +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> +			   const void *tx_buf, void *rx_buf)
> +{
> +	u32 smenr, smcr, data, pos = 0;
> +	int ret = 0;
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +				  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +				  RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
> +
> +	if (tx_buf) {
> +		smenr = rpc->smenr;
> +
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;
> +
> +			regmap_write(rpc->regmap, RPC_SMWDR0,
> +				     get_unaligned((u32 *)(tx_buf + pos)));
> +
> +			if (nbytes > 4) {
> +				nbytes = 4;
> +				smcr = rpc->smcr |
> +				       RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
> +			} else {
> +				smcr = rpc->smcr | RPC_SMCR_SPIE;
> +			}
> +
> +			regmap_write(rpc->regmap, RPC_SMENR, smenr);
> +			regmap_write(rpc->regmap, RPC_SMCR, smcr);
> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			pos += nbytes;
> +			smenr = rpc->smenr & ~RPC_SMENR_CDE &
> +					     ~RPC_SMENR_ADE(0xf);
> +		}
> +	} else if (rx_buf) {
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;
> +
> +			if (nbytes > 4)
> +				nbytes = 4;
> +
> +			regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +			regmap_write(rpc->regmap, RPC_SMCR,
> +				     rpc->smcr | RPC_SMCR_SPIE);

   Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it sends
JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the writing
branch above...

> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			regmap_read(rpc->regmap, RPC_SMRDR0, &data);
> +			memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
> +			pos += nbytes;

   ... and it skips byte 4 unless I copy the code from the end of the writing
branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03 instead of 0.

> +			regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +			regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +			regmap_write(rpc->regmap, RPC_SMADR, rpc->addr + pos);
> +		}
> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;
> +out:
> +	return rpc_spi_do_reset(rpc);
> +}
[...]

MBR, Sergei
