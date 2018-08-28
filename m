Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESMfYzhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1S4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1S4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:56:40 -0400
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com [209.85.216.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2872087B;
        Tue, 28 Aug 2018 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535468674;
        bh=FBJDJgrDZj8hSHs0gy7bP4ijiRNv7XVOKCsmGExckT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ESMfYzhuc4Lzxhzl/LFQAIKWqOyi6nUpvkpf3+laCCVxewPnx5snbCM52h68q1MB8
         hy666jApZKhBsd+zdIkv5GRvxGUOBFHAAvGzRgsrdM5n+LtP2aD0qYoxB8xRnVmI0g
         c+igMig03MTLiDeBmkQRIRMA49IasX6kxwfmWJfw=
Received: by mail-qt0-f182.google.com with SMTP id t5-v6so2057769qtn.3;
        Tue, 28 Aug 2018 08:04:34 -0700 (PDT)
X-Gm-Message-State: APzg51C2aL6R1Exvl0+Q8aUnxqMOPmnQpuJKP46+RVvz7OZKZP3EBRjH
        /6MjiGtIG4OqXxa7IyyIGOYmmLWSExBw75BSow==
X-Google-Smtp-Source: ANB0VdY87SAwzDDvyMGp/19k0oPIreDyXkKL3fStq3YIWdMTBak4xIMPJhvU0BpzxA3wJZJ8xNy9XOp9fYm6dyMC/Y4=
X-Received: by 2002:ac8:148b:: with SMTP id l11-v6mr2139464qtj.27.1535468673978;
 Tue, 28 Aug 2018 08:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-19-robh@kernel.org>
 <597b1b06-e1fb-dcf1-67f4-d6685fd38cad@linux.intel.com>
In-Reply-To: <597b1b06-e1fb-dcf1-67f4-d6685fd38cad@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Aug 2018 10:04:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+a4CU0b-ZMz7K5Ezmuw-Djrkuet6ZAg+CL_4NJkSyzw@mail.gmail.com>
Message-ID: <CAL_JsqJ+a4CU0b-ZMz7K5Ezmuw-Djrkuet6ZAg+CL_4NJkSyzw@mail.gmail.com>
Subject: Re: [PATCH] drm: Convert to using %pOFn instead of device_node.name
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:54 AM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Op 28-08-18 om 03:52 schreef Rob Herring:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: freedreno@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_modes.c     | 4 ++--
> >  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index 02db9ac82d7a..24a750436559 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -716,8 +716,8 @@ int of_get_drm_display_mode(struct device_node *np,
> >       if (bus_flags)
> >               drm_bus_flags_from_videomode(&vm, bus_flags);
> >
> > -     pr_debug("%pOF: got %dx%d display mode from %s\n",
> > -             np, vm.hactive, vm.vactive, np->name);
> > +     pr_debug("%pOF: got %dx%d display mode\n",
> > +             np, vm.hactive, vm.vactive);
> Aren't you removing it here instead of converting?

Well, yes. The full path and name are already printed so the node name
alone was pretty redundant.

Rob
