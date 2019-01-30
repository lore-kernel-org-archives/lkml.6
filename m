Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D67CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDA120857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfA3Kxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:53:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:15152 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3Kxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:53:48 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UArcK9091404;
        Wed, 30 Jan 2019 19:53:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Wed, 30 Jan 2019 19:53:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UArVXK091334
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 30 Jan 2019 19:53:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: executor-detected bug
To:     Dmitry Vyukov <dvyukov@google.com>
References: <000000000000419244058088e841@google.com>
Cc:     syzbot <syzbot+cea928fd1f13d3cbeee3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <dc8bb665-c30f-be49-0592-6b6560a3e9a4@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Jan 2019 19:53:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <000000000000419244058088e841@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/29 3:33, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    30bac164aca7 Revert "Change mincore() to count "mapped" pa..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11888d5f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> dashboard link: https://syzkaller.appspot.com/bug?extid=cea928fd1f13d3cbeee3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be4390c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cea928fd1f13d3cbeee3@syzkaller.appspotmail.com
> 
> vice hsr_slave_0 left promiscuous mode
> 2019/01/24 16:52:39 executed programs: 197
> 2019/01/24 16:52:41 BUG: executor-detected bug:
> child errored
> loop errored
> 2019/01/24 16:52:41 result: failed=true hanged=false err=executor 0: detected kernel bug
> 
> child errored
> loop errored

This error message was triggered by

  doexit(kErrorStatus);

in executor/executor.cc . This is not a kernel bug.

#syz invalid
