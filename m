Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5C92086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZK9LUfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5C92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeGQIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:35:04 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:42513 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:35:03 -0400
Received: by mail-oi0-f54.google.com with SMTP id n84-v6so366457oib.9;
        Tue, 17 Jul 2018 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0rmehL4hQFrU+cJ4/ZC/+nBlHDeAYWbFxeyyG+0rrWA=;
        b=vZK9LUfmck3x4FvtlVHPD0nieV+Ga+Ju3SO35rUDuSNS0yHPT7T6AScoBHUM7+fZWS
         UUBYvs/GBSict6aaH1QFW/von9QCyWFMVE8UguxKEp6gpPIzqicG4eRCwZsHny3OSgi8
         JHmbtCmzXHQ7GDbTwfxG3Mk5MVs8sBVr2xiMtvsNg0Jzv7rML7ZEKzCxUChcdxlBbiET
         YCteE73l9AnaRzjQC3yntw03MrrJjVDzK7k3X3khp+Kfzuyd/VUc9iVXwZbDsIHHTOxY
         d/m2g6uPX3cfQq1vnsJnIM1Ta2l7Kr7woIZZ3XDaiMirmhLfsYocx2eF2soQ2Sz68Kjb
         Uk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0rmehL4hQFrU+cJ4/ZC/+nBlHDeAYWbFxeyyG+0rrWA=;
        b=Vv0Lie4DXCKJRIM9hEIzud+A5ZY59gtjRT3SLzE1UpDGaHcqZNLfEOerC0PC+G5u8i
         3QxYL7dEqnDOHbk+r8zSu4aE0yWS55eSK7dkwiTeYrnUBTlT+TEBCVwoqMr9VyKSFKd+
         Xjk4dCM6312GxrdLTL1qx+dS6PM1LLnnViiSxO+DhjStoaDvRZVsrMbUsoXExqnGp5Jg
         WMfsrQW6hwgzA18JH3/FQ3HGjFbmeFcACRljB6XE42gDxk6W8QQctUohqh2tCPXaERPr
         GfZxCujPtED3B+z288t6t781488wXjYCgVfMqf8GBOQe6glBGm0j15iCi6YwyPSd87bK
         aU3Q==
X-Gm-Message-State: AOUpUlEGezO3RfZHZb93XlSplx0nRKvVsJinHHZkB35lopzjuufNUsHY
        xegWshZXw3zj+n3oDh0Xnc6k+gY2yHat3N9eZNo=
X-Google-Smtp-Source: AAOMgpdP6v7rpnLgKDGqBd7VwlTXfYX44WMzXMSBUPpAXRL2Q4bwOFdG50KlEl5weSmuU8kA4R/mhnRipQ8tAI2v6eA=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr627158oie.174.1531814622079;
 Tue, 17 Jul 2018 01:03:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:03:41
 -0700 (PDT)
