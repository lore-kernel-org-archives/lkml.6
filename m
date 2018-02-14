Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031375AbeBNP2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:28:36 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:46103 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031334AbeBNP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:28:34 -0500
X-Google-Smtp-Source: AH8x225OcqJ0k9UcQiWTnIag9/kbatFno/VDnyQAShYdSEXC9jWUJAu8geqQFBnrZGghBVkebSAPk8imID+YnHvuApc=
MIME-Version: 1.0
In-Reply-To: <20180214152109.GF11528@oracle.com>
References: <001a1141a524c513ca05628d8ad4@google.com> <20180112183046.GA26098@oracle.com>
 <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com> <20180214152109.GF11528@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 16:28:13 +0100
Message-ID: <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
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

On Wed, Feb 14, 2018 at 4:21 PM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (02/14/18 16:11), Dmitry Vyukov wrote:
>>
>> Hi Sowmini,
>>
>> Was this ever fixed? What's the fix? This still hangs as open. Please
>> provide "syz fix" tag.
>
> Are you still seeing this problem?
>
> I had expected that the changes around rds_destroy_pending - see commit
> ebeeb1ad9b8a - would have taken care of this (note that ebeeb1ad9b8a
> refactors/updates 3db6e0d172c9) but those fixes were done by inspection
> only. In other words, I was never able to reproduce this, so we may
> still have missed some race condition.


syzbot is probably not seeing this problem. However if you don't add
the Reported-by tag to commit, nor provide syz fix tag, it will
consider it as "open". One consequence of this is that it is still on
our radars. Another consequence is that syzbot will never report bugs
in rds_tcp_tune ever again as it thinks that it's the same known bug,
so no point in bothering anybody.
