Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1550EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16172173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="uGJf1RCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfAGPzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:55:23 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:42025 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=LUf3i20cHoKu4WO8xQ3ilU+ZgJZtqgS7d/XQ+V4O2M0=;
        b=uGJf1RCD0LYylduIhkKD29/Gdn8mWKSTn0rTN2ngUdq/8OTTgHgnMOcaRV4b5jfNXBam3OhF+y1yM5u8kIS+6kqxhjqVv/Z7i2h9g+MxrNvCsMW1nrXl8DvGSE23Yi4b9ciAnjT/KnOHs9c9rf/m6jlBVMONZMkJAkmLWLK/MqpbEj3WQMpaT7Xv2KvpCkdDcvjDXtQffRJP7Hl4XHDMrdq45nKLsQQLYlC2l+tuVBz6rQS8RFsNp5KPOL1ebN/OISIwzdo5Adsmha55OjQBSo8+ttmbRQiNiFoCexR7tXFxKGNg1HfnGCD+WejTVs06canuadbocQ65gJNmvLVFIQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64458 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXFI-0008Bj-R7; Mon, 07 Jan 2019 16:55:20 +0100
Subject: Re: [PATCH v2 04/14] drm: make drm_framebuffer.h self contained
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181230174838.32330-5-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <74c5a05b-b848-f1c9-7834-2b44d25573a0@tronnes.org>
Date:   Mon, 7 Jan 2019 16:55:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-5-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> Add forward declaration and pull in include
> file to make drm_framebuffer.h self contained.
> 
> While add it order include files alphabetically.
> 
> The use of TASK_COMM_LEN is the reason for including sched.h.
> I could not see any good way to avoid this dependency,
> and users of drm_framebuffer.comm already use
> TASK_COMM_LEN to check for length etc.

We can't avoid including it, the macro is used here after all.

> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  include/drm/drm_framebuffer.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
> index c94acedfb08e..f639ed527943 100644
> --- a/include/drm/drm_framebuffer.h
> +++ b/include/drm/drm_framebuffer.h
> @@ -23,13 +23,16 @@
>  #ifndef __DRM_FRAMEBUFFER_H__
>  #define __DRM_FRAMEBUFFER_H__
>  
> -#include <linux/list.h>
>  #include <linux/ctype.h>
> +#include <linux/list.h>
> +#include <linux/sched.h>
> +
>  #include <drm/drm_mode_object.h>
>  
>  struct drm_framebuffer;
>  struct drm_file;
>  struct drm_device;
> +struct drm_clip_rect;

I think you can add drm_gem_object to this list.

>  
>  /**
>   * struct drm_framebuffer_funcs - framebuffer hooks
> 

Acked-by: Noralf Trønnes <noralf@tronnes.org>
