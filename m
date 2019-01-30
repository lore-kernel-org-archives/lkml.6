Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC90BC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797E21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbVdWpwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfA3GBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:01:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfA3GBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:01:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so10901439pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=samU8fo3ywPoP/rVSLYa27WCE33+YfoN0anBeV5TrXk=;
        b=PbVdWpwHE3dY1giHuc1367CPou6B4V9bcHnMGB5PC6+FUnim8Zsum4A2ugPeQE6NOI
         niApwQDnyQ/eblojQI+8r7eYxUwgUs3yxobW1RZPHqT3xNGHxeM9cQnf2p1EsosV48AT
         hq8IdIdA6kqKbfXfzR/PGjw2qnLg6osx8CExw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=samU8fo3ywPoP/rVSLYa27WCE33+YfoN0anBeV5TrXk=;
        b=FAbDO2soRZg59M3phoV9ambP2bN0GTg21EiM7dIQOzaFxSuMTylX0XKrZlnbvhTRVl
         V8RvoNVWU2F3uyOdtTWgwsX3ob0H6jkPuTeBNm6SwE61V1U1dBeCzAfM58Os+14ysluJ
         Cw/OPHRZ4wRyMPGKEn/vqDnyH2maUTaQ/gjVPXBslHeRZVTI/3gtb0/p7IyadYIsRyaW
         WtmQ6/n6QYpvj8Klwb9ffVRAVBO92x5KNiEN7/XiqBt2IMFTwlw50Zp5Grh+W5HuT4rb
         E9+n6UjHv4b4FdpAqJwuUWTF8XiJjX/0XifJ3F76pRv8bSN6NJ6UaU8gsQkRMxH2LwQ3
         CQ6A==
X-Gm-Message-State: AJcUukcqO6KZkb5G808xi2D3eqX9qX57swCbd6wVw52vJGEqV3U+4yp3
        QumnyrIH50tUROIXGKuHQYlXlQ==
X-Google-Smtp-Source: ALg8bN64u60hq7uAhVMUaSksQqc+0PWXigb1KiFbWJyB4TXoKnC8/S/ucn5WDpCFFg6GBbRre4Ozvw==
X-Received: by 2002:a63:1560:: with SMTP id 32mr25849129pgv.383.1548828111978;
        Tue, 29 Jan 2019 22:01:51 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.gmail.com with ESMTPSA id t21sm560643pgg.24.2019.01.29.22.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:01:51 -0800 (PST)
Subject: Re: [PATCH 08/10] soc: mediatek: add packet encoder function
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
 <1548747128-60136-9-git-send-email-bibby.hsieh@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <c1aba25b-5d8c-b79a-36b3-3d6217a5aa6b@chromium.org>
