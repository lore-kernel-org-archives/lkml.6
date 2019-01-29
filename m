Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99CF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Tn4Kd0vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfA2ItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:49:19 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:46380 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2ItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=jyMnuyLlwIjWRsJTwhO0rzEM1HBIWI5UgX/0eI29gS0=;
        b=Tn4Kd0vMwfq9diaoyl3omus+f3XdPfOBW+K9Go5iik7k43PoOJu1ld5/8wQuXS34zn1paV7S3F4XSAsNqCFNd7kj/UY4MysvsREJzmlmR/+FJWnqFKaD5fUyNWesvFKOoQk86/I0ZeZV9EszeEZmA/9lvRxbHTZI+zT8t8y5zPIEmkHkXjOzCZ2x8MmmSwrHt9Vo98nl4/FPVrWKzSr91BDmHHSULF5m7ageHqO49SgAUwolr93uhct9Mv36K39WPq9jSffKA+APMNBjKg2jUwoL56OfSduQzm1yHpKm9WTsewax+G9wArtWSKnWADnEkanKBHTr8s+SrL72GSoZDg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:20072 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1goP51-0002no-3u; Tue, 29 Jan 2019 09:49:15 +0100
Subject: Re: [PATCH v2] drm/qxl: use ttm_tt
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190129082541.1392-1-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <d081229c-30e5-0363-0e9b-96c4a40dd877@tronnes.org>
Date:   Tue, 29 Jan 2019 09:49:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129082541.1392-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.01.2019 09.25, skrev Gerd Hoffmann:
> qxl device will not dma, so we don't need ttm_dma_tt.  Go use ttm_tt
> instead, to avoid wasting resources (swiotlb bounce buffers for
> example).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
