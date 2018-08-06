Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C94C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34BC21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34BC21A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeHFRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:21:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59919 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:21:38 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76FC4LT091224;
        Tue, 7 Aug 2018 00:12:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 07 Aug 2018 00:12:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76FC4Vh091209
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 00:12:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com,
        David Howells <dhowells@redhat.com>
References: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
 <00000000000070698b0572c28ebc@google.com>
 <20180806113212.GK19540@dhcp22.suse.cz>
 <39db7dbc-fedf-a86e-3c8b-0192e83d3c8d@i-love.sakura.ne.jp>
 <20180806145833.GA8607@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <570de9f7-eda8-ec72-a4d0-92b4cc2b4fd7@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 00:12:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806145833.GA8607@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/06 23:58, Michal Hocko wrote:
>> Since I can't find mm related changes between next-20180803 (syzbot can reproduce) and
>> next-20180806 (syzbot has not reproduced), I can't guess what makes this problem go away.
> 
> Hmm, but original report was against 4.18.0-rc6-next-20180725+ kernel.
> And that one had the old group oom code. /me confused.
> 

Yes. But I confirmed that syzbot can reproduce this problem with next-20180803
which already dropped the old group oom code. Therefore, I think that syzbot is
hitting a problem other than the old group oom code.
