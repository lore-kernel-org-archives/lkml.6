Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6989F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfA3J0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:26:22 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:8870 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3J0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:26:21 -0500
Received: from [10.28.18.236] (10.28.18.236) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 30 Jan
 2019 17:27:10 +0800
Subject: Re: [PATCH][next] mtd: rawnand: meson:: make several functions static
To:     Colin King <colin.king@canonical.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190129124429.19829-1-colin.king@canonical.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <a1f6dfbd-3434-be6a-c623-794398393609@amlogic.com>
Date:   Wed, 30 Jan 2019 17:27:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129124429.19829-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.236]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 2019/1/29 20:44, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several functions that are local to the source and do
> not need to be in global scope, so make them static.
> 
> Cleans up sparse warnings.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index b9c543d1054c..9557bd94dcd2 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -829,14 +829,14 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>   	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
>   }
>   
> -bool meson_nfc_is_buffer_dma_safe(const void *buffer)
> +static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
>   {
>   	if (virt_addr_valid(buffer) && (!object_is_on_stack(buffer)))
>   		return true;
>   	return false;
>   }
>   
> -void *
> +static void *
>   meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
>   {
>   	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR))
> @@ -848,7 +848,7 @@ meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
>   	return kzalloc(instr->ctx.data.len, GFP_KERNEL);
>   }
>   
> -void
> +static void
>   meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
>   				     void *buf)
>   {
> @@ -863,7 +863,7 @@ meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
>   	kfree(buf);
>   }
>   
> -void *
> +static void *
>   meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
>   {
>   	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
> @@ -876,7 +876,7 @@ meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
>   		       instr->ctx.data.len, GFP_KERNEL);
>   }
>   
> -void
> +static void
>   meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
>   				      const void *buf)
>   {
> 

Looks good to me:

Acked-by: Liang Yang <liang.yang@amlogic.com>


