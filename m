Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68750222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGkwSLay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390860AbfBMIxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:53:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42805 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389921AbfBMIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:53:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so1660156qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvNtqUgRn+5xblfASqqm7+ICkQoCoEzCjFID4kRMhuE=;
        b=RGkwSLayIeUVbURr0AxmrHuMENhgK05GZE0P40NPeNnnrZvSY4iSUAynHBHQoYj1J6
         7D5k5X9q85O2nW4wXA7WkiZDArpYopMfjWonzT/BUo+VhIoqjbWcv8kCG9cVjX1pnjWg
         bp881/72/e4ETB33ehQpuqFg56uRFbbyia4nVSXnyhRTIpU9WBCnHutr5RgXhqwursLu
         wPheNmZY5sgjHZTFGL29oiUptRciiHjxAv7XOMiJVrrNAsVMo9+NJ23NNtnq138LtRTg
         5mX81YRAFuGnTp4/kQpP7DXCsJZT8JoJrpFOVk0JN2yWy62q5YVUslkxJs4KfoBAaPfO
         NxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvNtqUgRn+5xblfASqqm7+ICkQoCoEzCjFID4kRMhuE=;
        b=nY2AG3tvG5JgS84nTy6+twbfxvr2BRHuwnSmBDrIRRqxGJnAsEwIsPFo+zcQhpLJGY
         sjNxgMh0qpT15T+g3PZTBK34/dfUICpukhGlMFwEa/2VZC7lY8RS0Opcm66NKF3OauaP
         CK9vq3hV+mO8LIeTdCYljNfy/q2GEutUJdMm0YXrzAUpDOTkk/Ao3+HURyiCEgjh2t/N
         /yeTXIekP8Fcpy26h9o7jcPb0egOlbusrPBeFMGD5vYLLlbJn1E1Qkk7eOpvORgEKQRD
         lYv7uhvyfel8u5B293HNs3TLEPZ+Y+6sRsMgFed5luKJdoa7F3uakB4RbLgY9Eg09QAf
         K9eA==
X-Gm-Message-State: AHQUAuZs/mpu8d9qPF9z9f3LO0rQtZV3/5dXF6wE8VayNtirOcYrbvfp
        dOhPJqbIt7Ou+jhh3XoyO6O72fkQ2ho0sDxOQrk=
X-Google-Smtp-Source: AHgI3IarQhYpAZ3uqAAvlzUPqPKUHPZ0BdrCCVKbq2NqYdS32fJ5RM3cBClLtGGTT2F3+HyBCrx6yUmJ71nD5w+Y1ek=
X-Received: by 2002:aed:3ba9:: with SMTP id r38mr6137680qte.330.1550047989280;
 Wed, 13 Feb 2019 00:53:09 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home> <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213062912.GA23233@jagdpanzerIV> <20190213063815.GA32272@jagdpanzerIV>
 <CAH2Cfb8ENK6f1BKvD4oqGhRjQU6cU5ii_OREcPtjwZqP=1qAeQ@mail.gmail.com> <20190213080852.GA1702@jagdpanzerIV>
In-Reply-To: <20190213080852.GA1702@jagdpanzerIV>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 16:52:49 +0800
Message-ID: <CAH2Cfb-vv8cAUqpv3vKMiYEg_W=5CGDqZXA9BkCukRONahWoxg@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:08 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (02/13/19 15:14), xiang xiao wrote:
> >
> > But how can I precisely control timestamp on/off per message
> > through sysfs node?
> >
>
> Hmm. I don't know how many kernel printk-s you have and how often
> do you write to kmsg.

It depend on use case, but I plan to create a generic driver which
could reuse by all rpmsg based remoteproc.
This is the driver for upstream:
https://github.com/thesofproject/linux/pull/177/commits/a0b7009fede5552dc98733f2996a8140bff62455
so we need more precisely control here.

> I was thinking about something like this:
>

>         echo 0 > /...printk.../time
>         dump buffer to /dev/kmsg
>         echo 1 > /...printk../time
>

Another problem is how to control sysfs node from driver code
naturally, the concurrency and global side effect also need to
address.

> - If you would have several kernel printk-s in the meantime, then
>   those would not have timestamps, but you kinda can roughly guess
>   it
>
>         write [1243] foo > /dev/kmsg
>         write [1244] foo > /dev/kmsg
>                 << printk(bar)               <timestamp ~[1244,1245]>
>         write [1245] foo > /dev/kmsg
>
> Maybe this won't suffice.
>
>         -ss
