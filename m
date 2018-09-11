Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B8D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tVGfR261"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B8D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIKOgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:36:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:36:42 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 490C057;
        Tue, 11 Sep 2018 11:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658691;
        bh=WTOLOHdjAng729P2N3PT/xjx2orumpg2HoSXN8NUbys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVGfR261kLQ7QLFpAJc75kWJ/MpOw1RPbyYeU5AgeovWHabsM7JQ4ld0VQxk1maUT
         QaPnPJNHVtDSwvFya7Tu7OS85o1ISFsrbP+Q8+nkkE2oY5AsUFhUHNvfxQjl4kJViG
         byi3tXlBBSy2GAn3b0WNlBNm4il+X63mNZRz9R/k=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] udmabuf: constify udmabuf_ops
Date:   Tue, 11 Sep 2018 12:38:23 +0300
Message-ID: <8141441.11M0NzlRds@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-5-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:15 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma-buf/udmabuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index ec22f203b5..44c3c1bf20 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -104,7 +104,7 @@ static void kunmap_udmabuf(struct dma_buf *buf, unsigned
> long page_num, kunmap(vaddr);
>  }
> 
> -static struct dma_buf_ops udmabuf_ops = {
> +static const struct dma_buf_ops udmabuf_ops = {
>  	.map_dma_buf	  = map_udmabuf,
>  	.unmap_dma_buf	  = unmap_udmabuf,
>  	.release	  = release_udmabuf,


-- 
Regards,

Laurent Pinchart



