Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64721C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213B720833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1fMxMIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213B720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI0AJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:09:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39614 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeI0AJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:09:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85-v6so11256241pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIjGo9D8cQQkqd2ZBabMqBzozyT8+tLjrlNyFZs/Yak=;
        b=Z1fMxMIRZJUT0WZ7V9AVnFIYzxiDnBfcAZs6lrCkyMZ7E/ihwbF17poJhmypju2T6Y
         i6p5asfnknCDNOZiLynEH6r51+JWZ2/6s828xTT/auOqODPA1Z15pvDPjPuu78YPZtkz
         VmjODcM6d5HHqtnZLzuMsvbLO5OecUGHjciLSJ+Qb7l5sGqXed+vQOuDueB8YakX5lMh
         6g5BM02bJVBAeWfdS9Vn5ZU5+0KEtwPItgtxYexgORU4jpvuwBBzwNB7XEHLm76Q0v8k
         30Ds+t0TKjLBIPu8YSq7r4jemUrzaMvqdVObXZW6THQA7zEiiz45VkfT0sNK6EBTQLL5
         O3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIjGo9D8cQQkqd2ZBabMqBzozyT8+tLjrlNyFZs/Yak=;
        b=N9Xg12YBRxN6kfDQRn3amSvuX7OIxTEcGlzLRJYp2UosiNahKaRsVtyIUwyWYAyGDR
         VD41XEljD12F9Vw19g4nh2oEWpAe6KtnZLuw19jWXtDrNI3qR2K0i6jSudZQEx3fYsVU
         MzbrgmptfqCKF00XL+i8bh+kT1gnOYAhlEa+T50AAQ9PYDEyXYD0LHbVXrpGP9q6gKm3
         033zFrS8UvbbAqSPQ6YUSGvIA3EFwAOc/CurJnDvy3B3Zq01M3Flf8s+9Zk1Fv3pMEIe
         +ccfWmqTGI+hh2KbpmIbrF5yZF9tdntb/PCbNHQ6jkNZ7d39VKTAsWdYCGMiyBtvRQwV
         /ldg==
X-Gm-Message-State: ABuFfoi33vC3qWF7CQdhkzPWYyXcj+MJN0tg0ANuvf6MsJI6gNBmvXyu
        n/ym8V6owLSH0mWJmseJJzvZRMGjertrNSzzPZY2IKfVV+c=
X-Google-Smtp-Source: ACcGV63UqbEVYMUlWiOL3lfcrCODHaWZP53CG8Hmg04ZgZZ2OD2dyzXPmnXD120tNi9LvpEYoFx8t3S3xtCKeJesebE=
X-Received: by 2002:a63:214f:: with SMTP id s15-v6mr6702304pgm.202.1537984519594;
 Wed, 26 Sep 2018 10:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180926070208.16924-1-natechancellor@gmail.com>
 <20180926071359.GA22855@kroah.com> <20180926074114.GA4966@flashbox>
In-Reply-To: <20180926074114.GA4966@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Sep 2018 10:55:07 -0700
Message-ID: <CAKwvOdkkaCAmizfOr8Bj8QLTN161KqwXRCbuKbiNDoo5RonrpQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe unused
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:41 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 09:13:59AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> > > Clang emits the following warning:
> > >
> > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > 'acpi_ids' is not needed and will not be emitted
> > > [-Wunneeded-internal-declaration]
> > > static const struct acpi_device_id acpi_ids[] = {
> > >                                    ^
> > > 1 warning generated.
> > >
> > > Mark the declaration as maybe unused like a few other instances of this
> > > construct in the kernel.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > index 6d02904de63f..3285bf36291b 100644
> > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > >     { SDIO_DEVICE(0x024c, 0xb723), },
> > >     { /* end: all zeroes */                         },
> > >  };
> > > -static const struct acpi_device_id acpi_ids[] = {
> > > +static const struct acpi_device_id acpi_ids[] __maybe_unused = {
> >
> > But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
> > macro does a functional thing.  Why is gcc not reporting an issue with
> > this and clang is?

Looks like GCC and Clang handle __attribute__((alias)) differently
when optimizations are enabled.  Clang has
-Wunneeded-internal-declaration (GCC doesn't have that specific flag,
which is why GCC doesn't report, but its behavior is also different),
as part of -Wall, which warns that it thinks the static var is dead,
then removes it from -O1 and up.

https://godbolt.org/z/Dpxnbp

I consider this a bug in Clang: https://bugs.llvm.org/show_bug.cgi?id=39088

As Nathan notes in this comment in V1:
https://lore.kernel.org/lkml/20180926064437.GA29417@flashbox/ having
additional references to the static array is enough to keep it around.
When there are no other references, then it should not be marked
static, in order to still be emitted.

We can work around this by removing `static` from struct definitions
that no other references than being passed to the MODULE_DEVICE_TABLE
macro.  GCC and Clang will then both emit references to both
identifiers.
-- 
Thanks,
~Nick Desaulniers
