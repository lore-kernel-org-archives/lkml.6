Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9AF21905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkJ9PYlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfBLTJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:09:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43259 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLTJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:09:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so4256210qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjCwUU73i8WJg5jTg5VIm8CkVcjSwaZc7tuN1+iFCjk=;
        b=WkJ9PYlbpAxyePQd0RQ4rOOfhTshSxg97nF0BZTXL8H9sztSrTuTNKk1N3V1AcFlZo
         O8V9Cz+PoAnXA1fL/fltAb0hgpA561HmWxUUR2IDFlG+s6/e7BbCwg0bMXQ302i33Dk1
         mzxq3XfWdSN0xO6Li+kykAsv9gvFssnTdR+57u1OkDt9VY3OtUFXO845H1M92HJ8xjC/
         /s21aezDABnDA7xTu/z7D9JYdP5ajsJ9GcuX3o5f8RmkjijYVAEwYlxT9bVz5yfpk6da
         f7qOdojKsWbTMgtHnPqJiZIAeP2aBVYTuqmrJ/x0OVdbZXbIplEnU2coFyIar70P8d93
         ViKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjCwUU73i8WJg5jTg5VIm8CkVcjSwaZc7tuN1+iFCjk=;
        b=hTlECjdeSA+Rikh14tOW50X4derNOdzBZGIMs3L3dM32trKlptpbO6jJVTwpwKmLtQ
         Lb6SKvSFM2uulMAZiAsbHa0FLlSqC1Fn21gr+INp1mIeH1qL/mgJIvhBcIYe1BQlUBOU
         0gMfOkkZZgAQMqWsYyJx+0mHk+T2EjnTXel1Qi2iNSMa1l28UIuCehIV7WdxJ0DA9S2t
         0IxjdEVCsEoNyWm+Blp7h4MU4TutS3TqhO6HiE8wb7hRnXPRlwGiignKuir3Sr7NgVlj
         FY2bbVVo/U358Jfc4AV1zQVSr274ejadtgd72lMOkGm4o7/I2r5qzAIzzAiatWcSZPsh
         waOw==
X-Gm-Message-State: AHQUAuaCXUK4IA3hLON0hHbzmQS8ybXvVp9G3xNBMGL0DYBITYKeTV3G
        U+kVR3p2/vnUt7w+OlZtMMBWznZx/Dv2kd1A5f4=
X-Google-Smtp-Source: AHgI3IYlgtyuszP0U6aa95g9m89aydbwmcwyQ0qQ4Jx5dvqeBEz6D0jvRAfURpv+ta0QpXSTCTkFTzg/jqevrfKGcfY=
X-Received: by 2002:a0c:9877:: with SMTP id e52mr3805713qvd.151.1549998570218;
 Tue, 12 Feb 2019 11:09:30 -0800 (PST)
MIME-Version: 1.0
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com> <20190212183408.GA14892@kroah.com>
In-Reply-To: <20190212183408.GA14892@kroah.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 03:09:19 +0800
Message-ID: <CAH2Cfb_ZQiHiL2pGCB4j2a3U60=78w6a9if_Z+pgk2qEi+8pZQ@mail.gmail.com>
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

On Wed, Feb 13, 2019 at 2:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 13, 2019 at 02:06:49AM +0800, Xiang Xiao wrote:
> > Here is the detailed description for memrchr:
> > https://linux.die.net/man/3/memrchr
>
> Please put it in the changelog, as web pages move and go away :(

Sure.

>
> >
> > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > ---
> >  include/linux/string.h |  1 +
> >  lib/string.c           | 21 +++++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 7927b87..f380f4b 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> >       memcpy(dst, src, cnt);
> >  }
> >  #endif
> > +void *memrchr(const void *s, int c, size_t n);
>
> Who is going to use this?

This patch will use memrchr:
https://github.com/thesofproject/linux/pull/177/commits/a0b7009fede5552dc98733f2996a8140bff62455
I am preparing to upstream it.

>
> thanks,
>
> greg k-h
