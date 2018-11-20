Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30633C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2198206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYx6j+bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2198206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeKUBOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:14:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36908 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeKUBOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:14:21 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so3850468iti.2;
        Tue, 20 Nov 2018 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9DB/CtvfgczhEwhT4EOcxrnAecZC5lxJJaQnPPQY4ug=;
        b=KYx6j+busDketmii4fqNycTpD/ytmcEKWIeY6RDxjcp2VA8HodyNTSTIctzN09vEIg
         FOJTKT0wOQHO9luAUKaA3NAwafIxLEG8YS+OXoskyoNmgqpGq8PjjNddnFB6gWcyzM0j
         LXtwNkt8zMKVySJVQHMvFu6hzpqLLm3/57BixxBnIBOTIfy88Xor7CCcc8U8cHJ/NQRN
         IZStOlklkWXHzwaKRenPeXT/zYoai4bL1IAHumgM1KlBOLESSDS7KrxPbP8gTISVNHIg
         5fVUyj6fhNyOSgVr9g1WdNVoq+DndMv4WkC8LXkly0IUwg0Qenm5sMfBTfkyDN/FZvzS
         ZsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DB/CtvfgczhEwhT4EOcxrnAecZC5lxJJaQnPPQY4ug=;
        b=ftJZYG+HTn1iU4p8sL/0BDQ31Bq6yjLf425pP5sb10y28os/Blv3EggN0VRmL5yEfi
         nxJum8Wti+qte29VJ6IFiMGJbEpTf1ufg2MJKI9lNgWEWwyBqJ8FDJhiZerhXMwDNUuv
         jh1DUyoC60W3/q0YImX7aT/GlV5dSrh+XV9PnXobAnKsOZCVQoRTFQsgLwTXpELEIkBQ
         4HN7uSRuRBPF6WlyjtQHOkR5gXJNKDFdnNRGkfT1mYp3Neyb9yTjW8L9OpPKMVczSHVN
         k2aRPGuqy4vQ9xMY1UAg1+hHjqEL5lWowgSf3Ob8+HSkjlXML6Hf4FrV6xffDjMsKgy9
         BI9A==
X-Gm-Message-State: AA+aEWZrTQN1RqY0XjFRNoc8VTY4wMJ7RMD2C4FRkXRdDM1swM+cc4cU
        mPOUqIx9jVVZ0sxwiRcIS/XbAysV28VjTJLGmUM=
X-Google-Smtp-Source: AFSGD/XqjCf/7dkVGFrUZdk6bjc9lclKs8wLX6M8VxFXNiUE/z8dIgWbB+xHLghFOVGULWSFT6gIhDGthLFX3NPYkE4=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr2261645ity.78.1542725091707;
 Tue, 20 Nov 2018 06:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20181120132359.19799-1-tiny.windzz@gmail.com> <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
In-Reply-To: <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 20 Nov 2018 22:44:30 +0800
Message-ID: <CAEExFWv-iarJbgXEN78P5BjvzRqnHoLgnjnV9YZU4hKPcT4e9g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: cpwd: add of_node_put()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/20/18 5:23 AM, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >   drivers/watchdog/cpwd.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> > index aee0b25cf10d..d3a81642ada5 100644
> > --- a/drivers/watchdog/cpwd.c
> > +++ b/drivers/watchdog/cpwd.c
> > @@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
> >
> >       platform_set_drvdata(op, p);
> >       cpwd_device =3D p;
> > +     of_node_put(options);
>
> It would be better to do that right after its last use to also cover
> error handling.
>
> Guenter
>
> >       return 0;
> >
> >   out_unregister:
> >
>
Hi Guenter=EF=BC=9A

Yes, you're right. I will send the second version right away.

Yours,
    Yangtao
