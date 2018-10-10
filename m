Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46883C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0832085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0832085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJJOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:20:18 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37300 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:20:18 -0400
Received: by mail-vs1-f67.google.com with SMTP id r83so4031816vsc.4;
        Tue, 09 Oct 2018 23:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zE6d/ym5PYH/o9qmLXC8QXhv4nybaWA3CGc/ZLfopg=;
        b=ScM+52E9l//BLJaeLSQpUuzV5dGV1stxO9AzUpBEqFElpCVfVlAgR8kiQL3jWspDQk
         3cP+FB9D85SaPs+Bg3jaeajSPKXVDi6zYLpRVfF9YZGu2enMT1MUN+rf3aw44EhUNivQ
         wBqPIfBG13nYSWOdzC8TFp8GjBhqKObtWMBm75LFA2+HP7GLB7320IEnwHwCYZtlN2sZ
         B6GDgbhZsignxBkSPzaOU0uIxVG0pkOTZHFprj/wd6y0IVZ95p6wwNv1/2aAV7xHhIQq
         Jby7RkH+pVxKQSo9ZoYbnbvJ0ZMxBJE0qQOx7fA7Z9cYAmIREyfeKjwGmynsdxOQErFN
         HQ1Q==
X-Gm-Message-State: ABuFfohhzfITH4qBoKTcjF0Ik7CBQ7v53SYff+tskCGJAt1TuAJbSEHY
        Ft7avfIPxjOacoMT40EaflY8BMCQxCB3X45ZIKs=
X-Google-Smtp-Source: ACcGV62XJA6YYqPoinJ2zjDzpp543NPQ+JyjST+85FM2IF0YOineBdU1ybSXU1pH3uB2SR6pv0atDbHG1+YNwJpNCxU=
X-Received: by 2002:a9f:30cb:: with SMTP id k11-v6mr3973553uab.28.1539154772843;
 Tue, 09 Oct 2018 23:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181008152523.70705-1-sashal@kernel.org> <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com> <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <1cbc87c6-7920-1f53-879b-79de87d685fc@gmail.com>
In-Reply-To: <1cbc87c6-7920-1f53-879b-79de87d685fc@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Oct 2018 08:59:20 +0200
Message-ID: <CAMuHMdUiAVamY--BMBFprEwdXn1Dyv9sERwMXB7x7F9omiEXkA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock behaviour
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Oct 10, 2018 at 12:07 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> I agree the bug is neither subtle nor recent, not security relevant and
> will affect only a handful of users at best.
>
> If you're worried about weakening the rules around stable releases, by
> all means go ahead and veto the inclusion of these patches in the next
> stable release.

I believe the distro the issue was reported against (Debian ports) will not
get the fix until the issue is fixed in the upstream stable release?

> On 09/10/18 08:20, Dmitry Torokhov wrote:
> > On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> someone on debian-68k reported the bug, which (to me) indicates that the
> >> code is not just used by me.
> >>
> >> Whether or not a functioning Capslock is essential to have? You be the
> >> judge of that. If you are OK with applying the keymap patch, why not
> >> this one?
> > I have exactly the same concerns about the keymap patch. This all has
> > not been working correctly for many many years (and it was not broken
> > in a subtly way as far as I understand, but rather quite obvious).
> > Thus I do not understand why this belongs to stable release. It is not
> > a [recent] regression, nor secutiry bug, nor even enabling of new
> > hardware, that is why I myself did not mark it as stable.
> >
> > I still maintain that we pick up for stable too many patches for no
> > clear benefit. This is similar to the patch for Atmel controllers that
> > was picked to stable and I asked why, as it is not clear how many
> > users might be affected (or if the problem the patch was solving was
> > purely theoretical, or only affecting hardware that is not in
> > circulation yet).
> >
> >> Debian will carry stable patches without explicit action on behalf of
> >> the maintainer. Unstable patches are a little harder to get accepted.
> >>
> >> On 09/10/18 06:11, Dmitry Torokhov wrote:
> >>> On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
> >>>> From: Michael Schmitz <schmitzmic@gmail.com>
> >>>>
> >>>> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
> >>>>
> >>>> The CapsLock key on Atari keyboards is not a toggle, it does send the
> >>>> normal make and break scancodes.
> >>>>
> >>>> Drop the CapsLock toggle handling code, which did cause the CapsLock
> >>>> key to merely act as a Shift key.
> >>> This has been broken for 10+ years. Does it really make sense to
> >>> promote it to stable?
> >>>
> >>>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> >>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >>>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> >>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> >>>> ---
> >>>>    drivers/input/keyboard/atakbd.c | 10 ++--------
> >>>>    1 file changed, 2 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> >>>> index 524a72bee55a..fdeda0b0fbd6 100644
> >>>> --- a/drivers/input/keyboard/atakbd.c
> >>>> +++ b/drivers/input/keyboard/atakbd.c
> >>>> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
> >>>>
> >>>>                   scancode = atakbd_keycode[scancode];
> >>>>
> >>>> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
> >>>> -                       input_report_key(atakbd_dev, scancode, 1);
> >>>> -                       input_report_key(atakbd_dev, scancode, 0);
> >>>> -                       input_sync(atakbd_dev);
> >>>> -               } else {
> >>>> -                       input_report_key(atakbd_dev, scancode, down);
> >>>> -                       input_sync(atakbd_dev);
> >>>> -               }
> >>>> +               input_report_key(atakbd_dev, scancode, down);
> >>>> +               input_sync(atakbd_dev);
> >>>>           } else                          /* scancodes >= 0xf3 are mouse data, most likely */
> >>>>                   printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
> >>>>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
