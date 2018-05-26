Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032052AbeEZPg0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:36:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35510 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031905AbeEZPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:36:24 -0400
X-Google-Smtp-Source: AB8JxZrLjL6l/SYORxR9Gp+mh2R2bkZKYYYYRQP9qmuA1xv/Qnz9ZnSodt/lNtltKuaqeUy2Fa1SaQumioEnzfEXbCU=
MIME-Version: 1.0
In-Reply-To: <20180508120643.GM4977@localhost.localdomain>
References: <000000000000062c1c056bacd39f@google.com> <20180508120643.GM4977@localhost.localdomain>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 26 May 2018 17:36:02 +0200
Message-ID: <CACT4Y+bpPTOWhVw=XehkdUeHutZbdOp-eFWmhsvybsa+cPEp7A@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sctp_generate_heartbeat_event
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: syzbot <syzbot+e4a5bbd54260c93014f9@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 2:06 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Tue, May 08, 2018 at 12:35:02AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    90278871d4b0 Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=119a7237800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=aea320d3af5ef99d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e4a5bbd54260c93014f9
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>
> A reproducer will be welcomed. With just these traces, I don't think
> we have enough information.


#syz fix: sctp: not allow to set rto_min with a value below 200 msecs
