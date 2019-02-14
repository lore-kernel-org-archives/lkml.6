Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786DB2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlyrjdNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502099AbfBNP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:27:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32990 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393823AbfBNP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:27:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so3815978qkf.0;
        Thu, 14 Feb 2019 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V7mFTMgcXlWD52IzMv/LR+6e0Zz2UU5+fhuJG1X4iiI=;
        b=mlyrjdNjVwTRwjJ0qxWu9+C6DcN/zQD/BACkaPAXA63xVXMDdf8QgaOOpMbAXpKexC
         YW3ho9HDyza5Id2b3dToCZVmp1SRkxDUloyH/fUIChy8qsJ67mQFQveayWWTBkG+oM0e
         aL4dNdfilIVDtvY7ew8zr4z6d8DQ0ajfAp3Auvv8/mpy/LKDwKhtkEQ9etYba9xnXDp+
         Bw7RsRlBEq4YVQ79oMU03mwTfwVXREAzFIUHRtRHXwLa/Lsx7yTTjAi7KOtNmNv92dZr
         0bR1EAjQuBFD+fwrjmhkg43riqGamsUKpcOmbQTAkd8upDAlobn9aU38sj2f2Wgk0Rr6
         5dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7mFTMgcXlWD52IzMv/LR+6e0Zz2UU5+fhuJG1X4iiI=;
        b=TblIsRkjEdrxsET+r3QkDtJzXPI5L38viFXuWO5HCAHUCwq81wGIVm3FL8XMtVdycD
         GPCfUzXpEuGZluwo4WXHo/np6IHlDpKLRpvitkdMSl/oB3PhltdBwI4gVPEneAQ0jw0k
         txM7LShgNrP6l9150RaSb/EO4dxUQccSqHzc2+MjNKIO8O0i3WOnbZf3YS4OtZWPUB0t
         CDqNotIRU1hnbRY2CGUz5IA9KtkO23KabZuLT5vJnVysmkdrOJA84FpbFfrTJNEwNSp9
         +nhUzGhDRrvipAeI6FKmOrklImtZZZnt/H+LTeAbp/EbIvX25pD+ezz5q/APk4PICZu3
         tmYA==
X-Gm-Message-State: AHQUAuau5gvKeWz5yx9jJkUd0cO8XOnnDxdfF0k8DpQQNBURop7g5OKc
        kI0rlQpW7b6LCZaol6eI/zU=
X-Google-Smtp-Source: AHgI3IYRvcjwbstuZVYG/HSOvRLOcdvJNuRPI8KMZpJboSKsz4L4KAHAKOwuB2bqbtwCK0P5eHl6GA==
X-Received: by 2002:a37:7885:: with SMTP id t127mr3274295qkc.323.1550158062790;
        Thu, 14 Feb 2019 07:27:42 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.109])
        by smtp.gmail.com with ESMTPSA id x80sm948877qkx.85.2019.02.14.07.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 07:27:42 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 93530180A9D; Thu, 14 Feb 2019 13:27:39 -0200 (-02)
Date:   Thu, 14 Feb 2019 13:27:39 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     syzbot <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_outq_tail
Message-ID: <20190214152739.GM13621@localhost.localdomain>
References: <0000000000002015db0581b71858@google.com>
 <CADvbK_dndFMxyUZk=k8qEy9=PNbLc81F++2L0fbdtUdbupq4Xg@mail.gmail.com>
 <20190213135157.GJ10665@localhost.localdomain>
 <CADvbK_fwUdU3_CWBFYfw+ZeOLvEF9p6koP2FUdo+m0SCqGN+Ug@mail.gmail.com>
 <20190214141745.GL13621@localhost.localdomain>
 <20190214143911.GL10665@localhost.localdomain>
 <CADvbK_ctRtcV3Fz6CwAoiTtVH3h5u7gj=6BsiZSR3Qdq+2rDMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_ctRtcV3Fz6CwAoiTtVH3h5u7gj=6BsiZSR3Qdq+2rDMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:52:00PM +0800, Xin Long wrote:
