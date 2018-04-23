Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbeDWLC1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:02:27 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43568 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeDWLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:01:38 -0400
X-Google-Smtp-Source: AIpwx4+UY/t56JVThOz+seaPdi7JgSHTYeUZHDy+LKHIcdpQ5bzpJOFzAJR8VGV0B+KsP2HHS5MzFgU7I0SEz3uTlt8=
MIME-Version: 1.0
In-Reply-To: <4c75f8f7-1c32-585b-f0c4-971e7fd40536@I-love.SAKURA.ne.jp>
References: <0000000000008eb847056a7a6c62@google.com> <4c75f8f7-1c32-585b-f0c4-971e7fd40536@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 13:01:17 +0200
Message-ID: <CACT4Y+b5ZmCe4_1MS-C_cX76UUiewDuRrPZSf0zO_tCbPp=SXg@mail.gmail.com>
Subject: Re: WARNING: inconsistent lock state
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>, gs051095@gmail.com,
        lauraa@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 12:52 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> This is a side effect of doing GFP_KERNEL | __GFP_NOFAIL allocation attempt from IRQ context.
>
> I think that this discussion will continue at
> http://lkml.kernel.org/r/201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp .

These 2 also look related:

https://syzkaller.appspot.com/bug?id=0e06e9b4ed9a043361196cb8413cdc16a15b4b1f
https://syzkaller.appspot.com/bug?id=80b25476ac7eedf5870b43464fd8f3bbfe912b90
