Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C6C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7630B2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQh3xHj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7630B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeFTACh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:02:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33721 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbeFTACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:02:32 -0400
Received: by mail-io0-f195.google.com with SMTP id d185-v6so1883003ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0n7criWxZbygG44gocDdJvvsUfs8bOtPgi9GwH2ZVyg=;
        b=cQh3xHj6GN6M3yHXg/dDI3BTYK8JYBIgEeqxjIoVLyOZHGjkTYs0a+Sr00LexRYZbm
         HryrDUJPdIzoCDsnbO1Xp2SjjS48iNuFhwMVKJL+vS5JiITQjcBo2pjvsAt/UIMh0uUH
         2sig5aAWi3BJFM4Sw0b/SEKxvb2bpXMuIJWUgSA2p4MgBR7FrjF/hQQ39LowJSP0XSfq
         btdiO35qEgCxVbQwlazNqhrWW+bw5g6OSpE715Y4sjatQ+zpnVjH2p5u9uJ+3mhWeqZa
         vngM+9sSjYOSi00JD9JRkT/zLpLMtf3bek/6tr+ERNq4FkCbjsynJSfjs+mWTLnWkszo
         KqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0n7criWxZbygG44gocDdJvvsUfs8bOtPgi9GwH2ZVyg=;
        b=bMEEWG5tIdKcIFiURD/qlv9t1t9cPvWI1A4gOJSJajRdKAZ9SSBmiCR24kTjbnVQDQ
         7LhiLWVjmEaYdTfMIwRLBjQhlxEIGa6uXaelGClxxYiOxKpvMKKEjnkxIxlxaJe4pZdQ
         9+30SQuLplW3zXMVB0E9tSAempBlsDYmm2Gin80Fkd7A0RyZJwh8A5ddwm0yfrpdWb0s
         6m3GCAa8FSwbRuZQ4dZ/SjAc160+syy1wVSrgsqORwhUWvHfiPTuOroM6688xJYTAz3+
         Ao79oV1EvLLNara6Ap57xRmUlZTCFNE7EaPu8wbyXAVe8lsg7fzzzddmsQWgyolHcLdl
         /vxA==
X-Gm-Message-State: APt69E38IwWZ0SPGt9vQkAgmvLGwfUjGC/StgPBcr1kFeJnsuXshOUP+
        1pmQ7e/1d/Gtl6p33piB0f5vl/d1Jt4+M18UtcWwMw==
X-Google-Smtp-Source: ADUXVKKBrjmBpjwfZpE7NW861hoMRoWwePraowA6CintFEDKzSb9NqdKsieJdzQrEJVPCGqYW31WYwITihGUpy2lNcI=
X-Received: by 2002:a6b:3a4:: with SMTP id e36-v6mr15279623ioi.297.1529452951950;
 Tue, 19 Jun 2018 17:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180619222444.134928-1-astrachan@google.com> <20180619225603.GB23389@kroah.com>
In-Reply-To: <20180619225603.GB23389@kroah.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Tue, 19 Jun 2018 17:02:20 -0700
Message-ID: <CANDihLHJDbwztOWSCcip2cCDkGQKuBYB=FX5DAGAkAuRG4=_EA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Fix mmap size validation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

On Tue, Jun 19, 2018 at 4:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 19, 2018 at 03:24:44PM -0700, Alistair Strachan wrote:
> > The ashmem driver did not check that the size/offset of the vma passed
> > to its .mmap() function was not larger than the ashmem object being
> > mapped. This could cause mmap() to succeed, even though accessing parts
> > of the mapping would later fail with a segmentation fault.
> >
> > Ensure an error is returned by the ashmem_mmap() function if the vma
> > size is larger than the ashmem object size. This enables safer handling
> > of the problem in userspace.
>
> Is this going to break current users of this api as their original call
> was succeeding?

If the user created an ashmem region, set its size with
ASHMEM_SET_SIZE, then mmap()ed a larger size, but did not touch the
extra memory it just tried to mmap(), it could pass with the existing
driver. With this patch, it would fail at mmap() time. We're not aware
of users that rely on such behavior.

> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: devel@driverdev.osuosl.org
> > Cc: kernel-team@android.com
> > Signed-off-by: Alistair Strachan <astrachan@google.com>
> > ---
> >  drivers/staging/android/ashmem.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android=
/ashmem.c
> > index a1a0025b59e0..1eeedb529a10 100644
> > --- a/drivers/staging/android/ashmem.c
> > +++ b/drivers/staging/android/ashmem.c
> > @@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct v=
m_area_struct *vma)
> >               goto out;
> >       }
> >
> > +     /* requested mapping size larger than object size */
> > +     if (unlikely(vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)=
)) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
>
> Unless you can measure the speed difference, never use likely/unlikely.
> The CPU and compiler almost always knows how to do this better than we
> do.  I know there are other checks like this in this function, those
> should also be fixed as well.

Sure. I'll split that out into another change and resend.

>
> thanks,
>
> greg k-h
