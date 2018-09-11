Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D11C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D681D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gtkczXKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D681D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIKOhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:37:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34218 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:37:35 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00E7B57;
        Tue, 11 Sep 2018 11:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658744;
        bh=RADl2VOa+UktfiKJkhnLhfHREcX1ah0IpKhbiMymxNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtkczXKmsPLoRQftCiOma3jwTfziXQ2bsJ1q/eRnpI4fRVIaxYl1d2Qow5Jy0sCw9
         K6KmDSUEB0DtO/75a8uikxziqHvN4EVb6C1x2LE3jL3GuW7/f8MVnQ5tZLcaTB4ALB
         hzB5gEe4tM/wAKOZTf1JI27cKbpPMFfW+dU24gh0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] udmabuf: constify udmabuf_create args
Date:   Tue, 11 Sep 2018 12:39:16 +0300
Message-ID: <3273517.JkZe1mtvyu@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-6-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:16 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 44c3c1bf20..0cf7e85585 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -116,8 +116,8 @@ static const struct dma_buf_ops udmabuf_ops = {
>  #define SEALS_WANTED (F_SEAL_SHRINK)
>  #define SEALS_DENIED (F_SEAL_WRITE)
> 
> -static long udmabuf_create(struct udmabuf_create_list *head,
> -			   struct udmabuf_create_item *list)
> +static long udmabuf_create(struct const udmabuf_create_list *head,
> +			   struct const udmabuf_create_item *list)

Shouldn't it be const struct, not struct const ?

With that fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  {
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct file *memfd = NULL;

-- 
Regards,

Laurent Pinchart



