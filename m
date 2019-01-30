Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE45C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C1A21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UiSM1HjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfA3GAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:00:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36068 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfA3GAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:00:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so10925452pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWZ9IvmdKBF0L6x0dpsHADFxCnzbAOdaGQVcC4KQZwY=;
        b=UiSM1HjJJWh8FSlwZuSDVlnx0+qTI0NpWEcD92mIRBTn2J7+mt0H/7WwZfZtJSZ3wT
         7NgITUTXHpBGQSq8jglG3Oe+WORRC7rEpeKau3FP8cYZN4sXPVm83Cy60cSSfuH4XyZs
         YkYhQQ8tml4BuuWbkpqzDgARnyd36gUpQizZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWZ9IvmdKBF0L6x0dpsHADFxCnzbAOdaGQVcC4KQZwY=;
        b=mvwqRzvpUCd6xNqk7XXSRwfl9m4H3CaUHSVgyoypPGphLNfvlFzoQjcovNUxTXc0yT
         wNBUrrLatW0twc75hCznQrQBgyCPAgXaw9w0MDVHY55xMT8w33h0nqpDzQAK0V4YX1to
         05KfHKFZqH46OY3XoY1uTkudtZYRT5P9KBcfAxWODfdqTqBRvMgrSKPE2n2PrdiCpNbK
         NXpseyai98SUHdrGKLS/7Efe65gY3qQGsJF9qkYQeNOCG5zBrtkrZosTDUWSJuuAHgaW
         VRrq8+JI6IMetCFe6lUGt79Va6bB2N4o9hajK908t7X/rB+asCSUcfDp3AAgNRXKuN7c
         dAxA==
X-Gm-Message-State: AJcUukc9r56KmuvaAeP8RPdGS5vrbDhjb+FW5MG2ncmvBtbcA7JFQpVq
        syJo1BMksBk/QW8i5Re5X6eBrp/aC74kaQ==
X-Google-Smtp-Source: ALg8bN4c/hZe16eU8bIYTHIh5N91aoEY/p+s0rsCBFxiJV6Vz7Xgp/tQT3fWvvmsXe+X3kdneLOEyw==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr25326626pgg.347.1548828033231;
        Tue, 29 Jan 2019 22:00:33 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.gmail.com with ESMTPSA id w3sm712259pge.8.2019.01.29.22.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:00:32 -0800 (PST)
Subject: Re: [PATCH 06/10] soc: mediatek: add register device function
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        srv_heupstream@mediatek.com,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        kendrick.hsu@mediatek.com, linux-mediatek@lists.infradead.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Frederic Chen <Frederic.Chen@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, ginny.chen@mediatek.com
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-7-git-send-email-bibby.hsieh@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <69c8ff46-c34c-c000-631c-a6ea8b4364c7@chromium.org>
Date:   Wed, 30 Jan 2019 14:00:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-7-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> GCE cannot know the register base address, we store the subsys-base address
> relationship in the device node, and store the relationship by
> cmdq_register_device function.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 24 ++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 6e4b85e..6ad997f 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -32,6 +32,30 @@ u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
>   }
>   EXPORT_SYMBOL(cmdq_subsys_base_to_id);
>   
> +struct cmdq_base *cmdq_register_device(struct device *dev)
> +{
> +	struct cmdq_base *clt_base;
> +	struct of_phandle_args spec;
> +	u32 idx;
> +
> +	clt_base = devm_kzalloc(dev, sizeof(*clt_base), GFP_KERNEL);
> +	if (!clt_base)
> +		return NULL;
> +
> +	/* parse subsys */
> +	for (idx = 0; idx < ARRAY_SIZE(clt_base->subsys); idx++) {
> +		if (of_parse_phandle_with_args(dev->of_node, "gce-subsys",
> +		    "#gce-subsys-cells", idx, &spec))

nit: Should have more indention for the line above. (Align with the
dev->of_node?)

> +			break;
> +		clt_base->subsys[idx].base = spec.args[0];
> +		clt_base->subsys[idx].id = spec.args[1];
> +	}
> +	clt_base->count = idx;
> +
> +	return clt_base;
> +}
> +EXPORT_SYMBOL(cmdq_register_device);
> +
>   static void cmdq_client_timeout(struct timer_list *t)
>   {
>   	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 0c7a6ee..a1f5eb6 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -138,5 +138,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   int cmdq_pkt_flush(struct cmdq_pkt *pkt);
>   
>   u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
> +struct cmdq_base *cmdq_register_device(struct device *dev);
>   
>   #endif	/* __MTK_CMDQ_H__ */
> 
