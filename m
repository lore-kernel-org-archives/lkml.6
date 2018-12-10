Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F009C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFFE2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y2JGgst4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFFE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLJJIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:08:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41203 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeLJJIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:08:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9588860wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O42yOUsF5m+Lm0y0IAiKsUjTDgPRlx7ZlXUb1Wixasw=;
        b=Y2JGgst4Wq69089a6dMvnE9M5RC+BX2YAWO6UZZttNO05XPoWtVMyr38C2YaMq3RCE
         YDP7QX6iQh4C5tPGD1wULR9qZx4wnifTFlM4zyGE3UJhPzCxebjocTLx76R7FK6hAXG3
         IVYzN96axke57HiP47V/rBbqnu0Hi9uz2RN+EqBlEhJOlM3QPW4UwdCBM4PDHgYMo7yn
         OZj0R0t/wczy6DkOTN2fB8C4jCBt9PLJfY3IoYCa91YgO2S7OFNbOVzZo2UYJAKX0IYK
         7PABEnL1LAlWAwmNUy0ZgstotVMNxFDaQlXv2oYA+v0MPNLjn7vPMbaZi9UgCQ4GqXzu
         ldhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O42yOUsF5m+Lm0y0IAiKsUjTDgPRlx7ZlXUb1Wixasw=;
        b=gUBfvshW4MspGUF1aZR9U9SA0OW46VBpth2zig6SH+gcEU85WSkHDJruEzQ3FMt4/f
         5DiGqTO+U/WZoLg5E38sEJSfNdux5Re2Z12DQ1khn7/fduOelFuyUBmiyDjv7sNfRZPn
         JOFcx3qbGPneXVDk+9zSQZBGC1B+hOnCD/b+GhSGiUIWjWK8uSlqO9Xm1ANzCUJ7t5vx
         8Y+N2ftiQVR1pb6qPPHFs/y3yuT4xOXnZOqRwKe4ACl/ajPXkzl8IH9YML+tpLXFi1Fl
         NPGv2cyuT0SzEohRUXstXfI1BwTJvl9fpgwz20Sjnfu6CbviB6yoF/s66e7QDfQitEWP
         kOpg==
X-Gm-Message-State: AA+aEWYJXL6bb/wExSzPJ6LUxZhk9bwTn0DTMVT4kFzHvel7Tna/N4n9
        2ruumMGFH7Bval3EmmjpyLEV7xKV2khPLCCCq//ZDw==
X-Google-Smtp-Source: AFSGD/Wd+hiVKRniurs4QTQa1A0ux9tGPXRYixIMksqehfHHfQUFs9Uri/NN5VsRGqFYOy44DKCRqw3HOXcjJFTypcY=
X-Received: by 2002:a5d:678b:: with SMTP id v11mr9948524wru.245.1544432919775;
 Mon, 10 Dec 2018 01:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20181210090448.4301-1-mjourdan@baylibre.com>
In-Reply-To: <20181210090448.4301-1-mjourdan@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 10 Dec 2018 10:08:28 +0100
Message-ID: <CAMO6nazQaBuSD=VN7+e1jcmgsMx_Zvj+yAENhQN5PvJKvyR0qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: remove firmware framebuffers
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:05 AM Maxime Jourdan <mjourdan@baylibre.com> wrote:
>
> In case we are using simplefb or another conflicting framebuffer, make
> the call to drm_fb_helper_remove_conflicting_framebuffers()
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Woops, some spaces made it in there.. will resend, sorry about that.
