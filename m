Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B27C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7971B214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuLxCXe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfBPBm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:42:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45121 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfBPBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 20:42:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id y195so6881751qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/TYbp6WTFquopYV48HIsUS8kivveVqNwysscHdcJ7ow=;
        b=XuLxCXe3PP7ofUqlKs7c4KiG4GTLtai2zMf/TipAAflWEkZT+VHfqaoEsGdSEkyr3d
         60f3RO4MO69b9CNzN7Z+T0wCpRrvMxeAG8f7/SSd2rGLGq3flVdMFmMAtxnkP+2ToxaX
         FMi0Osshhen71jUimqeuNtVHBo1qFXnGNmqzem5Q/PPOg/8JKRh4ipENoTw9z7mfoAIN
         17bs5IcZo2p7yggaHH/syR3ruv8iDqek26XUE5Uu2hMc1dPmS7zCTNtDJjc4rzFmDqv1
         2p0+DzPIFh8mRkTlYutOcrYSVIJM7ecVi7ZjeUtYL69Ns+/szQdorXt36RUrd4Q5SVyF
         +Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/TYbp6WTFquopYV48HIsUS8kivveVqNwysscHdcJ7ow=;
        b=KzzLZhSxS1N6qOsNABKJ4H9L15lz3XZnY/uxHLoXRk8E+6QavnFqo6RxQr90pUdjn0
         iR2dwDTDxm07jgLEJX6I7puYhAE1O3j+jfMcQFq9131i3NRZ5pQRp652qLX0roVSW/Yr
         protnyZCPnZju54XVKv0cmSZXTLpCkhFD7T9K+MXo5NhOlokLTWmWoqQgN1+su0jJ/U6
         xehJd6GXhC27AIP4B9UJLl5esGtBg5hKwUj1Y9+PyX/p7zMiy2Hzn97mC97MEns7X8cj
         oueQgxhtkx+cja4VkwQbF/b8m9IJgFXakRfo+hwy2Ckym+kDTsrWomL8eV6pXzz78Otl
         o+sA==
X-Gm-Message-State: AHQUAuYOx+/PLU0wzsLw/q0WvYY6bpUfMZQEJxPWASpIov0X7mb+So90
        UDIitYnl5D2gA17kQl/zrCzkxoRB3waDkS+hOZI=
X-Google-Smtp-Source: AHgI3Iab/WywGxgzzG7AJ23eNIqIYHODlXNUcDzuFDY/euLrs4UgNwNG1zhA3ZY9IsulcEGva9LTqWD0Tq3mtqRwHDI=
X-Received: by 2002:a37:4751:: with SMTP id u78mr9000418qka.280.1550281346032;
 Fri, 15 Feb 2019 17:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20190211070040.4569-1-jbroadus@gmail.com> <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm>
 <CAKgEEwteam5TCWAUtgQKxQpTzTk3+_DktmqwxZTLa=w3xt5i8Q@mail.gmail.com>
 <nycvar.YFH.7.76.1902150834180.11598@cbobk.fhfr.pm> <6280CE2E-0820-48DA-ABA1-621D107511CF@canonical.com>
In-Reply-To: <6280CE2E-0820-48DA-ABA1-621D107511CF@canonical.com>
From:   Jim Broadus <jbroadus@gmail.com>
Date:   Fri, 15 Feb 2019 17:42:14 -0800
Message-ID: <CAKgEEwsO025b1LqQNWqMa7fxEXQWv-4ZjxzCJB2qmBKS8yJG8g@mail.gmail.com>
Subject: Re: [PATCH] Fix resume for ELAN2097 touchscreen.
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy new year.

I think you might be right. I found some discussions about Dell
disabling S3 support in a recent bios due to a C-state bug.
I'll try to investigate a bit more this weekend.

Jim

On Fri, Feb 15, 2019 at 1:25 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Jiri and James,
>
> > On Feb 15, 2019, at 15:35, Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Thu, 14 Feb 2019, james broadus wrote:
> >
> >>> This should be fixed in hid.git#for-5.1/i2c-hid already by commit
> >>> 1475af255e18f. Could you please confirm that?
> >>>
> >>
> >> Hi Jiri. That change mutes the log messages, but I'm still counting
> >> around 35000 interrupts per second after resume and touch does not wor=
k.
> >> With the reset, the device works properly.
> >
> > Ah, I see. Should your patch then actually replace 1475af255e18f?
>
> Sorry for the late reply, was off because of Lunar new year.
>
> Commit 1475af255e18f is to silence the message when using the touchpad, s=
o it=E2=80=99s different to this patch.
>
> I=E2=80=99ve seen similar bugs happens on new platforms that defaults S2I=
dle (Modern Standby), but user uses S3 instead.
> On those systems, S3 was never tested, so the BIOS doesn=E2=80=99t cut th=
e touchpad=E2=80=99s power off during S3, and the IRQ line wasn=E2=80=99t g=
etting properly reset.
>
> So if the platform defaults to S2Idle but user wants to use S3, this issu=
e happens.
> If that=E2=80=99s the case, maybe it=E2=80=99s better to report to the pl=
atform vendor.
>
> Kai-Heng
>
> >
> > Thanks,
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
>
