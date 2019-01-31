Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA53218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="HBeLFlEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfAaKxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:53:53 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:36705 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfAaKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=5iJJUD73syrqIfCDuYFH6KpyetCw6V79AM0gcK6Y11Q=;
        b=HBeLFlENvxdMHs6lb5isqyWcXiVaF5wxkt9KzhYsSnPfv6GOnSeBIR5sOXM+36DLg6P3s50zj1LlIyS7l6ZikYpaZ0FUUgxhil3nOVOBIB1pwW/TdM/y36X2fV03WWFJ2oadWYnU5CEb4hA/hIJLa2hoVpiShBsOuSzVWMgtLu2fGhDWUmNIUiuJ8G8rUf0jimObpMrYglsX9ePpUky2qCdYBM4ZTBVeKJL1QvXVNXZU9EbD+sxLmDg5j2F4xIkMbO/DeWJzv6ybIgrOgE+R22InzFMA7UeQ5aH2a2pGweHbZTdbz716Fn7XCpqB2V1uVzVX1edh1MlzjVZBUaPWJg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52666 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gp9yf-0000U0-1z; Thu, 31 Jan 2019 11:53:49 +0100
Subject: Re: [PATCH v2 6/6] drm/virtio: move virtio_gpu_cmd_create_resource
 call into virtio_gpu_object_create
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-7-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <eff1a43e-a3ed-3c12-229c-61c450b31e86@tronnes.org>
Date:   Thu, 31 Jan 2019 11:53:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130094338.14203-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> Specifically call virtio_gpu_object_create() before ttm_bo_init(), so
> the object is already created when ttm calls the
> virtio_gpu_ttm_tt_bind() callback (which in turn calls
> virtio_gpu_object_attach()).
> 
> With that in place virtio_gpu_object_attach() will never be called with
> an object which is not yet created, so the extra
> virtio_gpu_object_attach() calls done after
> virtio_gpu_cmd_create_resource() is not needed any more.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
