Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D77C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FD32081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smP6Twdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FD32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbeKGAJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:09:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45525 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKGAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:09:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id d135so18486668qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6NXd9qwMyRlbaHtea73bJTHJH7mHB9FPKqKUB8aptUE=;
        b=smP6Twdj6W2ehiTrm2WMualq7rTvxtN77grJAXzoN4TYzvBHihLVLU7YMjDT+7ttaM
         YQNsfcP1CIMMgRKlpkoKTfonbj4XKK13hca6FcS4D1bCw20+o8EWI+qB3bt9APskekGT
         010QAI5RgeRUtcSRfy4SxClCHTUBUj18oVMkEuWCvg4WUV9d11f2vv1MgMhIPExsqFkH
         k5QdajDAcFlMkoZiPORw0YzMm/3aczdJROyoXhsdYLcosCncNh5i2lSOdQ7Y3d5YzKND
         5Peyw8rTbd7vmEbIQZxgMRS5LIcelPcuKYLn4s8Dcnb62dNUJm9CiMXv8BQhTqDsY9Fi
         xWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6NXd9qwMyRlbaHtea73bJTHJH7mHB9FPKqKUB8aptUE=;
        b=EHySLBvJJWovwoAQUCs4QrAx0b1tQnf3QjKtG+17K7t1rteRRZOrnwBkPBpIB9J0CM
         ZJgia4+81gP0Xk3cDo+uaWmGE+YIHHjRBE4JYtQynm3GLa9PEbivQ1ck8q/zyF/1hGFJ
         ycrAt/akQAxA+AgFPG35MHWgxN1lk/tvPmFvLZpTR/8DfzxnsdVgRgDF34uR6cVn97Zr
         Mk4+wYlepubarSoSIWTE0VEFHOKCHT4aY+6jMt6JNsoOg7RzHuc1gJnrVhdiD7glaF9B
         RG2PLRzRLphiISYv5dkyHVk70uU4RdCD4tZwOBfD1gz8AGZS5RcgCYEFq/qKlMzVUgpQ
         RkuQ==
X-Gm-Message-State: AGRZ1gIFtd38pbs7RANLKEPrb6UMuoBmmRs7vp3Isr9BseQvGyv9ZSwj
        9Ba7EtienftC+l6nG4zkTZ4QK+8LSESf+D5FkrY=
X-Google-Smtp-Source: AJdET5c0mDvTjFQc7dj9M8etwf6lHrCrNoQGLVd3SQClIYwdcqSxWUtECXH/LPXg0zW+mZJlDUQXPJWTXiVSNfMga6A=
X-Received: by 2002:a37:3892:: with SMTP id f140mr10261801qka.214.1541515430574;
 Tue, 06 Nov 2018 06:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20181106134630.29591-1-smuchun@gmail.com> <CAJZ5v0ifsQqkoFw2tossFKJAUkqDLdR9NpN3eZTn3t0xUz6K-g@mail.gmail.com>
In-Reply-To: <CAJZ5v0ifsQqkoFw2tossFKJAUkqDLdR9NpN3eZTn3t0xUz6K-g@mail.gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Tue, 6 Nov 2018 22:43:39 +0800
Message-ID: <CAPSr9jE8EbWue31LP18eF9+KysZHNRqHNrzif8H4NkCzHHtueQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add branch prediction hints in really_probe()
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

If we want the driver core to test driver remove functions, we can
enable CONFIG_DEBUG_TEST_DRIVER_REMOVE. This option is
just for testing it. So, in most cases, the option is disabled and the if
condition is false. So I think we can add an unlikely() to it.

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 6, 2018 at 2:47 PM Muchun Song <smuchun@gmail.com> wrote:
> >
> > If condition is false in most cases. So, add an unlikely() to the if
> > condition, so that the optimizer assumes that the condition is false.
> >
> > Signed-off-by: Muchun Song <smuchun@gmail.com>
>
> Have you measured the practical impact of this patch in any way?
>
> > ---
> >  drivers/base/dd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 169412ee4ae8..8eba453c4e5d 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -450,7 +450,7 @@ static int really_probe(struct device *dev, struct =
device_driver *drv)
> >         bool test_remove =3D IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE=
) &&
> >                            !drv->suppress_bind_attrs;
> >
> > -       if (defer_all_probes) {
> > +       if (unlikely(defer_all_probes)) {
> >                 /*
> >                  * Value of defer_all_probes can be set only by
> >                  * device_defer_all_probes_enable() which, in turn, wil=
l call
> > @@ -508,7 +508,7 @@ static int really_probe(struct device *dev, struct =
device_driver *drv)
> >                         goto probe_failed;
> >         }
> >
> > -       if (test_remove) {
> > +       if (unlikely(test_remove)) {
> >                 test_remove =3D false;
> >
> >                 if (dev->bus->remove)
> > --
> > 2.17.1
> >
