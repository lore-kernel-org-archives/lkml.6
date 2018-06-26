Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B61CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E68216F3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E68216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeFZKzo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:55:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:35311 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFZKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:55:43 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5QAt0RX008436;
        Tue, 26 Jun 2018 19:55:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 26 Jun 2018 19:55:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5QAsrYU008395
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 26 Jun 2018 19:54:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: what trees/branches to test on syzbot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
Date:   Tue, 26 Jun 2018 19:54:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/10 7:17, Linus Torvalds wrote:
> On Fri, Jun 8, 2018 at 11:36 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2018/01/22 22:32, Dmitry Vyukov wrote:
>>>
>>> FTR I've just dropped linux-next and mmots from syzbot.
>>
>> I hope that we can test linux-next on syzbot, as a tree for testing debug
>> printk() patches.
> 
> I think it would be lovely to get linux-next back eventually, but it
> sounds like it's just too noisy right now, and yes, we should have a
> baseline for the standard tree first.
> 
> But once there's a "this is known for the baseline", I think adding
> linux-next back in and then maybe even have linux-next simply just
> kick out trees that cause problems would be a good idea.
> 
> Right now linux-next only kicks things out based on build issues (or
> extreme merge issues), afaik. But it *would* be good to also have
> things like syzbot do quality control on linux-next.
> 
> Because the more things get found and fixed before they even hit my
> tree, the better.
> 
>                 Linus
> 

I hope we can accept NOW either "reviving linux-next.git" or "allowing debug printk()
patches for linux.git". For example, "INFO: task hung in __sb_start_write" got 900
crashes in 81 days but still unable to find a reproducer. Dmitry tried to reproduce
locally with debug printk() patches but not yet successful. I think that testing with
http://lkml.kernel.org/r/f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp
on linux.git or linux-next.git is the only realistic way for debugging this bug.
More we postpone revival of the linux-next, more syzbot reports we will get...

