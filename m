Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99112190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gydpjnZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfBLTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:22:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42544 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfBLTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:22:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so9411360qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6NbVwVV0hkwRdFYav8uoF6qnn2Ao3HzyjUBGy8N3DI=;
        b=gydpjnZI5XJ2eZxLejlvYNHnLrZ3ztVp13CdRmWC/TQtEOTVi5kHRc+7LZ3qTmCarL
         WwglT9FJr0LsHW7z3kWfvc+e/6wKkcoytuBZhB5k4jBvt7aOw8y1H9aFDPHnA+G1w9KT
         R6dFboVg3EF60aROtZ/tkw9HwKe9P5vimusoJZyVvIMwk+28W7x9/phH+nSnF2IubOfB
         /txkfRYoHvvDxXsFIoto48//XmNFSR0deoxGYjt9LQiGQ0IeixBSrCRcVFPk33mPLsHv
         aKyWsCvJaVnsQ3pUMNuSY9+LDYIUvKBWgjS07T8bENY/VW7OQQ7XyNuc2rWZk0rrSKFi
         mMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6NbVwVV0hkwRdFYav8uoF6qnn2Ao3HzyjUBGy8N3DI=;
        b=MeyO/RamQ2Mo3HFoMujgCovqVJddjyc2nhOhItJ3LHPqCG9h4kNXlqd1/OZX1UOW0x
         5x4CvXMm2mdSez6UNsTB++38dSs9+XUtiEPoCseIpNi7SM2WMKD79wciAO55zrgHePsI
         PydjlD3j7dGB5To/YWMT5PBtIT1T/ohQ021pF0HWKOpmuvU7GT9a8jY4Co4fin7RPdIr
         A9Uc9W9BcnGJmbnew3muuzpGuO0PQzrSOX+mhDQ1OW0E8XRu4Jwwz8VuOQ8gnaT2dw7B
         Kr268nm7iFTiufAQPjItlAj1tfa4m5MJBJvluCnXipYRbQQHfCnPQC9ZhJzYTBcQpoN4
         RMqw==
X-Gm-Message-State: AHQUAuYUXjtTCnk5iNDEshR0NvZXey8S14odq0ykc0Q4XkXdLdqn0wjx
        uJwChH6nCWk4J3gNFd4/jovWNQ7iTavq5+z0r1y5+RolvAg=
X-Google-Smtp-Source: AHgI3IZZKmvKC7mMsGfS4OziFRO6M5yCDzxMMV+gug2TM2wi/BGyqEtA0DTFcIsc+42Cygd/tEuIiDdEfynH4eY4Pg0=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr3808367qki.197.1549999361819;
 Tue, 12 Feb 2019 11:22:41 -0800 (PST)
MIME-Version: 1.0
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212183408.GA14892@kroah.com> <CAH2Cfb_ZQiHiL2pGCB4j2a3U60=78w6a9if_Z+pgk2qEi+8pZQ@mail.gmail.com>
 <20190212191535.GA22741@kroah.com>
In-Reply-To: <20190212191535.GA22741@kroah.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 03:22:30 +0800
Message-ID: <CAH2Cfb-4yJ0CO-Q3SWqpeiiLBFO+V8z7d-vffuXYSU6N=LLfjw@mail.gmail.com>
Subject: Re: [PATCH] lib/string: add memrchr function
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 13, 2019 at 03:09:19AM +0800, xiang xiao wrote:
> > On Wed, Feb 13, 2019 at 2:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Feb 13, 2019 at 02:06:49AM +0800, Xiang Xiao wrote:
> > > > Here is the detailed description for memrchr:
> > > > https://linux.die.net/man/3/memrchr
> > >
> > > Please put it in the changelog, as web pages move and go away :(
> >
> > Sure.
> >
> > >
> > > >
> > > > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > > > ---
> > > >  include/linux/string.h |  1 +
> > > >  lib/string.c           | 21 +++++++++++++++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > > index 7927b87..f380f4b 100644
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> > > >       memcpy(dst, src, cnt);
> > > >  }
> > > >  #endif
> > > > +void *memrchr(const void *s, int c, size_t n);
> > >
> > > Who is going to use this?
> >
> > This patch will use memrchr:
> > https://github.com/thesofproject/linux/pull/177/commits/a0b7009fede5552dc98733f2996a8140bff62455
> > I am preparing to upstream it.
>
> Great, make it part of the patch series for your driver, no need to
> submit it separately.
>

Ok, I will merge the depend patch into one series.

> thanks,
>
> greg k-h
