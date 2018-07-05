Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B8E21AA5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B8E21AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeGEKt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:49:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59031 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeGEKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:49:57 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w65AnGRl094367;
        Thu, 5 Jul 2018 19:49:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 05 Jul 2018 19:49:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w65An9QU094310
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 5 Jul 2018 19:49:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: what trees/branches to test on syzbot
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Guenter Roeck <groeck@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
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
 <876e38d9-95e5-0a93-9c26-7287151b8b53@i-love.sakura.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <8c9027d6-ead2-1cca-4410-c8dbbe4bf2ea@I-love.SAKURA.ne.jp>
Date:   Thu, 5 Jul 2018 19:49:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <876e38d9-95e5-0a93-9c26-7287151b8b53@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/27 5:37, Tetsuo Handa wrote:
> I think that syzbot can stop deciding email recipients and leave it to those who
> diagnose bugs, for the ratio of sending to wrong subsystem maintainers is not low.
> For example, syzbot assumed that "INFO: task hung in __get_super" is a fs layer bug.
> But I think that the problem is in more lower layers (block or mm or locking layer).
> The root cause could even be just overstressed due to instructions enabled by
> CONFIG_KCOV_ENABLE_COMPARISONS=y.
> 

Thinking from today's bpf related reports, I think that subversion/quilt-based
custom patches will be useful as well.

Since quilt can apply changes in a patch atomically (using "quilt push" command),
we can maintain one custom patch for one git tree. Then, the kernel source syzbot
will test is either "no custom patch applied" or "only one custom patch applied".
That is, if "quilt push" fails, syzbot will continue testing without custom patch.

Since subversion manages revision number using an integer, adding a column for
indicating "which custom patch was applied for this report" to the table will not
occupy much space. We will figure out that custom patch needs to be updated via
syzbot reports with that column being empty.

The custom patch can contain whatever changes which might be useful for debugging.
For example, debug printk() for "INFO: task hung in __sb_start_write" case.
For another example, context identifier for printk().

Updating custom patches in subversion repository is done manually. But the cost is
negligible.
