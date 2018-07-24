Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43178C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41DD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y1vCcdZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41DD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeGXT4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:56:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46701 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:56:19 -0400
Received: by mail-io0-f194.google.com with SMTP id i18-v6so4263806ioj.13;
        Tue, 24 Jul 2018 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNEPv+6hncH7eYWONLuf0yzm7p6PjXrCq11j3wRt4l8=;
        b=Y1vCcdZRNAnPDQN0yOrwS5MKpM4nlMef96D1difZ7CAWnX0cZlN/HEO+BW1dtXmWch
         OVLz0y9kffSfJ5gGVEkyJj6iB6B+bFXSEJWna68gmbOcXE+RH63PDqvt0qF9YShlEpSA
         jQP+CdmHWWirAn9kF3/TbIWg18x5wcWjN2jX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNEPv+6hncH7eYWONLuf0yzm7p6PjXrCq11j3wRt4l8=;
        b=USzXKoMKbP8rJyQfhUn9vNZj7LA3JqcCo+5Sp4wsK7S0NHHIjA42hq5KCDRWXIjzbE
         +EuNT8IWSKbbtsOD+PvnurEDpQy7wHwyIUcVNw6Ebj0SrTy3lCKxa3bDOYMOk14hm7IT
         Jy+63TlF2a4by/Z+gI6/G5DCv4RvtP7eUp/n/VuQfPWI2P0zrephoiIBACx5ofDqqIHk
         7l4rdgd97c/MGJoCFpN1NXMOExITt5uzyoRc6Nry42o7T+vJgOAyKQz+E0S6CQvd25Bx
         dsbWxWtgfr/rjUwvBmuWaOgUyrku3GmYaXxHWXkzK82FSODmKQgVMtmhiUekgIzoOqjw
         bN8g==
X-Gm-Message-State: AOUpUlGzR+MbHZ5KdSb1PBUA23Zxj4BbxwBM8Ct/++QUhYT19NkTiqgy
        Ew7/Ad1LcmrITHlRyi6ytAf1XUOXxMPImpu13CY=
X-Google-Smtp-Source: AAOMgpckS3UuUtNx16b+Iv5PAfFpsp3yus4L876DuUZTtz27MlOCmuNT+7BP1MYyzP+g6K0sprmFnfZAi1q80N0XlqM=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr15236918iov.203.1532458110780;
 Tue, 24 Jul 2018 11:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
 <20180724004110.37d0e5dc@coco.lan> <CA+55aFyV=5QNJXn+t_ZDCigGi+HjM6N94DRb_E50_xUsk+VTFA@mail.gmail.com>
 <20180724153923.0f1b9f56@coco.lan>
In-Reply-To: <20180724153923.0f1b9f56@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 11:48:19 -0700
Message-ID: <CA+55aFwVVQcbpH=3Qf8hfGhx_Dz-Xp0N+gbAoaFhqLkVD-+WtA@mail.gmail.com>
Subject: Re: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h after
 generic includes
To:     mchehab+samsung@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:39 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Works for me. Do you intend to apply it directly?

Yes, I took it and it should be pushed out.

> Yeah, some time ago mailing lists got flooded with some janitorial's
> patchset adding includes (some claiming to be needed on some archs or
> under some random Kconfigs)... Compile-test ended by adding more such
> stuff (for a good reason, IMHO). I wonder if are there a better way to
> handle includes without slowing builds.

It's a nightmare to do by hand, with all the different architectures
having slightly different header file requirements.

The scheduler people did it last year (roughly Feb-2017 timeframe),
and it was painful and involved a lot of build testing. Basically some
<linux/sched.h> was split up into <linux/sched/*.h>

I wouldn't encourage people to do that again without some tooling to
actually look at "what symbols might get defined by header file
collection XYZ, what symbols might I need with any config option" kind
of logic.

But it would be lovely if somebody *could* do tooling like that.

Just having something you can run on C files that says "these headers
are completely unused under all possibly config options and
architectures" might be interesting.

Because right now, most people tend to just copy a big set of headers,
whether they need it or not. And they almost never shrink, but new
ones get added as people add uses.

            Linus
