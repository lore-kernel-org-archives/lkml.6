Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B74C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CCE218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Bn3R+B3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAYRM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:12:57 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41349 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=SlGa1YF/nDzcfjn3mwXqrTqkP2IwffQlb9oAVKpbMZ4=;
        b=Bn3R+B3UP4rsu/2ZvUFxz7krPxjWVJDItYsQRKq7rmg6zT0QiC/SnPROpZcAmcSQ9s3IbJhezQTvlL2PD35D38CtTFyJ5ds56cSnKDMmS0rK84gr8VDAwLjTw0cY3JuF8ZZDzNPxP3F/2PiAK8cyg19T5bLPeuj+yP5kSGRaBeEabfymeLJ+jfL/3PzFevHwegA8rqVkEtjONLSXJ6UGoJFXo7MzQJz3xHmfOG4MOTvkDtWXZ6QLW34oHhmWlJRT+PunT69C4nBFHA6yoIU0OSKI6alf59hlq9OoeWDiUcE1bVSq3Rhb8ocxddACAIp8ujMMaVXUEVbHqRjGBRSckQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50260 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn52E-0001MP-5z; Fri, 25 Jan 2019 18:12:54 +0100
Subject: Re: [PATCH v3 15/23] drm/qxl: use qxl_num_crtc directly
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-16-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <32b84914-7ccc-42fe-cc2f-a012e389e61a@tronnes.org>
Date:   Fri, 25 Jan 2019 18:12:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-16-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> qdev->monitors_config->max_allowed is effectively set by the
> qxl.num_heads module parameter, stored in the qxl_num_crtc variable.
> Lets get rid of the indirection and use the variable qxl_num_crtc
> directly.  The kernel doesn't need to dereference pointers each time it
> needs the value, and when reading the code you don't have to trace where
> and why qdev->monitors_config->max_allowed is set.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
