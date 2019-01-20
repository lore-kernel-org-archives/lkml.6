Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7EAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38232084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfATBwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:52:38 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:44805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfATBwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:52:38 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0K1pSlg064292;
        Sun, 20 Jan 2019 10:51:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sun, 20 Jan 2019 10:51:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0K1pSCS064288
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 20 Jan 2019 10:51:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_creat
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+3155335ece2c94bead44@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000f93b510578c046bc@google.com>
 <CACT4Y+YC-=7+1DYeWD=Z53Tr-KBLTo3LG61i_8-_h3MY36rquw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <aa24ec86-a331-4da4-475f-eb8f487d31d4@i-love.sakura.ne.jp>
Date:   Sun, 20 Jan 2019 10:51:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YC-=7+1DYeWD=Z53Tr-KBLTo3LG61i_8-_h3MY36rquw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/20 4:00, Dmitry Vyukov wrote:
> "On Sun, Oct 21, 2018 at 7:15 PM syzbot
> <syzbot+3155335ece2c94bead44@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=160c9245400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3155335ece2c94bead44
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
> 
> +Tetsuo, Jan, Jens
> 
> This is a stall, but it involves __getblk_gfp. Is it the same bug as
> "INFO: task hung in generic_file_write_iter":
> https://syzkaller.appspot.com/bug?id=8afdd02539e35fc02ac7699014bc54a87fdd8dc0
> which will be fixed with "blockdev: Fix livelocks on loop device".
> 
> This bug also has 10 other duplicates:
> https://syzkaller.appspot.com/bug?extid=3155335ece2c94bead44

Yes, I think so.

#syz dup: INFO: task hung in generic_file_write_iter
