Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeDWKwb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:52:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:44886 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754808AbeDWKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:52:28 -0400
Subject: Re: WARNING: inconsistent lock state
To: syzbot <syzbot+9de458f6a5e713ee8c1a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <0000000000008eb847056a7a6c62@google.com>
Cc: akpm@linux-foundation.org, gs051095@gmail.com, lauraa@codeaurora.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, viresh.kumar@linaro.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4c75f8f7-1c32-585b-f0c4-971e7fd40536@I-love.SAKURA.ne.jp>
Date: Mon, 23 Apr 2018 19:52:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000008eb847056a7a6c62@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a side effect of doing GFP_KERNEL | __GFP_NOFAIL allocation attempt from IRQ context.

I think that this discussion will continue at
http://lkml.kernel.org/r/201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp .
