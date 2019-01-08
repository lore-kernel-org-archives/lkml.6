Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B0A20661
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FyToSk8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfAHXyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:54:02 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36911 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:54:02 -0500
Received: by mail-oi1-f180.google.com with SMTP id y23so4880335oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQ8wV+4IDEJTDJS1wbkPLavzlqW9+FSdjt05sq6wnGU=;
        b=FyToSk8IUSU4wKUSoSn2OnvML9ZdU7h2zgBQyIBtdcMNJ+7wm++n1H6daLwwa59Nvw
         pzxHmjjZE8F+fbF3guHDSeBG4Bhks+Y/BchB3aPvW4DztMPyQxJArJidhbsBOalBM6ut
         TQ0O7caDRt7FPTK5KQ4ujqG9JljpJ0pUPYfb/EfoM1rgzt2zZvu+MqLi02cVBqfnRyga
         NscF0AsdJOahCE6IbB/uJZZd8r93O2c0v8953C762bIMeNJ3jRyrA7uN5KT44SYcivM5
         8yDOF7xZJZl82nhkWIBKN6JQkV18oZAH9E6MZXJH5hQouS8/HCWTGf3p3yczrG4grA/R
         SjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQ8wV+4IDEJTDJS1wbkPLavzlqW9+FSdjt05sq6wnGU=;
        b=pX0e3lWeXo+1eww8Gffp1JYu1KbOgWOL1HWaIwGYdLguWD4g48jKL9au8BoTx8xLKA
         dfOFCHX5PNWbHNB21It4irt4M5MbRT76hvNKpkei6FRZHYWOQQOyuepFDP5/ZGlNUeYz
         kDZJLuvcOf30V2rbiaJCp2BsKfL48DLKhjR+EaXD9HQLor8V9ksJCJzLa/8e+BmWSDqm
         fCCgKmPy1Iakq6aHRKXVklsZ5cjU5if5BON8ZqRRxNUzo3GK+yDC1iycr/4t3lmC9DuD
         KviD9aHxqU2IHMN+3tk9xTumjVWPu3z4K3r8Yvmj60NU+7HokZxFiL/L2X82NBKbYzKQ
         /h0w==
X-Gm-Message-State: AJcUukev0cXo05lRYzZ56x73wb3HRLJCBnxE96mSsq+wnllicPFHw2l1
        0PPpm6pmnDAbaGWUc1bdCc8MF5CmDBj5umnCqOi/4w==
X-Google-Smtp-Source: ALg8bN4PRp+sIVQqdRtrGHX/2zEYcqfWtlWMT7UuRcxm2AU/ekdclqJqEGSN+jjN5J/wrrr0SYR/aQPPaTc/R65VoC8=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr2350231oit.235.1546991641417;
 Tue, 08 Jan 2019 15:54:01 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com> <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
In-Reply-To: <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 15:53:50 -0800
Message-ID: <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > Ah, thanks for the report! The key difference is that you don't define
> > a "label area", so the driver bails out early and never initializes
> > the security state.
> >
> > This should fix it up.
> >
> > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > index 4890310df874..636cdb06ee17 100644
> > --- a/drivers/nvdimm/dimm_devs.c
> > +++ b/drivers/nvdimm/dimm_devs.c
> > @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> > *kobj, struct attribute *a, int n)
> >
> >         if (a != &dev_attr_security.attr)
> >                 return a->mode;
> > -       if (nvdimm->sec.state < 0)
> > +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
> >                 return 0;
> >         /* Are there any state mutation ops? */
> >         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
>
> Okay, cool. I wasn't sure if that test needed a deeper check. :)
>
> Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
> support to Intel nvdimm")
> Tested-by: Kees Cook <keescook@chromium.org>
>

Actually, looking closer this should have been avoided by the fact
that __nvdimm_create() initializes the security state early and that
nvdimm->sec.state should have saved us.

I'll dig a bit deeper with your qemu config.
