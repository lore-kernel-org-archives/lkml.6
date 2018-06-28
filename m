Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88607275B4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK2KGGlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88607275B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935428AbeF1PPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:15:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37890 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935370AbeF1PPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:15:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so9426519wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCI4wUp6HTXkxstLJP2tblmho36dwm57fQsHSo4XaaY=;
        b=WK2KGGlX6JrN6jrJnXLnqI2oqBIgBnmY9toILVcoddoVoxlAvOaJBEKDbeaaX690GG
         hhSl+Kdn/GMi+KjwGdraDhI0Tp6DuxnlQvsYYhTX27FEBflfWc1zKGOXWkzQi7cc7pDo
         ssfjsncZed8T1Q9t5Vsys243tJJaEOBIvKM+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCI4wUp6HTXkxstLJP2tblmho36dwm57fQsHSo4XaaY=;
        b=tzPtPXZN8Q0rzcSxLHRE0tkA0pKhrVCEi0sO16opyqdTbViQKVIQWCh3Iy8emdETtE
         PL9ti0B7sNjBJ5O79bJzAgTY/qIQDADmHTL8Hu4wBqtXRdtKLm+Ne65ENnSpEBr1sBiS
         nb/DppSx7E7z3jQrWQahkxE90WmhspB+M44niFODQTL2Xn9tJqp+0giHklw2gjS4depL
         a6T+PlIZHGt/J5yoA1hFF6iFKDszDXO52pvT4J+qkFzWvrmeAU5/WRHLgkwK223Z5Bpu
         l28gZPCc1piyzJ8//aA7gEMjY/DQVpef3C3eYj2XK63kSISe26Jhto36fI45PKHeeJqJ
         mLZg==
X-Gm-Message-State: APt69E1zgxpg3iOAdfxvDAtJpyGjftNTogTi05b/97kmNF7JCPEU8REg
        qnVjwji19WSFQe5z9fBSq5MwqZzHHuA=
X-Google-Smtp-Source: AAOMgpdByBUVrn+fSRc1Jz3wlG9K5uDCm//qy7EHnsrQrlpiqcR5djgJAYwLQ2FI4K/PEE3+KHLcJw==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr8226059wme.22.1530198936086;
        Thu, 28 Jun 2018 08:15:36 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:3923:5e2e:38ae:83dc? ([2001:41d0:fe90:b800:3923:5e2e:38ae:83dc])
        by smtp.googlemail.com with ESMTPSA id v19-v6sm5232460wmc.9.2018.06.28.08.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:15:34 -0700 (PDT)
Subject: Re: [PATCH v5 1/6] ARM: at91: add TCB registers definitions
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-2-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1bc64ccb-1e22-364c-e08c-fa86692783ff@linaro.org>
Date:   Thu, 28 Jun 2018 17:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619211929.22908-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 23:19, Alexandre Belloni wrote:
> Add registers and bits definitions for the timer counter blocks found on
> Atmel ARM SoCs.
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  include/soc/at91/atmel_tcb.h | 216 +++++++++++++++++++++++++++++++++++

Is the header necessary ? Can it be moved in the .c ?

>  1 file changed, 216 insertions(+)
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> new file mode 100644
> index 000000000000..3ed66031fc76
> --- /dev/null

[ ... ]

> +static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
> +{
> +	struct clk *clk;
> +	char clk_name[] = "t0_clk";
> +
> +	clk_name[1] += channel;

clever :)

> +	clk = of_clk_get_by_name(node->parent, clk_name);
> +	if (!IS_ERR(clk))
> +		return clk;
> +
> +	return of_clk_get_by_name(node->parent, "t0_clk");

Why do you want to return clk from t0_clk if another channel is
requested ? This is prone to error.

I would clarify that at the caller level, if tcb_clk_get fails then try
with channel zero.

> +}
> +
> +static inline int tcb_irq_get(struct device_node *node, int channel)

no inline

> +{
> +	int irq;
> +
> +	irq = of_irq_get(node->parent, channel);
> +	if (irq > 0)
> +		return irq;
> +
> +	return of_irq_get(node->parent, 0);

Same comment than above.

> +}
> +
> +static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> +
> +struct atmel_tcb_info {
> +	int bits;
> +};
> +
> +static const struct atmel_tcb_info atmel_tcb_infos[] = {
> +	{ .bits = 16 },
> +	{ .bits = 32 },
> +};

Structuring the code with structure is a good practice. However, this is
too much :)

> +static const struct of_device_id atmel_tcb_dt_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-tcb",
> +		.data = &atmel_tcb_infos[0],

		.data = (void *)16;

> +	}, {
> +		.compatible = "atmel,at91sam9x5-tcb",
> +		.data = &atmel_tcb_infos[1],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +



> +#endif /* __SOC_ATMEL_TCB_H */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

