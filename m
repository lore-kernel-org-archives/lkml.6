Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B601C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244421771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="GAe+crku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244421771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flowbird.group
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeHCRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:03:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52576 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeHCRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:03:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so6582792wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XIyeTbKGMPJqb9N+akrt6JNyr01K5RyKHQ80SQ9fQXY=;
        b=GAe+crkuGsX9YrDjCdE+OD2kQOlLEbSXtslLTe+VpYb6RuYUlCFiyKDdGjYJbuA+Sj
         D/SCZfLuxMP6IsEv7yiafUPZo6OzXk9RpjGdldL2jucUfRIh3RsUWgi4wWtC0yDKOtaF
         cejf4ETJwuB0GqG+HIwjoQ0hXVKGy8hx9Pol8H12zyD7uFVr4gBFxJklgvo4TtqC6sui
         Qz/WwitRW0ePQFhvqKql57TjM0swxn/xPi3Dzg/jW9aGgPGff8WZUgKDES2cmhMihSbc
         +1ImrfOVOXewhitoJDExwsliqVp3+lX9LJH8MxB+LOQGsUakjpkOY4ku9N1Ay7QHq5sD
         j4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XIyeTbKGMPJqb9N+akrt6JNyr01K5RyKHQ80SQ9fQXY=;
        b=UHsdAEMpAOBgqQ7JeIFpitA8uZhKrrVb+TxnuKQcz8ZZsLXUr+tnkDtPXPRU7Oz/NI
         zg9syMC/XVFZnVj6GJliLguifzDqqpTOamv16DvojBPI1YcRSBf2/n8ngDT2JwOynK89
         0LIdh3QwZdC5e9XQxyUvjFI+yBy36r7UU5lbImtnt4ve1IH+pNjLQXqkrz8dULg2nv08
         xnuyRgLKv0UdLf/SRAfst2a7lJ/6Dct5GyXWBo+tEYjnJMkDyq4focxyyAYpdij984lg
         7kdaLyxoAbWWtHk3uOVsw3vewrBOgdhcQAKw9Y/CQfIC1xqGZmFVJbCgrMdOWx3eA4qJ
         p/nQ==
X-Gm-Message-State: AOUpUlF5ywpr+ykkmNJee9IUCql9Zv+1RnSD1sJXmRD0g54lqTcT45mR
        GMBOfv0CM1ejGI6Y0V4YgaO2Yw==
X-Google-Smtp-Source: AAOMgpeNF1SoelTwVFhZGk4s12y71T8wkTe9PB3M1LA3gkEmfYmZHbfsFHLKPg6Tc0Gd1k9NLGIZHw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21-v6mr4996993wmh.106.1533308787850;
        Fri, 03 Aug 2018 08:06:27 -0700 (PDT)
Received: from [10.32.51.159] ([185.149.63.251])
        by smtp.gmail.com with ESMTPSA id m2-v6sm3494345wrw.76.2018.08.03.08.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 08:06:26 -0700 (PDT)
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
 <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
Date:   Fri, 3 Aug 2018 17:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On 03/08/18 14:35, Emil Velikov wrote:
> Hi Martin,
>
> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
>
> Let's start with the not-so obvious question:
> Why does one open the imx as render node?
>
> Of the top of my head:
> There is nothing in egl/android that should require an authenticated device.
> Hence, using a card node should be fine - the etnaviv code opens the
> render node it needs.

Yes, the problem is not in egl/android but in the scanout buffer 
allocation code.

etnaviv opens the render node on the *GPU* (for submitting GPU 
commands), that part is fine.

But scanout buffers need to be allocated from imx-drm not etnaviv.

This done by renderonly_create_kms_dumb_buffer_for_resource() 
[src/gallium/auxiliary/renderonly/renderonly.c]
Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by 
DRM_IOCTL_PRIME_FD_TO_HANDLE
on the "kms_fd" (probably poorly named because it's not actually used 
for modesetting)
see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]


If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but 
DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW


In android 8.1 the hardware composer runs in a seperate process and it 
has to use the card node and be drm master (to use the KMS API),
therefore, when the surface flinger calls 
renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.

Making surface flinger use a render node fixes the problem for 
DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.


This probably worked in previous versions of Android where surface 
flinger and hwc were all in the same process.

Regards,

Martin


