Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B588C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDA02087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TI1T1miG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJIPOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:14:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35296 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:14:44 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so1317231itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nM7mbVctXVfkWr90aXB3MBQKviExgFmyC12UfURTelg=;
        b=TI1T1miGnhIl5t/OD/GpXycL4aNQ22mT6D3FdCEwlJlcwCNMNzMiI/bOyMxEfmUOqD
         si9WHcGzMnG2EIjPK++TGRmIy3KdG3PI8R2K6i+C3Cs7acamFEnP10y3g9bLTJK5v6G4
         fGDtAvgembKbhlsXy4Kpy/QBb4Ia/Zln1z7tGrzaJ/qS5K6HtkK+6gj36NbXJZkpC2BB
         VjcQHiEa6542xTHUL+OzQQsNTYLXdU43fELOWz72psBkRXEfN2KIIGGK69cG0eYtTOvh
         xb1JdC7nNtJYvaK8Bgq44C7PpLMZNH6ymWcR1U5Ajpag0Vl5ksvVH9npmdlFT9u3F26H
         jbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nM7mbVctXVfkWr90aXB3MBQKviExgFmyC12UfURTelg=;
        b=PCJFo8DTjZ6wPgbcjIsaey9rtExoe8nmEpMzabNkDjPpznifIUda7cboxMY0mif/Ga
         DnWY7buaLVDweU4uYs7GKd2jGOaNDU9alTFEuzIjw+1SiveWslG+DyCx6yVwLiRylp/+
         O8p/YONoq5i1JoYOhFS/Iwos4wGZ+dpFEDMVj8hFE9e/6o6jxFoyf8fHw9tQnl2m9CYh
         9zJcBeGVG2/xs3aKWtT3e+VUQrzE/DSS6L875GpOOWPalRFkL2Gn9tOjHilbJSgx6/7+
         a6dzri7K43dovMBYb8iUqzdhH31W9ZlJbj9k5hpGRsn92sT/XXQqvtslY+SON1SwwbeS
         NNYw==
X-Gm-Message-State: ABuFfojY2YlWKhb/t6YsThziIXlHuIFHLIhds9PeB8j0sNOYlHYcn0Qv
        Yc76nnkI/mCKDOcR+uFcGXWupdaaXzSME7X2OjHDUA==
X-Google-Smtp-Source: ACcGV63kVEQ2LMvA6EdjgbayNhUM2opx+UonnhmnmWG+ytkyvrhck+x2tPSytzQfJIHiK3krJBkjeiOf7j8SHx4JJ0s=
X-Received: by 2002:a05:660c:8c3:: with SMTP id g3mr1023967itl.53.1539071943918;
 Tue, 09 Oct 2018 00:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180827090651.25062-1-brgl@bgdev.pl> <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
 <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org> <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
 <0622b4da-20d3-5f05-5774-85c1dbabe00e@linaro.org>
In-Reply-To: <0622b4da-20d3-5f05-5774-85c1dbabe00e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Oct 2018 09:58:52 +0200
Message-ID: <CAMRc=Mc44cw__ZQ=Pv77BaEngbS6WETX8Xi-wB8epDeRwzx7LA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] sh: make early_platform code SuperH-specific
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 20 wrz 2018 o 18:48 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 20/09/2018 18:19, Bartosz Golaszewski wrote:
> > 2018-09-20 18:09 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> >> On 20/09/2018 15:00, Bartosz Golaszewski wrote:
> >>
> >> [ ... ]
> >>
> >>> Ping for 4.20. This is the third release cycle I'm trying to get this
> >>> merged and there never were any objections.
> >>
> >> Thanks for the heads up, it is in the pipe.
> >>
> >
> > I guess you mean only the clocksource patch?
>
>
> I meant it is in the pipe of things to review :)
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Last hopefull ping for v4.20...

Bart
