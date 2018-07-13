Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A53ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95626208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95626208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeGMKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:53:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:11977 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeGMKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:53:23 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6DAcDGG097677;
        Fri, 13 Jul 2018 19:38:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 13 Jul 2018 19:38:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6DAcCv5097674
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 13 Jul 2018 19:38:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000283c37056b4a81a5@google.com>
 <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net>
 <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
 <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
 <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp>
 <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
 <51f1de87-3fbe-48f6-0297-9717d9919772@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <03633af8-fab8-a985-c215-f619ea4ded08@I-love.SAKURA.ne.jp>
Date:   Fri, 13 Jul 2018 19:38:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <51f1de87-3fbe-48f6-0297-9717d9919772@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry noticed what is wrong and fixed the bug as
https://github.com/google/syzkaller/commit/06c33b3af0ff4072fb002879f83077c9d162a224 .

Since the bug did not reproduce for last 24 hours, it is OK to close this report.

#syz invalid

Thanks all.

