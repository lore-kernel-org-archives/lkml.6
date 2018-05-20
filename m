Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeETBpu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 21:45:50 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:43544 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeETBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 21:45:47 -0400
X-Google-Smtp-Source: AB8JxZrwGOJ6t6OCJauP3+gCDycveJQJl41b67Jp3/nrJ0ADtWpeQCN1NRN2g6OPJBh/1jnb7xlpcQ==
Date: Sat, 19 May 2018 22:45:44 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
Message-ID: <20180520014544.GB26212@localhost.localdomain>
References: <0000000000006d7517056c911740@google.com>
 <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 08:57:19AM -0700, Eric Dumazet wrote:
> SCTP experts, please take a look.

Ugh, same sctp footprint as in the other reports.

>
> >  _sctp_make_chunk+0x58/0x280 net/sctp/sm_make_chunk.c:1417
> >  sctp_make_control net/sctp/sm_make_chunk.c:1464 [inline]
> >  sctp_make_heartbeat+0x8f/0x430 net/sctp/sm_make_chunk.c:1177
> >  sctp_sf_heartbeat.isra.23+0x26/0x180 net/sctp/sm_statefuns.c:1005
> >  sctp_sf_sendbeat_8_3+0x38e/0x550 net/sctp/sm_statefuns.c:1049
> >  sctp_do_sm+0x1ab/0x7160 net/sctp/sm_sideeffect.c:1188
> >  sctp_generate_heartbeat_event+0x218/0x450 net/sctp/sm_sideeffect.c:406
> >  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
> >  expire_timers kernel/time/timer.c:1363 [inline]
> >  __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
> >  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
