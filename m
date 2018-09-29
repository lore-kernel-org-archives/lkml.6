Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3420879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTFzjX4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D3420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeI2TYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:24:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34444 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeI2TYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:24:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id q19-v6so10417404edr.1;
        Sat, 29 Sep 2018 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Vet9+d8MECqz4x7wr86ALZx7dPHCbSRgY+YnYT74J4=;
        b=lTFzjX4nu8qowc6x6wKHPzSYAuaWXTbPuRJl8nf5A3I6DqDM1dcoiVp4ifIWKfkwQs
         mhf4sOwyZlXejNmS0wJ4VcfEFrJbRofhuE8vw7gheJE3/5ikCGVqfztDgLls9x/TKiaU
         BKL4WGZkPHmJU/Y6DSFnKInmRMhQeisHUlAfl6gLshKXYjtF9QiUl5kGDXScIIrbzQK/
         +DLDey7+akWzwSYd0OSSedjAOdLTV+r9nH6Ue/HSb4KJQmq/H4CHyaXP2lRbel5kpoYe
         WgSE+aOMwS4Sv3mPMg4rOzZZxyPX0SI9+8Ye4xGrkww+Klubq8cGDZzvIdxaNa7F1PU2
         5z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Vet9+d8MECqz4x7wr86ALZx7dPHCbSRgY+YnYT74J4=;
        b=dszfXgbRuL76polIlRAZmtFnWuzNbqCFZMqBQ5u/Yfd97zRPQwIE2Q/+i++zmj2t9e
         QpnUHkbKjrAA9MuFUcgR0mqKJzM3vqIqop1blXo6uaz+SofbNHf6uAWNt9H2SmUM3pqK
         E4bvX5y/wVxMt6Gq2ItBRwWX18NUqTZYsRDj3H2sAtLLsJm+hoNGoxFT9gSh4dii8zXn
         +iiiNse0Uyn9/Ctg5asl+M9MrfM0Zq4uK6cWJDJTQb3pk62YrxDqdojFI641yXh1adpJ
         Nnc+J5dlko0Eu1jJ2N6ghL11X1zpxZTv5ZxzarJtgbJhTny9xlVWS5n7UNAe84lP8w31
         D1DQ==
X-Gm-Message-State: ABuFfoi/kTSOs77n+5SDlLGzhzaA1zTevObI6iQ3Ks3SB/NoLXyKKjxy
        OuYCRIJ+Qztc/LrB0VYqg3k=
X-Google-Smtp-Source: ACcGV628047HAuDboDTN1gJaW0Vcs+pxNCW/n7XqS6qvPEhknBhm+ne0unqYPHHjZcqt2lwj35BJ2A==
X-Received: by 2002:a17:906:1f87:: with SMTP id t7-v6mr1043044ejr.153.1538225776136;
        Sat, 29 Sep 2018 05:56:16 -0700 (PDT)
Received: from ziggy.stardust (p54A4E637.dip0.t-ipconnect.de. [84.164.230.55])
        by smtp.gmail.com with ESMTPSA id n25-v6sm2649074edq.27.2018.09.29.05.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 05:56:15 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mmc: mediatek: add bus_clk control
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
 <1538188195-3608-2-git-send-email-chaotian.jing@mediatek.com>
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
Message-ID: <b9a6e56c-0762-e8d7-08df-7633a8e28ec0@gmail.com>
Date:   Sat, 29 Sep 2018 14:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1538188195-3608-2-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2018 04:29, Chaotian Jing wrote:
> when gate MSDC0_HCLK, access register will hang, even the MSDC driver
> will never accessing register after HCLK was gated, but for safety, need
> gate the bus_clk(which used to access register) too.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 0484138..1c1c967 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -387,6 +387,7 @@ struct msdc_host {
>  
>  	struct clk *src_clk;	/* msdc source clock */
>  	struct clk *h_clk;      /* msdc h_clk */
> +	struct clk *bus_clk;	/* bus clock which used to access register */
>  	struct clk *src_clk_cg; /* msdc source clock control gate */
>  	u32 mclk;		/* mmc subsystem clock frequency */
>  	u32 src_clk_freq;	/* source clock frequency */
> @@ -660,12 +661,14 @@ static void msdc_gate_clock(struct msdc_host *host)
>  {
>  	clk_disable_unprepare(host->src_clk_cg);
>  	clk_disable_unprepare(host->src_clk);
> +	clk_disable_unprepare(host->bus_clk);
>  	clk_disable_unprepare(host->h_clk);
>  }
>  
>  static void msdc_ungate_clock(struct msdc_host *host)
>  {
>  	clk_prepare_enable(host->h_clk);
> +	clk_prepare_enable(host->bus_clk);
>  	clk_prepare_enable(host->src_clk);
>  	clk_prepare_enable(host->src_clk_cg);
>  	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> @@ -1900,6 +1903,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> +	if (IS_ERR(host->bus_clk))
> +		host->bus_clk = NULL;

That means the bus_clk is not requiered, even for mt2712, although the binding
says so. Not sure if this is good enough or if we want to enforce the driver to
actually error out, when the clock is not present in a mt2712 DTS.

I suppose that's up to the maintainer :)

Regards,
Matthias
