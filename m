Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58530C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 05:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3D021915
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 05:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYOmv5MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfAFFfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 00:35:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44198 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfAFFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 00:35:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so35278627otl.11;
        Sat, 05 Jan 2019 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMoH4IMoO0yo4/DlJkL0IE97j11aqVlT4UtfkRdQ0tQ=;
        b=ZYOmv5MKL6qpaIiy3sIEoE4Wtniy2D2HpUAYpu8CF7PordNLEnWSWuVvUXPuleT9ks
         94tVWB0Sy+kG7MPzLe8fvM4LCD540IcQl2Fn526//DyWNpGX3Ko8kh9nodu9ffWvZ4Bw
         5+b/eL+8eJOD7YE3yoNQPy+FFjbC9EkspFd86e7AvrsCbVVdtcKayrr6RfrkxKRCmfC5
         MRu8Gfohb0SpK+EAPlG+VIPKVXtJ47hSB6zZdOrTp+TspiN+DNFtI6O3YpWXTG58OKOe
         7KVr6LDn10shLYcW1yO9WKQtnri2g0OjKWw8GfDjlFvM0xVe936IxDtAh6EaanDElL4F
         KWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMoH4IMoO0yo4/DlJkL0IE97j11aqVlT4UtfkRdQ0tQ=;
        b=ILvhmtHcz6iPbER+YBXRYN/1PS6w1IPQhfb1zXduczppkQpyc3okBzIHI1FnwI728F
         LcegR1jXaFNNiv/UdTNZaUIfuyL7F9ZORQoUEwCjUxarxRnxGlqUXV/UYo3JNYMV4TUr
         LTFDX/TCazt0OgsRHV2OZj6H5lkZvHX3NrgdxqYc5oHVud7bfIJnikeaFFFiwgU+0WmX
         mWeMT7fHGv5qY6WqqX5L+m4pP4lnjoZViMWybdauA25cfVEWVGavkXmWajhXVKOCseFC
         RqWJUIk23jK68viDBT9scLqmSH/Mg0kiMe0JUuS+KUTm/y/0F9G0uGI9J1kGr/U8ISPG
         ZWgA==
X-Gm-Message-State: AJcUukcW9sqWgqaBF1XKeY7wdTvwi++v/df8ZDaE1BSGj1TNV9tI6Omk
        5ibo7cCzep1nTVNdV5V8/Ht3kiMF6Fnr7wtfDfQ=
X-Google-Smtp-Source: ALg8bN5OzhNxApWKVbXIn/qlWcdgmvubNtiJdNnSRZCxSG4PhgBMIpI/gmtSkzJbjFOqYFYreel+UdvBxPf4WGM6FRQ=
X-Received: by 2002:a9d:2067:: with SMTP id n94mr40809846ota.53.1546752903192;
 Sat, 05 Jan 2019 21:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20181230163143.21030-1-ap420073@gmail.com> <20190105.141021.1299321405902891635.davem@davemloft.net>
In-Reply-To: <20190105.141021.1299321405902891635.davem@davemloft.net>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Sun, 6 Jan 2019 14:34:52 +0900
Message-ID: <CAMArcTUGujArU1L8L=n32yKbT+MwuUEm6S8C=am_EGQ5GG3jQA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] umh: add exit routine for UMH process
To:     David Miller <davem@davemloft.net>
Cc:     Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2019 at 07:10, David Miller <davem@davemloft.net> wrote:
>
> From: Taehee Yoo <ap420073@gmail.com>
> Date: Mon, 31 Dec 2018 01:31:43 +0900
>
> > +void exit_umh(struct task_struct *tsk)
> > +{
> > +     struct umh_info *info;
> > +     pid_t pid = tsk->pid;
> > +
> > +     mutex_lock(&umh_list_lock);
> > +     list_for_each_entry(info, &umh_list, list) {
>

Thank you for review!

> So this is probably too expensive of a cost for every process exit.
> The problem is that the cost will be taken even if the process is
> not a UMH.
>

Yes, I agree with you.

> I've taken my time to respond in hopes that I could come up with a
> good alternative to suggest, but so far I don't have any better ideas.
>
> I'll keep thinking about this some more, please let me know if you
> have any ideas.

Thanks a lot for spending time to think about better ideas!
How about adding a new PF_UMH flag for task_struct->flags to identify
UMH process?
By using this flag, the exit_umh() can avoid unnecessary lookups.

Thanks again.
