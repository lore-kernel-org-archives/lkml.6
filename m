Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862ACECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F951206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KERJEpCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F951206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeIRMIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:08:10 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44331 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeIRMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:08:10 -0400
Received: by mail-yb1-f196.google.com with SMTP id s8-v6so349995ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QTVTvub5qrtIsSt9FdOr+BP7p/59TzS5tBZwi4OIrgc=;
        b=KERJEpCVAolATTAI5rVq3JQsSqzreYOkfHEZMNmBNSvipT4zUp2dfsREJKmMQzKCVg
         tik6sU6TzN3ysz4D/THbL9DGis0FomF08EAC0rZyR0pS7GIy2JErPsToJwx2QlgwWBdA
         bHDcrVB9wb6J2Kmy6ZDFYl4flGnMQXG7pELi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QTVTvub5qrtIsSt9FdOr+BP7p/59TzS5tBZwi4OIrgc=;
        b=i/pc7Y4AgcgqrFg97NU2B4tytWxMw4TDZnbnrDwUbIQTf8iegT8XfQhuZ8BJrUfDBK
         cOAc5+13Zwx2iUyt8jThbq+YIAdasOzShx+gjFMcVlMDev5uDNTM3VqnILo7Vp8o564s
         LDKTpHnQdLk5UFiQ/fjg5ONJ8ViEACwYR7ha4NnqyISqnQ5/RZiFGwO13jknNuvF1dqg
         o4B1Xx+v8Wwnm364qIFM/RkFgFgf2KQHO97lFGqW/3zw7il4vCRIVDzbcy/tx5vfR/4n
         qOjsNAZhbyqcYccKTEtaLJ1yDQEa4+Qbq/kJpB0CpPDbzWGo5z3Y7RJSHxUncW6Q+iTK
         qQFw==
X-Gm-Message-State: APzg51A2OX78ZyhbMCDVpG/zJZxHeEvM1Y3zyrw8lJlHStIo3aTynyNJ
        aqCoU8L756GL61F7AMaxPHiQ7FAOwZdz2Zz1Z2eLvg==
X-Google-Smtp-Source: ANB0VdZB/QJvm1fJKtZz59FWfsfcxfdRZm9R5q712AaEdpwxxqmKRSiL1o6D6B62Wn/YRSU0BTHX0eiPCXKuOBwWsfs=
X-Received: by 2002:a25:e548:: with SMTP id c69-v6mr11731496ybh.393.1537252621844;
 Mon, 17 Sep 2018 23:37:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 23:37:01
 -0700 (PDT)
In-Reply-To: <f1e95c4d-4f02-263d-7f35-cc87bc657fbb@xilinx.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-2-git-send-email-firoz.khan@linaro.org> <f1e95c4d-4f02-263d-7f35-cc87bc657fbb@xilinx.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 12:07:01 +0530
Message-ID: <CALxhOnho6av7nZja_MN4akQuVj1hVq753ZYgRM8fbKkL2rHzQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] microblaze: Replace NR_syscalls macro from asm/unistd.h
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 August 2018 at 12:18, Michal Simek <michal.simek@xilinx.com> wrote:
> On 9.8.2018 07:27, Firoz Khan wrote:
>> __NR_syscalls macro holds the number of system call exist in this
>> architecture. This macro is currently the part of asm/unistd.h file.
>> We have change the value of __NR_syscalls, if we add or delete a
>> system call.
>>
>> One of the patch in this patch series has a script which will
>> generate a uapi header based on syscall.tbl file. The syscall.tbl
>> file contains the number of system call information. So we have
>> two option to update __NR_syscalls value.
>>
>> 1. Update __NR_syscalls in asm/unistd.h manually by counting the
>>    no.of system calls. No need to update __NR_syscalls untill
>>    we either add a new system call or delete an existing system
>>    call.
>>
>> 2. We can keep this feature it above mentioned script, that'll
>>    count the number of syscalls and keep it in a generated file.
>>    In this case we don't need to explicitly update __NR_syscalls
>>    in asm/unistd.h file.
>>
>> The 2nd option will be the recommended one. For that, I moved the
>> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>> name also changed form NR_syscalls to __NR_syscalls for making the
>> name convention same across all architecture. While __NR_syscalls
>> isn't strictly part of the uapi, having it as part of the generated
>> header to simplifies the implementation.
>
> This macro was in unistd.h in past but it was moved out because it was
> causing problem with strace.
>
> commit 40c2702a02b755e0183b702778331b351f3be20c
> Author:     Michal Simek <michal.simek@xilinx.com>
> AuthorDate: Mon Jul 8 09:50:24 2013 +0200
> Commit:     Michal Simek <michal.simek@xilinx.com>
> CommitDate: Wed Jul 10 07:32:09 2013 +0200
>
>     microblaze: Move __NR_syscalls from uapi
>
>
> That's why I don't think this is the right thing to do.
> I have grepped strace and glibc and none is using this macro that's why
> I think it shouldn't be exported via uapi.


Thanks for you reply :)
Sorry for the delayed response :(

I would like to keep __NR_syscalls macro to uapi header in order to simplify
the system call table generation script. Otherwise the __NR_syscalls
macro need to update manually. That become a problem.

Please check the below implementation in uapi file make sense?
It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
and enclose it in #ifdef __KERNEL__

...
...
#define __NR_pkey_free  397
#define __NR_statx      398

#ifdef __KERNEL__
#define __NR_syscalls   399
#endif
...
...

- Firoz
