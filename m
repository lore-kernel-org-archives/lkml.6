Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955A22175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqDJxrGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955A22175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeHCOV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:21:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeHCOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:21:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so5246870wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XuLan1+ws482brESSvG7ZrrRm1JYBisurpGscsrLpuo=;
        b=PqDJxrGHQmx7bohffki4fiHEBwFKbEa1T+4Du7KB7TAt5oH5QKf/PQvOwbbLWRGDl+
         t+6+lJlkAUC/hGx4EQAqvQwZ0i2Spb+oLd548frpxkH42/2s8I8I4YQGns1Z3lFZxVx+
         4nwRfgHHzUw7SM2/D1o69mQa/58VUnw2Vw+uEQuSygVkIuY33UBHaTgaC5E/CqRLmPIb
         qO0A/hnaS7zSHIQJngMOOsMEvz85VIYq4pJSM0UOBOwxfbCLDVA66toKzoB37egZer+W
         yDr0/0prJnt/9Z5yJssVAFuxNbP5ROMpLTf+crn2Jutw5iC+U/PNG74mHYLynJczHy1m
         +IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XuLan1+ws482brESSvG7ZrrRm1JYBisurpGscsrLpuo=;
        b=PBQyBj3vQ83siT4g/vGuthb7SF0NfvFA2KrkjjBkl3GQFuuyM+JL6BoqI/XPrW0KHh
         fxRxzs46JbSm22bRYQSK1zG2U10b17YFDZP1DmEoaAQCXpJtmLyJRXiIoDc6cFsfFDLE
         tWND4FRjO6LQEoo4hmw8ngYQ+e1MsIMjWActdWX+EzXrzmJA+I+9i8Pq4371MDgcvZmC
         idldp4Shew7t3Q5gM+aulJCCLK0Cw+Iax0MW8jrOwacAF8W57B+espdfr1YB58CCpwfR
         bx5K88WH3RCTUzCQeE27jCd+7LdDXmAXDBEiiMaNHO0QWD3uGhYQeJe1wzrPh0cEbdQ0
         wfBw==
X-Gm-Message-State: AOUpUlF4TcS1xvA4TMSdu1+rwqFihdNxLbcYd1pgHqm3F/7gf0QA4kRv
        MFRZiXSuNE0qsY7MIdreQn+QpNp2VeFa7VgZ/Jw=
X-Google-Smtp-Source: AAOMgpcnYKctTxD8giuyZe8f9VjNHbEkDl7myEYm9jE7nn/gyriHZeYLI2RoCU2cjMa6iQBw6a6PAhOJFkIyz/w9utI=
X-Received: by 2002:adf:eac8:: with SMTP id o8-v6mr2293150wrn.150.1533299119844;
 Fri, 03 Aug 2018 05:25:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:178a:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 05:25:19 -0700 (PDT)
In-Reply-To: <20180724082213.25677-1-robert.foss@collabora.com>
References: <20180724082213.25677-1-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 3 Aug 2018 13:25:19 +0100
Message-ID: <CACvgo52_fXMFR90esTuY6TgJfPaTU=EGN30aV=YtepNdSEQ1nA@mail.gmail.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Brian Paul <brianp@vmware.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Norvez <norvez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sharing some ideas on the topic. Personally I'm neither for, nor
against this patch.

On 24 July 2018 at 09:22, Robert Foss <robert.foss@collabora.com> wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> There is no particular reason to prevent userspace for using this IOCTL,
> considering that it already has access to other, platform-specific
> IOCTLs. This patch makes is possible to have the same userspace code
> work regardless on the underlying platform, which significantly
> simplifies the stack.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Zach Reizner <zachr@chromium.org>
> Signed-off-by: Nicolas Norvez <norvez@chromium.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> ---
>
> I've been looking into enabling a kms_swrast based driver for mesa on
> the Android platform[1].
>
> But have come up against the issue of dumb buffer related ioctls below
> not being flagged with DRM_RENDER_ALLOW.
>
> DRM_IOCTL_MODE_CREATE_DUMB
> DRM_IOCTL_MODE_MAP_DUMB
>
> To be more precise, I've been seeing a failure due to DRM_IOCTL_MODE_MAP_DUMB
> not being allowed for /dev/dri/renderD* nodes, and used in mesa
> kms_sw_displaytarget_map().
>
>
> As I understand it the DRM_RENDER_ALLOW flag being unset is a very intentional
> restriction placed on dumb buffers in order to minimize its use.
> But as far as alternative solutions for software renderers there seems to only
> be VGEM and mmap()-ing DMABUFs.
>
> While it would be convenient from the point of view of software renderers if
> dumb buffers had more promiscuous permissions, it may be a hard sell upstream.
>
> If dumb buffers aren't the way forward, what is? VGEM? Or are there any other
> preferable ways?
>
The description of VGEM says "... as used by Mesa's software renderer
for enhanced performance."
Although that hasn't been the case really, since we're opening an
arbitrary GPU node with kms_swrast.

I think we should fix that.

On top of that we could also use the card node, which will remove the
need for this patch.
Yet again, there may be reasonable usecases where one needs the render
node to support the dumb buffer ioctls.

HTH
Emil
