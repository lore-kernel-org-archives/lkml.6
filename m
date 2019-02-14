Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72664C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402012229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi3XylTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392925AbfBNODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:03:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36596 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390733AbfBNODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:03:44 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so13286132itl.1;
        Thu, 14 Feb 2019 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iB84plduXNkNDw8SYCPoxY6/XXdsrjGcy1G6JgSDkw=;
        b=Vi3XylTjjYtnAi+txFf7JXTw/qcllRwN5AQHEmk3YFaTZOAfCI5GtEnThpaB5lC4Qp
         Xh8JPT0sCK8rKSbKe/8UYvKlDbXeqeGJJWZbGfmjI3jt6yAhx3xDDKTc25gcVyO/OpAl
         OimpDGOM+i78ix6y/0UN/pZZV6rOSBIs9Hna0QbFYw43Igq3eBXTi3Xodn7ZRnB/y+NO
         gPO8i3+2bVmY/ALamUh7Os+zGJ7tW+rc3oQPKEdAub9LlhaH9bO+GDG8MrB+KsNz47nG
         k0djiblMlOHoKA+vmvSN6y/Br0cyoHE5T1mz5Aek80xnN14GEsPXqP8LaY3PRH76meF8
         IIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iB84plduXNkNDw8SYCPoxY6/XXdsrjGcy1G6JgSDkw=;
        b=QatDA6BT7y38zu6S5Fnojd0pUkxVV1NdMt94OBKAL2EkhW08an6eDzl4IlwqO6Hmp0
         Kg+XROtxyIJexQIeuMeaBbVri6XWCIXqKxKaLcpjP7FLQSuQ12legLguuInWy3kB1c24
         L03tXvJIAhoUnlmPpgPN6hXHyaJyZ5p5bRF7Bql6PUieODlUZDjLgDpAROEE1sJWucm8
         tQJ4+dly7lxald8w0WiDM9CjSP4eRIDC0hx54yPBG49CnUXmN0yqsRBOOZmlNYAjMlGU
         /aZMAkR3zqReInYsaUghD2WAx8o+j9BSY4jZJdGldZyqNPZ7bc4cgFSuqDBToLudg7h6
         EKUg==
X-Gm-Message-State: AHQUAuZ8rfPAu0ZKMT6U4/Q6b9w6bLCOUgYyj0en7aLpB6dY8FdsHEAM
        NRgXrz7QO3shGCXsAFKMjjLQmpCFgJsCOOSdnmE=
X-Google-Smtp-Source: AHgI3IZaKqNWK6KpzWtNtN7Xfv7MApTZ1/dLq+fwaVt0EkWgCZKw4LwlIVLYNPp3DnRG1m/srZU+Lv/1MBVv6e0ugmY=
X-Received: by 2002:a24:280a:: with SMTP id h10mr1896360ith.103.1550153022375;
 Thu, 14 Feb 2019 06:03:42 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002015db0581b71858@google.com> <CADvbK_dndFMxyUZk=k8qEy9=PNbLc81F++2L0fbdtUdbupq4Xg@mail.gmail.com>
 <20190213135157.GJ10665@localhost.localdomain>
In-Reply-To: <20190213135157.GJ10665@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 14 Feb 2019 22:03:30 +0800
Message-ID: <CADvbK_fwUdU3_CWBFYfw+ZeOLvEF9p6koP2FUdo+m0SCqGN+Ug@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_outq_tail
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:52 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, Feb 13, 2019 at 12:35:56PM +0800, Xin Long wrote:
> > On Wed, Feb 13, 2019 at 4:00 AM syzbot
> > <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14140124c00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a112d3b0d6719b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7823fa3f3e2d69341ea8
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KASAN: use-after-free in list_add_tail include/linux/list.h:93 [inline]
> > > BUG: KASAN: use-after-free in sctp_outq_tail_data net/sctp/outqueue.c:105
> > > [inline]
> > > BUG: KASAN: use-after-free in sctp_outq_tail+0x816/0x930
> > > net/sctp/outqueue.c:313
> > > Read of size 8 at addr ffff88807b19a7b8 by task syz-executor.0/30745
> > I think https://patchwork.ozlabs.org/patch/1040500/ will fix this.
>
> I don't think so. Seems it will switch from use-after-free to NULL deref
> instead with that patch.
It will allocate ext for the stream if its ext is NULL in
sctp_sendmsg_to_asoc(), the new data will work fine. As for
the old data on the surplus streams, it has been dropped in
sctp_stream_outq_migrate().

>
> > > CPU: 1 PID: 30745 Comm: syz-executor.0 Not tainted 5.0.0-rc5-next-20190211
> > > #32
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
> > >   list_add_tail include/linux/list.h:93 [inline]
> > >   sctp_outq_tail_data net/sctp/outqueue.c:105 [inline]
> > >   sctp_outq_tail+0x816/0x930 net/sctp/outqueue.c:313
> > >   sctp_cmd_send_msg net/sctp/sm_sideeffect.c:1109 [inline]
> > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1784 [inline]
> > >   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> > >   sctp_do_sm+0x68e/0x5380 net/sctp/sm_sideeffect.c:1191
> > >   sctp_primitive_SEND+0xa0/0xd0 net/sctp/primitive.c:178
> > >   sctp_sendmsg_to_asoc+0xa63/0x17b0 net/sctp/socket.c:1955
>
> sctp_sendmsg_to_asoc()
> ...
>         if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
>                 err = -EINVAL;
>                 goto err;
>         }
>
>         if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
> ...
>
> It should have aborted even if an old ->ext was still there because
> outcnt is correctly updated. So somehow outcnt was wrong here.
>
> sctp_stream_init()
> ...
>         /* Filter out chunks queued on streams that won't exist anymore */
>         sched->unsched_all(stream);
>         sctp_stream_outq_migrate(stream, NULL, outcnt);   <--- [A]
>         sched->sched_all(stream);
>
>         ret = sctp_stream_alloc_out(stream, outcnt, gfp); <--- [B]
>         if (ret)
>                 goto out;
>
>         stream->outcnt = outcnt;                          <--- [C]
> ...
>
> We have a problem here because [A] is freeing ->ext, but [B] can fail (ENOMEM),
> which would lead it to not update outcnt in [C] even after the
> changes already performed in [A].
>
> It should handle the freeing of ->ext in sctp_stream_alloc_out()
> instead, or allocate the flexarray earlier (so it can bail out before
> freeing stuff).
Agree that it's better to do:
        sched->unsched_all(stream);
        sctp_stream_outq_migrate(stream, NULL, outcnt);
        sched->sched_all(stream);
after the flexarray allocation.

Just sctp_stream_alloc_out() can not be used here anymore, as
stream->out will be set in it.
