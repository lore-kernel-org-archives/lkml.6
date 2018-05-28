Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933131AbeE1SWh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:22:37 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34653 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeE1SWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:22:35 -0400
X-Google-Smtp-Source: ADUXVKK1OY5NLEwI/NhBEU6lZkm15y8Pctf7dJf/Gsvoeabxb5KpjT0XNHHJW644AQ6CePizqNio2g==
Date: Mon, 28 May 2018 15:22:31 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
Message-ID: <20180528182230.GE3787@localhost.localdomain>
References: <0000000000006d7517056c911740@google.com>
 <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
 <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 04:26:03PM +0800, Xin Long wrote:
> On Sat, May 19, 2018 at 11:57 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > SCTP experts, please take a look.
> >
> > On 05/19/2018 08:55 AM, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1462ec0f800000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcd59a1f907245f891f
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1079cf8f800000

The reproducer has:
r0 = socket$inet6(0xa, 0x1, 0x8010000000000084)

Considering socket() prototype uses an int for the 3rd argument, how
should I interpret this 64b value?

0x84 is IPPROTO_SCTP, but don't know about the 0x8010000000000000 in
there.
