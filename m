Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A560BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650A12147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K+DB7Vtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBHIw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:52:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54164 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:52:58 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so7061851ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUWeBmVi/ZNlxZc2/1dsYS+gKLOvXcMSGajfB7U1Z0o=;
        b=K+DB7VtdAtU5K5IrdzmD8zrwd8p2+AelbvZXMvi7KJaMjpjUllN4KPQnvft5/ujJVd
         ixmkaky6Y71mUj0K89KC7TWW9czx90WeavQNMenz9dnhl7S2xIh9B8YaTJNMJkUv6oyH
         4Ia5iY1ZBIQE/YrKvKNtXy4GN4V5IfxHIfsEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUWeBmVi/ZNlxZc2/1dsYS+gKLOvXcMSGajfB7U1Z0o=;
        b=nQR499TwK2AevzAmOB7vFxFXrOBHbbcK91cjCYbRFCwF4op1VYaaNyRxtuvKRPNJJv
         iRppjCYiLRph/q7cxFN2Kmpb7ZCVwPVkNE1pGDHbVQMxI7PUaIo+spg6iVjNt1mFgoUM
         JWF5FC88Fu5F5fwqN8VAIWqgx6F+3HmCTBLDRpANEyY+E96uVHbTOTxLGlv1/yhP9as5
         AG6mV0D2b9kH5lPY4SOvL3zid07sFKaz6IpDPMtLXxEcCmqS1KZWyxOF+6FQV+r498PU
         8zya4cHv0RAABIdy+TtH+QanFcnuuumN0XsozFjxTWJdj7n12jGpEA4bs4Dfos+hSO0O
         ORqQ==
X-Gm-Message-State: AHQUAubtD6LAtUZ6ElneUGiYcmLC11+ogbqwtww5AVoY3UAjf74AGK5V
        TvqFI6lIRNQkyLNBagvEO5hTMlj/TXYtaGNoJqnzmQ==
X-Google-Smtp-Source: AHgI3IalDidm3d+amvu+yrt/Aobt733poCYgS8BtFlm82nAdKpFfRACsRxjFchC7EylLehRiwEfqvjhqR2Y1OyRwF+I=
X-Received: by 2002:a5d:959a:: with SMTP id a26mr11640306ioo.278.1549615977298;
 Fri, 08 Feb 2019 00:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20190208123815.64757bc5@canb.auug.org.au>
In-Reply-To: <20190208123815.64757bc5@canb.auug.org.au>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 8 Feb 2019 09:52:44 +0100
Message-ID: <CAKMK7uHOJwunZ0erM31fBNi+kADoK=Y=CRpoSTx=CRKFFL596w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:38 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from drivers/gpu/drm/arm/display/komeda/komeda_drv.c:13:
> drivers/gpu/drm/arm/display/komeda/komeda_kms.h:87:20: error: field 'base' has incomplete type
>   struct drm_device base;
>                     ^~~~
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_parse_pipe_dt':
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:27:3: error: implicit declaration of function 'DRM_ERROR'; did you mean 'DRM_IOR'? [-Werror=implicit-function-declaration]
>    DRM_ERROR("get aclk for pipeline %d failed!\n", pipe_id);
>    ^~~~~~~~~
>    DRM_IOR
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_dev_create':
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:127:2: error: implicit declaration of function 'DRM_INFO'; did you mean 'DRM_IO'? [-Werror=implicit-function-declaration]
>   DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
>   ^~~~~~~~
>   DRM_IO
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c: In function 'komeda_dev_destroy':
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:170:3: error: implicit declaration of function 'devm_iounmap'; did you mean 'pci_iounmap'? [-Werror=implicit-function-declaration]
>    devm_iounmap(dev, mdev->reg_base);
>    ^~~~~~~~~~~~
>    pci_iounmap
>
> and lots more ...
>
> Probably caused by commit
>
>   e3b01f0d576a ("drm: remove drmP.h from drm_modeset_helper.h")
>
> I have used the drm-misc tree from next-20190207 for today.

Yup.

Sam, can you pls take a look at what komeda needs? you need to
manually merge together drm-misc-next and drm-next first I think.

Dave, Maxime, Liviu: Heads up, drm-misc-next + drm-next will colide.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
