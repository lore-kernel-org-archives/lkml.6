Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7nDSOYZyG1slaQAAmS7hNA
	; Sat, 09 Jun 2018 06:39:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0A89607E7; Sat,  9 Jun 2018 06:39:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0401600D0;
	Sat,  9 Jun 2018 06:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0401600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeFIGjY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:39:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48548 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeFIGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:37:02 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w596VUtN095423;
        Sat, 9 Jun 2018 15:31:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 09 Jun 2018 15:31:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w596VPI7095409
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 9 Jun 2018 15:31:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: what trees/branches to test on syzbot
To: Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
Date: Sat, 9 Jun 2018 15:31:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/01/22 22:32, Dmitry Vyukov wrote:
> On Tue, Jan 16, 2018 at 6:34 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>> The problem is testing linux-next and then using get-maintainer.pl to
>>> report the problem.
>>>
>>> If you are resource limited I would start by testing Linus's tree to
>>> find the existing bugs, and to get a baseline.  Using get-maintainer.pl
>>> is fine for sending emails to developers there.
>>
>> I second this, almost all of the issues you are hitting are usually in
>> Linus's tree.  Let's make that "clean" first, before messing around and
>> adding 100+ other random developer's trees into the mix :)
> 
> FTR I've just dropped linux-next and mmots from syzbot.
> 

I hope that we can test linux-next on syzbot, as a tree for testing debug
printk() patches. People do not like sending debug printk() patches to
Linus's tree, while majority of bugs are found in Linus's tree.

We could automatically expire (and delete) reports found in linux-next from
the table at https://syzkaller.appspot.com/ if the bug was not reproduced
for some time (e.g. one week or one month).
