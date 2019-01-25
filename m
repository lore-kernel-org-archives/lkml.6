Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B026F218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="YLt8mDAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfAYP7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:59:19 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:53288 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfAYP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Ar6vqw2fZMBQh+8b2R4gZJS1eGXWAZV6xxNSGyw50dY=;
        b=YLt8mDASMIJEkvMv9Nw7U9pArFWM67PgevS+bOL2osIN+9xZkZUc6T+PUTsbdXhO4sqnpSsB4Je8v/EbpjZpQEX50JbJTc3D93r7yE1R7zMxY4CeoZTsuHJ+1tBjXMW95QhYEC/EH57GRMXIy3Hv+rKEzt9FfLWa9wL/REoU8BeOeGaAU5hL4hOQbWCvv3ju8PrHPSk+Ya7cEUaajZThnKvMyeyvFPF9y5HEFYdew52JH+MeF+absnO/IgemkGKNdoYAajmwoCJ/cWKZ10v3JenE5f+Xni1zGqBxZOWcS1wGYn22EDzG6mDzXTYopkoxcYK6KUltSLGM2SijMwGUBg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49330 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3sy-0003ry-3i; Fri, 25 Jan 2019 16:59:16 +0100
Subject: Re: [PATCH v3 09/23] drm/qxl: use QXL_GEM_DOMAIN_SURFACE for dumb gem
 objects
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-10-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <4c01f764-618c-b7de-3121-56adb2d909b0@tronnes.org>
Date:   Fri, 25 Jan 2019 16:59:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-10-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> dumb buffers are used as qxl surfaces, so allocate them as
> QXL_GEM_DOMAIN_SURFACE.  Should usually be allocated in
> PRIV ttm domain then, so this reduces VRAM memory pressure.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
