Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EEECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9741920665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9741920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJ1TrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:47:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45667 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeJ1TrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:47:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so4835746eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 04:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bZhArkoqMIuKaNEK+cqsIteiW5Npk6lXBmRec8doAQ=;
        b=tbmIYRrC3zVqMTEz6NekD7n/w/5/XnEaPRrWKWmtfTxppyZ1ulfsNQRHv5HrzVV3x5
         QJAsQtVP08uzS4B8HQfueyo00RbUpryCExBZGk9K9+TJLs6IxVcYLTjC0SdZMIifSuRp
         Qv9a+97nBCqNchYxfyxKi6GvAgf+A/DfaXYdijWgZOzrvZ5WCOk8kFTwQsO77GBMUDSa
         +tv2+tg6gaeJ4oXJPAQy4tsy+RwJOjic0LnT/S+0+kdzlbbvcZkzA4QwG9UUiniHy5DD
         DjBcCVLQd3oG7b09PBry/AzXLoMgjZ4wm5cVKTCzwHBEK64aCDdQ7cPNr+9/8JPotGpU
         omow==
X-Gm-Message-State: AGRZ1gIbYBhiKGWT4oQmuncOX/aw5TAXEptZJST9O7iHi2IuQWMm0Uqw
        egzuZl3b7lUoaytRGaE+iUH+Tw==
X-Google-Smtp-Source: AJdET5dCanfRUhFtZ0VR3jheOYzoofDkcrR73gEa6LFbYlD+DibOqTXS20Rs6daWjLrJ9sXHmlWJ0g==
X-Received: by 2002:a17:906:7442:: with SMTP id x2-v6mr7692676ejl.169.1540724570858;
        Sun, 28 Oct 2018 04:02:50 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f11-v6sm990513eds.23.2018.10.28.04.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 04:02:50 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] staging: vboxvideo: Change uint32_t to u32
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
 <a81ed59de19694f34b5c5d183e06007d6cc50d1f.1540580493.git.shayenneluzmoura@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a74af0ae-70a3-1e10-fff2-32c6ac3b74c7@redhat.com>
Date:   Sun, 28 Oct 2018 12:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a81ed59de19694f34b5c5d183e06007d6cc50d1f.1540580493.git.shayenneluzmoura@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-10-18 21:04, Shayenne da Luz Moura wrote:
> This change was suggested by checkpath.pl.
> 
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

So as already mentioned in response to the coverletter of
the first posting of this series.

The drm headers use uint32_t in the prototype definition of the callback
functions we are defining, so the vboxvideo code should use the same even
if the compiler does not warn about the callback implementation having
different parameter types in this case.

To be precise, the page_flip member of struct drm_crtc_funcs is defined as:

         int (*page_flip)(struct drm_crtc *crtc,
                          struct drm_framebuffer *fb,
                          struct drm_pending_vblank_event *event,
                          uint32_t flags,
                          struct drm_modeset_acquire_ctx *ctx);

So our implementation before your patch exactly matches the prototype
which IMHO is the right thing to do.

Regards,

Hans




> ---
>   drivers/staging/vboxvideo/vbox_mode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
> index 79836c8fb909..8a1b117990b8 100644
> --- a/drivers/staging/vboxvideo/vbox_mode.c
> +++ b/drivers/staging/vboxvideo/vbox_mode.c
> @@ -311,7 +311,7 @@ static int vbox_crtc_mode_set(struct drm_crtc *crtc,
>   static int vbox_crtc_page_flip(struct drm_crtc *crtc,
>   			       struct drm_framebuffer *fb,
>   			       struct drm_pending_vblank_event *event,
> -			       uint32_t page_flip_flags,
> +			       u32 page_flip_flags,
>   			       struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct vbox_private *vbox = crtc->dev->dev_private;
> 
