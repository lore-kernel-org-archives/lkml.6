Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeDPLQV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:16:21 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36831 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:16:19 -0400
X-Google-Smtp-Source: AIpwx4+yuWQe6SlfUfpUlUv3ymqmtRRnzSHDFFNWPNvv3vljZqZvoOcazy29S9mP2EpKX0H8MJFwoZV85kTuK3sOv20=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwJ=fiuV+QF+-b+H58tquCzek6CNpssZn40r0z4E0Q6kA@mail.gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
 <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
 <20180323201634.GA16350@gmail.com> <CA+55aFwZpMB=VUTCNUgc4dcCEy9_T4iE0R0pAfDets=zDFJunQ@mail.gmail.com>
 <CACT4Y+YjD68zBdN7zCViB5ab9-R2JgBEf5OBiDauxMsyuEkLRw@mail.gmail.com> <CA+55aFwJ=fiuV+QF+-b+H58tquCzek6CNpssZn40r0z4E0Q6kA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Apr 2018 13:15:58 +0200
Message-ID: <CACT4Y+YUFbbQgE9C1awsVVBFOjLbTXANRQwPK+R58FLjhTb-Vg@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 8:25 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Coming back to this now that the merge window is almost over ]
>
> On Mon, Mar 26, 2018 at 1:46 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> I've switched emails to links instead of attachments, here are few
>> recent examples:
>> https://lkml.org/lkml/2018/3/25/31
>> https://lkml.org/lkml/2018/3/25/256
>> https://lkml.org/lkml/2018/3/25/257
>
> Looks good to me. I notice that only the last one got any replies, though.
>
> I wonder if some people auto-ignore the new reports because of having
> been burned by the previous "huge illegible emails" issue.
>
> I do see syzbot fixes in rdma, though, just not for that
> cma_listen_on_all issue. So maybe that bug is nastier.

"possible deadlock in handle_rx" is now marked as fixed with
"vhost_net: add missing lock nesting notation".
"KASAN: use-after-free Read in pppol2tp_connect (3)" is marked as
fixed with "l2tp: fix races in tunnel creation".
"KASAN: use-after-free Read in __list_add_valid (5)" is still open.

Though, there are still 182 open bugs on dashboard:
https://syzkaller.appspot.com/

80+ have reproducers and happened last time recently enough. Few
dozens without reproducers, but as history shows ~2/3 of them are
fixable. Part of the remaining ones is probably fixed, but nobody told
syzbot about the fixes. Part is probably still unfixed but happen
episodically.