> On Thu, Feb 14, 2019 at 10:39 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Thu, Feb 14, 2019 at 12:17:45PM -0200, Marcelo Ricardo Leitner wrote:
> > > On Thu, Feb 14, 2019 at 10:03:30PM +0800, Xin Long wrote:
> > > > On Wed, Feb 13, 2019 at 9:52 PM Marcelo Ricardo Leitner
> > > > <marcelo.leitner@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 13, 2019 at 12:35:56PM +0800, Xin Long wrote:
> > > > > > On Wed, Feb 13, 2019 at 4:00 AM syzbot
> > > > > > <syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following crash on:
> > > > > > >
> > > > > > > HEAD commit:    d4104460aec1 Add linux-next specific files for 20190211
> > > > > > > git tree:       linux-next
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14140124c00000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a112d3b0d6719b
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7823fa3f3e2d69341ea8
> > > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > >
> > > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > > >
> > > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+7823fa3f3e2d69341ea8@syzkaller.appspotmail.com
> > > > > > >
> > > > > > > ==================================================================
> > > > > > > BUG: KASAN: use-after-free in list_add_tail include/linux/list.h:93 [inline]
> > > > > > > BUG: KASAN: use-after-free in sctp_outq_tail_data net/sctp/outqueue.c:105
> > > > > > > [inline]
> > > > > > > BUG: KASAN: use-after-free in sctp_outq_tail+0x816/0x930
> > > > > > > net/sctp/outqueue.c:313
> > > > > > > Read of size 8 at addr ffff88807b19a7b8 by task syz-executor.0/30745
> > > > > > I think https://patchwork.ozlabs.org/patch/1040500/ will fix this.
> > > > >
> > > > > I don't think so. Seems it will switch from use-after-free to NULL deref
> > > > > instead with that patch.
> > > > It will allocate ext for the stream if its ext is NULL in
> > > > sctp_sendmsg_to_asoc(), the new data will work fine. As for
> > >
> > > Ehh, right!
> > >
> > > > the old data on the surplus streams, it has been dropped in
> > > > sctp_stream_outq_migrate().
> > >
> > > Yep.
> > >
> > > >
> > > > >
> > > > > > > CPU: 1 PID: 30745 Comm: syz-executor.0 Not tainted 5.0.0-rc5-next-20190211
> > > > > > > #32
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > > Google 01/01/2011
> > > > > > > Call Trace:
> > > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > > > > > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > > > > > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > > > > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
> > > > > > >   list_add_tail include/linux/list.h:93 [inline]
> > > > > > >   sctp_outq_tail_data net/sctp/outqueue.c:105 [inline]
> > > > > > >   sctp_outq_tail+0x816/0x930 net/sctp/outqueue.c:313
> > > > > > >   sctp_cmd_send_msg net/sctp/sm_sideeffect.c:1109 [inline]
> > > > > > >   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1784 [inline]
> > > > > > >   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
> > > > > > >   sctp_do_sm+0x68e/0x5380 net/sctp/sm_sideeffect.c:1191
> > > > > > >   sctp_primitive_SEND+0xa0/0xd0 net/sctp/primitive.c:178
> > > > > > >   sctp_sendmsg_to_asoc+0xa63/0x17b0 net/sctp/socket.c:1955
> > > > >
> > > > > sctp_sendmsg_to_asoc()
> > > > > ...
> > > > >         if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
> > > > >                 err = -EINVAL;
> > > > >                 goto err;
> > > > >         }
> > > > >
> > > > >         if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
> > > > > ...
> > > > >
> > > > > It should have aborted even if an old ->ext was still there because
> > > > > outcnt is correctly updated. So somehow outcnt was wrong here.
> > > > >
> > > > > sctp_stream_init()
> > > > > ...
> > > > >         /* Filter out chunks queued on streams that won't exist anymore */
> > > > >         sched->unsched_all(stream);
> > > > >         sctp_stream_outq_migrate(stream, NULL, outcnt);   <--- [A]
> > > > >         sched->sched_all(stream);
> > > > >
> > > > >         ret = sctp_stream_alloc_out(stream, outcnt, gfp); <--- [B]
> > > > >         if (ret)
> > > > >                 goto out;
> > > > >
> > > > >         stream->outcnt = outcnt;                          <--- [C]
> > > > > ...
> > > > >
> > > > > We have a problem here because [A] is freeing ->ext, but [B] can fail (ENOMEM),
> > > > > which would lead it to not update outcnt in [C] even after the
> > > > > changes already performed in [A].
> > > > >
> > > > > It should handle the freeing of ->ext in sctp_stream_alloc_out()
> > > > > instead, or allocate the flexarray earlier (so it can bail out before
> > > > > freeing stuff).
> > > > Agree that it's better to do:
> > > >         sched->unsched_all(stream);
> > > >         sctp_stream_outq_migrate(stream, NULL, outcnt);
> > > >         sched->sched_all(stream);
> > > > after the flexarray allocation.
> > > >
> > > > Just sctp_stream_alloc_out() can not be used here anymore, as
> > > > stream->out will be set in it.
> > >
> > > What about carving out a sctp_stream_init_out() ? Like
> > >
> > >        struct flex_array *new_out;
> > >
> > >       /* just allocate it, nothing more */
> > >          new_out = sctp_stream_alloc_out(outcnt, gfp);
> > >          if (!new_out)
> > >               goto out;
> > >
> > >          /* Filter out chunks queued on streams that won't exist anymore */
> > >          sched->unsched_all(stream);
> > >          sctp_stream_outq_migrate(stream, NULL, outcnt);
> > >          sched->sched_all(stream);
> > >
> > >       /* initialization stuff, and it can't fail anymore */
> > >          sctp_stream_init_out(stream, outcnt, new_out);
> > >
> > > This may hurt a bit more with the genradix migration, but then we
> > > don't end up dropping data for nothing.
> >
> > Reviewing calls to this function, if this allocation fails it will
> > either cause the asoc to be terminated or sendmsg error.  So data loss
> > is not really an issue here.
> >
>   sctp_stream_init+0xbc/0x410 net/sctp/stream.c:139
>   sctp_process_init+0x21c3/0x2b20 net/sctp/sm_make_chunk.c:2466
>   sctp_cmd_process_init net/sctp/sm_sideeffect.c:682 [inline]
>   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1410 [inline]
> 
> on this path, seems that it won't terminate the asoc nor report a sending error.

Seems that's only triggered from sctp_sf_do_5_1C_ack() and quite
interesting. If we can't perform the reduction of the number of output
streams, we will be violating the handshake. Considering the error
will cause it to stop processing the commands from the state machine,
it won't output cookie echo pkt and this asoc will be left in a
somewhat funny state.  I think the fact that it won't stop the T1
then, allows it to get corrected later on.
But that err_chunk, if any, gets leaked.
