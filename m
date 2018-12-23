Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84195C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441B22184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLiLTBJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbeLWVop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 16:44:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 16:44:45 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so13949407ith.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x91+ch0VmYQ9CI349v01D35K3GZjNxKUesirLmRtlM4=;
        b=GLiLTBJ2pNRKo9cL6CpyOy7FFUkPZ6lTXepAAbVPReyOGKaqSpxtKbEbkaJub2SLGN
         roHDjPRnvlHpajJS8OyJIAhHTgqaWQPLnoAYH3KDGJ2qv4m3uco+D9Ixqs3QlXi8aF4J
         l4gSNsqNU8AOd9MPRGT3clmuErD1XfWG1Rf/oVgibeph2blU48nnAgMREKUpeoWM7pac
         1GjHU8QlaFM9PZDi3pafUTRxPi5rhfDBAG9DTXeb5yoUE0mnDTf1Iqhg9Ah+jy4h3EFw
         6ah+txxVRCC/+UVPlJwWiz10BqWiNJoHnXCWzXUyAzshgTpwYZ48jdBY1jhJMxYEy0Cq
         y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x91+ch0VmYQ9CI349v01D35K3GZjNxKUesirLmRtlM4=;
        b=mC5KY3h+WiI6WQxtzBlh/goGjn8jxNeIsrCNEGs0DuBqAnQnltc7gj+G/b5cOodHvA
         lahDkkGAuPXksOWOqkCTsEexD4c4yHMBBk3f9u6Uv3CjqIfLF+vKUkY8hfYOIbpG07K8
         thCDhMk1uyHJM8rC2PAiGbcGP+b1mgx5XukugAlCEa8Y7+2V6/ul6UZfTtWagaRtDAC4
         ZvPdziaqBuHxzRaSzQ4Xqr/GyMlZnCZwQg84MGWx3ETaFhwF7pDWe6gFUpn2OAaoEji+
         /pVo4Wh98TeV17or22PZz2L5SUAXDTFd1Yru8KSm4YEfETWv7dtV+K3lBlUHR9WBSz9+
         OHmw==
X-Gm-Message-State: AJcUukfsQspCD/RsJbnp1AdlRUPXDAQToXjZNETWjdAmKaDWFnsc/lyZ
        yHLSVa0498WZ7m67F54QFHluKg==
X-Google-Smtp-Source: ALg8bN46TbsSZCATba0tbKNPFEoBpQZiPJt//ljd9ExWy2zyMihzWVHvNTOtHT3CfwkKCfEFfILgvg==
X-Received: by 2002:a24:9b87:: with SMTP id o129mr7584857itd.128.1545601482630;
        Sun, 23 Dec 2018 13:44:42 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id w16sm10326120ita.38.2018.12.23.13.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 13:44:41 -0800 (PST)
Date:   Sun, 23 Dec 2018 14:44:39 -0700
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
Message-ID: <20181223214439.GA157289@google.com>
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

Actually mode_cmd->pitches[0] is aligned mode_cmd->width multiplied
by cpp. So we can't just use mode_cmd->pitches[0]. And I'm not sure
if the hardware works with larger alignment (it certainly ignores
smaller alignment).
