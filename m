Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8184720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXNLGcwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8184720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLEGkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:40:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45273 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:40:02 -0500
Received: by mail-io1-f65.google.com with SMTP id o5so9808851iop.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSTjBv3aqT/opN2GvPNZpewuqlgSRwtfebaiQJlz5Lk=;
        b=YXNLGcwdw6C07viMVsTeRAQdZygN/3LGg+vflrmrgXZsNc8LzRbITE5z/xX4ShfUDj
         LsLRFQS51EXfX/Ru3E/OVAfzljYpuQoZKf5wqgLS4AAxODLhstAMye8V9sFCW6WuSWY4
         m/TFfSS06r4bqO5lFjXanNUCLlCCgUtHBUlU6KdSOGMe1BsqapJ6q1U6D1B790aMTwCU
         5boZt1C3kierNq78r5kBiONzv+LjoezDFLh7qiGLVg7cyK1/CIvQURW1BlUOJNeXzIAV
         EPL4tI+KfY3NjqfSnNTfL+fC1uGrSdX/crSyRe3Xz/yq1Gic4uZRYQ0UINW8ZdxZPC29
         ouSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSTjBv3aqT/opN2GvPNZpewuqlgSRwtfebaiQJlz5Lk=;
        b=UmAk1Zj7BhSTKEX0aTNhb/mUVKlW3kJFrFnPbcRbdjyezsrfC4KHgZW1t0+nPOvYGI
         tsx0bq3bp8hyB6oUBv71/kWCkmG/AwZpA41ru0vUQo0JG1SF1cOqDlys6QdWW2mYecXx
         rfGw+YuQzClYvxUBdB69K9LqUj9nOrV4VMnTJqloEInYgujHo75RRl2nrzYrkQCiOXGG
         P3uSKrbv1+9xMgT0QLl1540JaU2UaW//pmAmCOmqmbYFSXD9tFXWTZwyYVITil5EERPO
         T0NdRBPDu148ZaygOnbLQxg41SJ/DoFR2gohrilYBGJdkmSxIkxV59v30GogumT/BQx9
         v/Rw==
X-Gm-Message-State: AA+aEWbflUZ3+99LbrPwCApkrZdtl+PkeO7l8pekiNeme8pRIRfkPLjR
        9P3p7P3VQJNd3uoFZkvTSs8foaIlG1JXSEC6lEs=
X-Google-Smtp-Source: AFSGD/Xvr6lLuU3TwJC9hV1P/eMxMEkIbsJolMtyzXgbIzim+6MG8LAOHmimzXSJKJnEJtLrf5YPiIW0HukDaEqy6nQ=
X-Received: by 2002:a6b:f104:: with SMTP id e4mr15268038iog.165.1543992000904;
 Tue, 04 Dec 2018 22:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20181116101353.GA2752@hp-pavilion-15-notebook-pc-brajeswar> <CAFqtX7k8HhqwubN7MORbWd+cUo_+btN8X2ZJfefWXr1uHrKRdQ@mail.gmail.com>
In-Reply-To: <CAFqtX7k8HhqwubN7MORbWd+cUo_+btN8X2ZJfefWXr1uHrKRdQ@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 5 Dec 2018 12:09:48 +0530
Message-ID: <CAFqtX7mNVNoYo4oyMtV0mHK30HfaS9b4-B2ga_7G5kH=i3f0mg@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/qcom-ebi2.c: Remove duplicate header
To:     akpm@linux-foundation.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 1:52 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 3:43 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove linux/io.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/bus/qcom-ebi2.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
> > index a6444244c411..56b01e4344d3 100644
> > --- a/drivers/bus/qcom-ebi2.c
> > +++ b/drivers/bus/qcom-ebi2.c
> > @@ -21,7 +21,6 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/init.h>
> > -#include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/bitops.h>
> > --
> > 2.17.1
> >
