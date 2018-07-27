Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFEF208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msxhGLr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFEF208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeG0SXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:23:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39436 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbeG0SXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:23:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so5708569wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmLE2WtXNG5TArMcSuwLpLYJ/d6nA3BzySSEwHDNa7s=;
        b=msxhGLr7+PJ95HoWHLHBwuGQLG9qkVpGqKwRHkFI6WKiy5/G4pCQ9UaA4Ge7U6tl49
         m3W70kL2kGrMO1ZGvSvhkOyQcLDWxxja8XmYo5zSRQdIpHtjiKGraE2WGlqmUwDxvqWT
         k4UkGMmkAv3/PGr964sDNu5ytvVzP5KSYvoLe0GT9BLr5tZZ8O/7MvWnfP5gALof9wzV
         p2CP9mh3cgVeVkFlkQ0wFzKOGbd1wmFH+S62jvFfFruKR/s/VUi38ir+vQZE7rYUjc6Q
         RUtiW6rKZoBgVmac/KnNEGHX0ZUSU+eQeQj7mPPTq/Cc0HLLtWkOMlibzAz93XAb/Sr6
         8vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmLE2WtXNG5TArMcSuwLpLYJ/d6nA3BzySSEwHDNa7s=;
        b=GknL/fuvjOVoDp/Zmfph1VQEBXka2x/X15E7EF8r+jPfTeEGJdx+ibEcC6Frf9X6Ec
         rQFoyNKLiIJDt5ETdnGhzn5fsuU1oFc7gu0rFkZJei0uEuP1usvgQM1UYW2VZk/x9cvv
         9MoGpPMrR/+qCjIRU5/N9G9oLQEH60+LkbEBBg3WgBlC3I6Z6rU4qzWYeO0KjTII0A1z
         AdCEU0myaIj6s6BAUuzYA1h+BTcjC1mJEs9nm20butst8LiREbBoq2oiWpAsFDuPRa+B
         C2nTRRQPIf7BHYA/AHToIpXZRh1AhpSec5AnsgNHslU+1FvqeJ/W6o53XPDjp2hKvWcR
         NQBA==
X-Gm-Message-State: AOUpUlHysiKnyOg9tLNFfdrzEH5/UK46Axoev0+vhCN5P8OG6s2Cfo0Y
        tdXuyxc0WrieUJFaKtivikrD0nwUd6c63sxNtn8RKQ==
X-Google-Smtp-Source: AAOMgpeJrpwftpmsxlasTJtoWofZt3WyF8CBO2CP25G6UJDuembY0TfIYftAR6joSYf6ArMKsIJQiB+sJcleLzTKL2w=
X-Received: by 2002:a5d:5043:: with SMTP id h3-v6mr5346867wrt.186.1532710849077;
 Fri, 27 Jul 2018 10:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180727030737.231268-1-toddpoynor@gmail.com> <20180727030737.231268-7-toddpoynor@gmail.com>
 <20180727150731.GA3713@kroah.com>
In-Reply-To: <20180727150731.GA3713@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Fri, 27 Jul 2018 10:00:37 -0700
Message-ID: <CAAW3YpY2rD6adA8zcHxR6Ty+nkK=Hyj-DkntkdsbFfWg71PzHQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] staging: gasket: sysfs: convert to standard logging
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:07 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 26, 2018 at 08:07:33PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Drop gasket logging calls in favor of standard logging.
> >
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  drivers/staging/gasket/gasket_sysfs.c | 73 +++++++++++++--------------
> >  1 file changed, 35 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
> > index 1c5f7502e0d5e..418b81797e638 100644
> > --- a/drivers/staging/gasket/gasket_sysfs.c
> > +++ b/drivers/staging/gasket/gasket_sysfs.c
> > @@ -3,7 +3,9 @@
> >  #include "gasket_sysfs.h"
> >
> >  #include "gasket_core.h"
> > -#include "gasket_logging.h"
> > +
> > +#include <linux/device.h>
> > +#include <linux/printk.h>
> >
> >  /*
> >   * Pair of kernel device and user-specified pointer. Used in lookups in sysfs
> > @@ -66,7 +68,7 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
> >       int i;
> >
> >       if (!device) {
> > -             gasket_nodev_error("Received NULL device!");
> > +             pr_debug("%s: Received NULL device\n", __func__);
>
> I know you are just trying to clean up the logging mess, but this type
> of check isn't even needed, as it's impossible.

Ah, yeah, I noticed it when I was converting, I'll put this on my list
to clean up in next round, thanks.

>
> thanks,
>
> greg k-h
