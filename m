Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B63420652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppOO3KYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B63420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJDVIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:08:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33420 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbeJDVIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:08:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so10146775wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqNt2PpXNA3fvyQENUtKxiEO+/eq2FJuYNroZP+aR/U=;
        b=ppOO3KYl4TRKJog5wOjCHvTVIlyCWQWW+JOBTh+xEkDEvGB4qffDUQF8GDyO4rV46u
         hL7MCHg2yVXF8IFkCTPV91XdAd8PHNl6wo38sBMB+fTIQ6pT+OUehNNagNw6g8WKWjUJ
         0FDwTW/vgf9wtZAIb1mapw/mE0mxkmnHFh7Hd20sGC84Mj+D3UoslMB0FNCSCv6z93tz
         AyIgXSKpFYLIomVPQ9qBtTyQZx8I8hyxPHnhI9oAgkzVDEL8HEWkF5CT28d7Ra/cF1IP
         L3E1LiNfaOjLCGnmFXEM1+grV752GBrPiM0MUYuQPGOI+wEeHzYiFmUKz5K2coPt35vT
         +bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqNt2PpXNA3fvyQENUtKxiEO+/eq2FJuYNroZP+aR/U=;
        b=GA/nS2CU2OrJkDegGd1w/qstcjABYtbxZJ2744xKN1wTvKVAp57i7Fb/mNLo3IqxCv
         vEcqmrcOTbUU7ignVJ8jOhU09SORMwsYA04QHv9DrA6it3ln1p8U3NfPHgak9jNAvUjV
         YNkQ08PBSQZ0DUh1pNl7Ct1KxzmzggDkYQnEWcdLwUV7DgBKPzb68fq1nDR8Y0FPG+RO
         4Y0H23w2ND1GBcYsfCcUeK4fmQTzg29OdSXXJ4Bsgiug2VavsqeC/UfJJ1rBQKju8tVO
         MDVszfATIIbTOunDYRVbfQcBC/zb3AbRSBlBbF/rivnWY4ewz+pDfdsH8gNPjSjBeg8/
         cFxg==
X-Gm-Message-State: ABuFfoiCb/9Vqaeefw7PNCCmx6YNb1mIGtMRddnhlSmIu4Yi76E/U4jG
        tPWHGgS8xQRGooPDiCmov046oHJA1cA1JPR3IWg=
X-Google-Smtp-Source: ACcGV60MS6bj6QAy5nrSLWUDWgUBQyxdhW4IipqG5x0QtxFlqL5oly4a/rS2oPH3Zi4uWdSwA4H5D5wSJoK7qp9NdoU=
X-Received: by 2002:a5d:404b:: with SMTP id w11-v6mr4743156wrp.147.1538662509195;
 Thu, 04 Oct 2018 07:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <1538406558-6433-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1538406558-6433-1-git-send-email-ayan.halder@arm.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Oct 2018 15:09:45 +0100
Message-ID: <CACvgo50fW1=0WC6PY85XHVzXYiNFo5Q732s2K0DVLyiwUtNGhA@mail.gmail.com>
Subject: Re: [PATCH libdrm v4] libdrm: headers: Sync with drm-next
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 at 16:09, Ayan Kumar Halder <ayan.halder@arm.com> wrote:
>
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
> Changes in v2:
>     - Mentioned 'libdrm' in the commit header.
>
> Changes in v3:
>     - Removed the changes to radeon_drm.h, sis_drm.h and via_drm.h as suggested by
>       Emil Velikov <emil.l.velikov@gmail.com>
>
> Changes in v4:
>     - Removed the changes to vmwgfx_drm.h as it caused a build break ie
>       'make check' failed.
>
> Change-Id: I018a06f65bf4a6a68400ab252b9cd05d041299b3
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

With all the corner-cases sorted, merged to master. Thanks for the patience.
-Emil
