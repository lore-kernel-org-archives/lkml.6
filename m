Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7377C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5820684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm1hdwKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC5820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeIZRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:17:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46169 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:17:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id h22-v6so8732011qtr.13;
        Wed, 26 Sep 2018 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3vSKdVCJHkmAc7jg91f7YGI97xyY9ca0kofoJteseY=;
        b=Xm1hdwKWAQAcOPkcOeWSyJSzLAAGl+5ATHyWy5Ldk3RCzkeZk+3yzuuXnSSW/wt5xc
         CfHlnCyFP1D2kx1PQ+B37yyzQ8dNLqi7Ykj/ScCQsmLRAT/0jKNUWC+tB7Ivzr/cLv7G
         FGr+ZOfNmKJZvQvtDlMNm39sqkyI86AxKV9VlgE0FUoMKDmrnJdOSNvtkftx5p2w2Wgf
         9bIB9xgO3+hI+WeVZ2+bvkZ2Bz3q21SSwe1xwqkyrBIW7A63/sILdEAVDHPAJluEzvrY
         U3mwokjjoj/0wPKFANclNUv1GisYiWdT/6VeTjSb3MmC1vBdn/mgt57alv8lWNfLrWIk
         2amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3vSKdVCJHkmAc7jg91f7YGI97xyY9ca0kofoJteseY=;
        b=Z+xre88K/IDPTooRbEY5GNz25CEOckB+YIJExg1GBxXRuGc7YgSuL3Mj6QQ5i5WLRs
         LJeHNUNvOP8M7843hjJG3Uo/Rfz275s9v5AetopOXQcdBpXUqfE9CZIOy/q7QgIq7fET
         gfm5V/vE18T5y8STAn8SpNWDjLkvODY1/hrZKeMfmLAQw7DAUzrUZI1sADL4FTjHfVTm
         GwJo/7lF0KNDtVCeKdJRqE4hxwx25h3DWyJ1eIeCg2VEYifAyA+c1cO1eu5lsNNeeSYN
         MQRkIfHzLtS5qKSQA6DyKODvhnbPxuhh24rwf/i8v6umWnK8rI8WJJI0ESlYgQkF/VQu
         KOQA==
X-Gm-Message-State: ABuFfoii+kzjyjfaZuv6yorfjEgl6pCFoEn6wbZ/SDt3VPlokE2e5DRI
        bSp2tuTzVR5Pnp3q46JIOepHbdyswpdPaiWBY/c=
X-Google-Smtp-Source: ACcGV62ChZPuipY8fxdGEMyaKsqxIoHui5Bjif24LowVA+KMepgTGHXZDl4qRiqqdM8Ncnu5SMgGZv+aZxl20cyEQdI=
X-Received: by 2002:ac8:2759:: with SMTP id h25-v6mr3995115qth.274.1537959925479;
 Wed, 26 Sep 2018 04:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180925193418.28493-1-stuart.hayes@dell.com> <CAHp75Ve=ZnkBbdG3Myu1qzubr6+q74Q0u9pR7+nHXG=yAO-0rA@mail.gmail.com>
In-Reply-To: <CAHp75Ve=ZnkBbdG3Myu1qzubr6+q74Q0u9pR7+nHXG=yAO-0rA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 14:05:14 +0300
Message-ID: <CAHp75VcMDXsJWTzrEo+L7aQzaj1oRoUb_Cpc91J22p0wcybOjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Update and move Dell drivers dell_rbu and dcdbas
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 10:34 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> >
> > From: Stuart Hayes <stuart.w.hayes@gmail.com>
> >
> > The dell_rbu and dcdbas drivers need some changes, and should be moved to
> > drivers/platform/x86.  Additionally, dell_rbu needs a maintainer, and the
> > listed maintainer for dcdbas is inactive and needs to be changed.
>
> I pushed this series to my review and testing queue to allow bots play with.
>
> But.
> Please, add commit messages to patches 4 and 5 (I can't take w/o them).
> Collect Doug's tag that proves he is okay with the change (I remember
> he answered something to the old thread, though I don't remember the
> details except annoying footer which should not be up in open source
> mailing lists).

Applying: MAINTAINERS: Update maintainer for dcdbas and dell_rbu
.git/rebase-apply/patch:14: trailing whitespace.
M:      Stuart Hayes <stuart.w.hayes@gmail.com>
warning: 1 line adds whitespace errors.

Fix the above as well.

>
> So, while bots are playing with the code I'm waiting for v2 of this
> with above addressed.
> Thanks!
>
> >
> > Stuart Hayes (5):
> >   firmware: dell_rbu: Make payload memory uncachable
> >   firmware: dcdbas: Add support for WSMT ACPI table
> >   firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
> >   firmware: dcdbas: Move dcdbas to drivers/platform/x86
> >   MAINTAINERS: Update maintainer for dcdbas and dell_rbu
> >
> >  MAINTAINERS                                   |  11 +-
> >  drivers/firmware/Kconfig                      |  28 ----
> >  drivers/firmware/Makefile                     |   2 -
> >  drivers/platform/x86/Kconfig                  |  28 ++++
> >  drivers/platform/x86/Makefile                 |   2 +
> >  drivers/{firmware => platform/x86}/dcdbas.c   | 123 +++++++++++++++++-
> >  drivers/{firmware => platform/x86}/dcdbas.h   |  10 ++
> >  drivers/platform/x86/dell-smbios-smm.c        |   2 +-
> >  drivers/{firmware => platform/x86}/dell_rbu.c |   8 ++
> >  9 files changed, 175 insertions(+), 39 deletions(-)
> >  rename drivers/{firmware => platform/x86}/dcdbas.c (82%)
> >  rename drivers/{firmware => platform/x86}/dcdbas.h (93%)
> >  rename drivers/{firmware => platform/x86}/dell_rbu.c (98%)
> >
> > --
> > 2.19.0.221.g150f307af
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