In-Reply-To: <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 10:03:41 +0200
X-Google-Sender-Auth: KkTrdAzE00y7lWydpXPfgZSGYr0
Message-ID: <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Tue, Jul 17, 2018 at 9:33 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> Thanks for your report!
>
> On Tue, Jul 17, 2018 at 8:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> Hello,
>>
>> I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
>> idle state before stopping the tick") causes severe performance drop
>> for systems using pcc-cpufreq driver. Depending on the number of CPUs
>> the system might be almost unusable. The OS jitter for 4.17.y and
>> 4.18.-rcx kernels is off the charts, you can even spot it with top
>> command (issued when the system is supposedly idle), e.g.
>>
>>  top - 14:44:24 up 2 min,  1 user,  load average: 90.11, 38.20, 14.38
>>  Tasks: 1199 total, 109 running, 541 sleeping,   0 stopped,   0 zombie
>>  %Cpu(s):  1.2 us, 58.7 sy,  0.0 ni, 39.3 id,  0.6 wa,  0.0 hi,  0.3 si,  0.0 st
>>  KiB Mem:  13137064+total,  1192168 used, 13017848+free,     2340 buffers
>>  KiB Swap:  2104316 total,        0 used,  2104316 free.   522296 cached Mem
>>
>>    PID USER      PR  NI    VIRT    RES    SHR S    %CPU  %MEM     TIME+ COMMAND
>>   3373 root      20   0  982024  49916  36120 R  96.691 0.038   0:19.54 kubelet
>>     67 root      20   0       0      0      0 R  78.676 0.000   0:49.36 kworker/9:0
>>     25 root      20   0       0      0      0 R  78.125 0.000   0:49.67 kworker/2:0
>>    182 root      20   0       0      0      0 R  75.735 0.000   1:18.17 kworker/28:0
>>     43 root      20   0       0      0      0 R  75.000 0.000   0:11.56 kworker/5:0
>>    103 root      20   0       0      0      0 R  74.449 0.000   0:46.83 kworker/15:0
>>    334 root      20   0       0      0      0 R  72.978 0.000   1:06.88 kworker/53:0
>>    789 root      20   0       0      0      0 R  69.853 0.000   1:29.50 kworker/38:1
>>    418 root      20   0       0      0      0 R  69.301 0.000   0:41.33 kworker/67:0
>>    779 root      20   0       0      0      0 R  68.934 0.000   1:33.60 kworker/27:1
>>    773 root      20   0       0      0      0 R  68.566 0.000   1:37.91 kworker/22:1
>>    762 root      20   0       0      0      0 R  68.015 0.000   1:41.01 kworker/11:1
>>    769 root      20   0       0      0      0 R  67.647 0.000   1:37.65 kworker/18:1
>>    805 root      20   0       0      0      0 R  67.096 0.000   1:30.96 kworker/54:1
>>    840 root      20   0       0      0      0 R  66.912 0.000   1:23.82 kworker/89:1
>>    812 root      20   0       0      0      0 R  66.728 0.000   1:31.89 kworker/59:1
>>    847 root      20   0       0      0      0 R  66.360 0.000   1:28.40 kworker/96:1
>>    763 root      20   0       0      0      0 R  66.176 0.000   1:42.57 kworker/12:1
>>    772 root      20   0       0      0      0 R  66.176 0.000   1:12.58 kworker/21:1
>>    821 root      20   0       0      0      0 R  66.176 0.000   1:29.62 kworker/69:1
>>    923 root      20   0       0      0      0 R  65.809 0.000   1:44.32 kworker/3:18
>>   1284 root      20   0       0      0      0 R  65.809 0.000   1:23.50 kworker/101:2
>>     61 root      20   0       0      0      0 R  65.625 0.000   1:29.37 kworker/8:0
>>   3531 root      20   0   24384   3768   2356 R  65.625 0.003   0:08.91 top
>>    771 root      20   0       0      0      0 R  65.074 0.000   1:37.90 kworker/20:1
>>    767 root      20   0       0      0      0 R  64.706 0.000   1:38.01 kworker/16:1
>>    764 root      20   0       0      0      0 R  64.522 0.000   1:40.28 kworker/13:1
>>    765 root      20   0       0      0      0 R  64.154 0.000   1:40.13 kworker/14:1
>>
>> When I apply below patch (trying to revert essential parts of commit
>> 554c8aa8ecad) behaviour seems back to normal.
>
> Well, that basically defeats the purpose of the change in commit
> 554c8aa8ecad, so it's not what I'd like to do to fix this problem.
>
> Also it would be good to understand what actually happens.
>
>> I know that pcc-cpufreq driver is not "state-of-the-art" when it comes
>> to cpufreq drivers and you better not use it.
>
> That's exactly right.
>
>> But I wonder whether commit 554c8aa8ecad ("sched: idle: Select idle state before
>> stopping the tick") introduced bad behaviour for other cases as well.
>
> It has been tested quite extensively in that respect, although
> admittedly not with the pcc-cpufreq driver.
>
> Nothing bad related to it has been has been reported so far, FWIW.
>
>> I'll send some performance results to illustrate the issue asap. I've
>> also tried to modify pcc-cpufreq to reduce the amount of frequency
>> changes triggered by this driver but this does not help for kernels
>> where commit 554c8aa8ecad is applied.
>
> Can you replace pcc-cpufreq with a different cpufreq driver on the
> affected systems?  If so, do performance numbers look bad after that
> too?

Also, what cpufreq governor do you use with pcc-cpufreq?  Does
changing it to something like "performance" improve things?
