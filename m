Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A557C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D88218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1kXd5sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfAaQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:48:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39724 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfAaQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:48:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so2836342lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDyoiwVc/P+rQmgfPZ1EgOlBwwk20/Av0h+b00jThzQ=;
        b=a1kXd5sF/S2dw9DINureYZcHAhcRK0LmDTcMJQj8tOOZX0QGkb+ZBp77C/7yujiO2V
         KA9xj4oke69RHY4emMH6P5bASOIP+VowOWLY3SlZCT+C8caGRPdWdNsRR2tpCSBOS3/v
         jsPfm0+6p7eQB8zkI0HG8A+zmfK29sXfcwYeSBg94pAYP/4Ga67+2PzWDxkUsE3uEwzM
         UpJWtbkiAjXdj/IpR5NI5nyXJrEI10ogYhUW1bOJke3Gu+N/uod0iLXa7RYYmGCVmliz
         ziPQwCcCxn5LbckxdFIzvh3prHYu8Gk8BScqhl5102/2S3q71mLYmeDyRA3nhbbxD2oL
         iVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDyoiwVc/P+rQmgfPZ1EgOlBwwk20/Av0h+b00jThzQ=;
        b=NkGSTZVYHHOJ3zBoT75rTmj6qr24VIwwTJyfTGVNzMNiJjE2LxM/j7EJ/EIgVZ1JOu
         vBQ3ESx/eCXjwIRqjDuhiLgLDPcV4w6frn0IbS1kyvB9LIa6E3WurN3KearsBfucmeV2
         7+zlsePfTNrK4P79bOPcZ8gszOY5jxeGAUnGNWiMtIek5JtRHOea2GdjMlQUnQIFLu4E
         ofwBOyvgzwFNHfcIlf8fUqyumxP+G9DaXM2I0JbeFaKcBfM513lXY6JTaQ1ZG8IDcrar
         U3wVu2OMkj2CQfdzsDuFqa034CmT0x/Xykio+5l2RhIuej7p1LBfiASWu/pK3EiSjRqa
         Mq9w==
X-Gm-Message-State: AJcUukfHBvZh26A88NUDZDZ+XxDltQ83EoZxJhtkYf2w5emgCjaw/jFT
        nCkcF96fCmD26Cy/qnrwUXj6bIZ2g5oWJWf4Ubg=
X-Google-Smtp-Source: ALg8bN7Qp0TNPfUOYg0+3dVb6C8FMNwpmLQplTDCE68BMEPHedlDD1p8jMXBOR+gGs42DR2r1TbiLqBGXsQgW9LoeeY=
X-Received: by 2002:a19:6514:: with SMTP id z20mr19842443lfb.31.1548953305068;
 Thu, 31 Jan 2019 08:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20190123173707.GA16603@gmail.com> <20190131142221.GA26303@linux-8ccs>
In-Reply-To: <20190131142221.GA26303@linux-8ccs>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 31 Jan 2019 17:48:13 +0100
Message-ID: <CANiq72m8VuD_dsA+=0q88FRJgVnnSS1pt1SAFf9upGS7RFjT_g@mail.gmail.com>
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Thu, Jan 31, 2019 at 3:22 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> Hi Miguel, sorry for the delay!

No worries! :)

> The module init functions are only called once from do_init_module().
> Does the __cold attribute just assume it is unlikely to be executed,
> or just that it is infrequently called (which would be true for the
> module init functions since they're just called once)?

That was exactly my concern :-) Martin can provide way better details
than me, but as far as I understand it, it is the paths that end up
calling __cold functions that are treated as unlikely to happen. For
instance, if f() has a few branches and calls a cold g() in one of
them, that branch is understood to be rarely executed and f() will be
laid out assuming the other branches are more likely.

Then there is the other aspect of __cold, in the definition of the
function. There, it affects how it is compiled and where it is placed,
etc.

Therefore, I assume the current situation is the correct one: we want
to callers to *not* see __cold, but we want the init function to be
compiled as __cold.

Now, the alias is not seen by other TUs (i.e. they only see the extern
declaration), so it does not matter whether the alias is cold or not
(except for the warning), as far as I understand.

> In any case, module init functions are normally annotated with __init,
> so they get the __cold attribute anyway. I'm wondering why not just
> annotate the alias with __init instead, instead of cherry picking
> attributes to silence the warnings? That way the alias and the actual
> module init function would always have the same declaration/attributes.
> Would this work to silence the warnings or am I missing something?

We could do indeed do that too (Martin actually proposed a solution
with the new copy attribute, which would do something like that).

I chose to only add __cold to avoid any problems derived from the rest
of the attributes, since I don't know how they behave or what are the
implications (if any) of putting them into the alias (and not into the
extern declaration).

Cheers,
Miguel
