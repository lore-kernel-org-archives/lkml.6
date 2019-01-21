Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51349C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQExef8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfAUVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:34:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40251 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAUVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:34:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so18751821lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+WR6rqAsLY69fD2RIr7nPQbgUQg3CjnO+p2nEngDOk=;
        b=TQExef8BYuFuhUIec2v8/tK/ThxEecByouWzOklfmVJDiYgFEEKGLzjB9hbWTxFtL4
         JY+mT0Ej2EuK6JP8jCTn2BxG5zTFTZ0wWcCanAy/+ruFYiij/zRVq2EnkR1uLfo7NN95
         zmop9OoFXTVgtt6R+mqm51INMBS6gfKeItd2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+WR6rqAsLY69fD2RIr7nPQbgUQg3CjnO+p2nEngDOk=;
        b=ErbNwv+V8nREKePfyUH5noamCuCq5YXf9s5wCIbfqslYsSHAaqMEI72OiHix5hETpo
         Iu69Fds5oZdSX3UCNWywziXEY5XBAdsi9b/evLjfm5QjYvQvBpo+mLa/Dcb9bECs4jmE
         HG127C8RM4pQqUp3FdzFrPKnErRqL5MTLSD6iS+vGIMlKsK4x7DcuYAu70qRy710KYv6
         mTgt+yZOYWuC3LVRsxHlo4VlQ68qtK8OD0DRcc3bsrsjh+AOmBdko2uxPqNkLzCtxpjC
         eckR9x76paoeQSx90caqrqouLBOVOiPXK+UGY38zLV6S9G1kKHZwKCS9VJBwWhLWV2A5
         S4sg==
X-Gm-Message-State: AJcUukf4UYtNDLpcBpXBRspyoAPgY5UTLeqWK3DG9DF2TVtywu24uSst
        A1PzpMSezJ4/77k9MrmlGaiJnkF3SEjyNg==
X-Google-Smtp-Source: ALg8bN59EdElYl6uw2ccunYcGLVxaHgdrOdFzlE4Q9Dl3H0H+dFZFGZuxUyRUgMmFActJ73ekZ7plw==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr18302970lje.117.1548106465316;
        Mon, 21 Jan 2019 13:34:25 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n8-v6sm2705251lji.90.2019.01.21.13.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 13:34:23 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g11-v6so18769076ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:34:23 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr17001678ljj.120.1548106463124;
 Mon, 21 Jan 2019 13:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20190121201456.28338-1-rpenyaev@suse.de> <20190121201456.28338-3-rpenyaev@suse.de>
In-Reply-To: <20190121201456.28338-3-rpenyaev@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jan 2019 10:34:06 +1300
X-Gmail-Original-Message-ID: <CAHk-=wh16im2u1fHcZgMa-Z19Ri=UD2aY+r9=1rO4hginjcnBQ@mail.gmail.com>
Message-ID: <CAHk-=wh16im2u1fHcZgMa-Z19Ri=UD2aY+r9=1rO4hginjcnBQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] epoll: introduce user structures for polling
 from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm not entirely convinced, but I guess actual numbers and users
might convince me otherwise.

However, a quick comment:

On Tue, Jan 22, 2019 at 9:15 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> +struct epoll_uitem {
> +       __poll_t ready_events;
> +       struct epoll_event event;
> +};

This really ends up being a horrible data structure.

struct epoll_event is declared as

    struct epoll_event {
            __poll_t events;
            __u64 data;
    } EPOLL_PACKED;

and __poll_t is "unsigned". So on pretty much all 64-bit architectures
except for x86-64 (which sets that packed attribute), you have a
packing hole there in between the events and the data, and "struct
epoll_event" has 8-byte alignment.

Now, in "struct epoll_uitem", you end up having *another* packing hold
in between "ready_events" and "struct epoll_event".

So this data structure that has 16 bytes of actual data, ends up being
24 bytes in size.

Again, x86-64 happens to be the exception to this, but that's a random
small implementation detail, not a design thing.

I think "struct epoll_event" was badly designed to begin with to have
this issue, but it shouldn't then be an excuse to make things even
worse with this array of "struct epoll_uitem" things.

Hmm?

              Linus
