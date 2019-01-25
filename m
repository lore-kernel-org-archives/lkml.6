Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3970218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="CSBvYBH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfAYQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:11:25 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41650 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=0pwQYEoplY4VqyNHZeIB69rzI8ghyN8S9Gcy4dAd09M=;
        b=CSBvYBH56FEWw/3a1dy6L89HnY646xZVQgm2Gt5VXUJ2lpnmRGrve+p4BsurMlYLASROilhUTgPbM+y/cTMoHpv4GKAXPUuqHYwaXVYUwu/KaCiVOUGC6RonwpSHHpy4hqLQYas1GgmHSZGsPF4+mQyquSQbEN6ABSFi06mRz7TVGIogANCqvGC+VTKffH3HZjn0mZGcKhnuFamaKlswZRcgE+ALb9l9/HbqT2lfqzW0VrddyUa+Mi1MXnCMMPIaxbGYsgxzA/r0DMzGWWQBQFd/KXcgd5kvUncBqGizDVpflf3r0hGLJYvFA0/zy1JPOGWypnTfU9oysCpZAWCDTA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49446 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn44g-0006TP-7N; Fri, 25 Jan 2019 17:11:22 +0100
Subject: Re: [PATCH v3 12/23] drm/qxl: track primary bo
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-13-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <c0af8755-6d9d-5bbe-609d-ab93eb75e31e@tronnes.org>
Date:   Fri, 25 Jan 2019 17:11:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-13-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Track which bo is used as primary surface.  With that in place we don't
> need the primary_created flag any more, we can just check the primary bo
> pointer instead.
> 
> Also verify we don't already have a primary surface in
> qxl_io_create_primary().
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
