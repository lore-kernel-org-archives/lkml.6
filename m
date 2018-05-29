Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeE2Lx2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:53:28 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34612 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeE2LxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:53:23 -0400
X-Google-Smtp-Source: ADUXVKJiFNbrwqIiD1BBhbP7cvSGzOKfBYFRb+a16I2RBEXCV159o9NczzXlzglRhPvBIwOT9AK97/9oLDNPH4lT474=
MIME-Version: 1.0
In-Reply-To: <20180528182230.GE3787@localhost.localdomain>
References: <0000000000006d7517056c911740@google.com> <4b65142a-cf3b-05d7-d66b-018ff8da7ccc@gmail.com>
 <CADvbK_e7LXc7minSmaPw6iZvjWo215wG-pPAS0gr58+-VxUO7Q@mail.gmail.com> <20180528182230.GE3787@localhost.localdomain>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 29 May 2018 13:53:21 +0200
Message-ID: <CAAeHK+yz+O=Rz4rJwXeBsMjGe6mrYvF0prUvDN0djPtL+gcD_w@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in is_bpf_text_address
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3dcd59a1f907245f891f@syzkaller.appspotmail.com>,
        ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 8:22 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> The reproducer has:
> r0 = socket$inet6(0xa, 0x1, 0x8010000000000084)
>
> Considering socket() prototype uses an int for the 3rd argument, how
> should I interpret this 64b value?
>
> 0x84 is IPPROTO_SCTP, but don't know about the 0x8010000000000000 in
> there.

Hi Marcelo,

It gets stripped to int the same way C does it, so the value would be 0x84.

Thanks!
