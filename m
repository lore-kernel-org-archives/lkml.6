Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68B92147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg35bS8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBGWVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:21:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35959 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGWVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:21:09 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so4105605itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKsBxsWR/J+240SiNiY4Qs+vDGzoY3yXotB7sDm4IHQ=;
        b=lg35bS8bFMbKIWDyeWpZkVVJZqHBr75afgnj1yduN6qko4DVFkIf+2bnkyb5chMlPh
         0lpT1j28PzZTHaSMeeghZV0anOec2y5Ka42TX1qCoahTXO3+NZ9jemwtRnS+4cIiHCAi
         69ck/lTCXv8jpUV8SY6TjHi2By3DREgzC1bnAS0aYnupsuO9Y3jKw4R1SeDQLp8wX7EF
         PaC3l6DSnkgrM111jFcbfciGwY8pVU4ygEDj20a65/p26uC3i0NMlzj7q85IeR14eIN2
         yjwVQyJ2bKdGI8ytHt8Yly4Nxu2MNEV6rgs+eitMYhlLfvWjq2n/Btwi/rrAURQw6iIZ
         4t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKsBxsWR/J+240SiNiY4Qs+vDGzoY3yXotB7sDm4IHQ=;
        b=eY8v39D8pwlaUN6gCM+HZnpiE+SI8pKeU+Lew0CsKdUoignYftarQfMIxOYSwVsI/d
         TlrIlOw5/LZgAIeUQkDTFIKrTl5R52eUdkdA3pA6XA9ahwQ77aw0svgoBfWhc0vA+xMu
         +ZjVdr7dpvLL79YDGUM5JpnBRSK09sj7jJPJ7+ROqwEiHmCi4lzfuwjmXbEsqm8rDICY
         l5Tw9dfl+aY6G67sDme4NaQli/NCNRGDFzO6c7Il7zzXXI6hEtN3vXaYtJYKseTRtW1Z
         FsEPdeqdj2bCy65bOT1MsLPWSZ4FzqPFkwR+R7AyEO10lVD+T6h+DIpY968nd0vKMbVv
         JBSw==
X-Gm-Message-State: AHQUAubm+5/tWPrSQhiwO+LljKJfZdCB5uMB4QGF9ARcXDg7iUVV0BtR
        VH7Yzh6REdCqBIXcN5yCcLjSsj69TNu2TZXAsAKw1zAq
X-Google-Smtp-Source: AHgI3IYmNJEvtQNMqfiexlpB1MCl1HZA+x7EmWFKCW628NIOX4m5FcxRRmRSWtVP2xwTF4+KdANXNqTvh8jkinkJiGo=
X-Received: by 2002:a02:1217:: with SMTP id i23mr10414278jad.53.1549578068064;
 Thu, 07 Feb 2019 14:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com> <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
In-Reply-To: <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 7 Feb 2019 14:20:56 -0800
Message-ID: <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Thu, Feb 7, 2019 at 1:49 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Tue, Feb 5, 2019 at 9:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Can a Coccinelle script get written to find module-use of the non-devm
> > work init?
>
> Ok so I hacked together a Coccinelle script to find these
> user-after-free issues,
> related to work left running when the device or module is removed.
>
> As far as I can see, these issues may crash/corrupt the kernel even on
> _device_ remove/unplug. Users don't need root for that...
>
> I got 71 hits. At least one is a false positive.
> 34 out of 71 could benefit from devm_init_work().
...
> ./drivers//input/serio/ps2-gpio.c:412:1-18: missing clean-up of
> INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)

OK, this seems to be a real issue. We need to make sure we flush the
TX work inside ps2_gpio_close().

> ./drivers//input/keyboard/matrix_keypad.c:512:1-18: missing clean-up
> of INIT_WORK/INIT_DELAYED_WORK initialized here

This is not as simple. The work in question is scheduled from
matrix_keypad_start() and matrix_keypad_stop() uses flush_work() to
make sure currently running instance completes after making sure that
it will not be rescheduled. And matrix_keypad_stop() is guaranteed to
be called by input core when input device is being unregistered if
input device was opened. So in effect we do not actually leak work
past driver remove().

Thanks.

-- 
Dmitry
