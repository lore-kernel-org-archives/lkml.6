Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A48C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96362418E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96362418E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGEJyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:54:52 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:34979 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbeGEJyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:54:51 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id B314B901AA;
        Thu,  5 Jul 2018 12:54:49 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 9562B2207B4; Thu,  5 Jul 2018 12:54:47 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 986002206D8;
        Thu,  5 Jul 2018 12:54:47 +0300 (EEST)
Date:   Thu, 5 Jul 2018 12:54:47 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I tried 4.18.0-rc1-00023-g9ffc59d57228 and now
> > 4.18.0-rc3-00113-gfc36def997cf on a 32-bit server and then some other
> > 32-bit machines, and got half-failed bootup - kernel and userspace come
> > up but some services fail to start, including network and
> > systemd-journald:
> >
> > systemd-journald[85]: Assertion 'clock_gettime(map_clock_id(clock_id), &ts) == 0' failed at ../src/basic/time-util.c:53, function now(). Aborting.
> >
> > I then tried multiple other machines. All x86-64 machines seem
> > unaffected, some x86-32 machines are affected (Athlon with AMD750
> > chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),
> > some very similar x86-32 machines are unaffected. I have different
> > customized kernel configuration on them, so far I have not pinpointed
> > any configuration option to be at fault.
> >
> > All machines run Debian unstable.
> >
> > 4.17.0 was working fine.
> >
> > Will continue with bisecting between 4.17.0 and
> > 4.18.0-rc1-00023-g9ffc59d57228.
> 
> That does sound like it is related to my patches indeed. If you are not
> yet done bisecting, please checkout commit e27c49291a7f ("x86: Convert
> x86_platform_ops to timespec64") before you try anything else, that
> one is the top of the branch with my changes. If that fails, the bisection
> will be much quicker.

This commit was fine. So it's likely something else.

-- 
Meelis Roos (mroos@linux.ee)
