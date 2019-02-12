Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6EF222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO7YHLoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfBLTTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:19:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34657 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfBLTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:19:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id w4so4364461qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnPUxP4wkNN6G5QRmW//oRBq3wLHmYQB3mlfwK4ryDM=;
        b=HO7YHLoK+xVG1emVvfpXQ9aAJa2GA5YSGTDKXo4qxPF6tK2AJP58pMI2B357U18Kxv
         yVRPTkQCjFUYaYUGIVNAJOQTt9UqbORXexG35/kgoqrCIQaVF0N8q5IWrFnlQfQCGPIc
         Z040i6f45h12VQmeNZrD3YwrrViKRdnlOGZxT/6h/6Pui4Vza5ZG1ZCWDUvkSN7TI5YJ
         poFX9GQRgmkJgwCCLN/VLh2OalwHoN74bMXMKVyAS1BH6/fguMi/tIkyvRQhadig2kPH
         UfI2WRNNcnluLsm5WXAWsolksbXcbvLCPaVQu2RqnB3CNBJ8s2YqzS3CAk0cgDL8+L4V
         rOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnPUxP4wkNN6G5QRmW//oRBq3wLHmYQB3mlfwK4ryDM=;
        b=L07jZCF7a4m1PMAoARNqxGAi5SVOU6lYXZN8VQPDg5K0UMqyW2ZCBgORa2HQGAQawZ
         vixau/4RD1D5+TMifn2BgTadAsfcO4gyras4hjb4LRUWNv+fFHBliuJ4C2Jfm6Ef5W9G
         ycfWt4hPyVFAC+RbFHIFCB/2vEXoli1kY8SCWqGkzA2wKRDmAGMVqzK9AFs1ZR7QVrgd
         vMXnQAdbfTXu3OmdMqwtUqqQlya1MKzENjkCrqP/vSIfg4PCzV1uSSoB4YfveRyz37np
         17IgOrMhoJHToxtAmHPtYc7bu5EkiGSuuMq2Dgtc32/UZG/u5ZSpwXgdO3z4Deol2qWS
         Fk5A==
X-Gm-Message-State: AHQUAuaDz41XN6bg3olmrkVmfKrKLDZ/YFYTKtNRkOv0VfZMK5XhLqm2
        0r92i72WdM7oC5U/FX6SRxjYRkKu1/+RCHe5LPg=
X-Google-Smtp-Source: AHgI3IY5ntkFhvB8nG/FJ9yzTii7Ic+kvFy6y42se9wV5WNglxBSrAulH3AVhijAzZtzz9YJyjUaJrLAUwh+H05Lz0A=
X-Received: by 2002:a0c:d124:: with SMTP id a33mr3912345qvh.19.1549999191469;
 Tue, 12 Feb 2019 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
 <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com> <20190212191219.GB22246@kroah.com>
In-Reply-To: <20190212191219.GB22246@kroah.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 03:19:40 +0800
Message-ID: <CAH2Cfb-5SkZDcze2Ygv5pCa0g29UbpyczswZJxNsEwYQP0yi2A@mail.gmail.com>
Subject: Re: [v2] lib/string: add memrchr function
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 13, 2019 at 02:54:43AM +0800, Xiang Xiao wrote:
> > Here is the detailed description for memrchr:
> >
> > void *memrchr(const void *s, int c, size_t n);
> >
> > The memrchr() function is like the memchr() function, except
> > that it searches backward from the end of the n bytes pointed
> > to by s instead of forward from the beginning.
> >
> > The memrchr() functions return a pointer to the matching byte
> > or NULL if the character does not occur in the given memory
> > area.
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
> >  void *memchr_inv(const void *s, int c, size_t n);
> >  char *strreplace(char *s, char old, char new);
>
> Also, if you really need this, why not also provide the arch-specific
> versions as well?
>

Good point, I will make the arch-specific overwrite possible.

> thanks,
>
> greg k-h
