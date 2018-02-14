Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031977AbeBNP4R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:56:17 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34260 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031959AbeBNP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:56:13 -0500
X-Google-Smtp-Source: AH8x227Gy85LwwxgA50Hqn8BUklmO9aRhJbtDpdT/dkIRftQQu0DNDW/oKbXFUD5L4XNJ0tUDVQUxFKcYHrTjyqDhz8=
MIME-Version: 1.0
In-Reply-To: <20180214153555.GG11528@oracle.com>
References: <001a1141a524c513ca05628d8ad4@google.com> <20180112183046.GA26098@oracle.com>
 <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
 <20180214152109.GF11528@oracle.com> <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
 <20180214153555.GG11528@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:55:51 +0100
Message-ID: <CACT4Y+ZZjE9fsnsQ-uab3RMt_Zpe98nKF1Pcj31ZGepYsi1UGA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rds_tcp_tune
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: syzbot <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 4:35 PM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (02/14/18 16:28), Dmitry Vyukov wrote:
>> syzbot is probably not seeing this problem. However if you don't add
>> the Reported-by tag to commit, nor provide syz fix tag, it will
>> consider it as "open". One consequence of this is that it is still on
>> our radars. Another consequence is that syzbot will never report bugs
>> in rds_tcp_tune ever again as it thinks that it's the same known bug,
>> so no point in bothering anybody.
>
> understood, I think I saw this in the original syzbot mail as well,
> but I was hesitant to actually add the tag because the fix was
> based on code-inspection only, and I would have felt more comfortable
> about asserting the Reported-by if I'd done a clear-cut before/after
> verification.
>
> btw, checkpatch.pl complains about the syzbot*@syzkaller.appspotmail.com
> addresses as "Unrecognized email address", we should fix that
> error from checkpatch at some point.

Interesting. Looking at checkpatch.pl I think it wants all addresses
to be in <>, i.e.
Reported-by: <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>
There probably was some reason to enforce this, so I think I will
change the syzbot email template to include <>.
Thanks!
