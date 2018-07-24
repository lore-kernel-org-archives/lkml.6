Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B41204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B41204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeGXTsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:48:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:46217 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388419AbeGXTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:48:23 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fi2Ec-0003Od-Bh; Tue, 24 Jul 2018 20:40:34 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fi2Eb-000C7M-Ky; Tue, 24 Jul 2018 20:40:34 +0200
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
 <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
 <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
 <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
 <alpine.LRH.2.21.1807161948380.27791@math.ut.ee>
 <alpine.LRH.2.21.1807162200180.27791@math.ut.ee>
 <alpine.LRH.2.21.1807202339490.8506@math.ut.ee>
 <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
 <CAK8P3a19pCbn5Ns0jVqGTiSmGj4AOgjWL0CQtAA-sYRqY4Gvjw@mail.gmail.com>
 <32227088-7754-c160-8046-e860f42ca91c@iogearbox.net>
 <alpine.LRH.2.21.1807232322430.11834@math.ut.ee>
 <4a48811d-4094-ee4c-33ca-2cf0446a6313@iogearbox.net>
 <alpine.LRH.2.21.1807240744570.11834@math.ut.ee>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bc29beb2-f4c5-3d6c-2b64-1c0e11af4241@iogearbox.net>
Date:   Tue, 24 Jul 2018 20:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1807240744570.11834@math.ut.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24779/Tue Jul 24 18:43:34 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 06:47 AM, Meelis Roos wrote:
>>> Anyway, I started compile of v4.18-rc5 that was the latest I tested, 
>>> with the commit in question reverted. Will see if I can test tomorrow 
>>> morning. But I will leave tomorrow for a week and can only test further 
>>> things if they happen to boot fine (no manual reboot possible for a 
>>> week).
>>
>> Ok, thanks, please keep us posted on the outcome with the revert. Right
>> now I would doubt it's related resp. changes anything on the issue, but
>> lets see.
> 
> v4.18-rc5 minus the patch in question worked fine on 2 bootups so it 
> seems to be good.

And this was with CONFIG_BPF_JIT_ALWAYS_ON=y, correct? Could you try the
same with this below applied:

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 5579987..313c983 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -175,7 +175,7 @@ static const u8 bpf2ia32[][2] = {
 #define SCRATCH_SIZE 96

 /* Total stack size used in JITed code */
-#define _STACK_SIZE	(stack_depth + SCRATCH_SIZE)
+#define _STACK_SIZE	(stack_depth + SCRATCH_SIZE + 4)

 #define STACK_SIZE ALIGN(_STACK_SIZE, STACK_ALIGNMENT)


Thanks,
Daniel