Date:   Wed, 30 Jan 2019 14:01:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548747128-60136-9-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 03:32 PM, Bibby Hsieh wrote:
> Implement a function can encode the GCE instructions
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c   | 102 ++++++++++++++++++++-----------
>   include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
>   include/linux/soc/mediatek/mtk-cmdq.h    |  14 ++---
>   3 files changed, 76 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 16c0393..923a815 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -9,11 +9,43 @@
>   #include <linux/mailbox_controller.h>
>   #include <linux/soc/mediatek/mtk-cmdq.h>
>   
> -#define CMDQ_ARG_A_WRITE_MASK	0xffff
> +#define CMDQ_GET_ARG_B(arg)	(((arg) & GENMASK(31, 16)) >> 16)
> +#define CMDQ_GET_ARG_C(arg)	((arg) & GENMASK(15, 0))
>   #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
>   #define CMDQ_EOC_IRQ_EN		BIT(0)
>   #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
>   				<< 32 | CMDQ_EOC_IRQ_EN)
> +#define CMDQ_IMMEDIATE_VALUE	0
> +#define CMDQ_REG_TYPE		1
> +
> +struct cmdq_instruction {
> +	s16 arg_c:16;
> +	s16 arg_b:16;
> +	s16 arg_a:16;
> +	u8 s_op:5;
> +	u8 arg_c_type:1;
> +	u8 arg_b_type:1;
> +	u8 arg_a_type:1;
> +	u8 op:8;
> +};
> +
> +static void cmdq_pkt_instr_encoder(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
> +				   s16 arg_a, u8 s_op, u8 arg_c_type,
> +				   u8 arg_b_type, u8 arg_a_type, u8 op)
> +{
> +	struct cmdq_instruction *cmdq_inst;
> +
> +	cmdq_inst = pkt->va_base + pkt->cmd_buf_size;
> +	cmdq_inst->op = op;
> +	cmdq_inst->arg_a_type = arg_a_type;
> +	cmdq_inst->arg_b_type = arg_b_type;
> +	cmdq_inst->arg_c_type = arg_c_type;
> +	cmdq_inst->s_op = s_op;
> +	cmdq_inst->arg_a = arg_a;
> +	cmdq_inst->arg_b = arg_b;
> +	cmdq_inst->arg_c = arg_c;
> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +}
>   
>   u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
>   {
> @@ -180,10 +212,11 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_destroy);
>   
> -static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> -				   u32 arg_a, u32 arg_b)
> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
> +				   s16 arg_a, u8 s_op, u8 arg_c_type,
> +				   u8 arg_b_type, u8 arg_a_type,
> +				   enum cmdq_code code)
>   {
> -	u64 *cmd_ptr;
>   
>   	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>   		/*
> @@ -199,65 +232,59 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>   			__func__, (u32)pkt->buf_size);
>   		return -ENOMEM;
>   	}
> -	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> -	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> -	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +	cmdq_pkt_instr_encoder(pkt, arg_c, arg_b, arg_a, s_op, arg_c_type,
> +			       arg_b_type, arg_a_type, code);
>   
>   	return 0;
>   }
>   
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>   {
> -	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
> -		    (subsys << CMDQ_SUBSYS_SHIFT);
> -
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
> +				       CMDQ_GET_ARG_B(value), offset, subsys,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE,
> +				       CMDQ_IMMEDIATE_VALUE, CMDQ_CODE_WRITE);

All other codes use 0 instead of CMDQ_IMMEDIATE_VALUE. Also use 0 here
or use CMDQ_IMMEDIATE_VALUE at other places too?

>   }
>   EXPORT_SYMBOL(cmdq_pkt_write);
>   
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> -			u32 subsys, u32 offset, u32 mask)
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> +			u32 value, u32 mask)
>   {
>   	u32 offset_mask = offset;
>   	int err = 0;
>   
>   	if (mask != 0xffffffff) {
> -		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> +		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
> +					      CMDQ_GET_ARG_B(~mask), 0, 0, 0, 0,
> +					      0, CMDQ_CODE_MASK);
>   		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
>   	}
> -	err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
> +	err |= cmdq_pkt_write(pkt, subsys, offset_mask, value);

I know that the code was already that way before, but why do you or
the 2 return values, instead of just returning early if
cmdq_pkt_append_command fails?

>   
>   	return err;
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_mask);
>   
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
>   {
> -	u32 arg_b;
> -
>   	if (event >= CMDQ_MAX_EVENT)
>   		return -EINVAL;
>   
> -	/*
> -	 * WFE arg_b
> -	 * bit 0-11: wait value
> -	 * bit 15: 1 - wait, 0 - no wait
> -	 * bit 16-27: update value
> -	 * bit 31: 1 - update, 0 - no update
> -	 */
> -	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> -
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_OPTION),
> +				       CMDQ_GET_ARG_B(CMDQ_WFE_OPTION), event,
> +				       0, 0, 0, 0, CMDQ_CODE_WFE);
>   }
>   EXPORT_SYMBOL(cmdq_pkt_wfe);
>   
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	if (event >= CMDQ_MAX_EVENT)
>   		return -EINVAL;
>   
> -	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
> -				       CMDQ_WFE_UPDATE);
> +	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_UPDATE),
> +				       CMDQ_GET_ARG_B(CMDQ_WFE_UPDATE), event,
> +				       0, 0, 0, 0, CMDQ_CODE_WFE);
>   }
>   EXPORT_SYMBOL(cmdq_pkt_clear_event);
>   
> @@ -266,10 +293,15 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   	int err;
>   
>   	/* insert EOC and generate IRQ for each command iteration */
> -	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> -
> +	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_EOC_IRQ_EN),
> +				      CMDQ_GET_ARG_B(CMDQ_EOC_IRQ_EN),
> +				      0, 0, 0, 0, 0, CMDQ_CODE_EOC);
> +	if (err < 0)
> +		return err;
>   	/* JUMP to end */
> -	err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_JUMP_PASS),
> +				      CMDQ_GET_ARG_B(CMDQ_JUMP_PASS),
> +				      0, 0, 0, 0, 0, CMDQ_CODE_JUMP);
>   
>   	return err;
>   }
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 911475da..f21801d 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -19,6 +19,8 @@
>   #define CMDQ_WFE_UPDATE			BIT(31)
>   #define CMDQ_WFE_WAIT			BIT(15)
>   #define CMDQ_WFE_WAIT_VALUE		0x1
> +#define CMDQ_WFE_OPTION                 (CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | \
> +					CMDQ_WFE_WAIT_VALUE)
>   /** cmdq event maximum */
>   #define CMDQ_MAX_EVENT			0x3ff
>   
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index e5b0a98..e4d1876 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -70,26 +70,26 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>   /**
>    * cmdq_pkt_write() - append write command to the CMDQ packet
>    * @pkt:	the CMDQ packet
> - * @value:	the specified target register value
>    * @subsys:	the CMDQ sub system code
>    * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
>   
>   /**
>    * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
>    * @pkt:	the CMDQ packet
> - * @value:	the specified target register value
>    * @subsys:	the CMDQ sub system code
>    * @offset:	register offset from CMDQ sub system
> + * @value:	the specified target register value
>    * @mask:	the specified target register mask
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> -			u32 subsys, u32 offset, u32 mask);
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
> +			u32 value, u32 mask);
>   
>   /**
>    * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> @@ -98,7 +98,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
>   
>   /**
>    * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> @@ -107,7 +107,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
>   
>   /**
>    * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> 
