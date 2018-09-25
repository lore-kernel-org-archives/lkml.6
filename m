Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CC62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqrO0jpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CC62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeIYVAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:00:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYVAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:00:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so7566344wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u8ZF+ZFF1hhakpdeSKgjlZDz16thyUP50eThOZO3z6Q=;
        b=lqrO0jpWP/M3DyXVDxuqVMzYYmhw71W63qz8n2MrENl0tXCXtMp8ECVeHO7QbjJLHl
         e6I3NvbGlKLWJWKYtZhvI2JQ2TeD2z/MoEG/rNFNM/GfmKFYTrwvGWI8DosTRo8PvKSa
         Bkb57GxjXey75Jh5vKdWDzNToSYokF7SMl+VPYOB46H0VNtMiTn92hFLJ0e7f8tsHOQq
         OLdW9F2dFUnTCpqysN4kzvhQ3v/wBGLr+c9N5s320XOi+Ei4an9VOkjDcLmGNz6/Fukl
         XJ6LCkLrpa8ZrS1heNhqDtGeNGBcASnPMzUCakNkZxfXmheFMik52QAOPCpQU6wuyQBw
         yyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u8ZF+ZFF1hhakpdeSKgjlZDz16thyUP50eThOZO3z6Q=;
        b=lnSsYQtxjejUhBkcayNZnBrXGFaELF0PDuH3KOak9PIb/ORzSo0FdlJ0og/+P7Ael2
         rhOB4eIIlbeClhoqqzU8qfgD62khcia/rNV05bKxPklqnzheqLmtbnC9thlcC1p5Uf8d
         P5ObHNtHrWM1E4XhE2KZziiKLinHoALrJWlAbYE9aOFKmqcyWs2MxfNfuraA+LfhxPJ4
         M+zOnyjBE0VU5xGSZXK7rJ72LO+9IqzOIoP+LxJ2xWnLP+JGurOoSUuCuRPq1suEbXOi
         9tX+Rb/Z3i2fQ33kkHtcZe3K3yxLeCfEqc+EV1slig/nKdhjIieOhQitjPBOTc4FHEat
         RRwQ==
X-Gm-Message-State: ABuFfogSy/db4BKC0VAN2G/mkEBKOhmd/DYOX4fdXDwF8Y6RaQ17413f
        uQZwP89RmPX+M9XHHeWSGYnMEq1WsBCJAYwa7kw+A/qIQRU=
X-Google-Smtp-Source: ACcGV61UOtgmwFPx2FuONS4R1hkIBxkb3Sj9P5O6GRKCpcj4upH62LvlfpFjmXZasZR82EdGIh3CQMkm+8V8INr0gO4=
X-Received: by 2002:a1c:8085:: with SMTP id b127-v6mr1067309wmd.146.1537887169613;
 Tue, 25 Sep 2018 07:52:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:2d8e:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 07:52:48
 -0700 (PDT)
In-Reply-To: <1537880273-7277-1-git-send-email-ayan.halder@arm.com>
References: <1537880273-7277-1-git-send-email-ayan.halder@arm.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 25 Sep 2018 15:52:48 +0100
Message-ID: <CACvgo52+FbvK-c7KWXmUa0pFkkwfgtOPE9vPXN42s=ZRY=_mOA@mail.gmail.com>
Subject: Re: [PATCH v3] libdrm: headers: Sync with drm-next
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 September 2018 at 13:58, Ayan Halder <Ayan.Halder@arm.com> wrote:
> Generated using make headers_install from the drm-next
> tree - git://anongit.freedesktop.org/drm/drm
> branch - drm-next
> commit - 2dc7bad71cd310dc94d1c9907909324dd2b0618f
>
> The changes were as follows :-
>
>   core: (drm.h, drm_fourcc.h, drm_mode.h)
>     - Added client capabilities for ASPECT_RATIO and WRITEBACK_CONNECTORS
>     - Added Arm AFBC modifiers
>     - Added BROADCOM's SAND and UIF modifiers
>     - Added Qualcomm's modifiers
>     - Added some picture aspect ratio and content type options
>     - Added some drm mode flags
>     - Added writeback connector id
>
>   amdgpu:
>     - Added GEM domain mask
>     - Added some GEM flags
>     - Added some hardware ip flags
>     - Added chunk id and IB fence.
>     - Added some query ids
>
>   i915:
>     -Added an IOCTL (I915_PARAM_MMAP_GTT_COHERENT)
>
>   qxl:
>     - Minor changes
>
>   tegra:
>     - Added some comments about struct drm_tegra* members
>     - Modified DRM_IOCTL_TEGRA_CLOSE_CHANNEL
>
>   vc4:
>     - Added some members for 'struct drm_vc4_submit_cl'
>
>   vmwgfx:
>     - Added some DRM_VMW_* macros
>     - Renamed some structures like 'drm_vmw_dmabuf_rep' to 'drm_vmw_bo_rep', etc
>     - Added some new DRM_VMW_GB_SURFACE related structures and unions
>
> Changes in v2:
>     - Mentioned 'libdrm' in the commit header.
>
> Changes in v3:
>     - Removed the changes to radeon_drm.h, sis_drm.h and via_drm.h as suggested by
>       Emil Velikov <emil.l.velikov@gmail.com>
>
Seems like there's another breakage: SVGA3dMSPattern and
SVGA3dMSQualityLevel are typedefs from some random header.
One solution is to use the explicit fixed-size int equivalent.

Just like the earlier suggestions - things should go into the kernel
first or we can drop that file for now.
Sorry for missing that one :-\

Thanks
Emil
