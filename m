Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AECB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe8WAqsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AECB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeIKULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:11:45 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:35331 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIKULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:11:44 -0400
Received: by mail-yb1-f170.google.com with SMTP id o17-v6so9462710yba.2;
        Tue, 11 Sep 2018 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9WjvKjZHuVG0LZu3E2lqe/uvX/ZQt8RXccTeK9Yp2M=;
        b=Pe8WAqsa3FHzq1em01qvlNmMXAtILNyLQGV+MAWPIkHNICqZD6pdp0Rjy72OlnsdV8
         nBOpPiYm9eiRfu0PiNL6KtdnnS8F2tRxO713hmjwYlGFVcCmv/ARMh6ZwR9PwGFwPiCx
         qjB/hzUXn6mFjU50T0ZtKzv7c30gfqImax15A0WSqaKHgZ6DhXbXZpyd9h7pcT5jkHp7
         K3K4fREhPVps3OmKJrjnd8iyHQ/hhAIXZI1emWYi5wU8MsPz7AK4LfBOdyJfkNGNVGbC
         Zki6fjCGIhbTdW0zi2oeXgy4wp9PemFWBbuJCM0fjdODeLI5oetLkmECsuEOYnPo9n5k
         AHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9WjvKjZHuVG0LZu3E2lqe/uvX/ZQt8RXccTeK9Yp2M=;
        b=CWd5RadSgSaU9u8XSm/DHEv2SGh6LVGjqa40X3/36gw0iYoJeY5yhl7xAQv+cOe5KS
         GG3UfSWlE+LeaLoG7/ba3I6F1/uyp3pWhjDht8jSCtdQdw7KJzeRl8Uw6OW1vlpLnWVf
         MDRXwJ1uBM8BtkbrjvrB59gD1CUMHbr0e0U2OMySeQJxaASkyxxIP10p32442Gq6W1YY
         GtEzJ3R5DipTM7GGn55URAGJmkNXBv+t3CYDzVEZ/frbckglLt6J5Dx+grEP5VJF5Nvv
         1gObVyQgqoCzVf+QLc0ZbB6ysMfv7BAdKuySIB1lHCTA1zDjecLWS98MqPA98CM3RCAW
         xZiA==
X-Gm-Message-State: APzg51CeK7/3egV1R9Ol4P8UTe7kX3RxTvlDePV9FZ9CnresQ+dLdjMA
        J+Cw8k70ispCmwBmD/fuA7Tj8caYx1Jceva+6kw=
X-Google-Smtp-Source: ANB0VdbHK/pPtPzD+HwctEG+KqLeOZP1rVXR/BZDczCiKv4hQEq7jpmINRwyERv4w0bZDU3QIuJ2EvSUf0ywB5dG5SI=
X-Received: by 2002:a25:1a85:: with SMTP id a127-v6mr12847454yba.507.1536678719704;
 Tue, 11 Sep 2018 08:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Sep 2018 18:11:48 +0300
Message-ID: <CAOQ4uxiQ_Kb9H9z5nCJL0XJGO_2Dn2Z3KtGv2WZHkt-e+vkZ=w@mail.gmail.com>
Subject: Re: Is it possible to add pid and comm members to the event structure
 to increase the display of user and thread information?
To:     nixiaoming@huawei.com
Cc:     Eric Paris <eparis@parisplace.org>, Robert Love <rlove@rlove.org>,
        John McCutchan <john@johnmccutchan.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:51 AM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> Inotify api cannot display information about users and processes.
> That is, you can only know that the file event is generated, but you don't know who triggered the event, which is not conducive to fault location.
> Is it possible to add pid and comm members to the event structure to increase the display of user and thread information?
>

"Is it possible?" is not the only relevant question.
I suppose your patch can sort of works, but it exposes information to
potentially unpriveleged
processes, even exposes pid values outside of the process pid namespace.

While those issues could be addressed, you can't change the format
struct inotify_event
without breaking existing applications.

I guess you are not using fanotify API, which already provides pid
information (albiet tgid),
because it lacks other functionality that you need? Which
functionality might that be?
Is it directory modification events?
If so than you might be interested in my effort to add support for
those events to fanotify:
https://github.com/amir73il/fsnotify-utils/wiki/Super-block-root-watch

Your support, should you choose to offer it, could be in the form of
testing patches
and/or just by putting forward your use case as an example for the
need of an extended
fanotify API.

Thanks,
Amir.
