Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09958C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105821779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B105821779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbeHGNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:39:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbeHGNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:39:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9DEBACE2;
        Tue,  7 Aug 2018 11:25:23 +0000 (UTC)
Date:   Tue, 7 Aug 2018 13:25:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: WARNING in try_charge
Message-ID: <20180807112522.GA10003@dhcp22.suse.cz>
References: <20180806181339.GD10003@dhcp22.suse.cz>
 <0000000000002ec4580572c85e46@google.com>
 <20180806185554.GG10003@dhcp22.suse.cz>
 <CACT4Y+Zg3DhAnKWBAyJ-Y-3XVL+jCQy1U2iWR8mdraX6w23X_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zg3DhAnKWBAyJ-Y-3XVL+jCQy1U2iWR8mdraX6w23X_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-08-18 13:18:00, Dmitry Vyukov wrote:
[...]
> Great we are making progress here!
> 
> So if it's something to fix in kernel we just leave WARN alone. It
> served its intended purpose of notifying kernel developers about
> something to fix in kernel.

Yes, agreed! And the way how your syzbot automation works made it so
much easier so thanks a lot!

The patch has been posted http://lkml.kernel.org/r/20180807072553.14941-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
