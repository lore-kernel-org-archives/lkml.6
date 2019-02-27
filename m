Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F5C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E202063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfB0WhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:37:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:23679 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0WhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:37:12 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1RMao60093202;
        Thu, 28 Feb 2019 07:36:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Thu, 28 Feb 2019 07:36:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1RMakuK093016
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 28 Feb 2019 07:36:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: MAC Initialization failed.
To:     syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <0000000000001c63c80582e32294@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        takedakn@nttdata.co.jp
Message-ID: <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
Date:   Thu, 28 Feb 2019 07:36:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0000000000001c63c80582e32294@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/28 2:02, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15336f14c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1b8084e532b6ee7afab
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ee708ac00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16954084c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com

Thank you. The LSM stacking seems to be working as expected.
But this one should not be considered as a bug.

If something went wrong before loading access control rules,
it is pointless to continue. Thus, stopping with kernel panic.

If this path is trivially triggered enough to prevent testing, syzbot can
load access control rules from /etc/tomoyo/ directory of the filesystem
image and make tomoyo_policy_loaded = true by executing /sbin/init .

Hmm, maybe we need to think about automated testing environments where
neither built-in access control rules nor run-time access control rules
can be provided ... ?

#syz invalid

