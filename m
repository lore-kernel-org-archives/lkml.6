Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5268DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C2D218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfAaKT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:19:26 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:38908 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:19:26 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0VAIqAt007207;
        Thu, 31 Jan 2019 19:18:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Thu, 31 Jan 2019 19:18:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0VAIlBt007091
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 19:18:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@fb.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
 <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
 <20190130114052.GB30781@kroah.com>
 <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <511b89e2-9c0d-c4a2-de27-e803bc20c38c@i-love.sakura.ne.jp>
Date:   Thu, 31 Jan 2019 19:18:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/31 19:09, Kees Cook wrote:
> FYI, this patch does not fix the relay.c crash I bisected... I think
> more clean-up is needed?

You mean "general protection fault in relay_open_buf" at
https://syzkaller.appspot.com/bug?id=080fbc3a5d10bd8ada100799168ebe1b70e2eefa ?
