Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E018020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzVaN6M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeKIBXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:23:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39101 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKIBXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:23:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id 192-v6so16518958oii.6;
        Thu, 08 Nov 2018 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciwv79TtyNdFbxrLpQ5enUh1V3zn2yEjwbjmR2qn4G4=;
        b=LzVaN6M/OHxKUwkmrn7r2yrJumhwyKMM9G2wPEV3wybAzZtS1wCtjP+jhVxNxJI8s/
         bu3ERhb11k0dq1+q0B6meRT4koc3/DJn3ukYWIsfK08WEdOt+McZl7yt7aeTjwvLN22I
         cPL9U1L5AMKX7JEUsc6TLMvTVpd/EBarCWASkQOfGh8zqJRM+Au/H6ms1V7upQmri6y8
         mYHV8NIQ67rjs7eOvHyzN5BKAsQ+/DXVCQUmAD2A1c/5PtSHqDKFlYsAWtSKo6959Afs
         R4ZGm00C2KVZZ0dDRWcRtQV8/OI7dgrBWB5LYAqKUz1eOI6oSmHHkKJHmasGkIP2IFL8
         Md/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciwv79TtyNdFbxrLpQ5enUh1V3zn2yEjwbjmR2qn4G4=;
        b=V9LVTbKPoRbNEzB2yZGHV7eAh7/OHqRK2rxJpO0OQAkH4y2ja5plUdXYtZRjU05U9K
         Otl4Xl9RebrFwr+it5531wq8XfiaPMo6Z6bnEQGWwi0vRL1H0XezK/xHPHPIIxlA66rP
         Nc9zi6CKrbWiS+scWM206D7W0qHPrEPZufRLFjVSVCdyz60u414aMFi1EUO8ChAyTmmd
         WLZfeG+pSZMxpUsQfsorZw/MGuuqHaEAra2FsYREoWEZSGi/DKRDBr4nIUDVQf86w0ew
         ij3Ang4yHNiNHlJlrqcVm2EjCJxwOdcWBQpRNS7bCR8AcOlUy3Br1goJYwTPfU+Apmum
         uuvg==
X-Gm-Message-State: AGRZ1gLzm/fR2Krh5CHfpJQ6SoftPtbvdwD2kQwmnxaWMx6dJYsoMneb
        Ij/CYm9PlU+oetKv/Q+ThIhr3GOcRVmXCJm52I8=
X-Google-Smtp-Source: AJdET5dAgLB9s6g9fL8EkL60PA6O71GSuG0QvQUG2TTU1G3Z6/dIcJiLlF31CjuHveaZdbTuTvtdc/lqvzJdOENyUyQ=
X-Received: by 2002:a54:458c:: with SMTP id z12-v6mr2901021oib.297.1541692051369;
 Thu, 08 Nov 2018 07:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
In-Reply-To: <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 8 Nov 2018 10:47:20 -0500
Message-ID: <CAGngYiXEsg-6MXK60s8gOq2d8LGq+USTk1FC3GYqy2TQheaxHg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It looks like you build your own object management here. Maybe
> use kobject, or at least kref instead of the refcount_t based
> low-level implementation?

Excellent point. I'll replace with krefs.

>
>
> I see this is called from the interrupt handler at the moment, which
> means you cannot call sleeping functions, but it also means that
> the timeout may never happen because the timer tick IRQ cannot
> get through. That means you may have to change the irq handler
> logic, e.g. to try this a few times but then defer to a bottom half
> if it fails for a long time.

Touche ! Yes, this is very likely a big problem.

What if I converted the interrupt handler into a threaded interrupt handler?
That would allow the timer tick to get through, correct?

Point taken about cpu_relax(), I will fix.
