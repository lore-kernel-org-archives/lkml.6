Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80EDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE72174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCV97SC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEE72174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbeHGPlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:41:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33434 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388581AbeHGPlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:41:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so15811818wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JrDCOTs4uQPy0GETQyB8ar1aWcDDdccYHjE8ojb7S7o=;
        b=qCV97SC8YOsiszSTA4QUNjJsHETF07moBLPQp0KO29VF2Njyw5EIPWOwW51Hhz1pty
         GntJg8hI6HcLJ2KXZtdGkVriiPAOJSn+LAnHVTtcCBce/bUs2xhZNB/T+8pLjZvS+qbj
         NtqrP+OiZcSax+Ch1/KScehScYH10xfqVxx6QOwz2yunsQfYV/dNEq2Teo1q+A1Veaax
         df/6gD/eT4DCSY2dJ5rTtCXGQLW0r0Rud7LDgzdvY9uYag0DNn4PpM+3AQgI8iEdSIU8
         VCvjxLdLE8nyBY17C5OMwSRAWP+D1T3Sjpse9wrgiamzw2xV7oy36roC9f72KYPg7yE4
         O98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JrDCOTs4uQPy0GETQyB8ar1aWcDDdccYHjE8ojb7S7o=;
        b=CVDdg5rtYbg7hZdFUQPWUOaVOruryyIq4pwHdDlg+PD2x7RQKr+Gp6jM7knhni0KZJ
         VevEV/kyhaTkn6Gna1IU6JpAsxpAovpohF1ZArEnpPUfkaXoJ5uqOr+1+EdA1pzyQhhb
         MDQ0JT8ZGeOB07iAkXDqWza2zqcNB9NS6OvydtNDBshaF8AWbH4yMUcmY+gDFJe6ymlG
         bw1gxj/WwYnmYBWaKuVH9IWsIstRRS0LCP20lTm52GjiwBedMMWgvdNItvUkjKtVXhQW
         J21NHbFbhTGi7lnt8smEc1J8LokUhNqH+x0w/HfwGpcd5KqmL00tVnEIT9qW6nqhXPEf
         ihTA==
X-Gm-Message-State: AOUpUlEhX903zpB0iekJztQ96YioSZbvn5OCaeacHIZpLqtc+t5Cx92j
        z4+WJnXOQ7QDdFydB6QmpJXw2aH1pqtIG1hnXic=
X-Google-Smtp-Source: AAOMgpeB2I/M9pSDkhE3dFXxU82xjs/T5Mo0LDcZcxvxcTOz2/XWbX4rGa3uYncfoMOQiXklIQFrNrPqZrZUB6Oqrgg=
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr13429746wrv.4.1533648411277;
 Tue, 07 Aug 2018 06:26:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:178a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 06:26:50 -0700 (PDT)
In-Reply-To: <20180807122826.GU3008@phenom.ffwll.local>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group> <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group> <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
 <20180803195025.GO20303@art_vandelay> <CACvgo50Pk_FduWG5nev0W1pxqNfg3uMo0-7TuDPAckcBv=cHhA@mail.gmail.com>
 <20180807122826.GU3008@phenom.ffwll.local>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 7 Aug 2018 14:26:50 +0100
Message-ID: <CACvgo50Lxv8xy==Ai=TRLtSPBsuAmogXXobDViZwFoRr+2AboA@mail.gmail.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Robert Foss <robert.foss@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2018 at 13:28, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Aug 07, 2018 at 12:01:50PM +0100, Emil Velikov wrote:
>> On 3 August 2018 at 20:50, Sean Paul <seanpaul@chromium.org> wrote:
>> > On Fri, Aug 03, 2018 at 06:03:50PM +0100, Emil Velikov wrote:
>> >> On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
>> >> > Hi Emil,
>> >> >
>> >> > On 03/08/18 14:35, Emil Velikov wrote:
>> >> >>
>> >> >> Hi Martin,
>> >> >>
>> >> >> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
>> >> >> wrote:
>> >> >>
>> >> >> Let's start with the not-so obvious question:
>> >> >> Why does one open the imx as render node?
>> >> >>
>> >> >> Of the top of my head:
>> >> >> There is nothing in egl/android that should require an authenticated
>> >> >> device.
>> >> >> Hence, using a card node should be fine - the etnaviv code opens the
>> >> >> render node it needs.
>> >> >
>> >> >
>> >> > Yes, the problem is not in egl/android but in the scanout buffer allocation
>> >> > code.
>> >> >
>> >> > etnaviv opens the render node on the *GPU* (for submitting GPU commands),
>> >> > that part is fine.
>> >> >
>> >> > But scanout buffers need to be allocated from imx-drm not etnaviv.
>> >> >
>> >> > This done by renderonly_create_kms_dumb_buffer_for_resource()
>> >> > [src/gallium/auxiliary/renderonly/renderonly.c]
>> >> > Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
>> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE
>> >> > on the "kms_fd" (probably poorly named because it's not actually used for
>> >> > modesetting)
>> >> > see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
>> >> >
>> >> >
>> >> > If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
>> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
>> >> > DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
>> >> >
>> >> Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
>> >> So in order for things to work, we'd need to either:
>> >>  - allow dumb buffers for render nodes, or
>> >>  - drop the DRM_AUTH for fd <> handle imports
>> >>
>> >> Pointing an alternative solution, for kernel developers to analyse and
>> >> make a decision.
>> >>
>> >> >
>> >> > In android 8.1 the hardware composer runs in a seperate process and it has
>> >> > to use the card node and be drm master (to use the KMS API),
>> >> > therefore, when the surface flinger calls
>> >> > renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
>> >> >
>> >> > Making surface flinger use a render node fixes the problem for
>> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
>> >> > but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
>> >> >
>> >> >
>> >> > This probably worked in previous versions of Android where surface flinger
>> >> > and hwc were all in the same process.
>> >> >
>> >> There has been varying hacks for Android through the years. Bringing
>> >> details into the discussion will result in a significant diversion.
>> >> Something we could avoid, for the time being ;-)
>> >
>> > Did someone say diversion?!? The way this was handled prior to using
>> > render/control nodes in drm_hwc/[drm/gbm]_gralloc is that all modesetting was
>> > done via gralloc which was master. The hwc implementation was basically a proxy
>> > backchanneling all of the work to gralloc.
>> >
>> > Anyways, we probably don't want to go back there.
>> >
>> Now that we got the diversion out of the way, any input on my proposal
>> to drop the DRM_AUTH for fd <> imports.
>> Am I missing something pretty obvious that makes the idea a no-go?
>
> Dropping DRM_AUTH is only relevant for the card node. And a card node
> might not be sufficiently isolated against concurrent other clients, which
> is why we don't allow it.
>
Right. I did not spot anything that would make a distinction based on
the card vs render node used.

> What we could do is essentially check whether your driver supports render
> nodes (indicating sufficient amounts of separation), and then allow
> anything for unauthenicated clients if DRM_RENDER_ALLOW is set on the
> ioctl.
>
> But that's just reinventing render nodes on top of legacy card nodes, and
> I'm not clear on what that exactly gains us.
>
As more of a userspace person, it makes sense to keep render nodes for
GPU specifics and card ones - KMS/Display Controller.

> I think the proposal for dumb render nodes (for drivers which only do dumb
> kms buffers and no rendering at all) that's been discusson on irc a bit
> makes a lot more sense.

Ack. Thanks for shedding some light.

-Emil
