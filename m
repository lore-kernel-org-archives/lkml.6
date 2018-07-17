Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA09ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD21F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C70wgkO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeGQJXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:23:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44387 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeGQJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:23:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so578218oih.11;
        Tue, 17 Jul 2018 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M4KWxGYf2CfKFNyolWvoSEA1HqoLX6NjGVoNp+8d4OU=;
        b=C70wgkO7rjO2DZqUga0H6F1j0INYHtFh8XUls3SVrw9fFBU9bdV5NDR93sPsZIgi1Z
         TYphLeZ7or4z3neCSBgpwpdoZDzI56mNK+PyXK34AhcoXJF5siXerNpW/+TgqLP0A9Uo
         UrLOEGrU2tX/abMk/6SFDdV4jz2BzlRVO2u+d9gt81pw05g2J6mhMmzPvtQNj0fVbAkn
         gBMclPwTn+o4X5aO5WFKYv5CNPbsJspLpodEQ9DTh9jBZZpACR4+gvaDKvZEQlw9foeG
         X284PTAUmyMWwGIdLQyM/WvQErSdJE7VM3nT5O9Hrl9HLQtTta9uWwU2REqY1/AaCvE0
         Ld7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M4KWxGYf2CfKFNyolWvoSEA1HqoLX6NjGVoNp+8d4OU=;
        b=tmZqVbzF6YCNHgYknh/RqXgy3SV2mRqdD/lUIwYGIWCHV1Dnjf2mGi8gzBEBuH/E4x
         GsajEVJR0B+CeBIJy3YXVFX8wAIY1bFs/m6JiTkLxMBM6XoQHaJONliBUKOos1ZIaYyV
         2pirrlNOYLtS6CEn70K0gPJYWAihv67XMj0ORgQ/nlZ9/xqmAKNOL76BAGwuDbhmlfRW
         rusLlUkqk6ABsRqEfpnZHgtzRWAfatwYvwU5Nb1pWJ76q/p2DI2cHh0dS87GDTSVWJHu
         I13x6Ir82ng/KT2Vn4NACvrHtiBpMKPWVr8bL3q4JZA/7Qd9Y43GA9Yj7MddTS0XZWzr
         iVCg==
X-Gm-Message-State: AOUpUlHhEGBLNHR1m9AhxqlaR2UGltOAXN4Rs5qJ5E/6HJ09sVf3wuQO
        LFpteh65unCInXgtbZOcBX2J+d6PNG6EvSMrUag=
X-Google-Smtp-Source: AAOMgpeZ+yf1vWWovt1Gi5WWAKGzZrBk5aok7YlbbW4A/NLejlu45Sagie1284DrH9FonknpLWuto6bhVOzN/d077ko=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr786182oib.116.1531817523331;
 Tue, 17 Jul 2018 01:52:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:52:02
 -0700 (PDT)
