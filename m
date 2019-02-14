Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889AC2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOhIU8FW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393399AbfBNORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:17:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37339 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBNORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:17:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so6979842qtb.4;
        Thu, 14 Feb 2019 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w4n6iEM9APaFfr5snt6a8qSzZFjhCXJFt+JQZk91uns=;
        b=pOhIU8FWKdkw0FBGyQIiqJfSUlqIF5dfAnm7/+Wyraa9f9gtGZMRJrWs5TN/BRMsJT
         9FMkgwu9KbK9EKuRY4fRgJb5udcmy5PtTbHxL56mjVKRXhKWebhxcwYkxT1xCWU4O+WX
         eURswQgwO912LrV57McpVqoI9las5dJ5IJ7xCNI2tUT9HwprCSEQAhOwIN6Y5aPpKEq1
         lVmV+64msMM7UU+cFKQduwLsOsqi/8xoPbWYYBEtJRpBt+EWlGpMijtLoiNWWPq8JvMh
         o/nk7a4RLKRakDIXQ6472qRKM8nzgpaxLgSGE9hqwiUwk2NJi0ilNlyiIX7/aRao0vWl
         ca2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4n6iEM9APaFfr5snt6a8qSzZFjhCXJFt+JQZk91uns=;
        b=eBvx5XHPnOW0RN9sTG/p2dmwGKUBLPszsUmWap2Q+Gd85T/uxUmtfDM6qZfh+LACTt
         5+nOxtTQdSJD8NBi48WkYxu/seMDGu/5IeTkW1PiDxhR5/R6APOrTdWHcikxHqS+ulTw
         LyZ6UwmHtovmGjGF+8wWkLYLpoyN6O4ijXXIF8i4Jx9Y4gBrGRqvgQburzX7Mptb5gd2
         2Sw6AksdKeUwtupGutWralwMNlng8ZJsYkLWfsx+5dWqGBwh5+ANOwzApy/5pPOWoioD
         0Fzz12ZKsLD986OrspPJBPEJAioKecRXWSJIo3MVME5B0Xg0xbNZm4kPCiwVcDxX/mty
         JqSQ==
X-Gm-Message-State: AHQUAuaP/m4/Podj+Xko20fTkpc751Fjc+3SkcLOsnbz8LP5M6XQpgf3
        QbSMh3ksG4PioRnLJV26Jvs=
X-Google-Smtp-Source: AHgI3Ibt+sraEeAyera6CTgW1fsL92kkG7wyQZMNBeZpe43Nt99PK30LA3dLj6iIqco73J1QBq1TqQ==
X-Received: by 2002:ac8:3332:: with SMTP id t47mr3188203qta.52.1550153869428;
        Thu, 14 Feb 2019 06:17:49 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.109])
        by smtp.gmail.com with ESMTPSA id m41sm1878343qtc.58.2019.02.14.06.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 06:17:48 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 03770180A9D; Thu, 14 Feb 2019 12:17:45 -0200 (-02)
Date:   Thu, 14 Feb 2019 12:17:45 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     syzbot <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_outq_tail
Message-ID: <20190214141745.GL13621@localhost.localdomain>
References: <0000000000002015db0581b71858@google.com>
 <CADvbK_dndFMxyUZk=k8qEy9=PNbLc81F++2L0fbdtUdbupq4Xg@mail.gmail.com>
 <20190213135157.GJ10665@localhost.localdomain>
 <CADvbK_fwUdU3_CWBFYfw+ZeOLvEF9p6koP2FUdo+m0SCqGN+Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_fwUdU3_CWBFYfw+ZeOLvEF9p6koP2FUdo+m0SCqGN+Ug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:03:30PM +0800, Xin Long wrote:
