Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD25D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fi4tWvMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD25D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIKTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:52:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38930 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:52:35 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 360C2992;
        Tue, 11 Sep 2018 16:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536677574;
        bh=kWaXX/QbOFHW5Orc644Qg5K6Pwebmu9DZXTKLWGlXWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fi4tWvMRvIGGg0mQkRsSkhcWvDHtgD50AgHmQDSXfR/Es2tWtUZgqeVkfpd74otlV
         zWWtjy6He81l2YQbguRBdnQ9rOtU16cyyh8+krfrJ3PGLwtGBaBh3JKMV8J4DOYI2N
         IsmCZAma6RlhjWiyW3KRNJO00bBWDIjcFWun9m+E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/13] udmabuf: constify udmabuf_create args
Date:   Tue, 11 Sep 2018 17:53:06 +0300
Message-ID: <4625619.OKDULqJxva@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911134216.9760-6-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com> <20180911134216.9760-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 16:42:08 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index e3560e840d..4167da8141 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -116,8 +116,8 @@ static const struct dma_buf_ops udmabuf_ops = {
>  #define SEALS_WANTED (F_SEAL_SHRINK)
>  #define SEALS_DENIED (F_SEAL_WRITE)
> 
> -static long udmabuf_create(struct udmabuf_create_list *head,
> -			   struct udmabuf_create_item *list)
> +static long udmabuf_create(const struct udmabuf_create_list *head,
> +			   const const struct udmabuf_create_item *list)

Even if you really want to make it const, a single const should suffice :-)

>  {
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct file *memfd = NULL;


-- 
Regards,

Laurent Pinchart