In-Reply-To: <20180717083626.ait7lqvxk2e4b2hz@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <20180717083626.ait7lqvxk2e4b2hz@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 10:52:02 +0200
X-Google-Sender-Auth: uwJXtFU1L0ULBU2QhdpAVXgAHLA
Message-ID: <CAJZ5v0iSHz4o4eF_u_WajmbkGfcsnJ5rAsme0OhzNjUTwLC_5Q@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:36 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 09:33:53AM +0200, Rafael J. Wysocki wrote:
>> Hi,
>>
>> Thanks for your report!
>>
>> On Tue, Jul 17, 2018 at 8:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> > Hello,
>> >
>> > I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
>> > idle state before stopping the tick") causes severe performance drop
>> > for systems using pcc-cpufreq driver. Depending on the number of CPUs
>> > the system might be almost unusable. The OS jitter for 4.17.y and
>> > 4.18.-rcx kernels is off the charts, you can even spot it with top
>> > command (issued when the system is supposedly idle), e.g.
>> >
>> >  top - 14:44:24 up 2 min,  1 user,  load average: 90.11, 38.20, 14.38
>> >  Tasks: 1199 total, 109 running, 541 sleeping,   0 stopped,   0 zombie
>> >  %Cpu(s):  1.2 us, 58.7 sy,  0.0 ni, 39.3 id,  0.6 wa,  0.0 hi,  0.3 si,  0.0 st
>> >  KiB Mem:  13137064+total,  1192168 used, 13017848+free,     2340 buffers
>> >  KiB Swap:  2104316 total,        0 used,  2104316 free.   522296 cached Mem
>> >
>> >    PID USER      PR  NI    VIRT    RES    SHR S    %CPU  %MEM     TIME+ COMMAND
>> >   3373 root      20   0  982024  49916  36120 R  96.691 0.038   0:19.54 kubelet
>> >     67 root      20   0       0      0      0 R  78.676 0.000   0:49.36 kworker/9:0
>> >     25 root      20   0       0      0      0 R  78.125 0.000   0:49.67 kworker/2:0
>> >    182 root      20   0       0      0      0 R  75.735 0.000   1:18.17 kworker/28:0
>> >     43 root      20   0       0      0      0 R  75.000 0.000   0:11.56 kworker/5:0
>> >    103 root      20   0       0      0      0 R  74.449 0.000   0:46.83 kworker/15:0
>> >    334 root      20   0       0      0      0 R  72.978 0.000   1:06.88 kworker/53:0
>> >    789 root      20   0       0      0      0 R  69.853 0.000   1:29.50 kworker/38:1
>> >    418 root      20   0       0      0      0 R  69.301 0.000   0:41.33 kworker/67:0
>> >    779 root      20   0       0      0      0 R  68.934 0.000   1:33.60 kworker/27:1
>> >    773 root      20   0       0      0      0 R  68.566 0.000   1:37.91 kworker/22:1
>> >    762 root      20   0       0      0      0 R  68.015 0.000   1:41.01 kworker/11:1
>> >    769 root      20   0       0      0      0 R  67.647 0.000   1:37.65 kworker/18:1
>> >    805 root      20   0       0      0      0 R  67.096 0.000   1:30.96 kworker/54:1
>> >    840 root      20   0       0      0      0 R  66.912 0.000   1:23.82 kworker/89:1
>> >    812 root      20   0       0      0      0 R  66.728 0.000   1:31.89 kworker/59:1
>> >    847 root      20   0       0      0      0 R  66.360 0.000   1:28.40 kworker/96:1
>> >    763 root      20   0       0      0      0 R  66.176 0.000   1:42.57 kworker/12:1
>> >    772 root      20   0       0      0      0 R  66.176 0.000   1:12.58 kworker/21:1
>> >    821 root      20   0       0      0      0 R  66.176 0.000   1:29.62 kworker/69:1
>> >    923 root      20   0       0      0      0 R  65.809 0.000   1:44.32 kworker/3:18
>> >   1284 root      20   0       0      0      0 R  65.809 0.000   1:23.50 kworker/101:2
>> >     61 root      20   0       0      0      0 R  65.625 0.000   1:29.37 kworker/8:0
>> >   3531 root      20   0   24384   3768   2356 R  65.625 0.003   0:08.91 top
>> >    771 root      20   0       0      0      0 R  65.074 0.000   1:37.90 kworker/20:1
>> >    767 root      20   0       0      0      0 R  64.706 0.000   1:38.01 kworker/16:1
>> >    764 root      20   0       0      0      0 R  64.522 0.000   1:40.28 kworker/13:1
>> >    765 root      20   0       0      0      0 R  64.154 0.000   1:40.13 kworker/14:1
>> >
>> > When I apply below patch (trying to revert essential parts of commit
>> > 554c8aa8ecad) behaviour seems back to normal.
>>
>> Well, that basically defeats the purpose of the change in commit
>> 554c8aa8ecad, so it's not what I'd like to do to fix this problem.
>>
>> Also it would be good to understand what actually happens.
>>
>> > I know that pcc-cpufreq driver is not "state-of-the-art" when it comes
>> > to cpufreq drivers and you better not use it.
>>
>> That's exactly right.
>>
>> > But I wonder whether commit 554c8aa8ecad ("sched: idle: Select idle state before
>> > stopping the tick") introduced bad behaviour for other cases as well.
>>
>> It has been tested quite extensively in that respect, although
>> admittedly not with the pcc-cpufreq driver.
>>
>> Nothing bad related to it has been has been reported so far, FWIW.
>>
>> > I'll send some performance results to illustrate the issue asap. I've
>> > also tried to modify pcc-cpufreq to reduce the amount of frequency
>> > changes triggered by this driver but this does not help for kernels
>> > where commit 554c8aa8ecad is applied.
>>
>> Can you replace pcc-cpufreq with a different cpufreq driver on the
>> affected systems?  If so, do performance numbers look bad after that
>> too?
>
> I have no performance numbers yet for other cpufreq drivers on this
> system (checking this commit).  But I'll look it at next.

Thanks!

Generally speaking, pcc-cpufreq is fundamentally not scalable, so the
additional concurrency brought in by the commit in question may have
exposed that weakness if that driver is run on a system with multiple
logical CPUs.
