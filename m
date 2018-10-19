Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDDECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBlAsMHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC1821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJSQyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:54:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37750 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:54:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id c22-v6so30727558edc.4;
        Fri, 19 Oct 2018 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5PyWh3DIEuBD6OjiJ2xlnGiXa4cwft71UmBzEHvO/uU=;
        b=iBlAsMHx83RS+Zo/l0iw7lUsi9736TWRovFCzM13och+j3i2exMMHmaKjpoVfo7yhC
         NCd2jIZ3aoRM4l4l11suieR5SvyBVdcWFJDw1Z71ziyTlZ3CwpZcJETVhaIFAtHkRdut
         oZrIX8egmaMSfWnu6ZIxU+ulbNEeBzAcepHhXM0NUK3LDJTt6pBsaKkWdpGlvWlD0c/0
         RoOdq/7KU1gYu2xz4qkHVkkH45lvE8l6IIEV7408wSRqPdfG6kgKlJ1mAZcDcugdY9/Z
         ZAR/Kesje2t5BaYjA/JU317YpbRfiKSWuR9BXNZpEW7Y+rEyT6CtcuuA3bWKDaU2x2ip
         tKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5PyWh3DIEuBD6OjiJ2xlnGiXa4cwft71UmBzEHvO/uU=;
        b=AreCdqhrZ3SKiBCAjkIkK1Uu/1+7jqD7PoI4V2KfHh7pJpwyn2bOmBIJAk4inrKrJX
         v190FFJbpCwHZzwhsB491Nm9p2NcF1kdQXopyl8zcJoSdD71BkPXKZsO5DU5S2/zjYqY
         gegwWEMww/8L5VivfXBhCdMbUrJDbv5w/SKWJmUzZcCIYEfAi4ApfUcDeTh2fWroBjmK
         DNyt2lunK56TxbWJ5xAZsvJNQnwyqmYTd0PydZykOa7tzvysC4V5gkhMBUNCeknfjtPG
         zcUGYJpigSM2vR1YcxYqu8W4nzhHi3sq2JRzi6jU4Pet+A0Or/OCZMfytUH7SgJq68g3
         2XHg==
X-Gm-Message-State: ABuFfoj0ZUM+n7vosjYZCQ/xLf71ROze9nwPitXz3t8R0S2ZB38s7EBg
        icNysk2xR2OtqW7ggdQ8ZMM=
X-Google-Smtp-Source: ACcGV62UsgUyU88mZAIFNpBbOtyDoDALIycU+NvdqHvVFNqrUsXPexRvO0WThcFqb2W6ZTYRsHLmBw==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr5191553edy.99.1539938931516;
        Fri, 19 Oct 2018 01:48:51 -0700 (PDT)
Received: from ziggy.stardust ([93.176.144.101])
        by smtp.gmail.com with ESMTPSA id s46-v6sm10692662edb.49.2018.10.19.01.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 01:48:50 -0700 (PDT)
Subject: Re: [PATCH 4/6] mmc: mediatek: tune CMD/DATA together
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, jjian.zhou@mediatek.com,
        wenbin.mei@mediatek.com
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
 <1539415250-32337-5-git-send-email-chaotian.jing@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <51d95ab5-896e-c386-7a3e-362e8a3c2960@gmail.com>
Date:   Fri, 19 Oct 2018 10:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539415250-32337-5-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/10/2018 09:20, Chaotian Jing wrote:
> for MSDC IP which supports both data tune and async fifo, it can
> tune cmd/data together. which can save the time and make the tune
> result of CMD more stable as data line are 4bit or 8bit.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fe80a1d..09d7e44 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1773,12 +1773,98 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	return final_delay == 0xff ? -EIO : 0;
>  }
>  
> +/*
> + * MSDC IP which supports data tune + async fifo can do CMD/DAT tune
> + * together, which can save the tuning time.
> + */
> +static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct msdc_host *host = mmc_priv(mmc);
> +	u32 rise_delay = 0, fall_delay = 0;
> +	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
> +	u8 final_delay, final_maxlen;
> +	u32 tune_reg = host->dev_comp->pad_tune_reg;
> +	int i, ret;
> +
> +	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
> +		      host->latch_ck);
> +
> +	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +	sdr_clr_bits(host->base + MSDC_IOCON,
> +		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		ret = mmc_send_tuning(mmc, opcode, NULL);
> +		if (!ret)
> +			rise_delay |= (1 << i);
> +	}
> +	final_rise_delay = get_best_delay(host, rise_delay);
> +	/* if rising edge has enough margin, then do not scan falling edge */
> +	if (final_rise_delay.maxlen >= 12 ||
> +	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
> +		goto skip_fall;
> +
> +	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +	sdr_set_bits(host->base + MSDC_IOCON,
> +		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		ret = mmc_send_tuning(mmc, opcode, NULL);
> +		if (!ret)
> +			fall_delay |= (1 << i);
> +	}
> +	final_fall_delay = get_best_delay(host, fall_delay);
> +
> +skip_fall:
> +	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
> +	if (final_maxlen == final_rise_delay.maxlen) {
> +		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +		sdr_clr_bits(host->base + MSDC_IOCON,
> +			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> +			      final_rise_delay.final_phase);
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_DATRRDLY,
> +			      final_rise_delay.final_phase);
> +		final_delay = final_rise_delay.final_phase;
> +	} else {
> +		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> +		sdr_set_bits(host->base + MSDC_IOCON,
> +			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> +			      final_fall_delay.final_phase);
> +		sdr_set_field(host->base + tune_reg,
> +			      MSDC_PAD_TUNE_DATRRDLY,
> +			      final_fall_delay.final_phase);
> +		final_delay = final_fall_delay.final_phase;
> +	}
> +
> +	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
> +	return final_delay == 0xff ? -EIO : 0;
> +}
> +
>  static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct msdc_host *host = mmc_priv(mmc);
>  	int ret;
>  	u32 tune_reg = host->dev_comp->pad_tune_reg;
>  
> +	if (host->dev_comp->data_tune && host->dev_comp->async_fifo) {
> +		ret = msdc_tune_together(mmc, opcode);
> +		if (host->hs400_mode) {
> +			sdr_clr_bits(host->base + MSDC_IOCON,
> +				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, 0);
> +		}
> +		goto tune_done;
> +	}
>  	if (host->hs400_mode &&

Couldn't we put a else if here instead of using a goto?

Regards,
Matthias

>  	    host->dev_comp->hs400_tune)
>  		ret = hs400_tune_response(mmc, opcode);
> @@ -1794,6 +1880,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  			dev_err(host->dev, "Tune data fail!\n");
>  	}
>  
> +tune_done:
>  	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
>  	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
>  	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
> 
