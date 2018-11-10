Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5030C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F98E2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="qzTxhZnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F98E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeKJKK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:10:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54607 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:10:29 -0500
Received: by mail-it1-f196.google.com with SMTP id d6so5488408itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ns5aFoZvRPtJDKv1Do449qIHO53eyfwRwHYGxfzMRrc=;
        b=qzTxhZnhWLh5zqDVXrJSRsi8fRM9qPWdzRhFPn5JTECm2Y8RM+fz/LS/EUKbSUB3Aq
         mPyLuWK7UhW/KUE2PsrEpyo0KtxscgVKhV89BI+7KksXtAISI2ReIl+N4/3+wo4QX8XU
         /OU1M/d+A9QLZCYW0WZBKRxyu6+QFCGKV+PhZ0xZ409EGFOpG0oBlEYfu668z0AiVOAi
         jrYBfqq2tt/ajK0DQNTnCLhANqrkvhmvRN2PPaavtN6SEW2pGWPADzy+LzJlkWSsXsB0
         0GyCSFkPIKi0W9vdk17MXeOSNyfoIU8+XqeBEUswEd4UFnwXTkY2mx0I5gtBkqAz213W
         xbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns5aFoZvRPtJDKv1Do449qIHO53eyfwRwHYGxfzMRrc=;
        b=DP5Ui5CVcMHcnjmhskcul1M6TNcRlKV9twgjNLO7SafwM6MRNXvaJE/MVgiazwMyoU
         79FI29t7cu/yG95GfeZayuylYPbJiGhMiZ8LMz1xjVWh7ERMRRzL13oLRWY8XmyYV3ih
         3Eg7GvXeGQzyailePfiF5yqH/adXflnfg48348DXhT5u5c6Fl9y9wMxfi9iGN/C30RKl
         X7hP8JZCv+JRH5Es5Sz8QAJSmIbjNxtv5sjU0bRgh/TO80yUhpcSQMFOSVj3HRUGDyMc
         sXahKaisv5uZq2zEDCFYQS876AFCIl1i8YDxDU7nIp/Oz1rdWHd8VJnYZcwrwV5sQqrP
         ArMg==
X-Gm-Message-State: AGRZ1gLg/7a+Hpn4f6/0gYF6ZDMxN1cN1P+JLmXgtVmm+C8hJBo/sewg
        xxy6WGHdV706Sy3bP6I1pPvEQAc+bNtBqPDXGHmyGw==
X-Google-Smtp-Source: AJdET5ePWBrn4WbBN1i+6b0qhbbyPMv1qV+tHNIXS8jLV29jS9hgoxd2ZQiJMy/blj8RS1mXGMXZD40T6pgmdiI5f4s=
X-Received: by 2002:a24:338e:: with SMTP id k136-v6mr3833551itk.86.1541809647507;
 Fri, 09 Nov 2018 16:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br> <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
 <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com> <20181110002018.GA3938@kroah.com>
In-Reply-To: <20181110002018.GA3938@kroah.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 9 Nov 2018 22:27:15 -0200
Message-ID: <CAHd-oW4uWFco9qcVwMphetXE9LK4YJQmDAbBUPBEBCT3UHZSkA@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     festevam@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Victor Colombo <victorcolombo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:20 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 09, 2018 at 09:19:52PM -0200, Matheus Tavares Bernardino wrote:
> > On Fri, Nov 9, 2018 at 8:13 PM Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > Hi Matheus,
> > >
> >
> > Hi, Fabio
> >
> > > On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
> > > <matheus.bernardino@usp.br> wrote:
> > > >
> > > > This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> > > > which solves the checkpatch.pl warning:
> > > > "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> > > >
> > > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > > ---
> > > >  drivers/staging/iio/resolver/ad2s90.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > > > index 949ff55ac6b0..f439da721df8 100644
> > > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > > @@ -1,3 +1,4 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > This should be:
> > > // SPDX-License-Identifier: GPL-2.0
> >
> > Hm, but it seems that the identifier "GPL-2.0" is deprecated, look:
> > https://spdx.org/licenses/GPL-2.0.html. It has been updated to
> > "GPL-2.0-only" in license list v3
> > (https://spdx.org/licenses/GPL-2.0-only.html). Is there some other
> > reason to use the deprecated "GPL-2.0" that I'm not aware of?
>
> Yes, please read the in-kernel documentation for all of this at:
>         Documentation/process/license-rules.rst
>
> Long story short, we started the adding of these tags to the kernel
> before the crazyness of the "-only" markings for GPL in spdx.  Let's
> keep it this way for now, if we ever get the whole kernel finished, then
> we can revisit the markings and maybe do a wholesale conversion, if it's
> really needed.
>

Got it, thanks for the explanation! I'll correct this in v2.

Thanks,
Matheus

> thanks,
>
> greg k-h
