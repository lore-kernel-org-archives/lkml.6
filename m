Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62516C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5420834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="0KXEl8RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D5420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725751AbeLBHfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:35:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35863 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:35:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so8408430wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2jC8pAZNAG4QZTGvbUujShbOS+kjlE3VGoi7RJaHmVM=;
        b=0KXEl8RPKF9BGHxHRgcMB8eurXZtOZkQCj6HspcbGY7ZSD2NVNCQOsFa6EVA4HHx2S
         GBfq10tyeF7g2H5kQMRiLI86l0++dOKJalJf/JpXq9kPuRnefnnElvx77DCAK5iRGO0V
         rhmGo23BhFG9B51dlV3jsphFht59Ne1SpHJT3vrKw9odXFgATU3xTus8yrc/Cia3fnLZ
         D4Eem28bV/BpaFGV6sqmlUjNCtGD/P3ZK/G6VssRLQb2SXEXbB9ZMoBi2LjzGAblJdKs
         xlO+ICBObCMb2JuDKI/8nYQEEEPKDspqnlHuxHYkPHeh/rdUtZaQf2ZaqemaQmJrVKsk
         YXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2jC8pAZNAG4QZTGvbUujShbOS+kjlE3VGoi7RJaHmVM=;
        b=QZgb7+4tHfdiCVlF/WZD4vqSjA8r9/PEyLNMET7mIlxi411HIMB1SCT+3jF0HGOp6V
         iYCJuEduNvG6hIGMEqA2JtnJCfzJaL2HDP8vs8pRsGoibTEvzTiR2QVBx7wI+LYZf5Mp
         3DRkrx2ObgyxU1e4t6V0be111CQi9k7vD4OdSVRe49iMO6GcUCPH10Ty5KDpNnQ+SbNx
         v8V8vIvAxM3xwa3vAow9C8u0E1SfroYNJcNgNY/RLn3bgoPYRrznbieK0BqFMkG0UAwS
         S7GFkdhBrtgUs5WUtiy99BvwqL5VjbUn0lIy1GzutjhvnsmEYmytt+Uq1UUDeYgwUG9s
         X16A==
X-Gm-Message-State: AA+aEWbUi0/dQby2zdQ45HE0s5Nu6IIQWYuNgCf/qjlsP6DvW0sIlAwj
        Me3CRspmvgthfkh+FhRVjge4gg==
X-Google-Smtp-Source: AFSGD/VCoPeBY3btuMpz4oqMpYJGRihJQ9BbUmn7K6j5xUvlTlPcxRJ5f6dMjs566rftqG0gsuWBrg==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr9297717wro.78.1543695745104;
        Sat, 01 Dec 2018 12:22:25 -0800 (PST)
Received: from linux-2.fritz.box (p200300D993FC2A00DDBAF9A9E16D938D.dip0.t-ipconnect.de. [2003:d9:93fc:2a00:ddba:f9a9:e16d:938d])
        by smtp.googlemail.com with ESMTPSA id c13sm20935574wrb.38.2018.12.01.12.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 12:22:24 -0800 (PST)
Subject: Re: BUG: corrupted list in freeary
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000004eade9057ba76eae@google.com>
 <621f7c52-de52-eb35-bf61-e839adee7ec9@colorfullife.com>
 <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <3c159449-bcf9-759a-271c-4d4dd6f63802@colorfullife.com>
Date:   Sat, 1 Dec 2018 21:22:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 11/30/18 6:58 PM, Dmitry Vyukov wrote:
> On Thu, Nov 29, 2018 at 9:13 AM, Manfred Spraul
> <manfred@colorfullife.com> wrote:
>> Hello together,
>>
>> On 11/27/18 4:52 PM, syzbot wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
[...]
>> Isn't this a kernel stack overrun?
>>
>> RSP: 0x..83e008. Assuming 8 kB kernel stack, and 8 kB alignment, we have
>> used up everything.
> I don't exact answer, that's just the kernel output that we captured
> from console.
>
> FWIW with KASAN stacks are 16K:
> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64_types.h#L10
Ok, thanks. And stack overrun detection is enabled as well -> a real 
stack overrun is unlikely.
> Well, generally everything except for kernel crashes is expected.
>
> We actually sandbox it with memcg quite aggressively:
> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2159
> But it seems to manage to either break the limits, or cause some
> massive memory leaks. The nature of that is yet unknown.

Is it possible to start from that side?

Are there other syzcaller runs where the OOM killer triggers that much?

>
>> - Which stress tests are enabled? By chance, I found:
>>
>> [  433.304586] FAULT_INJECTION: forcing a failure.^M
>> [  433.304586] name fail_page_alloc, interval 1, probability 0, space 0,
>> times 0^M
>> [  433.316471] CPU: 1 PID: 19653 Comm: syz-executor4 Not tainted 4.20.0-rc3+
>> #348^M
>> [  433.323841] Hardware name: Google Google Compute Engine/Google Compute
>> Engine, BIOS Google 01/01/2011^M
>>
>> I need some more background, then I can review the code.
> What exactly do you mean by "Which stress tests"?
> Fault injection is enabled. Also random workload from userspace.
>
>
>> Right now, I would put it into my "unknown syzcaller finding" folder.

One more idea: Are there further syzcaller runs that end up with 
0x010000 in a pointer?

 From what I see, the sysv sem code that is used is trivial, I don't see 
that it could cause the observed behavior.


--

     Manfred

