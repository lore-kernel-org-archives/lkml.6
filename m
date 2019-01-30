Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D3C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF220989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wi6gewMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfA3GBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:01:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfA3GA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:00:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so9880063pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKKy7Zp7rHZIgz0Vlqdz0knCbBY+6CXoKW8FO1Am1iA=;
        b=Wi6gewMNPfCuXhGbctuuPwEPCohGiR7PHkl3xxMZscIE8PVutOFjG6IctY77YggX8a
         D64ttY3/WQK0MnrcHZfU2jJBUkHHecb1WBy88ni+4GoonYavRNaYx63tZQCNzTw71/Mo
         1384JzJ+PtchdC4Z+14dQvVVTxbqXtj3PLvPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKKy7Zp7rHZIgz0Vlqdz0knCbBY+6CXoKW8FO1Am1iA=;
        b=GJEEKSXVraHGMNoMLhl9arpPQhTlVZwvCiBxhrMPfarhwmklzGkvZNYDJRAxMq/EUX
         c+q54H5WuvoIYqGQFhKtgbgVC6hfKyWr90GUox32tXtxkwkOcdc+iG4VjT4we0obF6cw
         clG2hkuxeVJ4x96E9n1L/bo6nZHN2XjhZos0gSlxvJJ9tyC4kPAMtUhfvqsBU5qgaTgq
         kRwABySyugoUIbcJkUV5zPZYoQCbTp0+GyzroPbb+5cnYckWsBOSrcgKuOkD/E+l+4Qy
         tU/VeNlZYnGJ5H8V0rFFdbpAMxoSK7DRPepEKEBZZZ5UIjnMcLSjm9zuNb/p5R15bxYi
         oYYA==
X-Gm-Message-State: AJcUukfG/AvADY24/EfVyo+BW/ty53X4UOiN+LthT6+CYaYN9pYL06HD
        VqlJ+a7tUHInuLxSzW+wYjhKLg==
X-Google-Smtp-Source: ALg8bN5Y2WzVzwuUyOkOjtFgT7y7OWrAS7VbV2j9Hzs8UbwwevKW+UjYzQrize81jlFNzK3gtJuOeQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr24414736pgd.97.1548828058939;
        Tue, 29 Jan 2019 22:00:58 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.gmail.com with ESMTPSA id f62sm683412pgc.67.2019.01.29.22.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:00:58 -0800 (PST)
Subject: Re: [PATCH 07/10] soc: mediatek: add cmdq_dev_get_event function
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
 <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <4d6f8e17-58d7-2986-29b0-3e0134836929@chromium.org>
Date:   Wed, 30 Jan 2019 14:00:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> When client ask gce to clear or wait for event,
> client need to pass event number to the API.
> We suggest client store the event information in device node,
> so we provide an API for client parse the event property.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 29 +++++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 6ad997f..16c0393 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -56,6 +56,35 @@ struct cmdq_base *cmdq_register_device(struct device *dev)
>   }
>   EXPORT_SYMBOL(cmdq_register_device);
>   
> +s32 cmdq_dev_get_event(struct device *dev, const char *name)
> +{
> +	s32 index = 0;
> +	struct of_phandle_args spec;
> +	s32 result;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	index = of_property_match_string(dev->of_node, "gce-event-names", name);
> +	if (index < 0) {
> +		dev_err(dev, "no gce-event-names property or no such event:%s",
> +			name);
> +		return index;
> +	}
> +
> +	if (of_parse_phandle_with_args(dev->of_node, "gce-events",
> +	    "#gce-event-cells", index, &spec)) {

nit: Should have more indention for the line above. (Align with the
dev->of_node?)

> +		dev_err(dev, "can't parse gce-events property");
> +		return -ENODEV;
> +	}
> +
> +	result = spec.args[0];
> +	of_node_put(spec.np);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(cmdq_dev_get_event);
> +
>   static void cmdq_client_timeout(struct timer_list *t)
>   {
>   	struct cmdq_client *client = from_timer(client, t, timer);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a1f5eb6..e5b0a98 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -139,5 +139,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>   
>   u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
>   struct cmdq_base *cmdq_register_device(struct device *dev);
> +s32 cmdq_dev_get_event(struct device *dev, const char *name);
>   
>   #endif	/* __MTK_CMDQ_H__ */
> 
