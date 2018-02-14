Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162478AbeBNS7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:59:08 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:40611 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162460AbeBNS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:59:04 -0500
X-Google-Smtp-Source: AH8x225NQZ3oVrxOSjjkbvR9K9IXdqme/PTI1L+xPod+zi83DPXvzpQXaidQQGlnndfg/QGHRMHceQSAsznogeWeyf4=
MIME-Version: 1.0
In-Reply-To: <20180214184931.GA1718@ziepe.ca>
References: <001a1141a524c513ca05628d8ad4@google.com> <20180112183046.GA26098@oracle.com>
 <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
 <20180214152109.GF11528@oracle.com> <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
 <20180214153555.GG11528@oracle.com> <20180214184931.GA1718@ziepe.ca>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 19:58:43 +0100
Message-ID: <CACT4Y+b2F+4+MV4rWpMFJtps0fhfKdo3chETUTDSvWXtR2qxpg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rds_tcp_tune
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        syzbot <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 7:49 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Feb 14, 2018 at 10:35:55AM -0500, Sowmini Varadhan wrote:
>> On (02/14/18 16:28), Dmitry Vyukov wrote:
>> > syzbot is probably not seeing this problem. However if you don't add
>> > the Reported-by tag to commit, nor provide syz fix tag, it will
>> > consider it as "open". One consequence of this is that it is still on
>> > our radars. Another consequence is that syzbot will never report bugs
>> > in rds_tcp_tune ever again as it thinks that it's the same known bug,
>> > so no point in bothering anybody.
>>
>> understood, I think I saw this in the original syzbot mail as well,
>> but I was hesitant to actually add the tag because the fix was
>> based on code-inspection only, and I would have felt more comfortable
>> about asserting the Reported-by if I'd done a clear-cut before/after
>> verification.
>
> I think the point is you have to clear it from syzbot to get it to
> even test your patches, even if you are not totally sure your patch
> fixes it?

Sorry, I failed to parse this sentence. Can you please rephrase it?
