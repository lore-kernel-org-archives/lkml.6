Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5BBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CE82177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zwcw3zfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfA1UOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:14:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46817 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1UOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:14:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so15383991ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/diQOGkXR8GMA0o3Y5WRWapwL2ejQb39B0HrHbulmo=;
        b=Zwcw3zfkxXXHlAMJBtSSPW7o9+sdXTpbHPFcTndePKBBt8G144PQA9b2V/pa0HTGFs
         Q4s3SjTdEZFd46XyJttSZZO4LFDE2+xRcUgOXs3b3R+DDS4HAamVgGtYic0oc0SwiBms
         FwtSE5YyOKkQn3Ffi9GGVtP7RQajqUIhxvTvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/diQOGkXR8GMA0o3Y5WRWapwL2ejQb39B0HrHbulmo=;
        b=NqbArfLU1qfftL7o0PB816SIUn7bjkIFKel1Q23uGH4/9lYE5KBRVtldbVXsuGdJRe
         UruHQNuKHmkdVc/NhU5wYEBdBgong9P57V4ndtcFClWTr1MG+WaNAmWQKlyHQoq/MRGp
         W4LDZ1UBysAi2qz2akiXegaPkowhyZa0Rb6Iey/q/yNZnEHET2SDqlOBg03G5SdCi0vw
         C60dMhtU6IAJIyQh0mDhwwrBA/4CqFBrulDMWXzoha/dxuksS5H0gzNHlbn6UUEIo59w
         ia9sRmeURIE3nkNLO7qXb5McON1YBwj88rOExzOTh2zTDNU33O+FkSPnatlcASngR/CB
         a9RA==
X-Gm-Message-State: AJcUukfAhfFGn6SRthL2L98Fh7FVE33YTP+T61TeUiUz6PPTEmZAAJFU
        uDeRGrNPoCs7MS7nKhTG6UFtjgfT+r8=
X-Google-Smtp-Source: ALg8bN4lWzQZfGhs+1aYebmLIQ/kFD/EZgHnkA/+qlPmOHrhH/1rV+ezmreWXwc3XG/T7vvVGbKLrA==
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr19688000lje.105.1548706456561;
        Mon, 28 Jan 2019 12:14:16 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c133sm3453680lfc.45.2019.01.28.12.14.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 12:14:15 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id f5so12826119lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:14:15 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr17296800lfa.1.1548706455149;
 Mon, 28 Jan 2019 12:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de> <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de> <20190110163030.GB19693@kroah.com>
 <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de> <20190128082313.GA15182@kroah.com>
 <dedfa895-ae7e-9a64-9e89-055ca85cf2e3@pengutronix.de> <CAHk-=wjOMvFBxmBSBZPZEwSyU96L5V8Qhi6bXLqzV4Sdsb2HAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjOMvFBxmBSBZPZEwSyU96L5V8Qhi6bXLqzV4Sdsb2HAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jan 2019 12:13:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe72pccEAdQsp+UpjzKxXzsHbkiyaXbhG1UHnNg6uw1g@mail.gmail.com>
Message-ID: <CAHk-=whe72pccEAdQsp+UpjzKxXzsHbkiyaXbhG1UHnNg6uw1g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for tty_buffer_worker
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That's harder to do for reads - because incoming characters happen in
> interrupt context, but shouldn't be all that hard to do for writes.

Side note: the reason I mention this part is that "harder" may not
mean "impossible".

In particular, I wonder if we could do the tty buffer flipping in the
reader context too. Currently, what happens is that when we receive
characters, we schedule things for flipping with the workqueues. *BUT*
we could also just wake up any pending readers directly, and maybe
have the *readers* do the flip if they wake up before the workqueue.

And that would allow you to do real-time serial work simply by marking
the process *you* care about as RT, and not worry so much about the
workqueue threads at all. The workqueue threads would be fallbacks for
when there isn't an active reader at all.

I dunno. A bit handwavy, I know, but it sounds like if you care about
the read latency, that would be a better model entirely (skipping the
technically unnecessary kernel workqueue entirely).

              Linus
