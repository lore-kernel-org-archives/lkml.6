Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD4C2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axy6HY2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439427AbfBNOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:52:17 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35852 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfBNOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:16 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so13668305itl.1;
        Thu, 14 Feb 2019 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+i1aB/2MK/7F9R9KEUWcwcveH7pnYGuUPOsM2vj6OQ=;
        b=Axy6HY2lh2DfR/PY1f4BtmRYR8Pdq7xwggfzQp0w5MloNVwbiI5+tAEwUxslldeSfg
         L6bUcN9mocIo8s50ciqf9VtMwzV4YUOp/2EGgGJk3D2BnCB/T3k7rdrpc35aKo8UgobQ
         4FkyBiOtjTD6g7TUySRJah4uZFzJ+USTnqEr3IlffMX0HnoeY2nRWUjYLWIa0/a5V6k0
         4mYdjojzdd0C31zhFKGahAnAb1nGHyXIEsAlb5VEmyXEouFGgXR/6ZU+Tg+tZ5o3xSBk
         gx2PDHnyMtaPgwe+FuHbcZShIlH3CqXWiwaSMe5N+ZKIAKxMgBWafA4vJI1lspV3not3
         QvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+i1aB/2MK/7F9R9KEUWcwcveH7pnYGuUPOsM2vj6OQ=;
        b=crf0Kl0BzoBLKsKJTMYFZyv8aoWf3y8KKeY7seeiDsjPRzzjTc4r46vdbItd9MF+/1
         52wV2sNZrv7DnRdPhuuKU3ErSHs5nzkQElD1y5b/F35nfru1lzwB4YTIHGVB0JFnFMko
         4OtVm6QIp0al8P2aC4MoDC0ISw5xUu6XM2Qwen+zVgTiy0m5HMaWJTUhS0GasWEdSFez
         a81H64qZ4ziTK9XLDvZcil7qn5CM/G3GL4oOT6rTlTkZUpz/AfeYQAXwylkkzkEQpaN2
         k9ZT8kvOvsMS3qXsCbZi4E98yFIrhOn64HyEB8ZaA9HeCOJ1o63qi1N6nBt4PNJXXCSO
         sffg==
X-Gm-Message-State: AHQUAubnzaXB24blxHBDdYkauhcdMXvPffxoFF6Tz+ubLAUtknA1reUB
        kLXxTPzXMnCLHd7myN5JGiLxRQnTkolCXox4ykc=
X-Google-Smtp-Source: AHgI3IaFYiY1OSjitEs83DPWxMXJ/8un5SPSSqdwV3xX+MlCSgowgIZu42sJ/7zJzWsp6mxEeYsxFqgl6WVDl7nevLE=
X-Received: by 2002:a5d:9701:: with SMTP id h1mr2599589iol.157.1550155935329;
 Thu, 14 Feb 2019 06:52:15 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002015db0581b71858@google.com> <CADvbK_dndFMxyUZk=k8qEy9=PNbLc81F++2L0fbdtUdbupq4Xg@mail.gmail.com>
 <20190213135157.GJ10665@localhost.localdomain> <CADvbK_fwUdU3_CWBFYfw+ZeOLvEF9p6koP2FUdo+m0SCqGN+Ug@mail.gmail.com>
 <20190214141745.GL13621@localhost.localdomain> <20190214143911.GL10665@localhost.localdomain>
