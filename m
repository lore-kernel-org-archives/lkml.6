Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A2C2177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Segw7ZRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A2C2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeHCTBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:01:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:01:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so6026852wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=34oHgtuMXg+nXOkIyKByaSY+iRDDxhenRKBQzKu2ooo=;
        b=Segw7ZRTvKDlhOaUWBkvOxCXYXBd5CVlK+Ux73DCmw9X250WEjoJcKbBlJ9eNzeZcF
         1pzP/RXtVbPQ5kemu5hX0boKPPc3pOPqS0amtyHQbzk/58uTW+uxn1a1OTvufOfzd6sC
         8EPRpuKipMov0SMK/OWgShET7Bg/UUNLQnuIqbIwBE3pH5evI3dmt2nvaIg9HA8IYpbO
         n6KDohzpgoYdATttwdJg/d2Rbmzu3tCvzXM17Lr6nzDc7f0Zdpgub5IfkXnE9Q9M/fUM
         R+hz6KHa6pA1OIKX3BxCI+xHllQeQDjQ10ckxEIKbcK95vWc2g1C5ZrGc1qgKNjAZWjX
         jQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=34oHgtuMXg+nXOkIyKByaSY+iRDDxhenRKBQzKu2ooo=;
        b=A66582JgwGqJAbXF9X8EfhFJZV6CX85jOs/PtfwQXhnWlPCXspzG5sm3xUgHIMLZE/
         FrxNVJYddpwHqb4LJvkqWziZxlxV5ldeu0u/gS74vx9FHqmLrI1nLT5ZyZzUNPH3GWFL
         z34SN0kIYWLsCgqVly1fgEJjwTd4Qo9+w/WIPPM5cqEdvM9jXASq/YFFIC6Atyhvdqhn
         qaZrxeERsaOqqsZWaJHUtHobhcV4vWapOsZWgASlHiaAdXlXt/vv0HxdAQg2EB8YWj9v
         dqZZXC4EGju9CZfmbfraeiquYMsi1g/1OrEgpdm+IdFvDv1KBX7Vl9qTDTJBfVbqaWwy
         oF5Q==
X-Gm-Message-State: AOUpUlEtmTasWZzQ9vwb8tNhPKagbUZrXr+2UznhBMVcM+m7R+lRK0G8
        GgoV1FkTxXlZ6hBUlCwMpw6YzZaaTa2IwyRrGfs=
X-Google-Smtp-Source: AAOMgpdAzsiWuacH67ALTT1msLbfSvi7G1Tn30srSAhjPJzGQwIr7u7/XFomL5ryaNVD8wv1lhX6rAYQOHO+ZS+xwG0=
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr3234798wrs.137.1533315831117;
 Fri, 03 Aug 2018 10:03:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:178a:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 10:03:50 -0700 (PDT)
In-Reply-To: <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group> <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 3 Aug 2018 18:03:50 +0100
Message-ID: <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
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

On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> Hi Emil,
>
> On 03/08/18 14:35, Emil Velikov wrote:
>>
>> Hi Martin,
>>
>> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
>> wrote:
>>
>> Let's start with the not-so obvious question:
>> Why does one open the imx as render node?
>>
>> Of the top of my head:
>> There is nothing in egl/android that should require an authenticated
>> device.
>> Hence, using a card node should be fine - the etnaviv code opens the
>> render node it needs.
>
>
> Yes, the problem is not in egl/android but in the scanout buffer allocation
> code.
>
> etnaviv opens the render node on the *GPU* (for submitting GPU commands),
> that part is fine.
>
> But scanout buffers need to be allocated from imx-drm not etnaviv.
>
> This done by renderonly_create_kms_dumb_buffer_for_resource()
> [src/gallium/auxiliary/renderonly/renderonly.c]
> Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
> DRM_IOCTL_PRIME_FD_TO_HANDLE
> on the "kms_fd" (probably poorly named because it's not actually used for
> modesetting)
> see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
>
>
> If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
> DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
> DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
>
Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
So in order for things to work, we'd need to either:
 - allow dumb buffers for render nodes, or
 - drop the DRM_AUTH for fd <> handle imports

Pointing an alternative solution, for kernel developers to analyse and
make a decision.

>
> In android 8.1 the hardware composer runs in a seperate process and it has
> to use the card node and be drm master (to use the KMS API),
> therefore, when the surface flinger calls
> renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
>
> Making surface flinger use a render node fixes the problem for
> DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
> but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
>
>
> This probably worked in previous versions of Android where surface flinger
> and hwc were all in the same process.
>
There has been varying hacks for Android through the years. Bringing
details into the discussion will result in a significant diversion.
Something we could avoid, for the time being ;-)

Thanks
Emil
