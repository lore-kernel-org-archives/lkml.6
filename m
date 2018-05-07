Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeEGU4j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:56:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59620 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeEGU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:56:37 -0400
Subject: Re: general protection fault in lo_ioctl (2)
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
References: <000000000000cbaaf6056b341859@google.com>
 <CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <2030b2cf-29f9-7bfd-8266-b39abc19bdfe@I-love.SAKURA.ne.jp>
Date: Tue, 8 May 2018 05:56:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/02 20:23, Dmitry Vyukov wrote:
> #syz dup: INFO: rcu detected stall in blkdev_ioctl

The cause of stall turned out to be ioctl(loop_fd, LOOP_CHANGE_FD, loop_fd).

But we haven't explained the cause of NULL pointer dereference which can
occur when raced with ioctl(LOOP_CLR_FD). Therefore,

#syz undup
