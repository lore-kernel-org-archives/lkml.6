Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeFDSNa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:13:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36983 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFDSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:13:28 -0400
X-Google-Smtp-Source: ADUXVKLFSQLCAPew7Iin/HJLILKhvO2135EjPfnY6nC0nS2otZBeH9omzoJkj7v+FgAhDvhDwMALFQ==
Subject: Re: [PATCH v3] block/loop: Serialize ioctl operations.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ce5ce21a-5865-36c5-a110-eed11f785ab2@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <748bce03-afda-4ed2-13b3-1fcd01d57770@kernel.dk>
Date: Mon, 4 Jun 2018 12:13:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ce5ce21a-5865-36c5-a110-eed11f785ab2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/18 5:19 AM, Tetsuo Handa wrote:
> This problem was already ignored for 8 months. Unless we boost priority,
> this problem will be ignored for years. Jens, can we test this patch?

Sorry, it's just that I _really_ hate this patch. We're making up
a weird locking primitive that tracks the process, with a weird
unlock helper that only unlocks if it's the process that is
holding the mutex.

I'll try and think about this a bit, it would be nice if we had
a better alternative than the above.

-- 
Jens Axboe
