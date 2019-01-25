Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="YmAzpOPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfAYP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:58:23 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:56119 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAYP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=35ifbr3YpWBfiLKkz+C02OCiuTA1Q3vi3PMO0gbJdRA=;
        b=YmAzpOPB4gCGDgxTdJjUkWZzu9HxE6qiiUzhg+wNV+SQ4zSwtrGej3fiBtlMfChSu8Id/P3xYCyjBYH/KYgm8qa/cr1hR9guu0wRniOPIpLU1RSwrjXaBQpbrUeil++lcdq3I1Y1XX+/FsB7e/tRPKdiBO5pWwSVlDeUfrpIbQTgrW7QPlA7+JRgYtmAi/C8skjohJyogGD6+/AKX7L5qDLASy6BnTkgJn1AkMrY3MBjbLNOF6FiNS9y0ZQlffwWSoih5pSjk4ssVL1vGnhs1QLN6cYrRP1STzAfaiCBclNHm4zMTMZFNBipiYy71jzRkbGN6k1vyHtnaMahUHIQjA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49317 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3s5-0003gR-0t; Fri, 25 Jan 2019 16:58:21 +0100
Subject: Re: [PATCH v3 07/23] drm/qxl: allow both PRIV and VRAM placement for
 QXL_GEM_DOMAIN_SURFACE
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-8-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b02d7064-4a5d-057e-5342-e60688e8afbd@tronnes.org>
Date:   Fri, 25 Jan 2019 16:58:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> qxl surfaces (used for framebuffers and gem objects) can live in both
> VRAM and PRIV ttm domains.  Update placement setup to include both.
> Put PRIV first in the list so it is preferred, so VRAM will have more
> room for objects which must be allocated there.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
