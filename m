Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E06219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E06219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbeHFROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:14:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41983 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732410AbeHFROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:14:12 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76F4g0k086092;
        Tue, 7 Aug 2018 00:04:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Tue, 07 Aug 2018 00:04:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76F4fCK086087
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 00:04:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     David Howells <dhowells@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <39db7dbc-fedf-a86e-3c8b-0192e83d3c8d@i-love.sakura.ne.jp>
 <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
 <00000000000070698b0572c28ebc@google.com>
 <20180806113212.GK19540@dhcp22.suse.cz>
 <15945.1533567280@warthog.procyon.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3cc11dd9-6f83-741d-2e76-03c35865ee0b@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 00:04:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15945.1533567280@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/06 23:54, David Howells wrote:
> Do you have a link to the problem?
> 
> David
> 

https://groups.google.com/forum/#!msg/syzkaller-bugs/R03vI7RCVco/0PijCTrcCgAJ

syzbot found a reproducer, and the reproducer was working until next-20180803.
But the reproducer is failing to reproduce this problem in next-20180806 despite
there is no mm related change between next-20180803 and next-20180806.

Therefore, I suspect that the reproducer is no longer working as intended. And
there was parser change (your patch) between next-20180803 and next-20180806.

