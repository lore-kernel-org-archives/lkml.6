Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3718CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ7gapZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfA3C3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:29:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfA3C3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:29:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so10324514plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RXMQUTjYFuRZ0vKiKpicoQgVzwds0R8H6JfmM2E8yg=;
        b=PQ7gapZVzMwG9mKHT7n5beHEIz3eLeLBSIg50o4PY3iJJ6FqGb5NM9jn/f3Y26OTv9
         Tz4Ob1oxB75+yvOIp2xF+PWCRIXWbyoDmMFWldcRPWZe8HWWgv1QBOeZ3bRqhqDZGx9c
         ZnHJ2AKPzRVt8nTDp+T3YB1GGZKlTtfIFwBfUomX1c7raJw3K7XhivS9oDBg3P02snfj
         GQj0ID1g2scdOhoPq0lG2yjbkHxVYB7pLcBlmEsTOKLUeA00t47YvB8r6X3X6dsWYmCf
         1DbBa73vNbxjWSzz501Cydap3hSfw9NyFH8L22K4/OHkiFGkMMMAjDk3c+mOzZfdKMh6
         2Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RXMQUTjYFuRZ0vKiKpicoQgVzwds0R8H6JfmM2E8yg=;
        b=aG7H6b24nNMn9cXMrV3NRstZkbxFSnbFhZFJfiOSBbBnZSTe4YHAVEtMb5UxFa72Ev
         vYtfVQ+C10cnht0XWu/U6kOOKakH51pZSg1AhIO0XesyIukNbhKZufd7/ZtrqmCOBNdd
         B3zJw2lPh6aAKZOQ/lZBzwB+6yJiEJ51o9TA/92RiPpKEHpPeQF9SrKNa/70fxkJU3wE
         DRmCyGStuUvOS2zl4AX38ys+Llnkw7xGkojILzcr04wEgHSnm2sUVPZtJ/xMul0lwKTP
         NQSm6mN3G56VpbLPOR7Q0gjHxd8GRkmswPg+u3xZcdRdsBFAsOx2DEHwz6f8WES2gLn0
         Shfg==
X-Gm-Message-State: AJcUuke7OV/FgIq7Eft4zhzlitGJVLvjXVQr916sCp1n/Ikcff9CtVI7
        ln/VbcFHr9hgkBIer6rWZDY8aYwPN+elvKSk8OU=
X-Google-Smtp-Source: ALg8bN5nuLVvazBmaQAeZp44pc2Bq7p1kH94xsvDXnN6OKKUUBkQ4VPmnkmiRrFTU6Vu3mab0OnSzTO6ysIsA6AgNUg=
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr27321182plh.302.1548815382491;
 Tue, 29 Jan 2019 18:29:42 -0800 (PST)
MIME-Version: 1.0
References: <5c383af0.1c69fb81.c393d.125c@mx.google.com> <CAFqt6zZnc_XauKefVavwana2cMLF4arEkiqjmfd25h-MWfsuJw@mail.gmail.com>
In-Reply-To: <CAFqt6zZnc_XauKefVavwana2cMLF4arEkiqjmfd25h-MWfsuJw@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 07:59:31 +0530
Message-ID: <CAJr6mf16yq4gGD-GsfB+taT+JrcA3S3KaBMM-B=AMvdZPrvRaA@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 12:12 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/xattr.h which is included more than once
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  fs/cachefiles/namei.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 95983c7..edecb7f 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/namei.h>
> >  #include <linux/security.h>
> >  #include <linux/slab.h>
> > -#include <linux/xattr.h>
> >  #include "internal.h"
> >
> >  #define CACHEFILES_KEYBUF_SIZE 512
> > --
> > 2.7.4
> >
