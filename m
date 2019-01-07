Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAA520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r33pNFk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfAGEAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 23:00:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53168 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfAGEAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 23:00:43 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so8865445itg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 20:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=msYUTA8V1LXBK1Dwj8cMNbE1LfVrLU3s4S15xbngTn8=;
        b=r33pNFk1u438go9RUKJYNJgu2KrI4kvpbVkX72e2athiU0QMtP4Jk2JPi+adf6NecF
         HCQt05PnHLzQ39wugrqqHuKeKf6CfDTmmPmP9iYpi75aERE5j0CnZplVW7eJyP4ffsrk
         SXW3iOyp0vyLK5EkZOnSchhpimV6I+1C/DGKMTmWhcuWiBH6lgwuNeru7YKRPqtpfV3f
         MDBadvnJRLig2+wyHyCNNT3lCTTCe+WYzZiO16qkfwawUUOpNf7whE8g1OJbfOB6LDD1
         G8JoQH4hEDgTwshN5u9+DYiKQJFiG7BsQ8ePzrFpoRsnqSYFP7bSCeUfasEWYHvDJ/sz
         A7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=msYUTA8V1LXBK1Dwj8cMNbE1LfVrLU3s4S15xbngTn8=;
        b=jLlcDI3ym/06U2DgUUO6Fz2GycoSs+kPGwq4uy5dJJtZTvBAh8MfeODTipmG+QRidV
         iXL/N8QGBUL+TmMbt8WiMpVV2T2ZHDYzAVnF3akZ525avqPLqOdWCOuDilDNAiuV45/H
         +CZhUcKhQzxe8cx03KvIHzZ3OA8ZnWUmMLSXYs5SS036yhkh3frkt4TqqlaZZ4lVGlYC
         0bvNJxIHhPqTn2LWQPeOB+n1APOnEKAyXXi4fV9E2BX4cDFktfkZRkcnMTuigompgvsR
         5UhT2HQptp/sqKhbw9MDeUzK+eV/IGGJYu9ekzOmiqRLVhNK1Wo6uJ8JouHP3rRpsILG
         ermg==
X-Gm-Message-State: AJcUukcuW/GAuigZv3RyRsF/BAQyHLij4tLylYDaHKwStUKEAFaoDdpT
        w8HGZfBLD8S2v5gtfhGMgRBSHTA/JhC51rC5
X-Google-Smtp-Source: ALg8bN4x9hvRFacRi/eG3kaRkz0f4odCXWqXGlyWHEUjvtcjz/2mjmdSAhXNKlJCzr6AbSRzGqekUg==
X-Received: by 2002:a24:af0a:: with SMTP id t10mr6882810ite.159.1546833642022;
        Sun, 06 Jan 2019 20:00:42 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d2sm12754033ioc.69.2019.01.06.20.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 20:00:41 -0800 (PST)
Date:   Sun, 6 Jan 2019 21:00:38 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Samuel Li <Samuel.Li@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>, stable@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v5 1/2] drm/amd: validate user pitch alignment
Message-ID: <20190107040038.GA180037@google.com>
References: <20181223215239.173339-2-yuzhao@google.com>
 <20181230010021.196990-1-yuzhao@google.com>
 <75d5f1d6-b259-6944-6ee0-8cc68cb1af0e@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75d5f1d6-b259-6944-6ee0-8cc68cb1af0e@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 05:33:19PM +0100, Michel Dänzer wrote:
> On 2018-12-30 2:00 a.m., Yu Zhao wrote:
> > Userspace may request pitch alignment that is not supported by GPU.
> > Some requests 32, but GPU ignores it and uses default 64 when cpp is
> > 4. If GEM object is allocated based on the smaller alignment, GPU
> > DMA will go out of bound.
> > 
> > Cc: stable@vger.kernel.org # v4.2+
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 15ce7e681d67..16af80ccd0a0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -527,6 +527,22 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> >  	struct drm_gem_object *obj;
> >  	struct amdgpu_framebuffer *amdgpu_fb;
> >  	int ret;
> > +	struct amdgpu_device *adev = dev->dev_private;
> > +	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
> > +	int pitch = mode_cmd->pitches[0] / cpp;
> > +
> > +	if (pitch < mode_cmd->width) {
> > +		DRM_DEBUG_KMS("Expecting pitch(%d)/cpp(%d) >= width(%d)\n",
> > +			      mode_cmd->pitches[0], cpp, mode_cmd->width);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> 
> This should possibly be tested in drm_internal_framebuffer_create instead.

It seems to me drm_format_info_min_pitch() in framebuffer_check()
already does it. We could just remove the check here?
