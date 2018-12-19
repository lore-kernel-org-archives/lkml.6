Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9182F218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYKToupj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeLSPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:30:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43207 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeLSPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:30:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so15337958lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JZ1PND9ms8rQlXA+J3nz1imBWbAqbmwYZbGsqtzE+sY=;
        b=kYKToupj34EInptFM5bvsz9EMpQCQBPfM/2UczQX8Cr+rj8ScMG7Uz8dVCtrXAbDaO
         MxWl9NSQ4flcQSCpOlhcU4Nj7r7QcRHt/wViYe6pkxF0Piw2O7ufmsCBO2QniLJtAXUC
         3x2PeGg69f0XIrAIU7CX8BnRNqBEbYnX0uMMq8OeOocYRvDIxvNToRSbjdxGArIH8OHK
         2w9vZFMOlFuIUfHQBXqnhoInTbVC2xiNVl+9GLjKtximHyXiH2BQmSYiyczndfDZSc/F
         bLCU9Rme6z8bB6u2a5m2oJoiH/puyDL+77w1YRsn2rxJQy0bsXjuH8yxntT4z7hJhpUD
         LJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JZ1PND9ms8rQlXA+J3nz1imBWbAqbmwYZbGsqtzE+sY=;
        b=qgb1b/1AX9zjYcMrMsjAu6zGeT55CyQkI28ASbt8YCQkv/vyexXOjUXMUzm7PixtVD
         uEhH0gPOfu/DFqGliwe59Vg1hrWlKwYFZwDRV/mUsysdweHPdHH4cTGok7eBQ+kIiwOU
         HfGDNQDOtLCUiSZ5iO8UolZtKmp8OZcYNxBy/xtmRig4+qljZwPeEfN6c6RQgCkHPwwr
         Gh3O9vSobM+gZIRXiWmIzSsthsikBGcrsu1dPnFRS+McmWVd3v6rhRsGDLxPs4egs6ee
         GDv2giByIGaaTQXKTcBLPLuWp9mvRRpyDeB/X05HAoKjmcEaWLlEG0ROE3xME7ryAnem
         m26Q==
X-Gm-Message-State: AA+aEWZXUmC4HSTAtB/dDWFjkCwggrc+NcF7AJK0QyVhGhsVyhLnyz2b
        Jy1WQ9XAga7hDjK/1c3+ITI=
X-Google-Smtp-Source: AFSGD/UEEcGqCufSQq4JJABAKDfU1WkVQP3B7IFctMhXr/ITvNUqVEJ7bmO1WOWi1De2SKvB7a9ekw==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr12530281lff.88.1545233422264;
        Wed, 19 Dec 2018 07:30:22 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id e94sm3918086lfi.23.2018.12.19.07.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:30:21 -0800 (PST)
Subject: Re: [PATCH 03/14] drm/bochs: atomic: add atomic_flush+atomic_enable
 callbacks.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-4-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <da31d0ec-95ee-39da-46d0-fcbdfb6f376c@gmail.com>
Date:   Wed, 19 Dec 2018 17:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gerd!

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step one.
> Add atomic crtc helper callbacks.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs_kms.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index f7e6d1a9b3..59d469f343 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -115,6 +115,29 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
>   	return 0;
>   }
>   
> +static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *old_crtc_state)
> +{
> +}
> +
> +static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> +				    struct drm_crtc_state *old_crtc_state)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_pending_vblank_event *event;
> +	unsigned long irqflags;
You could probably move these under the actual if where these are needed,
but it's up to you
> +
> +	if (crtc->state && crtc->state->event) {
> +		event = crtc->state->event;
> +		crtc->state->event = NULL;
Not quite sure if touching the event above is allowed w/o holding the 
event lock
> +
> +		spin_lock_irqsave(&dev->event_lock, irqflags);
> +		drm_crtc_send_vblank_event(crtc, event);
> +		spin_unlock_irqrestore(&dev->event_lock, irqflags);
> +	}
> +}
> +
> +
>   /* These provide the minimum set of functions required to handle a CRTC */
>   static const struct drm_crtc_funcs bochs_crtc_funcs = {
>   	.set_config = drm_crtc_helper_set_config,
> @@ -128,6 +151,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>   	.mode_set_base = bochs_crtc_mode_set_base,
>   	.prepare = bochs_crtc_prepare,
>   	.commit = bochs_crtc_commit,
> +	.atomic_enable = bochs_crtc_atomic_enable,
> +	.atomic_flush = bochs_crtc_atomic_flush,
>   };
>   
>   static const uint32_t bochs_formats[] = {

