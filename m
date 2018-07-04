Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E72C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11982251F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK0K4vUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11982251F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeGDVaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:30:09 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43941 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:30:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id d74-v6so3752845vke.10;
        Wed, 04 Jul 2018 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tD8pCMulgVFU2JEnnCXM77jC8s6KCmufex5yKeiXbLQ=;
        b=XK0K4vUqrTOLS9uDJy/WJmKGHl+E+EP/F2DKES75TS5cwIhZeuc/7ejGRBF+RQ9407
         tVsbFtscEVcPQwDWNY3Ph4avZegCn0PQDVLP3L8rKMPNwjbs03n/inXKTouwHmgM1nX1
         VitXLIISut+DOlEJD7ipad2qnJTEvNFyUcSgI4S5Dr/55nFGPv6MSTJZEAsaFhnr4U9T
         4Xfoe9iLk9VjyaVMHbmGTvxJf9Q2lRI+OmkwMDTJYwYlUeu/RJ7tvUTpPm6YasrhNLrW
         StvAlVQAoKRm61DAHOTKWyGxmUDQzrVY8UXT1rii+5qKXGB6H26nXNePYHVaaWyJzenH
         Pnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tD8pCMulgVFU2JEnnCXM77jC8s6KCmufex5yKeiXbLQ=;
        b=RlL7QX8U4+Edqx8bRRQB+ivOIbi+AAubjFphQowunPZrdxbBdUBn0G1zqxl5LiwhQ9
         Ll6kL+WD8BZ2y0RdAn9XI4EHIasODnD5insdTsA6fFZOmCZwfdVsM+rZgFmH2Txzp1gB
         q8FRj28lv9GSLaT25Qr9Ol7pHWwSZunEwH3IFc8Rc03T0toBAmGNFcX5YRP/h3zo6DNK
         5PWAvAngb1T09VU7zH2R4LjoD7DqUuk3rTwgA3iga+cdgHqnLbmmlZHAdAkMgF17yNaQ
         wlorpOTUL+2PiCYM1l52P6hVCyXcRJ87CfRhhfomcsfF02oxPsuVr+YJU6EkpjzX0nlv
         F4FQ==
X-Gm-Message-State: APt69E2wBrToBM3ZvHz6veo1SDIbHwiqtv70+ohkYsUrOhM6cGQKs/+f
        Ecw6WEc1CXlclrGSWQp/jk2AqqLyK4K8SUilhoo=
X-Google-Smtp-Source: AAOMgpdorGIu/CWcuerPe6Ghi07lGwtl/APkE8ek2Y0JO+nEx6MA0jdDvVN/8Zvo00R7oDmylLLKZXf3jCSaruCb9J0=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr1953966vkg.176.1530739806556;
 Wed, 04 Jul 2018 14:30:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 14:30:06 -0700 (PDT)
In-Reply-To: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
References: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Jul 2018 00:30:06 +0300
Message-ID: <CAHp75Vd9RSxVsYrbiAFJKLPL4wNzAtS9qAPjCNJJ4E=QbeTP8A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] bitmap: Introduce alloc/free helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 11:17 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> A lot of code is using allocation of bitmaps using BITS_PER_LONG() macro and
> sizeof(unsigned long) operator. The readability suffers because of this.
>
> The series introduces three helpers, i.e. bitmap_alloc(), bitmap_zalloc() and
> bitmap_free(), to make it more cleaner.
>

Dmitry, it seems we are all set now and if you have no objections
against this version, it would be nice to see it in your tree followed
by upstream.

> Patches 1 and 2 are preparatory to avoid namespace collisions between
> bitmap API and DM / MD bitmap. No functional changes intended.
>
> Patch 3 introduces new helpers.
>
> Patches 4 and 5 is just an example how to use new helpers. Locally I have
> like dozen of them against different subsystems and drivers.
>
> Taking above into consideration it might make sense to have
> an immutable branch for this cycle.
>
> Ideally it would go through Input subsystem, thus, needs an Ack
> from MD / DM maintainer(s).
>
> Since v3:
> - split DM part and do rename accordingly (Mike)
> - explain better in the commit message why we can't make helpers as
>   inliners (Dmitry, Andrew)
> - drop applied orphaned patch
>
> Since v2:
> - fix compilation issue in MD bitmap code
> - elaborate changes in commit message of patch 5
>
> Since v1:
> - added namespace fix patch against MD bitmap API
> - moved functions to lib/bitmap.c to avoid circular dependencies
> - appended Dmitry's tags
>
> Andy Shevchenko (5):
>   dm: Avoid namespace collision with bitmap API
>   md: Avoid namespace collision with bitmap API
>   bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
>   Input: gpio-keys - Switch to bitmap_zalloc()
>   Input: evdev - Switch to bitmap API
>
>  drivers/input/evdev.c                         |  16 +-
>  drivers/input/keyboard/gpio_keys.c            |   8 +-
>  drivers/md/dm-raid.c                          |   6 +-
>  drivers/md/md-bitmap.c                        | 305 +++++++++---------
>  drivers/md/md-bitmap.h                        |  60 ++--
>  drivers/md/md-cluster.c                       |  18 +-
>  drivers/md/md.c                               |  44 +--
>  .../md/persistent-data/dm-space-map-common.c  |  20 +-
>  drivers/md/raid1.c                            |  35 +-
>  drivers/md/raid10.c                           |  52 ++-
>  drivers/md/raid5-cache.c                      |   8 +-
>  drivers/md/raid5.c                            |  44 +--
>  include/linux/bitmap.h                        |   8 +
>  lib/bitmap.c                                  |  19 ++
>  14 files changed, 326 insertions(+), 317 deletions(-)
>
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
