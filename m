Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4C2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A4C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeJKQUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:20:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41891 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:20:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so7492661edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wl8gSPlxfjZjzDEPXNQsSkMFVQ6GaOVf9OeTyrk+82w=;
        b=fgRn1mxcAmlVZt/nfNGxmQkN+xpiqfHCFPEKRn2CAzqHlk2uhGSDwIdIxKHyeJu4Vq
         aalnXZQsQJOWXoGLrNmyl3iglwpL1K7mytz/9MLAM1h8JM+Qs62VSNHSF+zVCM90leRX
         69DZOq5ZQwAmLwpMGgx6TTK1PP1nTUwFFgqeGxiAImfd1Jx2pMkesi45dcN76owRBjyq
         bo2wtZsdxEQE9+QXf92GLEdsCp5dfHw7rdDG19BLq5CJZeHBAQU70Jm1wVI/8LKPJgjy
         iiRvbj5lZQiUzsGf6hbe07EFr58JRtPy0NRNDvI5VuaB6KSxtN7arCw/U7ct/6mmGib2
         m2wA==
X-Gm-Message-State: ABuFfoieXa5ixkYJ+0gntC0LlQYIvFrNb/7JL2d4NWe/5LZpj/nGkCdu
        kPeYctEBzs/DPVTDoVCrNEvdETF36JI=
X-Google-Smtp-Source: ACcGV62nDw4f4rE28FU4KgiIDsqnstm8faTOeYYNsMUUIhM2TuzrYoUfzzkCzfIXiMIesCvEXNq8hA==
X-Received: by 2002:a17:906:3f4e:: with SMTP id f14-v6mr1182952ejj.62.1539248024311;
        Thu, 11 Oct 2018 01:53:44 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s46-v6sm9277494edb.49.2018.10.11.01.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:53:43 -0700 (PDT)
Subject: Re: [PATCH] staging: vboxvideo: make a couple of funcs static
To:     Craig Kewley <craigkewley@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181010201705.15220-1-craigkewley@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <08d278ea-516d-0c8a-a240-44d41af6063e@redhat.com>
Date:   Thu, 11 Oct 2018 10:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181010201705.15220-1-craigkewley@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-10-18 22:17, Craig Kewley wrote:
> Fix Sparse warnings:
> drivers/staging/vboxvideo/vbox_mode.c:309:6: warning:
> symbol 'vbox_primary_atomic_disable' was not declared. Should it be static?
> 
> drivers/staging/vboxvideo/vbox_mode.c:452:6: warning:
> symbol 'vbox_cursor_atomic_disable' was not declared. Should it be static?
> 
> Signed-off-by: Craig Kewley <craigkewley@gmail.com>

Thanks.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/staging/vboxvideo/vbox_mode.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
> index 042e4f384df9..deed28c7a1db 100644
> --- a/drivers/staging/vboxvideo/vbox_mode.c
> +++ b/drivers/staging/vboxvideo/vbox_mode.c
> @@ -306,8 +306,8 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>   				    plane->state->src_y >> 16);
>   }
>   
> -void vbox_primary_atomic_disable(struct drm_plane *plane,
> -				 struct drm_plane_state *old_state)
> +static void vbox_primary_atomic_disable(struct drm_plane *plane,
> +					struct drm_plane_state *old_state)
>   {
>   	struct drm_crtc *crtc = old_state->crtc;
>   
> @@ -449,8 +449,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
>   	mutex_unlock(&vbox->hw_mutex);
>   }
>   
> -void vbox_cursor_atomic_disable(struct drm_plane *plane,
> -				struct drm_plane_state *old_state)
> +static void vbox_cursor_atomic_disable(struct drm_plane *plane,
> +				       struct drm_plane_state *old_state)
>   {
>   	struct vbox_private *vbox =
>   		container_of(plane->dev, struct vbox_private, ddev);
> 
