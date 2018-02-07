Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeBGNzq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:55:46 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:36899 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeBGNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:55:44 -0500
X-Google-Smtp-Source: AH8x227lwXKWQYWu4Z4Sy6p/sVs1NYSaIgbWh930dWGrBjkFakfTFieRgAGCzO3xOeeB2yciNrUfxr+VFZRahwjyb8I=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+n8XCAwsRzDRoaxRqDEH9byMB=6e5FxPW=1mrGoUzRRQ@mail.gmail.com>
References: <94eb2c0efc1ede1c4205648e8a49@google.com> <CACT4Y+ZybLXnPiQ8BDLORD6VA8E7KeMrJZxO8q46MfMKyH7q_Q@mail.gmail.com>
 <CAGXu5j+n8XCAwsRzDRoaxRqDEH9byMB=6e5FxPW=1mrGoUzRRQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Feb 2018 14:55:23 +0100
Message-ID: <CACT4Y+Zqnfpv4fZyEgbXGzKoS+6QBv4-J4Z804OsisdQrTutsg@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in put_cmsg
To: Kees Cook <keescook@chromium.org>
Cc: syzbot <syzbot+c4dcac91687a29cbae15@syzkaller.appspotmail.com>,
        keun-o.park@darkmatter.ae, Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 8:16 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 7, 2018 at 4:33 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Tue, Feb 6, 2018 at 6:31 PM, syzbot
>> <syzbot+c4dcac91687a29cbae15@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> e237f98a9c134c3d600353f21e07db915516875b (Mon Feb 5 21:35:56 2018 +0000)
>>> Merge tag 'xfs-4.16-merge-5' of
>>> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>>>
>>> So far this crash happened 8 times on net-next, upstream.
>>> C reproducer is attached.
>>> syzkaller reproducer is attached.
>>> Raw console output is attached.
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached.
>>
>> #syz dup: WARNING in usercopy_warn
>>
>> Let's make that one the main copy, since Kees is already looking at it.
>
> This one has a more descriptive subject, can we dup towards this one?
> Whatever the case, yup, still working on it.

Humm, I see that there is currently no way to just "undup" a bug. It's
possible to remark it as invalid, or fix with commits, but not
possible to just undup and get into "open" state. I've filed
https://github.com/google/syzkaller/issues/520 for this. Meanwhile,
please add either Reported-by: tag from the other bug, or from both.
