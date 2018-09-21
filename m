Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD6ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E4D21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqdA+kH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E4D21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390726AbeIUW6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:58:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36707 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIUW6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:58:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id t5-v6so2408236qtn.3;
        Fri, 21 Sep 2018 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tfFrySvThHWLKdjkG9wKPwMAPFyHlwZwH97b01uqwo=;
        b=ZqdA+kH2VTjdjkc8pwgLA2NRNQDMsNUdOEfwnHIYRk9ppr3+ZlN4F2rdiGyakay78J
         NaBadKtPOMfLYe2k/M/7APZrvrHLnm82uxyTTBBDzJt/ujKCEb6dVerLbBcaiuRITV+A
         Gs4uo/3ozhGKeuejaHwLV/RpIXLsHDaRey+ZHURPr7eJjARzp7TtgjKmB/hpX/Iq6mqq
         4WFfhGXaBSP9yTWIWIicSQc/4HRUx9Te31T/YLsbJ6d6K5efNBDQsunGtlRg1cQrhdLy
         aV2+91xTcr8Thxn4Qe2NGpmUk8HT/BB11GRUC3WAy82btIFRagr/mL5oboedagxBoY1q
         /anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tfFrySvThHWLKdjkG9wKPwMAPFyHlwZwH97b01uqwo=;
        b=OvsANHj0z3eN29YCn2zz4e8XvAmsoqj5hhPULG7iS2dqFkZWKP8Q3rtg5WIrnSDs3y
         KqIByG/agARdOlnTaotWzUKgH5fV77v3a28ftbhmRd1yycO/qk6O4wtM2/+5d1v1m8rH
         nv1UccvKHSt9fIGXRANi09XnzxfECm/1q9+hv5zhlKzladNXC11hCSa5dhE08GWblesH
         RqxCUMLdheRIgaQiVzVCy9xaIjok+7Y55D6SagknCYetZ5mHPAdE5xa41m1Pm9NH295t
         t/tcHvcncWc/PinsLovvvJyMMwMYzQAFZbPzG3kiV/ORJXOaVerl+owWKkHlDbEZE+qE
         SDUw==
X-Gm-Message-State: APzg51CRnoiu2NA/X62V0nqWnh7fbmYHnAMmUQIEN3KlJJFnl92v4dhd
        yJc0ydYJUoDdAn8jUfvE0P3HeBPh0VmMW8i3ux8=
X-Google-Smtp-Source: ANB0VdYmK2ku2RTM88rIUNGcHk64+O6jCv+SmMmkugxgF5vsGWf3gmHQ6jBDvsTGlJ192jVm7eeCsRVaIj/kM7Nqqgg=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr33139471qtk.187.1537549693783;
 Fri, 21 Sep 2018 10:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
 <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de>
 <BF554FD5-17BA-4F16-9FDF-705D1FC76C12@canonical.com> <CAPpJ_edB_G5QPj-by9Y6Zjj36Xm9dmKXy8Kv5gXMf4YfybvuwA@mail.gmail.com>
In-Reply-To: <CAPpJ_edB_G5QPj-by9Y6Zjj36Xm9dmKXy8Kv5gXMf4YfybvuwA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Sep 2018 20:08:02 +0300
Message-ID: <CAHp75VcCLvb+LvE49YNWnptTMFpUNuj+Jao7udhQeLfOuHh2vg@mail.gmail.com>
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, steved424@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 8:53 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> 2018-09-12 16:19 GMT+08:00 Kai-Heng Feng <kai.heng.feng@canonical.com>:
> > at 14:32, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> On Wed, 12 Sep 2018, Kai-Heng Feng wrote:
> >>
> >>> There's a Dell machine with RTL8106e stops to work after S3 since the
> >>> commit introduced. So I am wondering if it's possible to revert the
> >>> commit and use DMI/subsystem id based quirk table?
> >>
> >>
> >> Probably.

Have you seen this thread:
https://patchwork.ozlabs.org/cover/968924/

and this one:
https://patchwork.kernel.org/patch/10583229/

?

> >
> >
> > Hopefully Jian-Hong can cook up a quirk table for the issue.
>
> Module r8169 gets nothing in the PCI BAR after system resumes which
> makes MSI-X fail on some ASUS laptops equipped with RTL8106e chip.
> https://www.spinics.net/lists/linux-pci/msg75598.html
>
> Actually, I am waiting for the patch "PCI: Reprogram bridge prefetch
> registers on resume" being merged.
> https://marc.info/?l=linux-pm&m=153680987814299&w=2
>
> It resolves the drivers which get nothing in PCI BAR after system resumes.
>
> After that, I can remove the falling back code of RTL8106e.
>
> Heiner, any comment?
>
> Regards,
> Jian-Hong Pan
>
> >>
> >>> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
> >>> reservation mode for non maskable MSI") cleared the reservation mode, and
> >>> I
> >>> can see this after S3:
> >>>
> >>> [   94.872838] do_IRQ: 3.33 No irq handler for vector
> >>
> >>
> >> It's not because of that commit, really. There is a interrupt sent after
> >> resume to the wrong vector for whatever reason. The MSI vector cannot be
> >> masked it seems in the device, but the driver should quiescen the device
> >> to
> >> a point where it does not send interrupts.
> >
> >
> > Understood.
> >
> >>
> >>> If the device uses MSI-X instead of MSI, the issue doesn't happen because
> >>> of
> >>> reservation mode.
> >>
> >>
> >> Reservation mode has absolutely nothing to do with that. What prevents the
> >> issue is the fact that MSI-X can be masked by the IRQ core.
> >
> >
> > So in this case I think keep the device using MSI-X is a better route, it's
> > MSI-X capable anyway.
> >
> >>
> >>> Is it something should be handled by x86 BIOS? Because I don't see this
> >>> issue
> >>> when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
> >>
> >>
> >> Suspend to idle works completely different and I don't see the BIOS at
> >> fault here. it's more an issue of MSI not being maskable on that device,
> >> which can't be fixed in BIOS or it's some half quiescened state which is
> >> used when suspending and that's a pure driver issue.
> >
> >
> > Understood.
> > Thanks for all the info!
> >
> > Kai-Heng
> >
> >>
> >> Thanks,
> >>
> >>         tglx
> >
> >
> >



-- 
With Best Regards,
Andy Shevchenko
