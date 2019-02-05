Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A5A20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX2WI5B7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfBEPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:23:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36587 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfBEPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:23:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so6297487otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHvrpSBtrE0fka2owfLPmjsKj68frWtOpkzmFj2aAJc=;
        b=CX2WI5B7R1tFq8HgCn67HEoiwkURvV7Umg9NoWZb/A0fLsGrJV/Sv/cT01T8IVU6Su
         ro20m6i/XORZwUOdXfkpExaygQU63o/RqmotZuQaHvcuVEZNZ4+fCNRREYrWDnrbg0/r
         8C8gfaIC+4diRDPd0yD3ooRDeofIDlW6inL+bgGmumkHzYQKgLgUJ1+vZh3AyTCAvPcq
         4xxInuNn9ygFsNsLR9AEPABSs4wweRAhFYt2af7AXpiAKWeKFocLJhrRCvjqPexmeEYD
         nFnQ6zwyv5M6G7VthpFzcModOhaGSbemL0/+VYzENgFb7/KgCkyIntEKXIwtn76WnAfU
         hsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHvrpSBtrE0fka2owfLPmjsKj68frWtOpkzmFj2aAJc=;
        b=tkAhx+4xYCm46MQ75WNiyWRjEbMZ6j7LG6/K7FOEmeehseUg2oVLzobifmLvZQnKF7
         iqLzsHHrGp4+FC5juO5nBR9G3AWc8EjN4vjowmK7nEeXQEfRYcN4fzyFqIrns/X1r1wc
         p6WA7VdAP2ZfJpdUoQNL4sGo8aVFI4JfpzTHaEW5+dRl1heLlDrdn80usdeWe2Gn8KeQ
         5vSZrZzl5HKY/Qmu50r/JfFqtcPXiwrgAPNwoPo35TIMR+VBLZDSawByCkYbbYhdenzy
         pZCEMq8VcRw4zO6KHZ/AHGj3L5EmV02/jcX7mkzGFgGflVpC3yUjLFdBqP0jegc8T/+B
         i+sw==
X-Gm-Message-State: AHQUAubcjdYsGe8MplVNZaMjY/SgcoXqkRErwhcllKeJAq4yZZZAAQzs
        dOoztQmnv3z1XmOmyOkdsg1yfw+H4UKgUDxztmc=
X-Google-Smtp-Source: AHgI3IZwDI5k7RRWmLZgsItRkwAtLJpFsnB92sbhucXcE5zxD6kwFsqNsZ/M83dShe1QiQEsTzICeiXfEd79vNQr5/c=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr3119816otp.225.1549380181709;
 Tue, 05 Feb 2019 07:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com> <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 5 Feb 2019 10:22:50 -0500
Message-ID: <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 9:57 AM Kees Cook <keescook@chromium.org> wrote:
>
>
> Can a Coccinelle script get written to find module-use of the non-devm
> work init?

My thoughts exactly ! But sadly I'm not a Coccinelle expert. I did
look briefly at
its syntax, but I didn't immediately "get" how Cocci could find this class of
errors, without a huge false positive rate (which would make it worse than
useless).

>
> It seems like finding these in __init functions should be relatively
> easy? (Or can we add runtime detection in the existing INIT_*WORK()
> code to see if it is running from the wrong place?)
>

IMHO the problem isn't that they're called from __init functions.
Also, nothing is
wrong with the location of INIT_*WORK per se.

The real problem is that developers overlook calling cancel_work_sync()
on unload. I'm not sure how we could bolt on runtime detection to catch
a *missing* function. Again, without causing tons of false positives.