> On Wed, Feb 13, 2019 at 9:52 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 12:35:56PM +0800, Xin Long wrote:
> > > On Wed, Feb 13, 2019 at 4:00 AM syzbot
> > > <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14140124c00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a112d3b0d6719b
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7823fa3f3e2d69341ea8
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in list_add_tail include/linux/list.h:93 [inline]
> > > > BUG: KASAN: use-after-free in sctp_outq_tail_data net/sctp/outqueue.c:105
> > > > [inline]
> > > > BUG: KASAN: use-after-free in sctp_outq_tail+0x816/0x930
> > > > net/sctp/outqueue.c:313
> > > > Read of size 8 at addr ffff88807b19a7b8 by task syz-executor.0/30745
> > > I think https://patchwork.ozlabs.org/patch/1040500/ will fix this.
> >
> > I don't think so. Seems it will switch from use-after-free to NULL deref
> > instead with that patch.
> It will allocate ext for the stream if its ext is NULL in
> sctp_sendmsg_to_asoc(), the new data will work fine. As for

Ehh, right!

> the old data on the surplus streams, it has been dropped in
> sctp_stream_outq_migrate().

Yep.

> 
> >
> > > > CPU: 1 PID: 30745 Comm: syz-executor.0 Not tainted 5.0.0-rc5-next-20190211
> > > > #32
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
> > > >   list_add_tail include/linux/list.h:93 [inline]
> > > >   sctp_outq_tail_data net/sctp/outqueue.c:105 [inline]
> > > >   sctp_outq_tail+0x816/0x930 net/sctp/outqueue.c:313
> > > >   sctp_cmd_send_msg net/sctp/sm_sideeffect.c:1109 [inline]
> > > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1784 [inline]
> > > >   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> > > >   sctp_do_sm+0x68e/0x5380 net/sctp/sm_sideeffect.c:1191
> > > >   sctp_primitive_SEND+0xa0/0xd0 net/sctp/primitive.c:178
> > > >   sctp_sendmsg_to_asoc+0xa63/0x17b0 net/sctp/socket.c:1955
> >
> > sctp_sendmsg_to_asoc()
> > ...
> >         if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
> >                 err = -EINVAL;
> >                 goto err;
> >         }
> >
> >         if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
> > ...
> >
> > It should have aborted even if an old ->ext was still there because
> > outcnt is correctly updated. So somehow outcnt was wrong here.
> >
> > sctp_stream_init()
> > ...
> >         /* Filter out chunks queued on streams that won't exist anymore */
> >         sched->unsched_all(stream);
> >         sctp_stream_outq_migrate(stream, NULL, outcnt);   <--- [A]
> >         sched->sched_all(stream);
> >
> >         ret = sctp_stream_alloc_out(stream, outcnt, gfp); <--- [B]
> >         if (ret)
> >                 goto out;
> >
> >         stream->outcnt = outcnt;                          <--- [C]
> > ...
> >
> > We have a problem here because [A] is freeing ->ext, but [B] can fail (ENOMEM),
> > which would lead it to not update outcnt in [C] even after the
> > changes already performed in [A].
> >
> > It should handle the freeing of ->ext in sctp_stream_alloc_out()
> > instead, or allocate the flexarray earlier (so it can bail out before
> > freeing stuff).
> Agree that it's better to do:
>         sched->unsched_all(stream);
>         sctp_stream_outq_migrate(stream, NULL, outcnt);
>         sched->sched_all(stream);
> after the flexarray allocation.
> 
> Just sctp_stream_alloc_out() can not be used here anymore, as
> stream->out will be set in it.

What about carving out a sctp_stream_init_out() ? Like

	 struct flex_array *new_out;

	/* just allocate it, nothing more */
         new_out = sctp_stream_alloc_out(outcnt, gfp);
         if (!new_out)
	 	goto out;

         /* Filter out chunks queued on streams that won't exist anymore */
         sched->unsched_all(stream);
         sctp_stream_outq_migrate(stream, NULL, outcnt);
         sched->sched_all(stream);

	/* initialization stuff, and it can't fail anymore */
         sctp_stream_init_out(stream, outcnt, new_out);

This may hurt a bit more with the genradix migration, but then we
don't end up dropping data for nothing.

