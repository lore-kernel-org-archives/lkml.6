Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBADE2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfAIP3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:29:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbfAIP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:29:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so4614719qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHIoyvJ6wOj03zsUc6yprgUWpK6Tykrcn6Wjy6B7AkY=;
        b=evtKiFyg2cjneawnv5pJWIA/J47T7fYj3rOI6p94vl8N04o89LK41wbLg24F91Ybjq
         yHLBohmOVxHfeVKbelUYiJ+JZdK1fFKHutwJSHchQyaULFoSv3Nbleugpmpz/l/oBuTm
         TycYKF08v/UbcCWWZmTYtE4tZdfS9VPwNK4dBeNAbs0OrJslxhwNnNWuTZSMDVUJy6z6
         1nJGD0jHjZ24P3lyXIL7b3v206udkjBN0P4PyRISenur62n+FtA+q7X0WhB5jlBn1tsr
         XKnkq969tgtZhor4P4a1tZc0pFwotHdDVzYOwBmRzwtAaPclbW98z0/Tw8JQbZB9QY7V
         1uxw==
X-Gm-Message-State: AJcUukfmo9a0M2K5kz/WNzvEFppSeYFNHnMePNGswSxbTjxGehewEklY
        9GJta9A2X/G7uyr8Z1jEVizFWw==
X-Google-Smtp-Source: ALg8bN4/C3YktYlVVG9BGJjQMTtQFGuKrsMMva3zSziYIsATWzAR7eGe1YgeXaZ14H6Za85Cf7fz6g==
X-Received: by 2002:a37:b1c7:: with SMTP id a190mr5627883qkf.94.1547047751994;
        Wed, 09 Jan 2019 07:29:11 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::814b? ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id r56sm38648890qtj.30.2019.01.09.07.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:29:11 -0800 (PST)
Subject: Re: [PATCH] tools uapi asm: Update asm-generic/unistd.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20190108221758.14546-1-labbott@redhat.com>
 <20190109131540.GC25192@kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2be8f051-1430-77d6-413c-2edaad4c1346@redhat.com>
Date:   Wed, 9 Jan 2019 07:29:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109131540.GC25192@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/19 5:15 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 08, 2019 at 02:17:58PM -0800, Laura Abbott escreveu:
>> Commit 4e21565b7fd4 ("asm-generic: add kexec_file_load system
>> call to unistd.h") added the system call to the generic header
>> but not to the perf copy resulting a compile failure on aarch64
> 
> Humm, that shouldn't happen, i.e. kernel developers don't have to update
> anything in tools/ as part of their normal kernel development workflows.
> 
> They can if they wish, but are not required, so the build failure was
> due to something else or a pre-existing bug where tools/ living stuff
> used things outside tools/.
> 

I think that's the issue, I couldn't reproduce the issue until I
installed the 5.0-rc1 headers. This is the invocation of the script
(paths trimmed)

/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl' 'gcc' 'gcc' /tools /tools/arch/arm64/include/uapi/asm/unistd.h > arch/arm64/include/generated/asm/syscalls.c


In tools/perf/arch/arm64/entry/syscalls/mksyscalltbl,

$hostcc -I $incpath/include/uapi -o $create_table_exe -x c -

This was the gcc command that was failing.
tools/arch/arm64/include/uapi/asm/unistd.h includes asm-generic/unistd.h
so I think that's what's leaking from the system.

>> When running mksyscalltbl
> 
> Lemme try this on my Orangi PI zero...
> 
> - Arnaldo
> >> BUILDSTDERR: <stdin>: In function 'main':
>> BUILDSTDERR: <stdin>:273:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
>> BUILDSTDERR: <stdin>:273:44: note: each undeclared identifier is reported only once for each function it appears in
>>
>> Fix this by syncing up.
>>
>> Fixes: 4e21565b7fd4 ("asm-generic: add kexec_file_load system call to unistd.h")
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> Found this on Fedora when compiling 5.0-rc1, I hadn't seen a patch
>> queued yet.
>> ---
>>   tools/include/uapi/asm-generic/unistd.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
>> index c7f3321fbe43..d90127298f12 100644
>> --- a/tools/include/uapi/asm-generic/unistd.h
>> +++ b/tools/include/uapi/asm-generic/unistd.h
>> @@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
>>   __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
>>   #define __NR_rseq 293
>>   __SYSCALL(__NR_rseq, sys_rseq)
>> +#define __NR_kexec_file_load 294
>> +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>>   
>>   #undef __NR_syscalls
>> -#define __NR_syscalls 294
>> +#define __NR_syscalls 295
>>   
>>   /*
>>    * 32 bit systems traditionally used different
>> -- 
>> 2.20.1
> 

