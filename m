Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46959C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B114E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966368AbeFSNCi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:02:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:43953 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965961AbeFSNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:02:36 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5JD1RQt064775;
        Tue, 19 Jun 2018 22:01:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Tue, 19 Jun 2018 22:01:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5JD0oEA064521
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 Jun 2018 22:01:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
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
 <CACT4Y+bvd+z3F4H5Y_W03Txi09UzU6CJqR1Ymid94quj5nELhA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e7c307e5-97be-8fe7-1380-42201e043de3@i-love.sakura.ne.jp>
Date:   Tue, 19 Jun 2018 22:00:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bvd+z3F4H5Y_W03Txi09UzU6CJqR1Ymid94quj5nELhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/19 20:47, Dmitry Vyukov wrote:
>> If no, we would want a git tree for testing under syzbot.
> 
> Thinking of this, we could setup a sandbox instance that won't report
> anything over email at all, but crashes will be available on the web.
> We could point this instance to a custom git tree, where additional
> patches can be applied as necessary.  The main question is: who and
> how will manage this tree? The tree needs to be rebased periodically,
> patches applied, old patches taken out.
> 

The simplest approach (if Linus can tolerate) would be to merge any
debug printk() patches to linux.git with single kernel config option
(e.g. CONFIG_DEBUG_AID_FOR_SYZBOT=y) for turning them on/off.
Assuming that we will eventually be able to move to saving and analyzing
vmcore files, some bit of debug printk() code would be tolerable for now?

Other possible approach (if Andrew can tolerate) would be to use
linux-next.git and carry debug printk() patches via mmotm tree.

