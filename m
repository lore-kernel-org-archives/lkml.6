Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6541E20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgHB8EG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6541E20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeKEWZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:25:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40064 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeKEWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:25:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so13221280qki.7;
        Mon, 05 Nov 2018 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llZyIDXQ1CUuKCh86p2LCR5eml/udVSP64MMDX5nXxU=;
        b=kgHB8EG6954QcvQK53Y34fR8SLeFFA7IflrectdlWg1l7wGXhAupXtW+D8lwBrNFh8
         he9C5KOlcEbMfCMpYBWiK0qabAER93WKg/R65v0gb5N+cH3kPQNeN1reyv/tOgTqF7Z2
         yA2iYqPwy2+/Ve3IjRlkAtpVkDSm/ya2DXKzTeEQRQjO1EA1A6grPLhQxOzy6CDFxX8x
         i2zaO181LpAjJlGHpH0TUQK0AHpJ8LRIjFOc89gIH8wxsN0kUgt/3RzGwEKtHxMzqtya
         O345RT9Gmh+ArWrYNQ9FqizMPkrP64PlvP1VhiDRv889d9lxZjJiOC7VJVToS/vglMY0
         t7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llZyIDXQ1CUuKCh86p2LCR5eml/udVSP64MMDX5nXxU=;
        b=eVF6ebD3kCNB7ODdTV+GDnZk1w3/MZSB+E8SvchOkkbXnm8BNYEhW2ffCZACghREsx
         xgHcjZSnwi0ngecFE852lWwjeCNEVOuekDBDPtRRzeLUOunAdb5nrOTMlJ9zyRPgL85C
         JIch5LWa4RqVoICWZUPnQHHiSn2/GTVfhgYDawV5W9IWIxt0RbBOCz5hKjR/TCw23vTA
         mHXYZW/sxEyQWESdsVxeNaoNvB0mH5NkR6UCxrWDk2dZWx6Uh4HPHp6iAkcCo1YkJZnx
         68dQEyGGIw2rMavCkHleWApfFbAU8YOOPwJHId6YNCsVhDXCxYu60m7WBL8VPGbTf057
         r0Pg==
X-Gm-Message-State: AGRZ1gLcnMyRwCMGhxHRSQMjOS1ki9BxuXmIXhuX/F/rAomnVPYfN39K
        EUyjV7VSM7MHYLtrgaM4xsBD0kD1VYQojs0yvJ8=
X-Google-Smtp-Source: AJdET5f7PKQXl6rklRQ1BqpFEjuCzb9HB4pwYVCFsQB330CrBpAgfz9wdtKoN2sCrU2J05YO2b+6tKqOpD/8wlpic68=
X-Received: by 2002:a37:4792:: with SMTP id u140mr21069643qka.301.1541423129598;
 Mon, 05 Nov 2018 05:05:29 -0800 (PST)
MIME-Version: 1.0
References: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn>
 <1541414431-84128-5-git-send-email-peng.hao2@zte.com.cn> <CAHp75VfP4d0fK9NDbAcHqy4aqTiMGTKBX5VQ36QbSyhRzrpOSQ@mail.gmail.com>
In-Reply-To: <CAHp75VfP4d0fK9NDbAcHqy4aqTiMGTKBX5VQ36QbSyhRzrpOSQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Nov 2018 15:05:03 +0200
Message-ID: <CAHp75VfZfBox+DVNU=JWLkD0ETHPca5tUfuh0srnEAU8M+q0Zg@mail.gmail.com>
Subject: Re: [PATCH V7 5/9] misc/pvpanic: add support to get pvpanic device
 info by FDT
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 2:58 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 5, 2018 at 4:31 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
> >
> > By default, when ACPI tables and FDT coexist for ARM64,
> > current kernel takes precedence over FDT to get device information.
> > Virt machine in qemu provides both FDT and ACPI table. Increases the
> > way to get information through FDT.
>
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/init.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/types.h>
> > -#include <linux/acpi.h>
>
> Adding new headers in this change is okay, while shuffling them is
> logically a separate change.

Couple more remarks (regarding ping-pong style in this series):

1. The shuffling part should go after you remove init.h: no need to
shuffle the stuff you eventually remove.
2. When you introduce global variable for base, put it directly to the
place where it would be after your ifdef patch.


-- 
With Best Regards,
Andy Shevchenko
