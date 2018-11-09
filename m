Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAF620827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="vc5Y8RB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAF620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeKJJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:02:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50382 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeKJJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:02:50 -0500
Received: by mail-it1-f194.google.com with SMTP id k206-v6so5373219ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6+XdCXYVgnzG4w07sx/X4b8IQVrvvuH6AvsJEt9GIc=;
        b=vc5Y8RB+80L9LmMzm3c3I8kfwXKpkZI8cNTsy2O0phXOqRyu3YGKp6wHrKckwCKGd8
         t764/6vdblBlJTdCIiCCOYKK81jb+x9s7+k/Ov3vsyyWUJp43CrCOZY3HWtTg7XH7WkM
         z2+F2JMbHzaqxB2cE9nq6sPOrUr23980mNAOKTC96vq4O7LY8s3EF7nn0STZXcDnvtJM
         qPGShMNx8PtJKv9wUFD+Zzn+99WtxOGpiPtnQ7ED5+gVwTIFn3SF0hwpRGEhQs+o2BKF
         PdON34iFW8jh5rc4Vq5QyLtuTJYzWpo4x6op9JawC3E9Cur3+zjfnZRdacVjc2Iu3Io2
         x/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6+XdCXYVgnzG4w07sx/X4b8IQVrvvuH6AvsJEt9GIc=;
        b=So8tDOFCDFLcgQqf/v2+BPUvRU9ZIbNPfFjoLPOcWSF4IsPSL9ci5DxgHDW3NwHC2u
         P9mvqZPiI0U4EhWUwRX72+hgxHTSH8v+PJIudXTMZ54wb403U/NzOjTNOeMZKTpuOWpM
         tXjXy566cgxMOv1Xqrj7I/nSiuPdvWhtBobcQG1uZV9qaPfh619SUzDgMP94FuxfbWCI
         j9ElDNiCoNDwVdCygsQkU0pg62l2VIuhmfbI/YmAStNoTUssFHFRVqjMKVqPjINMlif1
         eBBbfpyydvv5DfPIGalxTTW3V3J6/V3if49AWh/OW0SLg0Ks3KQKhXLb6LhKGB+y3QYP
         lmAw==
X-Gm-Message-State: AGRZ1gLGvTwkeCj8J+IbRI1viN457466ZMyQbqSgiQyiST+spZLaQmSd
        Zmpr8bbnBz/tPZE7GLR9O77waybnBibCmW7vCF6LPQ==
X-Google-Smtp-Source: AJdET5eB+eRe6f/t2GQH+UpIu4WJjbYJS/nI/rqTNgVGuUer9mU+7AdS0L4bAxui8WEMx6ltfQyhA1WI5Vk7N0H1Xrk=
X-Received: by 2002:a24:338e:: with SMTP id k136-v6mr3680787itk.86.1541805603941;
 Fri, 09 Nov 2018 15:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br> <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
In-Reply-To: <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 9 Nov 2018 21:19:52 -0200
Message-ID: <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To:     festevam@gmail.com
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Victor Colombo <victorcolombo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:13 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Matheus,
>

Hi, Fabio

> On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> > which solves the checkpatch.pl warning:
> > "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/staging/iio/resolver/ad2s90.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > index 949ff55ac6b0..f439da721df8 100644
> > --- a/drivers/staging/iio/resolver/ad2s90.c
> > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> This should be:
> // SPDX-License-Identifier: GPL-2.0

Hm, but it seems that the identifier "GPL-2.0" is deprecated, look:
https://spdx.org/licenses/GPL-2.0.html. It has been updated to
"GPL-2.0-only" in license list v3
(https://spdx.org/licenses/GPL-2.0-only.html). Is there some other
reason to use the deprecated "GPL-2.0" that I'm not aware of?

Thanks,
Matheus
