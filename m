Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbeDWVoA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:44:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18407 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeDWVn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:43:57 -0400
Subject: Re: general protection fault in wb_workfn
To: Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <000000000000e563d7056a35bbb3@google.com>
 <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1a40d046-9994-ad02-8f29-c4952429e557@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 06:43:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/04/23 19:09, Tetsuo Handa wrote:
> By the way, I got a newbie question regarding commit 5318ce7d46866e1d ("bdi:
> Shutdown writeback on all cgwbs in cgwb_bdi_destroy()"). It uses clear_bit()
> to clear WB_shutting_down bit so that threads waiting at wait_on_bit() will
> wake up. But clear_bit() itself does not wake up threads, does it? Who wakes
> them up (e.g. by calling wake_up_bit()) after clear_bit() was called?
> 

Below report might be waiting for wake_up_bit() ?

  INFO: task hung in wb_shutdown (2)
  https://syzkaller.appspot.com/bug?id=b297474817af98d5796bc544e1bb806fc3da0e5e
