Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A6D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTPGcSq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A6D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJICd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:33:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJICd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:33:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so15110721ljc.12;
        Mon, 08 Oct 2018 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKYRvDd9F/SwT6JdPyd4EbqZoJqKFEVGuZyJt32Lcx0=;
        b=GTPGcSq4+PIXTW2Rstq0qo0I+RodTO7O2rmEBaPZkl5zFQhFeDzdNZf/z5PoQx1BsA
         j3+eLma0g8fqwGxjQKbdLr+9XEiqjh0IaVW3Gfa5RE3PHiMVoV1C4735P1dZfQ5TOe8L
         lD6KcmMzSUZoaxELKeB9J92Smxd0rgFC9Je/QLeCk6pOAzXJ7K0FIwFkzMT9HVXFhXZx
         9NyS9NE9fPehudXuJh8J5Pt7/F9HXtjA81yqGGPHbb0wJsYgH9ZXF5DImur9UUZsprRU
         YIQY+aQGc6mMgHaS/NNBjwt13oA5YT/J7wRKPtnkee22UPm0GpBwofz3XR+OJaVZ5rQR
         eaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKYRvDd9F/SwT6JdPyd4EbqZoJqKFEVGuZyJt32Lcx0=;
        b=HM6Rc602mgBX6uydSl+5ViVqml/OUS+N5G+TLkUGyf9yji19cmWP4J1yK05rhKrxBb
         IIc0TWsofikeeiTxqUiId1mEEkzokSZvlSNceXXqDF7xqpTw0Af1fRB2vhwSfdabOmB/
         r0y7j84jr3BbeUbOAycT+7fVtiEE0kmppRqYa1Q1Od5bTNCIcs97jJaYEb0zHp6fY05s
         N+zKgM/V0g/QsOgfHzVu7xljQQsw2b6DmuFo3P17Sqt38lajmrBi8E9m0VkP+rEc2A7j
         Q8i805hgs6Bvt/E3GrEN3F7uRCUV8hbjP1IqUPNVm3tzzTV3/HlHlI8wvX6srgK4YxPK
         wMeQ==
X-Gm-Message-State: ABuFfohas55Ed2VZCcIlrURnAe6B+WYMNvEfQ/hvo7x67XssJY0n0jPP
        QukIncxv8edD4jFujy+MY7+6cqFzBFF0s7Mh2IE=
X-Google-Smtp-Source: ACcGV63qgCyfrrHchayBXmTjN7xkhpUxOtiXEmuHa0w3+7DhKecNj43IV4dEDSercq65UnoBBqkMtaCQ2ltAmuFodn0=
X-Received: by 2002:a2e:5317:: with SMTP id h23-v6mr14908760ljb.26.1539026437828;
 Mon, 08 Oct 2018 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181008152523.70705-1-sashal@kernel.org> <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com> <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
In-Reply-To: <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 8 Oct 2018 12:20:26 -0700
Message-ID: <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock behaviour
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     sashal@kernel.org, "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Dmitry,
>
> someone on debian-68k reported the bug, which (to me) indicates that the
> code is not just used by me.
>
> Whether or not a functioning Capslock is essential to have? You be the
> judge of that. If you are OK with applying the keymap patch, why not
> this one?

I have exactly the same concerns about the keymap patch. This all has
not been working correctly for many many years (and it was not broken
in a subtly way as far as I understand, but rather quite obvious).
Thus I do not understand why this belongs to stable release. It is not
a [recent] regression, nor secutiry bug, nor even enabling of new
hardware, that is why I myself did not mark it as stable.

I still maintain that we pick up for stable too many patches for no
clear benefit. This is similar to the patch for Atmel controllers that
was picked to stable and I asked why, as it is not clear how many
users might be affected (or if the problem the patch was solving was
purely theoretical, or only affecting hardware that is not in
circulation yet).

>
> Debian will carry stable patches without explicit action on behalf of
> the maintainer. Unstable patches are a little harder to get accepted.
>
> Cheers,
>
>      Michael
>
>
>
> On 09/10/18 06:11, Dmitry Torokhov wrote:
> > On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
> >> From: Michael Schmitz <schmitzmic@gmail.com>
> >>
> >> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
> >>
> >> The CapsLock key on Atari keyboards is not a toggle, it does send the
> >> normal make and break scancodes.
> >>
> >> Drop the CapsLock toggle handling code, which did cause the CapsLock
> >> key to merely act as a Shift key.
> > This has been broken for 10+ years. Does it really make sense to
> > promote it to stable?
> >
> >> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> >> ---
> >>   drivers/input/keyboard/atakbd.c | 10 ++--------
> >>   1 file changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> >> index 524a72bee55a..fdeda0b0fbd6 100644
> >> --- a/drivers/input/keyboard/atakbd.c
> >> +++ b/drivers/input/keyboard/atakbd.c
> >> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
> >>
> >>                  scancode = atakbd_keycode[scancode];
> >>
> >> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
> >> -                       input_report_key(atakbd_dev, scancode, 1);
> >> -                       input_report_key(atakbd_dev, scancode, 0);
> >> -                       input_sync(atakbd_dev);
> >> -               } else {
> >> -                       input_report_key(atakbd_dev, scancode, down);
> >> -                       input_sync(atakbd_dev);
> >> -               }
> >> +               input_report_key(atakbd_dev, scancode, down);
> >> +               input_sync(atakbd_dev);
> >>          } else                          /* scancodes >= 0xf3 are mouse data, most likely */
> >>                  printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
> >>
> >> --
> >> 2.17.1
> >>
> >
>

Thanks.

-- 
Dmitry
