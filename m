Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00FFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE721A09
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CE721A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbeHFNkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:40:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:32786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728515AbeHFNkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:40:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B555AE1B;
        Mon,  6 Aug 2018 11:32:13 +0000 (UTC)
Date:   Mon, 6 Aug 2018 13:32:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: WARNING in try_charge
Message-ID: <20180806113212.GK19540@dhcp22.suse.cz>
References: <884de816-671a-44d4-a6a1-2ad7eff53715@I-love.SAKURA.ne.jp>
 <00000000000070698b0572c28ebc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000070698b0572c28ebc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-08-18 04:27:02, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
> 
> Reported-and-tested-by:
> syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         8c8399e0a3fb Add linux-next specific files for 20180806
> git tree:       linux-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fe18e2400000
> 
> Note: testing is done by a robot and is best-effort only.

OK, so this smells like a problem in the previous group oom changes. Or
maybe it is not very easy to reproduce?

-- 
Michal Hocko
SUSE Labs