In-Reply-To: <20190214143911.GL10665@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 14 Feb 2019 22:52:00 +0800
Message-ID: <CADvbK_ctRtcV3Fz6CwAoiTtVH3h5u7gj=6BsiZSR3Qdq+2rDMA@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 10:39 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 12:17:45PM -0200, Marcelo Ricardo Leitner wrote:
> > On Thu, Feb 14, 2019 at 10:03:30PM +0800, Xin Long wrote:
> > > On Wed, Feb 13, 2019 at 9:52 PM Marcelo Ricardo Leitner
> > > <marcelo.leitner@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 13, 2019 at 12:35:56PM +0800, Xin Long wrote:
> > > > > On Wed, Feb 13, 2019 at 4:00 AM syzbot
> > > > > <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14140124c00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a112d3b0d6719b
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7823fa3f3e2d69341ea8
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com
> > > > > >
> > > > > > ==================================================================
> > > > > > BUG: KASAN: use-after-free in list_add_tail include/linux/list.h:93 [inline]
> > > > > > BUG: KASAN: use-after-free in sctp_outq_tail_data net/sctp/outqueue.c:105
> > > > > > [inline]
> > > > > > BUG: KASAN: use-after-free in sctp_outq_tail+0x816/0x930
> > > > > > net/sctp/outqueue.c:313
> > > > > > Read of size 8 at addr ffff88807b19a7b8 by task syz-executor.0/30745
> > > > > I think https://patchwork.ozlabs.org/patch/1040500/ will fix this.
> > > >
> > > > I don't think so. Seems it will switch from use-after-free to NULL deref
> > > > instead with that patch.
> > > It will allocate ext for the stream if its ext is NULL in
> > > sctp_sendmsg_to_asoc(), the new data will work fine. As for
> >
> > Ehh, right!
> >
> > > the old data on the surplus streams, it has been dropped in
> > > sctp_stream_outq_migrate().
> >
> > Yep.
> >
> > >
> > > >
> > > > > > CPU: 1 PID: 30745 Comm: syz-executor.0 Not tainted 5.0.0-rc5-next-20190211
> > > > > > #32
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Call Trace:
> > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > > > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > > > > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > > > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
> > > > > >   list_add_tail include/linux/list.h:93 [inline]
> > > > > >   sctp_outq_tail_data net/sctp/outqueue.c:105 [inline]
> > > > > >   sctp_outq_tail+0x816/0x930 net/sctp/outqueue.c:313
> > > > > >   sctp_cmd_send_msg net/sctp/sm_sideeffect.c:1109 [inline]
> > > > > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1784 [inline]
> > > > > >   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> > > > > >   sctp_do_sm+0x68e/0x5380 net/sctp/sm_sideeffect.c:1191
> > > > > >   sctp_primitive_SEND+0xa0/0xd0 net/sctp/primitive.c:178
> > > > > >   sctp_sendmsg_to_asoc+0xa63/0x17b0 net/sctp/socket.c:1955
> > > >
> > > > sctp_sendmsg_to_asoc()
> > > > ...
> > > >         if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
> > > >                 err = -EINVAL;
> > > >                 goto err;
> > > >         }
> > > >
> > > >         if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
> > > > ...
> > > >
> > > > It should have aborted even if an old ->ext was still there because
> > > > outcnt is correctly updated. So somehow outcnt was wrong here.
> > > >
> > > > sctp_stream_init()
> > > > ...
> > > >         /* Filter out chunks queued on streams that won't exist anymore */
> > > >         sched->unsched_all(stream);
> > > >         sctp_stream_outq_migrate(stream, NULL, outcnt);   <--- [A]
> > > >         sched->sched_all(stream);
> > > >
> > > >         ret = sctp_stream_alloc_out(stream, outcnt, gfp); <--- [B]
> > > >         if (ret)
> > > >                 goto out;
> > > >
> > > >         stream->outcnt = outcnt;                          <--- [C]
> > > > ...
> > > >
> > > > We have a problem here because [A] is freeing ->ext, but [B] can fail (ENOMEM),
> > > > which would lead it to not update outcnt in [C] even after the
> > > > changes already performed in [A].
> > > >
> > > > It should handle the freeing of ->ext in sctp_stream_alloc_out()
> > > > instead, or allocate the flexarray earlier (so it can bail out before
> > > > freeing stuff).
> > > Agree that it's better to do:
> > >         sched->unsched_all(stream);
> > >         sctp_stream_outq_migrate(stream, NULL, outcnt);
> > >         sched->sched_all(stream);
> > > after the flexarray allocation.
> > >
> > > Just sctp_stream_alloc_out() can not be used here anymore, as
> > > stream->out will be set in it.
> >
> > What about carving out a sctp_stream_init_out() ? Like
> >
> >        struct flex_array *new_out;
> >
> >       /* just allocate it, nothing more */
> >          new_out = sctp_stream_alloc_out(outcnt, gfp);
> >          if (!new_out)
> >               goto out;
> >
> >          /* Filter out chunks queued on streams that won't exist anymore */
> >          sched->unsched_all(stream);
> >          sctp_stream_outq_migrate(stream, NULL, outcnt);
> >          sched->sched_all(stream);
> >
> >       /* initialization stuff, and it can't fail anymore */
> >          sctp_stream_init_out(stream, outcnt, new_out);
> >
> > This may hurt a bit more with the genradix migration, but then we
> > don't end up dropping data for nothing.
>
> Reviewing calls to this function, if this allocation fails it will
> either cause the asoc to be terminated or sendmsg error.  So data loss
> is not really an issue here.
>
  sctp_stream_init+0xbc/0x410 net/sctp/stream.c:139
  sctp_process_init+0x21c3/0x2b20 net/sctp/sm_make_chunk.c:2466
  sctp_cmd_process_init net/sctp/sm_sideeffect.c:682 [inline]
  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1410 [inline]

on this path, seems that it won't terminate the asoc nor report a sending error.
