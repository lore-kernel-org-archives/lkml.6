Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C665C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A7B218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="DZrKx8FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfAYRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:25:55 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:56549 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=A3hRuhiHbl/xL3+qWAPQzMJcxRWQ2BE0XEW1SHC5ktc=;
        b=DZrKx8FPc2BdZl6Pq3ggo3VwCSeoI4JBmvJI1X5Spy78caftLYMHJpPwaQu9GN8Bf9fJSwKnbvIizRI1rZZp49WBYnfR7CPBaziRU6AUcCKuORNc0xphP+sdwsWWv6wlzwpQivnvJ3SV6TK7le2VXNhUnWRxhSvmf+Y+zmr4nvtjqOCV+1x+8WwRk0zdO/H80e9W1c/U3XU+bAvQ03+3pUKWJo7BRKlilH/zTcxbBVkGRG/TPBPLCt8g2R5/Sz2HK01Wb/MDww4OyT0NJe2+vH7yn34JMHCRJq8MwLfFPfl6xUww4q42yWq4ybkikF462AomdSHw168khKPof8vCdw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:14831 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn5Em-0003gW-TU; Fri, 25 Jan 2019 18:25:52 +0100
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-19-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
Date:   Fri, 25 Jan 2019 18:25:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-19-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Lovely diffstat, thanks to the new generic fbdev emulation.
> 
>  drm/qxl/Makefile   |    2
>  drm/qxl/qxl_draw.c |  232 ----------------------------------------
>  drm/qxl/qxl_drv.h  |   21 ---
>  drm/qxl/qxl_fb.c   |  300 -----------------------------------------------------
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.h  |  21 ---
>  drivers/gpu/drm/qxl/qxl_draw.c | 232 -------------------------------
>  drivers/gpu/drm/qxl/qxl_fb.c   | 300 -----------------------------------------
>  drivers/gpu/drm/qxl/Makefile   |   2 +-
>  4 files changed, 1 insertion(+), 554 deletions(-)
>  delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c
> 

Nice!

Acked-by: Noralf Trønnes <noralf@tronnes.org>
