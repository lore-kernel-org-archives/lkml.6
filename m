Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F2C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB27B2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB27B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeKCKPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 06:15:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23162 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKCKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 06:15:53 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA3169AZ054416;
        Sat, 3 Nov 2018 10:06:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Sat, 03 Nov 2018 10:06:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA3164O2054398
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 3 Nov 2018 10:06:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in lo_release
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+a4e4a2663a21c3c3c2b1@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>
References: <000000000000f961390571457196@google.com>
 <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
 <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c3f63c2f-f163-d626-f96e-9e274b037124@i-love.sakura.ne.jp>
Date:   Sat, 3 Nov 2018 10:06:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/03 4:24, Dmitry Vyukov wrote:
>> Dmitry, it is impossible to check what these lock holders are doing without dump of these threads
>> (they are not always TASK_UNINTERRUPTIBLE waiters; e.g. PID=18508 is TASK_RUNNING with a lock held).
> 
> I know. One day I will hopefully get to implementing dump collection...
> 
>> Jens, when can we start testing "[PATCH v3] block/loop: Serialize ioctl operations." ?
> 
> Was that merged? If we have a potential fix, merging it may be the
> simplest way to address it without debugging.
> I see that this "[v4] block/loop: Serialize ioctl operations." still
> has "State: New":
> https://patchwork.kernel.org/patch/10612217/
> 

Jan Kara is going to resend https://marc.info/?i=20181010100415.26525-1-jack@suse.cz
after the merge window closes.
