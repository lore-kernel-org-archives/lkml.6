Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2CE20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0y+dTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2CE20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeIYVqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:46:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40761 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeIYVqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:46:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so3723690pfj.7;
        Tue, 25 Sep 2018 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tg784LxR7bs8FG/2jY26vCmVwzxE/NVAOY5nu7jF72U=;
        b=Qb0y+dToWmuH5KbvexCddIzJQhgDJxuyKyidFp+jpcwSTUC4gLtOuusYCD7s2jXzu3
         4fpFpIXrm4hUCaeZXe+74gjmG1QbG1xstEe9HokVNbz+0PJTGk9Lmb8SGnczM6S+C8qm
         0BcR5sIxBJh+KdO8IjaBUHOufQHKvakzA6qpxyayPV3MuaGn3GPhnckoqSrXqmOC2HPd
         UpQ4CA3UWtl6djSReVFFl6bK247WOEvey13o8bT9UCyFVhCjJmuTHvifBIZNJJmwhqQR
         bOnNOc35RY/ZiWLwQopvNNEG0yBDSJrKZOCVNsrgVB5ZJJbFOU9qg+jiWRVW2sX7/dAD
         9XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tg784LxR7bs8FG/2jY26vCmVwzxE/NVAOY5nu7jF72U=;
        b=QcjzL3Bw4F3EY0XoL9jY45M0TaNHS1WK2ovNvmly3IyB6IWbAWLXHvY5ejNM1GCa3F
         E+l0YT8oZHV28PiATQnAJ/yqtpoQhmUDRXroGlnZg7Gv+/CFgBxNnGCDanx61+HT1WI4
         mJgE1Uo2HH9WvdjLQ32hyaxEPA5SuVTVJvvWrKnewm4TUgjZ7voMnv2P/TYIRA9OMlvL
         RcCpuPMVbT8MnGEyFnLyNW/OMjFVcLIjdMbqXAAdn6/SgWcyDfWYrKxmd4NK2vlxXzoS
         nI6IfnNS6vz8CL1Nnr44mnXS3RYqGVEdTZUdotdd6BKETfHgG+D7xtPHhCg4YEgZEh6/
         vD4A==
X-Gm-Message-State: ABuFfoiI/V8wfyccGLxFaohg2G2ZGlQiAjhUCgjJXXeGTPuWdKnNN7oU
        1b9Sjk0Yet9zVR6/g74upBo=
X-Google-Smtp-Source: ACcGV62ZiiJdDEyshT40vhUDfPm8LDGCCLGcLJjye+86zwt8Lrn15D0BBIYD8UQlZ1/4s9X2o+DLSA==
X-Received: by 2002:a63:31c8:: with SMTP id x191-v6mr1571989pgx.229.1537889918447;
        Tue, 25 Sep 2018 08:38:38 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id i80-v6sm1958413pfi.87.2018.09.25.08.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:38:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] soc: mediatek: pwrap: add pwrap driver for mt6765
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
 <1536064314-31967-3-git-send-email-argus.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <dc257382-f930-158e-f5b3-4375707f2a63@gmail.com>
Date:   Tue, 25 Sep 2018 17:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536064314-31967-3-git-send-email-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 14:31, Argus Lin wrote:
> mt6765 is a highly integrated SoCs, it uses mt6357 for power management.
> This patch adds pwrap driver to access mt6357. Pwrap of mt6765 support
> dynamic priority meichanism, sequence monitor and starvation mechanism
> to make transaction more reliable.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>

I fixed the has_bridge variable, as this is obsolete now.
Please check that I didn't do an error.

Applied to v4.19-next/soc

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 49 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 4e931fd..ddaeace 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -381,6 +381,38 @@ enum pwrap_regs {
>  	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
>  };
>  
> +static int mt6765_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_RDDMY] =			0x20,
> +	[PWRAP_CSHEXT_WRITE] =		0x24,
> +	[PWRAP_CSHEXT_READ] =		0x28,
> +	[PWRAP_CSLEXT_START] =		0x2C,
> +	[PWRAP_CSLEXT_END] =		0x30,
> +	[PWRAP_STAUPD_PRD] =		0x3C,
> +	[PWRAP_HARB_HPRIO] =		0x68,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x6C,
> +	[PWRAP_MAN_EN] =		0x7C,
> +	[PWRAP_MAN_CMD] =		0x80,
> +	[PWRAP_WACS0_EN] =		0x8C,
> +	[PWRAP_WACS1_EN] =		0x94,
> +	[PWRAP_WACS2_EN] =		0x9C,
> +	[PWRAP_INIT_DONE2] =		0xA0,
> +	[PWRAP_WACS2_CMD] =		0xC20,
> +	[PWRAP_WACS2_RDATA] =		0xC24,
> +	[PWRAP_WACS2_VLDCLR] =		0xC28,
> +	[PWRAP_INT_EN] =		0xB4,
> +	[PWRAP_INT_FLG_RAW] =		0xB8,
> +	[PWRAP_INT_FLG] =		0xBC,
> +	[PWRAP_INT_CLR] =		0xC0,
> +	[PWRAP_TIMER_EN] =		0xE8,
> +	[PWRAP_WDT_UNIT] =		0xF0,
> +	[PWRAP_WDT_SRC_EN] =		0xF4,
> +	[PWRAP_DCM_EN] =		0x1DC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1E0,
> +};
> +
>  static int mt6797_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -690,6 +722,7 @@ enum pmic_type {
>  
>  enum pwrap_type {
>  	PWRAP_MT2701,
> +	PWRAP_MT6765,
>  	PWRAP_MT6797,
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
> @@ -1117,6 +1150,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
>  		break;
>  	case PWRAP_MT2701:
> +	case PWRAP_MT6765:
>  	case PWRAP_MT6797:
>  	case PWRAP_MT8173:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
> @@ -1460,6 +1494,18 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6765 = {
> +	.regs = mt6765_regs,
> +	.type = PWRAP_MT6765,
> +	.arb_en_all = 0x3fd35,
> +	.int_en_all = 0xffffffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 0,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct pmic_wrapper_type pwrap_mt6797 = {
>  	.regs = mt6797_regs,
>  	.type = PWRAP_MT6797,
> @@ -1513,6 +1559,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  		.compatible = "mediatek,mt2701-pwrap",
>  		.data = &pwrap_mt2701,
>  	}, {
> +		.compatible = "mediatek,mt6765-pwrap",
> +		.data = &pwrap_mt6765,
> +	}, {
>  		.compatible = "mediatek,mt6797-pwrap",
>  		.data = &pwrap_mt6797,
>  	}, {
> 
