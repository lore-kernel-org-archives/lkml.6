Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B349C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7A269C2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C7A269C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeFZUhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:37:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:47821 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeFZUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:37:46 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5QKb2Ks043677;
        Wed, 27 Jun 2018 05:37:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 27 Jun 2018 05:37:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5QKb2nl043673
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 Jun 2018 05:37:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: what trees/branches to test on syzbot
To:     Guenter Roeck <groeck@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
 <20180626141602.GA17788@thunk.org>
 <CACT4Y+YH3Z1q9aVTUgTbTPfDp2ao-z=YAjzBGU5HsjGJ-utgeg@mail.gmail.com>
 <CABXOdTe1HCy78w+G4LuN8S7Ad5kvUxwHsiP2a=8aW-jEvpjdug@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <876e38d9-95e5-0a93-9c26-7287151b8b53@i-love.sakura.ne.jp>
Date:   Wed, 27 Jun 2018 05:37:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABXOdTe1HCy78w+G4LuN8S7Ad5kvUxwHsiP2a=8aW-jEvpjdug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/26 23:54, Guenter Roeck wrote:
> On Tue, Jun 26, 2018 at 7:38 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Tue, Jun 26, 2018 at 4:16 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>> On Tue, Jun 26, 2018 at 07:54:53PM +0900, Tetsuo Handa wrote:
>>>> I hope we can accept NOW either "reviving linux-next.git" or "allowing debug printk()
>>>> patches for linux.git". For example, "INFO: task hung in __sb_start_write" got 900
>>>> crashes in 81 days but still unable to find a reproducer. Dmitry tried to reproduce
>>>> locally with debug printk() patches but not yet successful. I think that testing with
>>>> http://lkml.kernel.org/r/f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp
>>>> on linux.git or linux-next.git is the only realistic way for debugging this bug.
>>>> More we postpone revival of the linux-next, more syzbot reports we will get...
>>>
>>> Here's a proposal for adding linux-next back:
>>>
>>> *) Subsystems or maintainers need to have a way to opt out of getting
>>>    spammed with Syzkaller reports that have no reproducer.  More often
>>>    than not, they are not actionable, and just annoy the maintainers,
>>>    with the net result that they tune out all Syzkaller reports as
>>>    noise.
>>
>> False. You can count yourself. 2/3 are actionable and fixed.
>>
> 
> Problem is that some if not many of the other 1/3 will be considered
> noise, and even some of the 2/3 will be considered noise because they
> have already been fixed by the time they are reported. Same problem as
> with, say, stable tree merges: People don't see the thousands of bug
> fixes inherited with such merges, but they do see the two or three
> regressions. Plus, of course, one can not prove that the thousands of
> bug fixes did any good because the fixed bugs are not observable
> anymore. The only remedy is to try to reduce regressions down to zero
> (or, of course, stop using/merging stable releases).
> 
> The same applies here: People won't see the good, they only see the
> noise. This is pretty much the reason why I all but stopped reporting
> build/boot failures on -next. You would have to reduce the noise
> almost down to zero for people to stop complaining, and you would have
> to be _really_ sure that the problem was not already fixed or reported
> elsewhere.
> 
> Guenter
> 

I think that syzbot can stop deciding email recipients and leave it to those who
diagnose bugs, for the ratio of sending to wrong subsystem maintainers is not low.
For example, syzbot assumed that "INFO: task hung in __get_super" is a fs layer bug.
But I think that the problem is in more lower layers (block or mm or locking layer).
The root cause could even be just overstressed due to instructions enabled by
CONFIG_KCOV_ENABLE_COMPARISONS=y.
