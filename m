Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB444C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A74208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBfRBZ6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A74208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeIYVrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:47:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43769 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:47:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so10971624pgn.10;
        Tue, 25 Sep 2018 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ex1QtYFkUKbnwQJJPgaNQcIWgem2nTUcaZ/09YQdIfI=;
        b=qBfRBZ6XCSmwMG8rHG2JL7cCXMsRtzPTkyPNbtwre1DLnLo5wvgibYonqG/gc6BbTC
         ppsUAeCyvAqbGY+aG88LZBpCdPWVREgkRzgOeKkFk5RqNfEGFIBzo7NonkIXrg971Dbt
         2gvb/Zmsfx20tJEkOh1zNQj9lc1uUma5lhJ3AcmNr1KXs63zqpfiP6fDPENtU6Lbfp9u
         K+aFSWF0iIlVW7kHvlF8N8YOy8kjHlmu4LMNeCmGYkmjtu7Haol7KN6Dx6hQHkkDTbmf
         eAxjmHiZjMKGYcKeerp8DgW6FwYPIGpDY7fmI7NKy9XdrFbuDc/AMIEkRg1zu8GJuZww
         K4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ex1QtYFkUKbnwQJJPgaNQcIWgem2nTUcaZ/09YQdIfI=;
        b=tXwyGGqhBr/OmJ8ZZ+kfjDe22WBoHJS28HxFqx0FuefFkMo3Dzf5fwe45njDWsPHVG
         XeCxJfCJTVJpeCGATi13VVaf3S4xL/hlxCb6lLaaHAtsPmfNXbmKZTw66ktiZ2MihKf5
         +h1CCpcPB62fha/3W5nbniAqc/yXgxw2SxTxO4JZL9ImUmrxhrx9LPsP0Cpiztv5Mxkm
         xgDz+XHXV1TOLsW+PzyA3uiE4Cmp8ZlaTE9U3ogC1iRD9PpMwZc+c3917eJndNQJt1gg
         bluVtYdXrGuUqSZ50svsxFTs8VoFUKFUU4q4JbNUY+Xh23ya0kJzBDvZAGdxHtx6wvoJ
         Km+A==
X-Gm-Message-State: ABuFfoiJVkZvWx+KWCYZgQ3odq7jUk9CigLsyoPLZ43TaVGpP/3C08Nh
        2WloqlkLgpSzD22sC+ebaiI=
X-Google-Smtp-Source: ACcGV62a6SISOU4HK8mQ+JTHcr2FibojluA5vKpb1GqKRauickhVfwlBj5E+PtTkEHd2DzJAyUp7JA==
X-Received: by 2002:a63:e918:: with SMTP id i24-v6mr1696942pgh.64.1537889974702;
        Tue, 25 Sep 2018 08:39:34 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3296684pgo.2.2018.09.25.08.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:39:33 -0700 (PDT)
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add mt6357 driver for mt6765
 SoCs
To:     Argus Lin <argus.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra.v" <shailendra.v@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1536064314-31967-1-git-send-email-argus.lin@mediatek.com>
 <1536064314-31967-4-git-send-email-argus.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <1fd800c0-9e7c-9533-6724-55cd8eee9964@gmail.com>
Date:   Tue, 25 Sep 2018 17:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536064314-31967-4-git-send-email-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 14:31, Argus Lin wrote:
> MT6357 is a new power management IC and it is used for mt6765 SoCs.
> To define mt6357_regs for pmic register mapping and pmic_mt6357
> for accessing register.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>

Needed some handwork to get it applied, please check that no bug slipped in.

Applied to v4.19-ext/soc

Thanks a lot.

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index ddaeace..2b2cee1 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -161,6 +161,21 @@ enum dew_regs {
>  	[PWRAP_DEW_RDDMY_NO] =		0x030C,
>  };
>  
> +static const u32 mt6357_regs[] = {
> +	[PWRAP_DEW_DIO_EN] =		0x040A,
> +	[PWRAP_DEW_READ_TEST] =		0x040C,
> +	[PWRAP_DEW_WRITE_TEST] =	0x040E,
> +	[PWRAP_DEW_CRC_EN] =		0x0412,
> +	[PWRAP_DEW_CRC_VAL] =		0x0414,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0418,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041A,
> +	[PWRAP_DEW_CIPHER_EN] =		0x041C,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x041E,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x0420,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x0422,
> +	[PWRAP_DEW_RDDMY_NO] =		0x0424,
> +};
> +
>  enum pwrap_regs {
>  	PWRAP_MUX_SEL,
>  	PWRAP_WRAP_EN,
> @@ -716,6 +731,7 @@ enum pwrap_regs {
>  enum pmic_type {
>  	PMIC_MT6323,
>  	PMIC_MT6351,
> +	PMIC_MT6357,
>  	PMIC_MT6380,
>  	PMIC_MT6397,
>  };
> @@ -1175,6 +1191,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		break;
>  	case PMIC_MT6323:
>  	case PMIC_MT6351:
> +	case PMIC_MT6357:
>  		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_EN],
>  			    0x1);
>  		break;
> @@ -1460,11 +1477,26 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.pwrap_write = pwrap_write16,
>  };
>  
> +static const struct pwrap_slv_type pmic_mt6357 = {
> +	.dew_regs = mt6357_regs,
> +	.type = PMIC_MT6357,
> +	.regmap = &pwrap_regmap_config16,
> +	.caps = 0,
> +	.pwrap_read = pwrap_read16,
> +	.pwrap_write = pwrap_write16,
> +};
> +
>  static const struct of_device_id of_slave_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt6323",
>  		.data = &pmic_mt6323,
>  	}, {
> +		.compatible = "mediatek,mt6351",
> +		.data = &pmic_mt6351,
> +	}, {
> +		.compatible = "mediatek,mt6357",
> +		.data = &pmic_mt6357,
> +	}, {
>  		/* The MT6380 PMIC only implements a regulator, so we bind it
>  		 * directly instead of using a MFD.
>  		 */
> @@ -1474,9 +1506,6 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  		.compatible = "mediatek,mt6397",
>  		.data = &pmic_mt6397,
>  	}, {
> -		.compatible = "mediatek,mt6351",
> -		.data = &pmic_mt6351,
> -	}, {
>  		/* sentinel */
>  	}
>  };
> 
