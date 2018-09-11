Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026ED20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AXj+Z48V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026ED20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeIKOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:34:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34130 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKOeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:34:14 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 118D357;
        Tue, 11 Sep 2018 11:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658543;
        bh=rnYreR5MlLBlW4EtpIqxw8/8+D6qTZV5Riqmeh0Hwpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXj+Z48VgQrIB3zDMX3yC8MI9D7pwOEtHJ8HdxJGafDI/upjevwUZRWl9EvSbyHal
         zd1m+m6U6AqmzWkHL+h0jMMT56b+b5eSXMbeyMDRtmQY4fk4meAY7Am3idb9uJ6tHg
         1HLNPqVQa3cBnJ0xM0+/o5rHlgeVBxf5P/noaDDI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] udmabuf: sort headers, drop uapi/ path prefix
Date:   Tue, 11 Sep 2018 12:35:55 +0300
Message-ID: <2525961.SbzEzdfdcR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-2-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:12 EEST Gerd Hoffmann wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/dma-buf/udmabuf.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 2e8502250a..e63d301bcb 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -1,17 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/init.h>
> -#include <linux/module.h>
> +#include <linux/cred.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/miscdevice.h>
>  #include <linux/dma-buf.h>
>  #include <linux/highmem.h>
> -#include <linux/cred.h>
> -#include <linux/shmem_fs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/memfd.h>
> -
> -#include <uapi/linux/udmabuf.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/shmem_fs.h>

Nearly there, l comes after h :-)

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +#include <linux/udmabuf.h>
> 
>  struct udmabuf {
>  	u32 pagecount;


-- 
Regards,

Laurent Pinchart



