Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D4320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bkFvwCee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D4320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIKUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:06:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39828 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeIKUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:06:41 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 76EF5992;
        Tue, 11 Sep 2018 17:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536678417;
        bh=oDhqrt7QBAAO90W1309sSJeZTvXNbKpR1GCmzrKgzgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkFvwCee22xR9UdZPBJ2LhVIJj1birBzJpI6Zpz+7NF7VB179vpNp+GysoPaqyUmf
         Li3GXRvp5Zqc7bJJRXmzsIMfbaDu6w2VEZzNd6R/UbEcvuGoAT1X0v0s9WuN/pdxr1
         uPW7kkoWdvIzn8wYgJS3jW1pMOCQqpcWXsA/1kU0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] udmabuf: drop WARN_ON() check.
Date:   Tue, 11 Sep 2018 18:07:10 +0300
Message-ID: <1547650.lRi8WmezH2@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911134216.9760-12-kraxel@redhat.com>
References: <20180911134216.9760-1-kraxel@redhat.com> <20180911134216.9760-12-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 16:42:14 EEST Gerd Hoffmann wrote:

Still no commit message ? :-)

> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma-buf/udmabuf.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index b637a8be6d..7a4fd2194d 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -25,9 +25,6 @@ static int udmabuf_vm_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct udmabuf *ubuf = vma->vm_private_data;
> 
> -	if (WARN_ON(vmf->pgoff >= ubuf->pagecount))
> -		return VM_FAULT_SIGBUS;
> -
>  	vmf->page = ubuf->pages[vmf->pgoff];
>  	get_page(vmf->page);
>  	return 0;


-- 
Regards,

Laurent Pinchart



