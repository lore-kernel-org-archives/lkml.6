Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F23C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F159020878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I9K3Ef1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F159020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLDLvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:51:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39461 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:51:40 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so13915665itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNglaynzG6zE10B9QvxFyeonyhHV3x/2AFoCl87gzkg=;
        b=I9K3Ef1K4XT/n0I3E2lw40t4fC0J9J/06b9mKNiDsZGcyV7XrkWmT+K6uX+Gxn71nA
         yb4KZdpHO52v+3Y37RqpPlFPBCr0qiaH/UnRLcfToJ/2bk8ptuI1kRvcwq5crIADVYfY
         pE1kTZ7O08SzKngfu+15bhVstFYs1Q5538seA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNglaynzG6zE10B9QvxFyeonyhHV3x/2AFoCl87gzkg=;
        b=nEpt+FKBC7BeauPH3Ian57DNmWH5pf2rguDxTsBTmdeFjZN6WrmFhWdtTI7SLHZo6f
         PsSLSbkTe/mhc7h9Gy4COMbwM9xFvShGThmEb1rLc8gi6+A4bheNJ5IIHZ4X6X0iVdNG
         d5gvXYlEBoCIMSJa4qQjMIe0Mcla0sB3/LJaqQuMch/vFPow9DRCPM9ReUHW3uprOULZ
         CTOD76MT86brHd0yQRs+C0PfIGiTp+ySJgeBN5Ai1tDTBF4AJmEKj5/CMunZg+nflciG
         UzZcGSjqu0WQK93OSRcBsKegPTcScJd+edrmGbpUSyRmVLBoC5haZEX2JRCP81HJiRbl
         8VDA==
X-Gm-Message-State: AA+aEWaXrUsBWZ4FvUdQJKcP54ZjMiwdSvrkzjfTNa1O8RFTw8XUHQZs
        VfKrxzvGCASLraKMMSDq2Y4JgP+xEsuG0ArSr2/4cA==
X-Google-Smtp-Source: AFSGD/UI+NkXMaWDXjksNUSo0YduSgTGsksLiMRwpWa2DuIfurbHRZ6EgQXWCSDoikLpqXFotunL59ra1E1qWtPpGFE=
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr10623454ita.140.1543924298633;
 Tue, 04 Dec 2018 03:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20181203222438.25417-1-eric@anholt.net>
In-Reply-To: <20181203222438.25417-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Tue, 4 Dec 2018 11:51:27 +0000
Message-ID: <CAApk1dWeKKrk1SpOQFi_6VLjfE-+4NztBd3RULhhwubzCtjqOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/v3d: Document cache flushing ABI.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 22:24, Eric Anholt <eric@anholt.net> wrote:
>
> Right now, userspace doesn't do any L2T writes, but we should lay out
> our expectations for how it works.
>
> v2: Explicitly mention the VCD cache flushing requirements and that
>     we'll flush the other caches before each of the CLs.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  include/uapi/drm/v3d_drm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 35c7d813c66e..ea70669d2138 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -52,6 +52,14 @@ extern "C" {
>   *
>   * This asks the kernel to have the GPU execute an optional binner
>   * command list, and a render command list.
> + *
> + * The L1T, slice, L2C, L2T, and GCA caches will be flushed before
> + * each CL executes.  The VCD cache should be flushed (if necessary)
> + * by the submitted CLs.  The TLB writes are guaranteed to have been
> + * flushed by the time the render done IRQ happens, which is the
> + * trigger for out_sync.  Any dirtying of cachelines by the job (only
> + * possible using TMU writes) must be flushed by the caller using the
> + * CL's cache flush commands.
>   */
>  struct drm_v3d_submit_cl {
>         /* Pointer to the binner command list.
> --
> 2.20.0.rc1
>
