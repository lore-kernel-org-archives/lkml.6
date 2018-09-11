Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6D320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YAv43Nxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6D320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeIKOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:38:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34238 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:38:29 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7A9F57;
        Tue, 11 Sep 2018 11:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536658798;
        bh=eKVEWmg8Wi6D5QlqDD1kAyWkJQJ3IRzMwHvBqWH7VjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAv43NxpeoyJZmAxy8pa04tfFxcFlOLhtff0tFGTDL9vo1UUKdd0Ba5XX2dzGnnop
         IN2EOYcum5HRbkgxOx/TSta7DBlfS+iKJ/x7jSHYREqR69aMhWwg3BhxOBdisAzo2L
         SNyQEiiMqcFux0pky/9bkVBO/sYnk31OAlrAtK0o=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] udmabuf: add MEMFD_CREATE dependency
Date:   Tue, 11 Sep 2018 12:40:10 +0300
Message-ID: <9324055.sTKbuWCmpk@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065921.23818-7-kraxel@redhat.com>
References: <20180911065921.23818-1-kraxel@redhat.com> <20180911065921.23818-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Thank you for the patch.

On Tuesday, 11 September 2018 09:59:17 EEST Gerd Hoffmann wrote:
> udmabuf builds without it, but if userspace can not create memfd
> handles in the first place it is rather pointless to include it.

Except perhaps for compile test coverage ? How about

	depends on MEMFD_CREATE || COMPILE_TEST

?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/dma-buf/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 338129eb12..fc3fe3f04e 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -34,6 +34,7 @@ config UDMABUF
>  	bool "userspace dmabuf misc driver"
>  	default n
>  	depends on DMA_SHARED_BUFFER
> +	depends on MEMFD_CREATE
>  	help
>  	  A driver to let userspace turn memfd regions into dma-bufs.
>  	  Qemu can use this to create host dmabufs for guest framebuffers.


-- 
Regards,

Laurent Pinchart



