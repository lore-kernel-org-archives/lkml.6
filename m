Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDFPxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:53:49 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34734 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeDFPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:53:48 -0400
X-Google-Smtp-Source: AIpwx4/n9b84QQiibasyyYHsIvajyo8ABd/dt7AYeQqLo2+ZqDFulhyuiZ2mSHnLtCdDty2GkZyY9Q==
Subject: Re: INFO: task hung in __blkdev_get
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, Ming Lei <tom.leiming@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org,
        syzbot
        <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <f403043a9be410acd1055fe5f72e@google.com>
 <652eab47-81b5-3249-3c78-427eeec45fbc@I-love.SAKURA.ne.jp>
 <2e093801-6d71-6747-42df-52f191811ad0@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
Date: Fri, 6 Apr 2018 09:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2e093801-6d71-6747-42df-52f191811ad0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/18 4:12 AM, Tetsuo Handa wrote:
> ----------------------------------------
> 
> The reason of q->mq_freeze_depth == 1 turned out that loop_set_status()
> forgot to call blk_mq_unfreeze_queue() at error paths for
> info->lo_encrypt_type != NULL case.

Thanks for finding this, applied.

-- 
Jens Axboe
