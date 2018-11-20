Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222FCC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F172146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1foyHdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F172146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKTTIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:08:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38092 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKTTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:08:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so898764lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2M2YFIYgt8/BowVdVpoGJ+d8Mg1hvL/BYFFzQUp5s/c=;
        b=T1foyHdvFm13SR4GcMfr4EOX2tmRnBiteJyazP41HmblnAw5vxr3x5hCKB4PoZWHc3
         rDfmyxUj15mCYUrX8tnzUf1ji5tar9sT/7kT9m+V+aKiKaydpoJ5XaBll8J9pN3kFBu7
         EenayPtSreZbGa/VUGdSuJY/ApTl5igfhfOMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2M2YFIYgt8/BowVdVpoGJ+d8Mg1hvL/BYFFzQUp5s/c=;
        b=XreMAFFSoAiPFidp4ZaDiwoFmkG4TPizT2YXNpDIlzxCv8T42YXkI1JGC3CdTlKMVE
         v06UPL9HbxE+83rmrXh4r+IXH1qZSh/QEXGrX99n9CywgtoA4DjtliNQYGkNBYdYEtHr
         4yp8xIe2b0Ak1qgkr/Q3Hypn9ntHJCjjFXVgM4URVyKVMsKv+jOQ5VvhOOWNs8NPOdoc
         Nrfi2H9P72D6C07k6mpBdmeN9b2Q00LXMN/QI/12yHdXfEayzr7kzrdLzhlUPgWY/xac
         3sDDVxuRN5cHQQF0fPeqWOk7Arzt4rF8EXPn866cgn6urFlsTWr1KBFBYXZRe1gATnEC
         cMAg==
X-Gm-Message-State: AA+aEWZKhy3+uuLgubKwyULwGfOJSExJ0j0zQpX6IL895P/8Jo8RO+j2
        mG4ArlbZ7isxtXQdP6tGouryb826y0f14XZ2ZqnwD1KJnZNSrA==
X-Google-Smtp-Source: AFSGD/Wk49iNCT61RWa4tqHULNSG4CR9bN7Ga6LYWFaXoVygbTkg9sJTV/rDKpDYeIFPCggpEIA0BlyfvKO8LoiEPxs=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr654601ljp.12.1542703238289;
 Tue, 20 Nov 2018 00:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl> <CACRpkda4aarCn=PHPSWfMgtOZhcGA2ifcA7_ujYgmj+do2+N+Q@mail.gmail.com>
 <CAMRc=MeAR=aW0FKNyRm0xy075BkF=cpDJyJDiwtWpWcmkdmF2A@mail.gmail.com>
In-Reply-To: <CAMRc=MeAR=aW0FKNyRm0xy075BkF=cpDJyJDiwtWpWcmkdmF2A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:40:27 +0100
Message-ID: <CACRpkdaN+SsF+gGPV7KTT_E6k7_KAFhSgUKR=Jg0-fSjrx8V=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: davinci: fix ethernet support on da850-evm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> pt., 16 lis 2018 o 22:51 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):

> > I have some patches starting to move DaVinci over to using only
> > descriptor tables, but that's not somthing we can pull off overnight
> > so I guess we have to go for this solution.
> >
>
> Nice, would you mind sharing the development branch? I'm interested in
> it as well and may be doing some work on that early 2019 so let's sync
> to avoid duplicating the effort.

Just a stab:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commi=
t/?h=3Dgpio-descriptors-leds&id=3Db4db69c2a066a87c990a6757720284df88f11f57

It will also require this patch (as I realized after talking to the PXA
people):
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commi=
t/?h=3Dgpio-descriptors-mmc-cd-wp&id=3D1911a4fe1ed8805080d8c7e0adc298f74053=
1c3b

I guess I should queue the naming patch in some immutable branch
or something so it can be pulled in all over the place.

Yours,
Linus Walleij
