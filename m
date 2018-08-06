Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D7021A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D7021A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeHFQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:50:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56603 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:50:53 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76EfRDX078408;
        Mon, 6 Aug 2018 23:41:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 06 Aug 2018 23:41:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76EfQ9x078404
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 6 Aug 2018 23:41:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com,
        David Howells <dhowells@redhat.com>
References: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
 <00000000000070698b0572c28ebc@google.com>
 <20180806113212.GK19540@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <39db7dbc-fedf-a86e-3c8b-0192e83d3c8d@i-love.sakura.ne.jp>
Date:   Mon, 6 Aug 2018 23:41:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806113212.GK19540@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David Howells

On 2018/08/06 20:32, Michal Hocko wrote:
> On Mon 06-08-18 04:27:02, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger
>> crash:
>>
>> Reported-and-tested-by:
>> syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
>>
>> Tested on:
>>
>> commit:         8c8399e0a3fb Add linux-next specific files for 20180806
>> git tree:       linux-next
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fe18e2400000
>>
>> Note: testing is done by a robot and is best-effort only.
> 
> OK, so this smells like a problem in the previous group oom changes. Or
> maybe it is not very easy to reproduce?
> 

Since I can't find mm related changes between next-20180803 (syzbot can reproduce) and
next-20180806 (syzbot has not reproduced), I can't guess what makes this problem go away.

But since this problem did not occur for 3.5 hours on next-20180806 (when this problem
was occurring once per 60-90 minutes), the reproducer might not be working as intended
due to "kernfs, sysfs, cgroup, intel_rdt: Support fs_context" or something...

  ./kernel/cgroup/cgroup-internal.h                                          |    3
  ./kernel/cgroup/cgroup-v1.c                                                |  211
  ./kernel/cgroup/cgroup.c                                                   |   81
