Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1F2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIGWJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:09:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39028 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:09:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so17011710qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bhfDOT699q47QC2IVbeRU81m4U4IN5Lkn/a2PscBxf0=;
        b=dNOm3aOza2KPCEzc35pGHKYRy9VZIJbOTM5dpWphzKxnriYAZKWsxC38BriI90J8zH
         vhhVVV8WhOhU0feyH5d75YrOsD6rl/16kzHgvoHXsGEsVbZKwhPgiuwipolZguaJfgQ4
         ZoQXHHNQ1KmQx+HAgTtMMjegTHj8gIcd7vKO0zCZwz0y7KqWzC1OvO5126s6y+wp4G5g
         HOQw25xtRMpZof58fGfiRvA1OTEqDB0G5/EEXhe12DXjVopwdPIlxQ19ngANaHxONiVO
         RfeCiTDP28YuJq8xoWPtAVwkAk8+8F+iwG6gHGBVLTlmux+PNq6ac8NSwaVL/enqOGmO
         zVGQ==
X-Gm-Message-State: APzg51Do0TNYxuUdF0nsB0fD6SzmBDzyuZqijQLYfYQBsVlzoiUDUq1g
        UgggoREudYNF6x7I2ap2RNhLbO7xVuA=
X-Google-Smtp-Source: ANB0VdZ3QK7zeT/rF8zAU4nJTh2XXg+7HnIo/pI3BsJzo+FCkA04ikAIVsDptI5iXMDxUS5KsaXuAQ==
X-Received: by 2002:a0c:d788:: with SMTP id z8-v6mr6706656qvi.71.1536341266135;
        Fri, 07 Sep 2018 10:27:46 -0700 (PDT)
Received: from malachite.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id k5-v6sm4899742qkf.53.2018.09.07.10.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:27:45 -0700 (PDT)
Message-ID: <e73583043c36ef1c4e7c40ff50a03f3ab276099e.camel@redhat.com>
Subject: Re: [PATCH v4 2/6] drm/nouveau: Add NV_PRINTK_ONCE and variants
From:   Lyude Paul <lyude@redhat.com>
To:     Joe Perches <joe@perches.com>, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 13:27:44 -0400
In-Reply-To: <4d74256435a71cdb7ec8d114b1c3cb640f29c267.camel@perches.com>
References: <20180906214328.24012-1-lyude@redhat.com>
         <20180906214328.24012-3-lyude@redhat.com>
         <4d74256435a71cdb7ec8d114b1c3cb640f29c267.camel@perches.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 22:35 -0700, Joe Perches wrote:
> On Thu, 2018-09-06 at 17:43 -0400, Lyude Paul wrote:
> > Since we're about to use this in nouveau_backlight.c. Same thing as
> > DRM_WARN_ONCE, DRM_INFO_ONCE, etc...
> 
> Can you redefine this in terms of the patches I submitted
> instead?
> 
> https://lore.kernel.org/patchwork/patch/979598/
> https://lore.kernel.org/patchwork/patch/979601/

Unfortunately this patch series has already been merged:

https://github.com/skeggsb/nouveau/commit/c5082a8e3d84330140b9250692a3f4c38d7da3ea

So it is probably a better idea to do this the other way around and just
rebase your patches on top of that
> 
> 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_drv.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > index 6e1acaec3400..d9d687916553 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> > @@ -244,10 +244,12 @@ void nouveau_drm_device_remove(struct drm_device
> > *dev);
> >  	struct nouveau_cli *_cli =
> > (c);                                        \
> >  	dev_##l(_cli->drm->dev->dev, "%s: "f, _cli->name,
> > ##a);                \
> >  } while(0)
> > +
> >  #define NV_FATAL(drm,f,a...) NV_PRINTK(crit, &(drm)->client, f, ##a)
> >  #define NV_ERROR(drm,f,a...) NV_PRINTK(err, &(drm)->client, f, ##a)
> >  #define NV_WARN(drm,f,a...) NV_PRINTK(warn, &(drm)->client, f, ##a)
> >  #define NV_INFO(drm,f,a...) NV_PRINTK(info, &(drm)->client, f, ##a)
> > +
> >  #define NV_DEBUG(drm,f,a...) do
> > {                                              \
> >  	if (unlikely(drm_debug &
> > DRM_UT_DRIVER))                               \
> >  		NV_PRINTK(info, &(drm)->client, f,
> > ##a);                       \
> > @@ -257,6 +259,12 @@ void nouveau_drm_device_remove(struct drm_device
> > *dev);
> >  		NV_PRINTK(info, &(drm)->client, f,
> > ##a);                       \
> >  } while(0)
> >  
> > +#define NV_PRINTK_ONCE(l,c,f,a...) NV_PRINTK(l##_once,c,f, ##a)
> > +
> > +#define NV_ERROR_ONCE(drm,f,a...) NV_PRINTK_ONCE(err, &(drm)->client, f,
> > ##a)
> > +#define NV_WARN_ONCE(drm,f,a...) NV_PRINTK_ONCE(warn, &(drm)->client, f,
> > ##a)
> > +#define NV_INFO_ONCE(drm,f,a...) NV_PRINTK_ONCE(info, &(drm)->client, f,
> > ##a)
> > +
> >  extern int nouveau_modeset;
> >  
> >  #endif
-- 
Cheers,
	Lyude Paul

