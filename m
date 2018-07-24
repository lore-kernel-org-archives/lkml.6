Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1D8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533BB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533BB20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbeGXFw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:52:27 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:35030 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388203AbeGXFw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:52:27 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id D89A190113;
        Tue, 24 Jul 2018 07:47:51 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id C39FA220910; Tue, 24 Jul 2018 07:47:49 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id C98002201DD;
        Tue, 24 Jul 2018 07:47:49 +0300 (EEST)
Date:   Tue, 24 Jul 2018 07:47:49 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <4a48811d-4094-ee4c-33ca-2cf0446a6313@iogearbox.net>
Message-ID: <alpine.LRH.2.21.1807240744570.11834@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee> <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com> <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com> <alpine.LRH.2.21.1807161948380.27791@math.ut.ee> <alpine.LRH.2.21.1807162200180.27791@math.ut.ee> <alpine.LRH.2.21.1807202339490.8506@math.ut.ee> <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
 <CAK8P3a19pCbn5Ns0jVqGTiSmGj4AOgjWL0CQtAA-sYRqY4Gvjw@mail.gmail.com> <32227088-7754-c160-8046-e860f42ca91c@iogearbox.net> <alpine.LRH.2.21.1807232322430.11834@math.ut.ee> <4a48811d-4094-ee4c-33ca-2cf0446a6313@iogearbox.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anyway, I started compile of v4.18-rc5 that was the latest I tested, 
> > with the commit in question reverted. Will see if I can test tomorrow 
> > morning. But I will leave tomorrow for a week and can only test further 
> > things if they happen to boot fine (no manual reboot possible for a 
> > week).
> 
> Ok, thanks, please keep us posted on the outcome with the revert. Right
> now I would doubt it's related resp. changes anything on the issue, but
> lets see.

v4.18-rc5 minus the patch in question worked fine on 2 bootups so it 
seems to be good.

-- 
Meelis Roos (mroos@linux.ee)
