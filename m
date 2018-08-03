Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B19C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2EC2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk3gSgwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2EC2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCObw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:31:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45274 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeHCObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:31:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so5252179wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wpQmnJomdj2K6XAdjkAsijWMJ5sp0iOAASGaGcqKubc=;
        b=Tk3gSgwgIVaJ7J7BmTSEkron0641pKP9IyDlWwBRLAUDsitkWegqxrQUjWngMLVxTx
         OFcy8PMprCncEU20EYaRgy9ydaipLvf1l5X4xpolMKokTKpC56OiKmOEqNUnbBnu6nt+
         0Sf1OH2+1byk9kMSDznvZsKm7oRAruKDr6jGN6/4zvxNR+afnk+JciYv7r73etuf8R1V
         9ekEOMU/s/1bzGToEIM8uWxrZhy1faqRcCbkwNN+L8Sv5K7L02tJJIo6sd7cVrdxoki9
         AuxPfgVIpa2ogxcdxTumizP9MZnL0FrnGoQtIXIAufyXd/l0xOElB/tCfLptxjJEv+R4
         oSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wpQmnJomdj2K6XAdjkAsijWMJ5sp0iOAASGaGcqKubc=;
        b=nrkxAiPOYRsYq3ajwe5SvWcKw+s7Pn8rF/UxZZvzgRtbz3eYLhlmZKcl1yFqCU/JU7
         O4BMazbCvUjylmWEaz9ez8h9E//d/EUnc3Syz9uNahs03fWmH3tKcsGDxaRWQjn7y5s8
         QXWnJoT2hjQnqgeukczPpBSNvL23QPBYE5Z7y+m2OQqfS0ELPENa6birs3OHtqC2DnNF
         2aUkI1Pwtk+dsnZ5ah2Z/R5KnfQ8CpkpJnDbm9X8ykXcnq937nVVWjPIHv3os+8PQBQk
         TygNqr2WShLZ5gLsidNUeUUNhJPBv9C1mAsqQzWgI+IyLKXlJP93JLa9x3m4feJCFPUp
         Ujag==
X-Gm-Message-State: AOUpUlFba7HRj+UfqHR2J/QyTBZz64+GeN5S7s4J85BVNRvOLQOpauE4
        Yt43sgK5QrAHPwEwn4wlEZva1vCMRF4pJu+6LOo=
X-Google-Smtp-Source: AAOMgpe1dnU1ozkdtwL/p1OCjfhCPXrZlZbj8Bs031xy2jRaU/vBzwb6Hdv/D7BJrNhPSWlYE1CkotDBRDcsfYQsfow=
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr2535039wrs.137.1533299742819;
 Fri, 03 Aug 2018 05:35:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:178a:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 05:35:41 -0700 (PDT)
In-Reply-To: <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
References: <20180724082213.25677-1-robert.foss@collabora.com> <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 3 Aug 2018 13:35:41 +0100
Message-ID: <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> Hi,
>
> I am running into the same problem using etnaviv on i.MX6 under Android 8.1
>
> The mesa etnaviv code uses CREATE_DUMB / MAP_DUMB for the scanout buffers
> and is called from the surfaceflinger process.
>
> But, under Android 8.1 drm_hwcomposer runs in a seperate process to
> surfaceflinger.
> Since drm_hwcomposer needs to use the KMS API it must be the DRM master,
> that means that surface flinger cannot be DRM master too.
>
> Adding a render node to the imx drm device and configuring mesa to user
> fixes
> the problem but requires the render node to have access rights to use
> CREATE_DUMB
> / MAP_DUMB.
>
>
> Here is my full patch:
>
> Make imx-drm export a render node so that mesa can use it to allocate
>
Let's start with the not-so obvious question:
Why does one open the imx as render node?

Of the top of my head:
There is nothing in egl/android that should require an authenticated device.
Hence, using a card node should be fine - the etnaviv code opens the
render node it needs.

It's been a while since I looked at the imx/etna code, so I may be
missing something.

HTH
Emil
