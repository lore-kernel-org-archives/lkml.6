Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5442084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce9xvy4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBHEac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:30:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43239 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfBHEab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:30:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so1815396lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 20:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQlvXhGfIkRC4TrgLnc6anTwFoSxifqTWXGE0OJN5TE=;
        b=ce9xvy4YlXHnUUUJ9XoNxrmZPs49Va18Z/7f5w/V6fXGwSDoliHSfe9i5MXWOkDiGo
         2VGlUpZMxO9wf2qpnvx5TlQ8mtyjMVa2FVleN+X34NaANM+ZTzSq62cWJ0LMIJs3NW/y
         /Kn2XFQdq0TdGFUP5cb0F8/wMW6jXS91Hi1TWpx1/Fbsc1drCHU15+apcxiDWPgQtsed
         M8ldYaiYjr8D2U/XocMEGYxB6qC5DfXBEXXX+XBUsyTOlMgr3TzBKvv9dJIhs6nAB5O1
         jJ3Uf1PX5q4pdKiHqM9LCYCCGQ/pNpLrUK1jJX49+eBfKaWsRgdcpArS4+x3ChB7iaLl
         /O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQlvXhGfIkRC4TrgLnc6anTwFoSxifqTWXGE0OJN5TE=;
        b=r+8l8KdURYUvG0I18aKInw4byDFSkVadiGyy7hzIswWGkixY1EOI3jLj8S4u8mfSig
         j/6V6xLYrSCBSwcBgfu+h2NKcKSWisndmJVSHS62E3oHjX1so0gayVr9UYinuNlb7Q53
         4JBsFWBZLKfLoxjD9wBwG9XWYUAObjY43B0pYv1GxST3/DnOlvvR6ZrkaWb9AMsSLfu3
         WRjgawXQ8ZyXS06XDCFhnYyipXRbt/hBEtmqurROFAyCneabQRRVWQcJzqlBVVbKb3CU
         9Lrsfb3rXCb0IYlR2YTlNZa8wthI4/DMpVkqL0f7pYGvnDndQCOqUeVmrscEHbvHbCsF
         JvZA==
X-Gm-Message-State: AHQUAuYd2ynPTZhbUOeQSXKs27IcHz5I7YXTG143BRywhpWeIgM2Poox
        SpzllkSSkcWIqMf6qQiQ31x7l9xOqRaEjGod0x0=
X-Google-Smtp-Source: AHgI3Ia3c2j7z77tzBwoC6+dCLQJxSQ5fCbLoINL4GDUS74WV22vLXycamUo9Wb81gIn3DMFpJuqjdWZY/K2Cmcbuns=
X-Received: by 2002:a2e:9681:: with SMTP id q1-v6mr12056316lji.182.1549600229559;
 Thu, 07 Feb 2019 20:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com> <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
In-Reply-To: <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Feb 2019 05:30:18 +0100
Message-ID: <CANiq72kw1=XhGhy8Ac2R9y3ws_jjo0YogoQ5D=tO+7oat=8swA@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 11:33 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 5:21 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > > ./drivers//input/keyboard/matrix_keypad.c:512:1-18: missing clean-up
> > > of INIT_WORK/INIT_DELAYED_WORK initialized here
> >
> > This is not as simple.
> >
>
> PS If you change
> flush_work(&keypad->work.work);
> to
> flush_delayed_work(&keypad->work);
>
> then the Coccinelle script works correctly, and does not flag
> this driver.

Similarly, in drivers/auxdisplay/ht16k33.c, the cancel_delayed_work()
is there, instead of cancel_delayed_work_sync(). Having the script
suggest this change would be useful, too (i.e. instead of the devm_
change, assuming the cancel_delayed_work() is already there).

Thanks!
Miguel
