Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2327AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D7221757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTILfX72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D7221757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbeHGNPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:15:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52139 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:15:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so16980525wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JfFDy50f8k+rF9zVUA29SlVOmGYP2ZMLDAJ5Z5F3E/A=;
        b=cTILfX72N0JH+JxTDN3V3MWYa9mYF5ieWt+LtvQJeF0yLHRULWOVq1T8kjeTT8Q6oq
         okJAJWBAySP+U+gTRHPKOnLg9HiFJVYeq1dVC0KnrGNBB72/3QXQ4Q3zuaNySd2THKtm
         +xfLCs2dtQbhCo84qD3yzOxdoX5iTx1MqanIXb/T5Jap/PcAdHzR4yRQMoEr1uQbuYL/
         phNqvckDwFlJZPg+hiBC9C+JV1SaQ4Xj6vzsm4Vglfk2Y5lzwHrJpN/KWfzD5Uo64QEG
         Kp6pxYlGjJ0Gh20jq3VtXQ0Om3creKjViLfTgV9ogYLAmPGld+DDuPXtm+N1tEqubR0q
         bYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JfFDy50f8k+rF9zVUA29SlVOmGYP2ZMLDAJ5Z5F3E/A=;
        b=HIDC7BHQ6tT53VmAXme0uKL/HzPe98hlXe0tN4VZ2PU+eDENYa6uR7tM5/IEONAfLi
         pkOAGtD++UJdsWuUNYDBF2cFdJYw3qIhuGe+p8Bmddklb8zPaWDmCw/k7ZS+aibO7XUh
         UQPqpdcv6zLOT1zmZTJqHs0UqN1G5iT7q3yPtnpMhzb0QUQu9FS6Y/7ASB1C5En3QWhy
         fxMA+xhVVLmEo6Y4NK4Ybm/041i3nfHksMTKuP3BrliPBfSBPI56RPgtNkQ2NUBX0B0g
         3Yjg61zB4G1b74novoYMfbVseuPhVwGOp5Vx5RaKMzwFHsZEOnL/OYCNDsmNr0hReknW
         R44A==
X-Gm-Message-State: AOUpUlGqatJytqsonn2P6LUfRuBBkCbcSyMyPoTLMSg8hB5WS2Z57opO
        0pvr8eoqJ9dX22JVO3eHXdemzacmyFfjM41wzBs=
X-Google-Smtp-Source: AA+uWPx3qlW56S+tUPeUiSg8X5ks6ztg/UROKvbQXSEoviScNDx+7oOwqGBCVZoWFNG/DIg45+nbzg4QXfOBkDpCSQ0=
X-Received: by 2002:a1c:e595:: with SMTP id c143-v6mr1396927wmh.85.1533639711543;
 Tue, 07 Aug 2018 04:01:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:178a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 04:01:50 -0700 (PDT)
In-Reply-To: <20180803195025.GO20303@art_vandelay>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group> <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group> <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
 <20180803195025.GO20303@art_vandelay>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 7 Aug 2018 12:01:50 +0100
Message-ID: <CACvgo50Pk_FduWG5nev0W1pxqNfg3uMo0-7TuDPAckcBv=cHhA@mail.gmail.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2018 at 20:50, Sean Paul <seanpaul@chromium.org> wrote:
> On Fri, Aug 03, 2018 at 06:03:50PM +0100, Emil Velikov wrote:
>> On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
>> > Hi Emil,
>> >
>> > On 03/08/18 14:35, Emil Velikov wrote:
>> >>
>> >> Hi Martin,
>> >>
>> >> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
>> >> wrote:
>> >>
>> >> Let's start with the not-so obvious question:
>> >> Why does one open the imx as render node?
>> >>
>> >> Of the top of my head:
>> >> There is nothing in egl/android that should require an authenticated
>> >> device.
>> >> Hence, using a card node should be fine - the etnaviv code opens the
>> >> render node it needs.
>> >
>> >
>> > Yes, the problem is not in egl/android but in the scanout buffer allocation
>> > code.
>> >
>> > etnaviv opens the render node on the *GPU* (for submitting GPU commands),
>> > that part is fine.
>> >
>> > But scanout buffers need to be allocated from imx-drm not etnaviv.
>> >
>> > This done by renderonly_create_kms_dumb_buffer_for_resource()
>> > [src/gallium/auxiliary/renderonly/renderonly.c]
>> > Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
>> > DRM_IOCTL_PRIME_FD_TO_HANDLE
>> > on the "kms_fd" (probably poorly named because it's not actually used for
>> > modesetting)
>> > see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
>> >
>> >
>> > If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
>> > DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
>> > DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
>> >
>> Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
>> So in order for things to work, we'd need to either:
>>  - allow dumb buffers for render nodes, or
>>  - drop the DRM_AUTH for fd <> handle imports
>>
>> Pointing an alternative solution, for kernel developers to analyse and
>> make a decision.
>>
>> >
>> > In android 8.1 the hardware composer runs in a seperate process and it has
>> > to use the card node and be drm master (to use the KMS API),
>> > therefore, when the surface flinger calls
>> > renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
>> >
>> > Making surface flinger use a render node fixes the problem for
>> > DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
>> > but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
>> >
>> >
>> > This probably worked in previous versions of Android where surface flinger
>> > and hwc were all in the same process.
>> >
>> There has been varying hacks for Android through the years. Bringing
>> details into the discussion will result in a significant diversion.
>> Something we could avoid, for the time being ;-)
>
> Did someone say diversion?!? The way this was handled prior to using
> render/control nodes in drm_hwc/[drm/gbm]_gralloc is that all modesetting was
> done via gralloc which was master. The hwc implementation was basically a proxy
> backchanneling all of the work to gralloc.
>
> Anyways, we probably don't want to go back there.
>
Now that we got the diversion out of the way, any input on my proposal
to drop the DRM_AUTH for fd <> imports.
Am I missing something pretty obvious that makes the idea a no-go?

Thanks
Emil
