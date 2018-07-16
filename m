Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8020870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0cVuM3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB8020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeGPOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:32:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:42278 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeGPOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:32:05 -0400
Received: by mail-pf0-f177.google.com with SMTP id l9-v6so14700650pff.9;
        Mon, 16 Jul 2018 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqQmhPdvVJ8vi/StfxMkD/jRs05WPTlpQZrJ3dvSXY4=;
        b=t0cVuM3byxchj9d7mbKxxX/g1OaAu8qEe4vdWVL1e2MYQyWnTG5JidwMqkElamU3tR
         GgQJ4eA3Gq5aARhtC8A0biusKdib7ET57cSUHBJGKRYFsUnnp1igMpXEzlnb9N8baf7C
         g58J7xqJCDLi67J+xDLksRhJLpwtOyxLzv81OJbp33CjaK+0xB7L9YIz4e1iHb2hoPSo
         5JPpvbQ0LE1pWD6tlyuCYluuCu2VCx5J+17qZZcBONkdN52YuraPzrQA5z9Y1H0q/kqy
         IXbcd4TR1klh0AOBG0g5vMHZjwA8WXWu0qMirMCYiTakzgXh7ypSurPkXZb6DddEToMa
         LkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqQmhPdvVJ8vi/StfxMkD/jRs05WPTlpQZrJ3dvSXY4=;
        b=YtW+WKoOqtUazuJ3N+VF9LCAHoCmje3lsN4mBtI29eGZJtRTLJfboE9kv8ts1BL5cs
         CbaxgybZ5EbAPmDI2DP5kCGqQ1zpNhDfiV2aBwHXJq8L/aFnhe7rLjFF9X2A+ypqKuUB
         hQRuQLdgW59nX0CIyvnSUPbVTbXywrRuyYGRGUiFnwtvuro6p8aGBmiNmBLO4M1mBOkF
         xRLORuqipjFMjN13B2cbmFTLq5kwxXwlsxnkX7y92Eo/3sG0uB+hsmMgS7UTumMH04fK
         yvXJpzhCWBp53R8Yake3skgg2Nh7r68ZxwUavjar8WVw1Qi2PCyGLtpQox4XgEyrW2XZ
         Iq9A==
X-Gm-Message-State: AOUpUlEL16/dc+y8STOqq1xof7lFzkqKO2vWH1YGr6nY1+mR8BrzFWBo
        TerdlboVq1bQnbHuTAG5JUIHdSbG1gFQHw1K9eY0RZla
X-Google-Smtp-Source: AAOMgpeFtXUFVbwNihWe3FWNkPm4vc4QFuQ0PAZLv9j1nM2RCjQUuh+tgEZh/iIwcPgXjBrgHdCSsfzUz/JvdmRUJGw=
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr16052615pgo.208.1531749868827;
 Mon, 16 Jul 2018 07:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
 <20180716121909.4869-2-michele.dionisio@gmail.com> <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
In-Reply-To: <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
From:   Michele Dionisio <michele.dionisio@gmail.com>
Date:   Mon, 16 Jul 2018 16:04:17 +0200
Message-ID: <CAFwEtmq1f6fSe0cyXeQrGjh-5O9p+DmYDp=LmKt=tNYYzNK9SQ@mail.gmail.com>
Subject: Re: watchdog: davinci_wdt: add possibility to configure watchdog period
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michele Dionisio <michele.dionisio@powersoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have done what are already done in:
omap_wdt.c with parameter timer_margin
softdog.c with parameter softMargin
...

the same feature is missing in davinci_wdt and I think is quite usefull.

if you NACK because I don't use watchdog_init_timeout I can rewrite
the code but I do that to reduce the number of changes done in one
commit
Il giorno lun 16 lug 2018 alle ore 15:31 Guenter Roeck
<linux@roeck-us.net> ha scritto:
>
> On 07/16/2018 05:19 AM, michele.dionisio@gmail.com wrote:
> > From: Michele Dionisio <michele.dionisio@powersoft.com>
> >
> > It is not possible to implement setting of watchdog period because it is
> > not possible to stop watchdog so it is nice to have possibility to
> > configure watchdog period at module loading.
> >
> > Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
> >
> > diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> > index 6c6594261cb7..5f95afa20fee 100644
> > --- a/drivers/watchdog/davinci_wdt.c
> > +++ b/drivers/watchdog/davinci_wdt.c
> > @@ -54,6 +54,10 @@
> >   #define WDKEY_SEQ0          (0xa5c6 << 16)
> >   #define WDKEY_SEQ1          (0xda7e << 16)
> >
> > +static unsigned int init_timeout;
> > +module_param(init_timeout, uint, 0);
> > +MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
> > +
> >   static int heartbeat;
> >
> >   /*
> > @@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
> >       wdd->ops                = &davinci_wdt_ops;
> >       wdd->min_timeout        = 1;
> >       wdd->max_timeout        = MAX_HEARTBEAT;
> > -     wdd->timeout            = DEFAULT_HEARTBEAT;
> > -     wdd->parent             = &pdev->dev;
> > +     if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
> > +             wdd->timeout = init_timeout;
> > +     else
> > +             wdd->timeout = DEFAULT_HEARTBEAT;
> >
> >       watchdog_init_timeout(wdd, heartbeat, dev);
> >
>
> NACK. This is done with the 'heartbeat' module parameter already.
>
> Guenter
>
>
