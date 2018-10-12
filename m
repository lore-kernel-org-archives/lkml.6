Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA73C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4558520865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4558520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeJLUTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:19:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48930 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeJLUTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:19:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D9B64208B7; Fri, 12 Oct 2018 14:47:29 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D49820719;
        Fri, 12 Oct 2018 14:47:19 +0200 (CEST)
Date:   Fri, 12 Oct 2018 14:47:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
Cc:     linux-mtd@lists.infradead.org, richard@nod.at,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        marek.vasut@gmail.com, liuxiang_1999@126.com, han.xu@nxp.com,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [PATCH v3] mtd: spi-nor: fsl-quadspi: fix read error for flash
 size larger than 16MB
Message-ID: <20181012144720.799a855f@bbrezillon>
In-Reply-To: <1535466777-3833-1-git-send-email-liu.xiang6@zte.com.cn>
References: <1535466777-3833-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 22:32:57 +0800
Liu Xiang <liu.xiang6@zte.com.cn> wrote:

> If the size of spi-nor flash is larger than 16MB, the read_opcode
> is set to SPINOR_OP_READ_1_1_4_4B, and fsl_qspi_get_seqid() will
> return -EINVAL when cmd is SPINOR_OP_READ_1_1_4_4B. This can
> cause read operation fail.
> 
> Fixes: e46ecda764dc ("mtd: spi-nor: Add Freescale QuadSPI driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

Queued to spi-nor/next.

Thanks,

Boris

> ---
> 
> Changes in v3:
>  move changelog position.
> 
>  drivers/mtd/spi-nor/fsl-quadspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 7d9620c..64304a3 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -478,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
>  {
>  	switch (cmd) {
>  	case SPINOR_OP_READ_1_1_4:
> +	case SPINOR_OP_READ_1_1_4_4B:
>  		return SEQID_READ;
>  	case SPINOR_OP_WREN:
>  		return SEQID_WREN;

