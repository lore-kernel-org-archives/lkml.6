Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B22146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="xxFc2Rdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeKUWJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:09:35 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37910 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:09:35 -0500
Received: by mail-ua1-f68.google.com with SMTP id p9so1790385uaa.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWLTdLnjGxFNIGXafVQP36uofwcE+NOk64U/yUqhW+c=;
        b=xxFc2RdcVcm+lLxm0vbzvk6kzc1oeWuigVB7YfrUlhdA/WXZuEcbLEii1HUA+3C7Y7
         JununLQ/wW7Wh3RdII0QgvFyI9Fvqdh7dLAixMYNGw3m7zYQAvcdJD/yRxNv3lWqtyht
         qLoIQN87y1x6yypRffvpl0z9V19PiXxDCpswCG+PYymDZoxfmhdcC++IvDEZ+ndECYcl
         4Rq5eA2gW0cxluUoB0YRRW68+w2Zs5U1HyH3nhJVlnoA6g63UIxDA9TKD4KLpI3wE2hP
         zScM2Tw+ifFyPmED0AytR23vzLIFXgOGelmxdC8TjkeJqc0fJ+CJaVzPl5oaNRCcIYxP
         aWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWLTdLnjGxFNIGXafVQP36uofwcE+NOk64U/yUqhW+c=;
        b=ReYFvyrksgzeX9+epZXNsJ8aI0obz6FJciNBqweB0IRwU+hIT6alqV8Ig7Im/ND1uW
         cuDeABVVtoE0pGNWtKtkke8Ud6WcbP2/Hi1p/7toyZHUCwrfDRHYwx4WDNt5HA9KtYel
         fjyP5cczaJmKu2MJPmdQHY9U0H/a7BeoGaBhxg2gUQ2P+2iJBeyOKfQ/76dNaQ1bGN7k
         h8c2/3HJ47AM7FCqlcFtK+zrZrP5POATc+CQRnBLVEROXGGTkk0VpN8PhnPlZ30DT7/x
         VtzmI2f3yNg87x/ApThrliHOBIR8nRJ9KN4Hkx5cRp/X7exQV93xa6+ccfPXGxZRgrF8
         mo/g==
X-Gm-Message-State: AA+aEWbjXL3mcbgwHKjCHcdIwYG/JsuBfYvzrZPJGgCih1HRYXjbc7Li
        uFdWjmidQPz50xgcXSv6Wm3O7enpjvZBWkW4GTZULg==
X-Google-Smtp-Source: AFSGD/VDqvB60F4aJ2IM9jRODtpOSO4lCh6m8ozN5ES2ACZyi/uGxT+EE43IK0EZ8VREBWfHxUiC9+5v5YCsM2WqMDk=
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr2523985uad.29.1542800130866;
 Wed, 21 Nov 2018 03:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com> <154279503602.15074.8041259573781223214@jlahtine-desk.ger.corp.intel.com>
In-Reply-To: <154279503602.15074.8041259573781223214@jlahtine-desk.ger.corp.intel.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Wed, 21 Nov 2018 12:35:19 +0100
Message-ID: <CANr-nt0jNB1WMYRepHdC_jqmXTX5pKSswvOtCKx73dj=7azRSA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: avoid rebuilding i915_gpu_error.o on version
 string updates
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:10 AM Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:
>
> Quoting Hans Holmberg (2018-11-21 11:54:23)
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > There is no need to rebuild i915_gpu_error.o when the version string
> > changes as the version is available in init_utsname()->release.
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>
> Seems reasonable to me.
>
> Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>
> Out of curiosity, are you by any chance hashing the i915_gpu_error.o
> file (or the contents elsewhere) for some purpose?

Oh no, I was just moderately annoyed by the file being rebuilt every
time the version was updated(I use my current branch name as
LOCALVERSION when building).

Thanks,
Hans
>
> Regards, Joonas
>
> > ---
> >  drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> > index 8762d17b6659..958e1484a3dd 100644
> > --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> > +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> > @@ -27,7 +27,7 @@
> >   *
> >   */
> >
> > -#include <generated/utsrelease.h>
> > +#include <linux/utsname.h>
> >  #include <linux/stop_machine.h>
> >  #include <linux/zlib.h>
> >  #include <drm/drm_print.h>
> > @@ -650,7 +650,7 @@ int i915_error_state_to_str(struct drm_i915_error_state_buf *m,
> >
> >         if (*error->error_msg)
> >                 err_printf(m, "%s\n", error->error_msg);
> > -       err_printf(m, "Kernel: " UTS_RELEASE "\n");
> > +       err_printf(m, "Kernel: %s\n", init_utsname()->release);
> >         ts = ktime_to_timespec64(error->time);
> >         err_printf(m, "Time: %lld s %ld us\n",
> >                    (s64)ts.tv_sec, ts.tv_nsec / NSEC_PER_USEC);
> > --
> > 2.17.1
> >
