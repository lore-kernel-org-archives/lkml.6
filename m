Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935161AbeBLQOD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:14:03 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33594 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbeBLQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:14:01 -0500
X-Google-Smtp-Source: AH8x226/p2vuJO3WlOpB4rRC1eHG/WfFsUUoNJEReFxKuXV2MMOrSGop3tDGXx8SBaPfXzw2ImHu3nQ/F1UZW6LCo0k=
MIME-Version: 1.0
In-Reply-To: <20171204184307.GU21978@ZenIV.linux.org.uk>
References: <001a1146fbf6a6305c055cfdf55e@google.com> <20171204164452.GT21978@ZenIV.linux.org.uk>
 <CACT4Y+ZxdSEV=vZmuGb_rXuM6CAyOD4SBCkEvkhkpb2czRLpNQ@mail.gmail.com> <20171204184307.GU21978@ZenIV.linux.org.uk>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 17:13:40 +0100
Message-ID: <CACT4Y+YksM_mARRKmD6eySitESyf+-wvRGpuORSCFGhB_mgqGg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __fput
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot
        <bot+7f44246e4b515a3908f27c3ac65d68c7c6cb4544@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2017 at 7:43 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Dec 04, 2017 at 07:39:29PM +0100, Dmitry Vyukov wrote:
>> On Mon, Dec 4, 2017 at 5:44 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > On Thu, Nov 02, 2017 at 04:05:01AM -0700, syzbot wrote:
>> >> Hello,
>> >>
>> >> syzkaller hit the following crash on
>> >> 3a99df9a3d14cd866b5516f8cba515a3bfd554ab
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> >> compiler: gcc (GCC) 7.1.1 20170620
>> >> .config is attached
>> >> Raw console output is attached.
>> >
>> > That one is almost certainly double-free in kcm_clone() fixed in
>> > https://marc.info/?l=linux-netdev&m=151208776817071&q=raw
>>
>> Hi,
>>
>> What's the title of that commit? We need the title for syzbot. "fix
>> kcm_clone()"? I don't see such commit in net-next.
>
> For a good and simple reason that it's _not_ in net-next yet.


#syz fix: fix kcm_clone()
