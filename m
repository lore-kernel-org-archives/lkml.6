Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DC020657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMegr3pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfAQHeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:34:08 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39676 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfAQHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:34:07 -0500
Received: by mail-qt1-f176.google.com with SMTP id u47so10326618qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ano3SqWp66yQqzVhkZbAfrasrd5X2kMN23aTIxAq3CM=;
        b=TMegr3pYaXdx81LR6XxVFrIbI5ifRUEmbZCAYeRlGjujIgarNgJFKxDol6Pjnt2HOP
         F4RrcBZysUNcQ/glI71xmBLuQKMNlba4dpyTcRO0l4RZSKnC+GT8PPipj8+FyXxsC+zp
         MolGs26PMqFHNfHdj/0dB/9yuDFY90+yHnCBsT+I4MGzkUx7YZmjdmKZz/1eB6cEirTL
         I6p2EuXKN7D/F3mg1M+XAJZjLagVlf9n0W/aFcim5xiQprSZ1g5jbtGODuC1vWFILG17
         y1F9CUUI/i+3YmbXSUYtQinbamekrHa63Vmmq8NvEP6R8pV7rS7xPYBVUfZTAHI4AgxO
         i0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ano3SqWp66yQqzVhkZbAfrasrd5X2kMN23aTIxAq3CM=;
        b=ZKJYm8k6UgEZ9VkKtVTBJmZKfLwwFzX6AJtJOQ+hrXCCROcKpEQ6eJ6IEbtmxCCdH7
         JCSql3rgzeheBpz+yQaduuhEYh5jC0hDOC7OtboUBG99nGDtxj5tSG4gZreuqX2Gri2Q
         ETcbgNgCuAHuj3nYbj3WHR/hST0Sw/uymjeIldJ02K9E69FMQ0WLdUNTzBE5j+SDTTZt
         v59YD7dX2sx1eAynBqObo//gQMxHPIYKHn1cgTJ/01DsiNl9TlFFthDb6F8WOLu8/mxE
         N4LhSX5yanPlEyEMtQydP1K1pmrFzMzyTgHa0DTz14lfw3k21OLEA0nrFMUBtA4XFjCj
         j3gw==
X-Gm-Message-State: AJcUukd5UViLOdI5C9CaBHgFJRu2TlR5Eqqd7xuqNwmwDjWYaovi2dvJ
        d8XMrS7dSOfItWpH6gWf8kBaB+y4zEFprTWy7w8=
X-Google-Smtp-Source: ALg8bN7CcjbUOT9JfPfK6ExDSS2G14x2I37U9XIm4OLxumtEg7Db3z3Zj8OhRFR1nohxRPBbX0wzfR5+1zoiVz+AYDA=
X-Received: by 2002:a0c:9d41:: with SMTP id n1mr6720282qvf.212.1547710446182;
 Wed, 16 Jan 2019 23:34:06 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
 <20190116213425.GA16366@krava> <CAPhsuW6g9FOXvWA=9_Ab7Qo2B=DHraTPCT_ekmywF8soZz90=A@mail.gmail.com>
In-Reply-To: <CAPhsuW6g9FOXvWA=9_Ab7Qo2B=DHraTPCT_ekmywF8soZz90=A@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 16 Jan 2019 23:33:55 -0800
Message-ID: <CAPhsuW7AktPKcw6KG7kRm-5Jm_TnhdPczT_G8fP3c49jT0DqWQ@mail.gmail.com>
Subject: Re: perf segfault in in ordered_events__free()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 1:53 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> Thanks Jiri!
>
> On Wed, Jan 16, 2019 at 1:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Jan 16, 2019 at 10:57:49AM -0800, Song Liu wrote:
> > > Hi,
> > >
> > > We are debugging a segfault of perf in ordered_events__free().
> >
> > hi,
> > any backtrace or info on how to reproduce it?
>
> Here is the backtrace:
>
> #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
> #1  0x0000000000500196 in ordered_events.reinit ()
> #2  0x00000000004fe413 in perf_session.process_events ()
> #3  0x0000000000440431 in cmd_record ()
> #4  0x00000000004a439f in run_builtin ()
> #5  0x000000000042b3e5 in main ()"
>
> >
> > > Disassemble shows the segfault was caused by oe->buff == NULL
> > > in the following line:
> > >
> > >         /*
> > >          * Current buffer might not have all the events allocated
> > >          * yet, we need to free only allocated ones ...
> > >          */
> > >         list_del(&oe->buffer->list);
> > >
> > > After poking around the code, I suspect it is caused by the following
> > > condition in alloc_event():
> > >
> > >         } else if (oe->buffer) {
> > >                 new = &oe->buffer->event[oe->buffer_idx];
> > >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> > >                         oe->buffer = NULL;
> >
> >
> > argh.. yea, we need to check oe->buffer in ordered_events__free
> >
> > would attached change fix it for you?
>
> Let me try roll a fixed version to confirm.

Yes, the patch fixes this segfault. Please CC me on the official patch to
back port the official version.

Thanks,
Song
