Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DEDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68C020656
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXEsTWg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfADRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:24:58 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44898 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfADRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:24:57 -0500
Received: by mail-ed1-f52.google.com with SMTP id y56so32357422edd.11;
        Fri, 04 Jan 2019 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QYG9S/Kfch01D+I5FXqsAT0eufkUnswh8c8NdeY/VU=;
        b=XXEsTWg+1JQs3ibpSdos8ihJ2kMXerdCGjxX2cj9GBQOybTQ+C+pksxYgMY9C89rHV
         uqpA1yrlE9sJ6Hxccgt01N33ahZneNP7yHFjIqCBHeLktoq+GL6WBbeTtUwPpNeFGHXK
         00NGJCBLoau7BxVIx4t+gRBWvI5st3+e4dZoHcsXSmJun6j+PoVgfYtYIm9VqGlS45+0
         hLMWEwDnczPqo519xP3uVMcqObJ6SNumCMN+XhLjVWTafPhTUYi5DteDN28kRVKWBi+o
         WbJcjGlguZ6Wmkw4hUvAA7OtF2i49lLDtnBHiQvxKMffjWmsTslztsTjx5NlRsTCo0np
         1Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QYG9S/Kfch01D+I5FXqsAT0eufkUnswh8c8NdeY/VU=;
        b=eiXubFVuLpe6E4dvbSnvUnB3oZqIXdBMafyF8aOnmUZw8+9Jr0xqY5fWqoZiiAf33s
         tUDkj3MxIenpDmDBTZNvlQDK6C2gdbywpRdQjycgN6cZyJLlPJvY9pO/2QNNb32ojmfr
         ds0vOynZncVzFrSs3jHe7ma3Fpz4mCMguS9GeOUacxaSugtj/JNHsx8Rak0w8CTlfXI/
         i5X90uRUZnkoLQ19nIv30XBcZFAzwJivgFYjoMBvjkCe4ufmW/QjHL9TUytirr88f4GV
         RSwYeec70FebXa0fjZnxDVQi3GAgkMCZWcDylEvI9VVOru1fLGomglkYNeL7L51ABjPW
         3fMw==
X-Gm-Message-State: AA+aEWZbvXT6/MjPdh4OMaRFGpQArn9fnmlOFF0j/H0n4DeP7Za0IASV
        0+QJMTm6OnkwTtX84IJ3JU/PKWTmvf+vmC6MKgs=
X-Google-Smtp-Source: AFSGD/UcNS0h+xnbOI9M1lJdLKilEdrWofzzPhuf/0qlfEvovjm3Tezx60tH6sIhYaEapo8p6FYRUMCTshzBWSa4tso=
X-Received: by 2002:a50:a517:: with SMTP id y23mr47723552edb.219.1546622695016;
 Fri, 04 Jan 2019 09:24:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com> <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
 <20190103225404.66b0ec9f@redhat.com> <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
 <20190104115435.478b4b4a@redhat.com> <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
 <20190104181424.5ad4b1de@redhat.com>
In-Reply-To: <20190104181424.5ad4b1de@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 4 Jan 2019 12:24:18 -0500
Message-ID: <CAF=yD-LdShBqHz1amBAAAA4w==0O+HfeWutfLi5K6LmWhK_x6Q@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 12:14 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Fri, 4 Jan 2019 12:05:04 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Fri, Jan 4, 2019 at 11:54 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Fri, 4 Jan 2019 11:32:12 +0100
> > > Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > > >
> > > > > On Thu, 3 Jan 2019 15:15:06 -0600
> > > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > > syzbot generated stack traces with
> > > > > >
> > > > > > [  183.517380]  udpv6_err+0x46/0x60
> > > > > > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > > > > > [  183.525054]  gue6_err_proto_handler+0x199/0x280
> > > > >
> > > > > Where? I can't find that in any logs linked from the dashboard at
> > > > > https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(
> > > >
> > > > Stefano, there are these 4 bugs reported that have similarly looking
> > > > reproducers involving udp sockets and that crash modes that looks like
> > > > stack corruption/overflow:
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> > > > https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
> > > > https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
> > > > https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> > > >
> > > > Are these the same bug as this?
> > >
> > > Judging from the reproducers for the first three, they seem to be.
> >
> > OK, then I will mark them as dups of this one.
>
> syzbot just finished the tests I requested and couldn't reproduce the
> first three issues with the fix I posted (fou6: Prevent unbounded
> recursion in GUE error handler).

Thanks for preparing the fixes so quickly, Stefano.

I also noticed one trace that seemingly goes through an ip6erspan
tunnel as well as gue6.

[  760.618683]  ? __udp6_lib_err+0xcb/0x640
[  760.622716]  ? udplitev6_err+0x46/0x60
[  760.626573]  ? gue6_err+0x105/0x270
[  760.630170]  ? udp_lib_close+0x20/0x20
[  760.634027]  ? ip6erspan_tunnel_xmit+0xdc0/0xdc0

Without knowing the err_handler code too well: is it possible that
packets with an intermediate IPIP or other tunnel still bypass the
checks (which check for strictly UDP in GUE)?
