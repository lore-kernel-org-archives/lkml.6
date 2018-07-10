Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA78C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC017208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC017208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeGJCOt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:14:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41219 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:14:43 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6A2DwTQ017409;
        Tue, 10 Jul 2018 11:13:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Tue, 10 Jul 2018 11:13:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6A2Dwbi017404;
        Tue, 10 Jul 2018 11:13:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w6A2Dwu9017402;
        Tue, 10 Jul 2018 11:13:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807100213.w6A2Dwu9017402@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: what trees/branches to test on syzbot
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Guenter Roeck <groeck@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <fengguang.wu@intel.com>
MIME-Version: 1.0
Date:   Tue, 10 Jul 2018 11:13:58 +0900
References: <e05a0804-6759-7579-c1d6-f0e80daf36ae@I-love.SAKURA.ne.jp> <20180709173546.dc720ad918e5362b8be2e034@linux-foundation.org>
In-Reply-To: <20180709173546.dc720ad918e5362b8be2e034@linux-foundation.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 7 Jul 2018 08:26:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
> > Hello Andrew,
> > 
> > It seems that syzbot (experimentally ?) restarted testing linux-next.
> > 
> > May I ask you to carry temporarily debug printk() patch at
> > https://groups.google.com/d/msg/syzkaller-bugs/E8M8WTqt034/OpadOICfCAAJ
> > for "INFO: task hung in __sb_start_write" case?
> > 
> > The bug should be reproduced within a day if executed under syzbot environment.
> > Thus, I'm sure that we don't need to carry this patch for long.
> 
> Sure, I can add that.

Thank you.

>                        Let's get the build warning sorted out first,
> please.  Any old silly workaround will suffice in a developer-only
> debug patch.

The build warning is about mips architecture rather than this patch itself,
for x86_64 builds fine. You can add this patch despite the build warning.
