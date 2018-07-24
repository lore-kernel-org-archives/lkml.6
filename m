Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D398120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D398120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeGXHQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:16:23 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:57462 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbeGXHQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:16:23 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id A0B7B9005D;
        Tue, 24 Jul 2018 09:11:31 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 84504220910; Tue, 24 Jul 2018 09:11:29 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 8C1C9220665;
        Tue, 24 Jul 2018 09:11:29 +0300 (EEST)
Date:   Tue, 24 Jul 2018 09:11:29 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
In-Reply-To: <4a48811d-4094-ee4c-33ca-2cf0446a6313@iogearbox.net>
Message-ID: <alpine.LRH.2.21.1807240756170.11834@math.ut.ee>
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

> >> I would be curious as well about that whether revert would make it
> >> work. What's the value of sysctl net.core.bpf_jit_enable ? Does it
> >> change anything if you set it to 0 (only interpreter) or 1 (JIT
> >> enabled). Seems a bit strange to me that bisect ended at this commit
> >> given the issue you have. The JIT itself was also new in this window
> >> fwiw. In any case some more debug info would be great to have.
> > 
> > net.core.bpf_jit_enable is 1.
> > 
> > Since it breaks bootup, I can not easily change the value at runtime (it 
> > would be postfactum). Do you mean changing the 
> > CONFIG_BPF_JIT_ALWAYS_ON=y option?
> 
> Yeah if you chance it to N, and don't have any fixed /etc/sysctl.conf
> setting, then you'll boot up with interpreter first (net.core.bpf_jit_enable
> as 0). Curious whether that works just fine for you.

Disabled CONFIG_BPF_JIT_ALWAYS_ON on v4.18-rc5 and it works, tested on 2 
bootups.

-- 
Meelis Roos (mroos@linux.ee)
