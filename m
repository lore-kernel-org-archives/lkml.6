Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3DC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3DC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbeGXMvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:51:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37411 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbeGXMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:51:12 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6OBiqFa093786;
        Tue, 24 Jul 2018 20:44:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Tue, 24 Jul 2018 20:44:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6OBilFn093773
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 24 Jul 2018 20:44:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: linux-next build error (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com>,
        harry.wentland@amd.com, alexander.deucher@amd.com,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000f0ec4f0571a91339@google.com>
 <CACT4Y+bhQGLGPKSy48JJ8pHai3C=CcLC4B0Xa0ODXwyvDsisFw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <30f47a5c-1357-5c28-10b9-be02003d5a35@I-love.SAKURA.ne.jp>
Date:   Tue, 24 Jul 2018 20:44:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bhQGLGPKSy48JJ8pHai3C=CcLC4B0Xa0ODXwyvDsisFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

Can you temporarily disable config options which are causing this build error?
syzbot is failing to test next-20180723 and next-20180724 due to this problem.

By the way, ".config" at
https://syzkaller.appspot.com/bug?id=bd788040e839b85be53a030f219a2a1e4dc8acd2 is
failing because of empty link.

  <a href="">.config</a>

On 2018/07/23 20:39, Dmitry Vyukov wrote:
> On Mon, Jul 23, 2018 at 1:38 PM, syzbot
> <syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    6d93abaf4c5b Add linux-next specific files for 20180723
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10e02f0c400000
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9118f0a7ae77f4eee4a9
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com
> 
> +Matthias,
> 
> I guess this is caused by one of the following commits, and probably
> affects KASAN and similar tools:
> 
> commit cc32ad8f559c36ca2433d282aff690a6842a3a27
> Date:   Thu Feb 8 12:53:16 2018 -0800
> 
>     amdgpu/dc/calcs: Support clang option for stack alignment
> 
> commit 37172013fa2e527735ec9eda51a11cfea3af0ff1
> Date:   Thu Feb 8 12:53:14 2018 -0800
> 
>     amdgpu/dc/calcs: Consolidate redundant CFLAGS
> 
