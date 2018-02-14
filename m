Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161552AbeBNRxW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:53:22 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:36086 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161402AbeBNRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:53:20 -0500
X-Google-Smtp-Source: AH8x224TaJbXG0pyeyIeWzgfUKXW6YXNyTIyBuKMpJgqacneFFIlndwDXp54kwjWsMw62xKCFFfcTI+R87gyZKg2nsI=
MIME-Version: 1.0
In-Reply-To: <52478830-f0b5-e400-8101-b329ba35bcef@oracle.com>
References: <089e08231920353a4805618b365c@google.com> <d91da249-5a0f-7a1f-cfd5-68f10f0a2fc1@oracle.com>
 <CACT4Y+bd6Tyq672JC3GNSHPX2CEHacVKkcbKOAgpi8o-=T8DRg@mail.gmail.com>
 <491a26b8-7abb-0d36-0a2e-e1c7bfcde79d@oracle.com> <CACT4Y+YxrNiP==ty-KBjkDewnuS378GmG314-=ytWskZXQx3zw@mail.gmail.com>
 <52478830-f0b5-e400-8101-b329ba35bcef@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 18:52:58 +0100
Message-ID: <CACT4Y+aWVFEvVMihw2MBiMgYKMzup4O78c_HrByhRyF8-zfzpw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rds_find_bound
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: syzbot <syzbot+93a5839deb355537440f@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 6:35 PM, Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
>>>> Hi Santosh,
>>>>
>>>> What is that fix? You forgot to provide any link/reference. I also
>>>> don't see any patches from you at around that date...
>>>>
>>> Fix [1] was later not added since there was a still a race. Wanted to
>>> see if the issue re-appears after recent netns fix [2].
>>
>>
>>
>> We will not see if the bug re-appears or not until this bug is closed.
>> Please see this recent discussion about another rds bug:
>> https://groups.google.com/d/msg/syzkaller-bugs/3XjmOzr5jRU/g7pXIsY1BgAJ
>> In the current state syzbot will never report bugs in these functions
>> again.
>>
> OK. Can you close that one then in that case ?

Anybody can do this:

#syz fix: rds: tcp: use rds_destroy_pending() to synchronize
netns/module teardown and rds connection/workq management

syzbot provides full self-service, see first email and in particular this:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot

Thanks
