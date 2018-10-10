Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01E2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqoKdGIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF01E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJJIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:51:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34854 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJJIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:51:06 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so5747090itp.0;
        Tue, 09 Oct 2018 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xv9P+evkxsAIe39vulMkiewXxkXXy8M2onsk6yXvRFI=;
        b=kqoKdGICqVJ2+ewII8YurJNH40Zd0Srs7nG4OHguQYV4kgzWsypz5Dz6/v5RKgWfjo
         Vdj2hK75sXJVEhKRwT6lr7Ifjm7BKjKITYln+wxj1Dk8qR9T9Y4gqyjMtwoP5rBphgFa
         UoSaqkGQoOhdyfZDmdvBBqfr61uTPpQLozvMofMpu8At9horhO3vE1BVloIe4wcY9jIQ
         JhdQgnO8fg6T+hlFrjdXdT+E03hqWaQhuD3TDz1KdiYW+bVbJLsERkZZr/VIsZo/kXK7
         paaCjKQha9GyPkJHDHEg5yNcPPkGcTWMKrtg4DcsDN7ZDwf/xYbGONdJ75/r7UEsQe2W
         75wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xv9P+evkxsAIe39vulMkiewXxkXXy8M2onsk6yXvRFI=;
        b=fcLP1O3E8qSgGHCoy9oOOHnV+Mmc+eS7o9DMdK+C9eamNo3F9Zl6mew01vPisHTLSn
         r6/cDZWeF28dJISnYqnUPjkrlKJZogKC0Qg99ZT9gFIiibZKbqKFHns1dzDKA6l86mW8
         QrpuWONSOHRsi9IA7xzLgNcKCUwbE3mLAzd98wEh6m+/iGa9MDr0IwuE0LHsFgcWCeLz
         T1SiIF68IvHj+O6nST6H3RvnHVEC2qm1N7d+kJaF6JsLHlBkWqcROe3lxpZpX2uSVKIf
         EDHNVD1SBH/pK9EqdPhQ6DDqNKK/1UV/7GzGNAJ40dMOYbVgvKae+6Mb3m0EY3VqIa28
         5Qkw==
X-Gm-Message-State: ABuFfogRhB31X0uPrl0JMl9z7Uhy+jlS2rr2ih6eQi6uQYwiwYTo+fZT
        OULijhcCxVj86PeuBMU8UI0FG7wHLiWByTfZUVE=
X-Google-Smtp-Source: ACcGV62ZfBXnU4ZBcJ3ha0QGcqdWBNEgRELbKqWe4ppoeGeAzC3NEIDXGoUWoo9ItJ6cFHm4RkqvVkJO1PuISUnrArA=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr3315443itc.154.1539135081230;
 Tue, 09 Oct 2018 18:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
 <1539086718-4119-2-git-send-email-laoar.shao@gmail.com> <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
 <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com>
 <CANn89iKe4vETuo-FBZ8ZrovJGiimBbhbzBnbqawX_h0LA+8PoA@mail.gmail.com> <CANn89i+-g5DEnrv0DSCsMq3fXo35mAaOmXvf1Tr22Ybif1OV0Q@mail.gmail.com>
In-Reply-To: <CANn89i+-g5DEnrv0DSCsMq3fXo35mAaOmXvf1Tr22Ybif1OV0Q@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 10 Oct 2018 09:30:44 +0800
Message-ID: <CALOAHbBKabLHkLk4SEU8cRV3JZoTbe9TUiLd9RCp2nOx7Y0fPA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 11:38 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Oct 9, 2018 at 7:58 AM Eric Dumazet <edumazet@google.com> wrote:
> >
>
> > We do not add bloat in the kernel if no application is ever going to
> > use it, especially in the TCP fast path.
> >
>
> BTW, are you willing to change all memory allocations in the kernel as well ?
>
> Let say an application is using a system call providing a pathname
> (open(), stat(), ...), how this system call
> is going to ask the kernel for no direct reclaim ?
>
> Even allocating a socket with socket() or accept() has no ability to
> avoid direct reclaim.
>
> So tcp_sendmsg() is only the tip of the iceberg.

If we can really find a solution that is good enough to hanlde direct
reclaim in tcp_sendmsg,
we could also implement it in other syscalls.
Unexpected latency is hateful.

Thanks
Yafang
