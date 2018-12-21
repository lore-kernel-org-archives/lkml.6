Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C74218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqDinqEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbeLUTlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:41:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50883 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389698AbeLUTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:41:18 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so8536428iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x0CF291M5+8V+SPL6vHpEZ2KD6w++V0lbIFulR40ZKg=;
        b=gqDinqEdqOnVbdwoQKW9JmSazQoJCuF9/+7Q09duF2Sy2Tf1YUNfjmmB3ciKGv/tu6
         00BmuDwfGa9XUMaAgIRijd0BM4+Ns5LXLsWta+mIj5MCN3MnRUr0wcgvPwtzQNhBIdn4
         3LDTHttVxPkgUbB8q4E26LVNaBCOw3wsHNnLHzCdiAYW+dGZt0x0shMZwKVJdT26gZoU
         PQBDDPrOUD1Xd29FfAifprPewxnLRWDRGcQRLrIt+PtNiemK1EsCTctF5OL8IhqHJFXb
         zXZJtyeqX9PczOfmQ4Ke+PTzxkaqvP+ZPUaY6nu2B6l5nzq9HvXvkBjC8WcG/Jwufqtr
         owAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x0CF291M5+8V+SPL6vHpEZ2KD6w++V0lbIFulR40ZKg=;
        b=no1n0RzmxVqHE7mDfscHsKuCcza7RHz1w5j2+rnLROyEhlBwLYO5oOLHHp9EIi3qzo
         IK7lzy69GsBJrZH/je2fFcoCrNcxXuWrmRuMJVc7uIw3EQy5Xx0BQEnGMdlv/Wet7FVB
         cnZqvDvTfKDEVT+19yu8sAEsQgMpaLEqp2M+aIy++dJ+GIZYMcghDkyatjpNsvhk1jw6
         Z77kJrOi8fsYhibWfQeygctgTpCUREKFyWUznKOOM37zwt5j6kxyvJshVCC2SeXUMVFK
         QtGUepsSb6Bcpn3P6lGzaY036vbzZ8Q4VhXvfksTWyyquyhYrfy7HCuI7xq7/l9JKAq3
         mpXg==
X-Gm-Message-State: AA+aEWZqSmyBATqEv9lM3EvFldXIvS77/Pj7fbuKYQ0ntqWJfyfgbVOR
        MYG+f/DwRnc/Xh/dOd8M8JXMig==
X-Google-Smtp-Source: AFSGD/UL+WFqPyPexKLGVxFr7HyFl+nfUufjfFVNFvR8cIfbgq79Lmhc5lrnfd2BI2Mh+0nGAN6Ofg==
X-Received: by 2002:a24:5a11:: with SMTP id v17mr2901280ita.114.1545421276309;
        Fri, 21 Dec 2018 11:41:16 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id c21sm10823998iob.22.2018.12.21.11.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:41:15 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:41:13 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Samuel Li <Samuel.Li@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 2/3] drm/amd: validate user pitch alignment
Message-ID: <20181221194113.GA23401@google.com>
References: <20181221031053.240161-1-yuzhao@google.com>
 <20181221031053.240161-2-yuzhao@google.com>
 <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:07:26AM +0100, Michel Dänzer wrote:
> On 2018-12-21 4:10 a.m., Yu Zhao wrote:
> > Userspace may request pitch alignment that is not supported by GPU.
> > Some requests 32, but GPU ignores it and uses default 64 when cpp is
> > 4. If GEM object is allocated based on the smaller alignment, GPU
> > DMA will go out of bound.
> > 
> > For GPU that does frame buffer compression, DMA writing out of bound
> > memory will cause memory corruption.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index e309d26170db..755daa332f8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> >  	struct drm_gem_object *obj;
> >  	struct amdgpu_framebuffer *amdgpu_fb;
> >  	int ret;
> > +	struct amdgpu_device *adev = dev->dev_private;
> > +	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
> > +	int pitch = amdgpu_align_pitch(adev, mode_cmd->width, cpp, false);
> 
> Also, this needs to use mode_cmd->pitches[0] instead of mode_cmd->width,
> otherwise it'll spuriously fail for larger but well-aligned pitches.

Good point, thanks.
