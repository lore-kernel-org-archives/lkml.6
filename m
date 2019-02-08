Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iUddjeMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBHM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:27:39 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54952 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:27:38 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so8258213ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rcwExCzNoL+yg617jsQnJerR6CSHpOTYTtf3KT5kGcw=;
        b=iUddjeMIr5uEDafh3drBAEn05JBVkVu3p7zC/+JqgG1WQJJmoB0vn5ecMydqLtIw8L
         gU2XsuvVAuxYvkRvhXyo9Sn1tfP8qYyBISMBOZKqH3UIHPSQxVNm9pj5M9Qqf7mP22a/
         4pgMfzqzGlL+uC9CPcp8HMa2WDfkwOtn8omfPESv7kLCfaGDUXGd8kr47g9sPzvj5JvG
         8zJcXiW+IEs0A4pRpImskD9OjodGr3jM286JF9fM9KfUV4VV5rwnJ8Ok7V+tAE1RmfmX
         QvnLDa5LXUNzbtLQefyJugKYsuxX9lcDuUSm3Pz9eXf2ytEM7WysDQG27beFRdiF8cDi
         uH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rcwExCzNoL+yg617jsQnJerR6CSHpOTYTtf3KT5kGcw=;
        b=EMtH+kbGYcHbRfwCqhsyyG6WUsUXvpoHcOxqnMrV/0dRH4nVJAkuRL80WDq6V9ESqZ
         Zk03sORinRBcM6G4V2zeu7wW+tptJAxnobMYX6iyvdNKmoqj/qP7MaMPnh2qb1Ue9z41
         ZEfBwZcSqGQwuM8s8a9lJUs1whsfUBUxNQnOmSDQ1VOXtgiz1J102MiSbsV4X93aycUS
         lnnPoQuVJZdW4ykWN9hMZOFuGhJ/exPxW26x0m3iAW+pf/kiwBjqt1rCMzPu+K16PN2F
         E0rWDUpCk3hgu+vc8YA4iTT2lP4QkwRfq+f1FH+0jETo1VGmbXN1Op61gEW3zOuI1Y8J
         KYVw==
X-Gm-Message-State: AHQUAuYcBh6L6db+Jd906q+M1q0HSswF0HznWDuBbjnSznmCRyy+Zg2Z
        OeMwIkEGQgy2sywSpmUggDWD8q/0YN3/URnN2rN6Tg==
X-Google-Smtp-Source: AHgI3IYzjk7sMJji7Y7S3Nhqtgur/rxitLL8oQLyEzaHW8raU0cFAN3cEMzrCTy5viobvZUYD1wZLzuhLrOLUP5eW0w=
X-Received: by 2002:a02:6f4d:: with SMTP id b13mr10837675jae.57.1549628857291;
 Fri, 08 Feb 2019 04:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com> <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
In-Reply-To: <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Feb 2019 13:27:26 +0100
Message-ID: <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lut 2019 o 12:43 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 05/02/19 9:41 PM, Bartosz Golaszewski wrote:
> > pon., 4 lut 2019 o 22:49 David Lechner <david@lechnology.com> napisa=C5=
=82(a):
> >>
> >> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> >>> the irqchip drivers and moves them over to drivers/irqchip.
> >>>
> >>
> >> This has been on my todo list for years, but I've never had enough
> >> time to figure it out. Nice to see it finally getting done!
> >>
> >> Series tested on LEGO MINDSTORMS EV3 (da850-like). I can now use
> >> IIO triggers without having to patch the kernel to add extra
> >> interrupts.
> >>
> >> Tested-by: David Lechner <david@lechnology.com>
> >>
> >>
> >
> > Wow thanks for taking the time to review it!
> >
> > I'll address certain remarks - for those unaddressed - I'll fix them in=
 v2.
> >
> > Sekhar: are you fine with sending both the clocksource and interrupt
> > series together next time with additional patches on top making
> > davinci part of multi_v5_defconfig?
>
> I think its better to keep them separate. You can base both on latest
> mainline.
>
> Thanks,
> Sekhar

If you prefer I can keep them separate, although there were a couple
conflicts when I merged them in my tree, which are now resolved.

Let's maybe start with the interrupts (I'll send a v2 tonight if you
don't have any more comments), and once you have that in your tree, I
will rebase the timer code and then the multi_v5 series.

Bart
