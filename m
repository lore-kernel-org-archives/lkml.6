Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B423C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDE22082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHwfnXfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDE22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeLEGkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:40:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51386 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:40:43 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so19637488itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDW64jo21GZok+L6+U9a+5U9Cyhuj4awgKFTmN54d98=;
        b=MHwfnXfj1v9VRZUIcUBpSXwIc86q74zSgBITDMr34rSWqOQMmu1icoHtP/NLcaHJzS
         CktqFEESDh6ljUN/SXL2B8pDI3UT2AX/MCdhjl0DO2jhXesuky7R2X17i2bsEaYEhEty
         BvkGaTiZIAchos+uUxyZpqfFDbmNSBXnACoaSf0XJs5AlJ0vsAivRRmYMJ6+COtYrRhz
         nLlCtEzkAcLmomXIwvnGi+gTkMc2yVLa0HrUkLc2RW7UtFRntX4CLJ0u+kpuB1xmu6bm
         Bs+oqQq5Hpjig1i/Rena/jDw1OxYuwG4FKhzpDhr/IG5418zkqsmj75qPfmtdOVovF+b
         c4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDW64jo21GZok+L6+U9a+5U9Cyhuj4awgKFTmN54d98=;
        b=tB+AAVjDPwOMXklLM68y2RUbrBUczQb//VVFUXj+mBeh5j1sk/iK5jx5jWDy7V+Nks
         AyglBA2Ahwfd4bsRr4kW2TNiRlNwgahmgK9rNcbeHAsIs7XCXCa33Ad1slwt5AcTH1Y4
         x9PJ5WrZjxFgK3x2w6hM1eymcdYGW10P56OPSVWFp1eow4T+poJFmXO0xIvgfXUiAXHT
         J/BQ/UzPPAmOWFXCVaGChQOb+2uthUe4pRlE8ghsaDUPzFo6q0h5cbysAJkSxjyi2GiX
         UCPI8lv2K60mEVqCUyl6WXvaxpjpv4/7fQQGboJhqhnJGqlxibi7BL/1KDJM8UJiibnK
         xYBA==
X-Gm-Message-State: AA+aEWab6hZdR59V7Fa8wDgFWXLJObayoQWXwVhQ1AqXuUK7WoXhYngU
        XsO+RMIDXz+azYVcFK2CF7CGJdq46HGK/suYmpE=
X-Google-Smtp-Source: AFSGD/VCSxTEx/kimQpzsro6ka90g+SXPNPb0A1kQxzSXP5Aixi7mctqQTHz4ZOMrBc7exn4fbKHz5SBVC3A2esszes=
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr1940673itl.83.1543992042212;
 Tue, 04 Dec 2018 22:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar> <CAFqtX7kfSuWkjYHPWsxRaYcsQRD4OtJVyUBAezZu3HQT4QjoYg@mail.gmail.com>
In-Reply-To: <CAFqtX7kfSuWkjYHPWsxRaYcsQRD4OtJVyUBAezZu3HQT4QjoYg@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 5 Dec 2018 12:10:29 +0530
Message-ID: <CAFqtX7k4dqpTqKwUmfLP__=pKXga5QBovnZMT7JNDk07A=pUBA@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
To:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 8:47 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Fri, Nov 9, 2018 at 3:21 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove linux/fsl/mc.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/bus/fsl-mc/dpbp.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> > index 17e3c5d2f22e..9003cd3698a5 100644
> > --- a/drivers/bus/fsl-mc/dpbp.c
> > +++ b/drivers/bus/fsl-mc/dpbp.c
> > @@ -5,7 +5,6 @@
> >   */
> >  #include <linux/kernel.h>
> >  #include <linux/fsl/mc.h>
> > -#include <linux/fsl/mc.h>
> >
> >  #include "fsl-mc-private.h"
> >
> > --
> > 2.17.1
> >
