Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m7eMNY9mG1vvHAAAmS7hNA
	; Sat, 09 Jun 2018 05:33:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4D856089E; Sat,  9 Jun 2018 05:33:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 55DB2607A4;
	Sat,  9 Jun 2018 05:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55DB2607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeFIFdB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 01:33:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:16527 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeFIFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 01:33:00 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w595UleC074809;
        Sat, 9 Jun 2018 14:30:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sat, 09 Jun 2018 14:30:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w595Ugl3074791
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 9 Jun 2018 14:30:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in wb_workfn (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
Date: Sat, 9 Jun 2018 14:30:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> Here we go:

Great. Thank you.

> 
> [ 2853.033175] WARNING: wb_workfn: device is NULL
> [ 2853.034709] wb->state=2
> 

It is surprising that wb->state == WB_shutting_down .

WB_shutting_down is set by only wb_shutdown() and is always cleared
before leaving wb_shutdown(). This means that someone was calling
wb_shutdown() on this wb object. And bdi->dev == NULL means that
bdi_unregister() already did bdi->dev = NULL while someone was still
inside wb_shutdown().

Since we call wb_shutdown() from bdi_unregister() for each wb object
on this bdi object, this should not happen. But since "INFO: task hung
in wb_shutdown (2)" found that it is possible that wb_shutdown() is
concurrently called on the same wb object, there might be something
complicated concurrency.

Well, is it really true that "we call wb_shutdown() from bdi_unregister()
for each wb object on this bdi object"? It seems it is not always true...

While cgwb_bdi_unregister() from bdi_unregister() calls wb_shutdown() on
each wb object reachable from bdi->wb_list, wb_shutdown() firstly calls
list_del_rcu(&wb->bdi_node) (which was added by
list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list) from cgwb_create()) and
then starts waiting for that wb object by calling
mod_delayed_work()/flush_delayed_work() and then clears WB_shutting_down.

Then, it is possible that cgwb_bdi_unregister() from calls wb_shutdown()
fails to find a wb object which already passed list_del_rcu() from
wb_shutdown(), and cgwb_bdi_unregister() can return without waiting for
somebody who is waiting inside wb_shutdown(). Hence, allows doing
bdi->dev = NULL before a wb object which somebody is waiting inside
wb_shutdown() completes wb_workfn(), and NULL pointer dereference...
