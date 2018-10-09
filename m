Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D777C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C997C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6zYIaV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C997C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJIWPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:15:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35448 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJIWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:15:47 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so3140023itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znF2dXmEw6I6sqhqCgrR/LkxoK0WiWJksvm1s3zT76g=;
        b=Y6zYIaV+DO0dswyKV5aR0hPeFc9/VaiDArVrzBoWIdDJBu1kJXVDPDqekHI4bsu1Z/
         phzwMeQQmMPJ4vDOmkUtps/HoA+vslDRDUUOvfeaOZHwkFcXIsrzz3vLJJWY2wmtPlDw
         jGxT+0NUnu6uITGdOvM9unzD+sLC9nbG0yUFiqPMA31DLyoU/HH678BMCgKIxoH8uirs
         lrxyj/0oIG6+UCR7vhUnuP0zXGP7Kr0a8tVJdaVf2grrAxwQR+zaoIynamiIZGww3JTT
         mABV6f/K0+PMjQV90u7KvmhG9DgWIahoLO7pyzmq0jiEiO0VbcNlEg7+nvanYwUzZL4F
         xbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znF2dXmEw6I6sqhqCgrR/LkxoK0WiWJksvm1s3zT76g=;
        b=DRK60WC0BcbowO7Q4AzRvxyDjukJy14RQt6cdHuwjSJI2U97W1MYQbNUde2kXtWO7M
         Q3XyIDeEs0lTlECmFBDhOVPE7NESJ4b/XkNHK4GOr/sh3TaPGYgitqyrhU7tZASfDk3H
         IWl3Xvjpj/hdIzWAYY5whZZ/Kc1LQ/NP/LtIRv6X5fvlmFBMPQB6VySVPlN48oLiTmLO
         ujtynDTOJvT5HcjLf4a+5bELgNfZ//vRVEfwh7v5+v6acDVYnDTvw7gD9XLZzTfZaDxy
         diHEOELDnPLrmxXrl5F21zh5qE5/dYq8eRZqXPBHvsjulTwtcCOpgwLFMXNXEergaixP
         9exw==
X-Gm-Message-State: ABuFfojlMW+HtmXjAF0lJsPC+AfcSVYatyoLTwRlLpQm+ekIBGrGRAhs
        yHHLcq0/fXoZbCoP4jEAgKg0CCPcky7B/VvvTcONNfYVa5k=
X-Google-Smtp-Source: ACcGV62YyCWg30aj4WrRECEjk0Gg5PKgIryXQMSmED5zZ8yOiZaiKU2jbnZKIy91fkNz67ymLgsk470rkKx95ao/HIk=
X-Received: by 2002:a24:f803:: with SMTP id a3-v6mr1952791ith.178.1539097106924;
 Tue, 09 Oct 2018 07:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
 <1539086718-4119-2-git-send-email-laoar.shao@gmail.com> <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
 <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com>
In-Reply-To: <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 07:58:14 -0700
Message-ID: <CANn89iKe4vETuo-FBZ8ZrovJGiimBbhbzBnbqawX_h0LA+8PoA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> There was a network latency (hunreds msecs or even one sec ) recently
> on our production enviroment.
> And finally I diagnosed that this latency was caused by direct reclaim
> in tcp_sendmsg.
> That issue could be resovled by keeping a reserved memory.
> But I think deeply that why not forbid direct reclaim if we set MSG_DONWAIT.
> So I did this change and tested it. The application got a errno
> returned instead of being blocked in send path.
> That's why I sumbit this patch.

Sure, and I asked you how you have tested it, because it seems clear
to me that  you missed
the real memory allocation point (We fill up to 64 KB of page
fragments memory into one (small) skb)

And how is the application going to use MSG_DONTWAIT in the real
world, I do wonder as well.

We do not add bloat in the kernel if no application is ever going to
use it, especially in the TCP fast path.

Give us a test, so that we can see how this can be used...

Thanks.
