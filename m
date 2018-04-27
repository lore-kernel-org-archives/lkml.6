Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZr4ZpB009v/83QgbDWO8c6qtQWaZ49rGV965nBe0s2ZNSLcKDdZtkstgc5tRcNr11+65vts
ARC-Seal: i=1; a=rsa-sha256; t=1524865321; cv=none;
        d=google.com; s=arc-20160816;
        b=SVUJX6ADeXlY4KsLrMplGgIEYbKf7PSd0zR1AFK2pKurNBbOnr+ETPJpBXXz9ckRhe
         G3w7ynDgBHdFoLqpJuf1mzvHtV/4txhs6RylmE8h2ghE6B8CiUItNSY48UJU8UQzfPbJ
         AAjqwgOHp9PMVqksWXfNoLDlz2TxadY/MDNV6IbVVv6ZxYAvogBUDwmVSgMFp63wTUnG
         LJwWVqd4gIwyXFFADIpMBEiphYKW4cDaz7mb9JfIk1QMmQ+DRtvqd5IpCkqnH1qtfAEe
         X8nAoOokaIPf+L0OX+qRUQT0dZUHUd1InaapUdT3NBZ1vx1S4ntM7VcxMg2iJuHnXh93
         94rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=NFwtGe+LQw52djeOChMp7TlHXsZUPW3VpAQoqjXdXTk=;
        b=vGXQIAvjPBGWjtqxok0svzmi0sdZAbP7G2TfRRuMcSJlbckwIfSlR4Dv/pukuPbRpa
         ljA5Fx0NrHCZznOtogTpMotFeHKqKMPQRnMGjVaqrHPTH6ITN/roj7taqatxNlxvOhhX
         +3vIyZATs2w9n4ePjbWDIeTJzacfpjMjK8qn6/sbuFYjOkQK5pMiyKz6m5/TAyTfu3mA
         2iQdFLq80RVvmz+wCrrki17cvhAnGTGOOK3WV7KMibA2yauPtPeI2owjP9rMrg63Ljr/
         ETOyYmTGW/s2Yx87pACkKI0Y5BnJNh1ZZrRGI8za9CYeYcN5eVLUm1eyW0022y7DCvRV
         RA9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759307AbeD0VmA (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 17:42:00 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57233 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759235AbeD0Vl7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 17:41:59 -0400
Subject: Re: [PATCH 1/1] selftests: Fix lib.mk run_tests target shell script
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20171028134639.16811-1-mathieu.desnoyers@efficios.com>
 <44e3d6b0-6e0d-4482-fa7e-d8dac8619d4e@osg.samsung.com>
 <1490563551.1701.1509574972486.JavaMail.zimbra@efficios.com>
 <1717349402.1702.1509575073204.JavaMail.zimbra@efficios.com>
 <c1575990-8bb7-9997-0c0a-8a5b78b347c6@osg.samsung.com>
 <740429490.6175.1524860259330.JavaMail.zimbra@efficios.com>
 <670cba49-7419-5506-de06-05267f0493e9@kernel.org>
 <3fa8c84a-6587-dfca-2e93-5cfe15f42c81@kernel.org>
 <769479298.6230.1524864798331.JavaMail.zimbra@efficios.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <834c528c-9ff2-0a62-6124-84697798dfdc@kernel.org>
Date: Fri, 27 Apr 2018 15:41:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <769479298.6230.1524864798331.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582509238172680386?=
X-GMAIL-MSGID: =?utf-8?q?1598937179132931649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 03:33 PM, Mathieu Desnoyers wrote:
> ----- On Apr 27, 2018, at 5:05 PM, shuah shuah@kernel.org wrote:
> 
>> On 04/27/2018 02:42 PM, Shuah Khan wrote:
>>> On 04/27/2018 02:17 PM, Mathieu Desnoyers wrote:
>>>> ----- On Nov 1, 2017, at 6:28 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>>
>>>>> On 11/01/2017 04:24 PM, Mathieu Desnoyers wrote:
>>>>>> ----- On Nov 1, 2017, at 6:22 PM, Mathieu Desnoyers
>>>>>> mathieu.desnoyers@efficios.com wrote:
>>>>>>
>>>>>>> ----- On Nov 1, 2017, at 5:33 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>>>>>
>>>>>>>> On 10/28/2017 07:46 AM, Mathieu Desnoyers wrote:
>>>>>>>>> Within run_tests target, the whole script needs to be executed within
>>>>>>>>> the same shell and not as separate subshells, so the initial test_num
>>>>>>>>> variable set to 0 is still present when executing "test_num=`echo
>>>>>>>>> $$test_num+1 | bc`;".
>>>>>>>>>
>>>>>>>>> Demonstration of the issue (make run_tests):
>>>>>>>>>
>>>>>>>>> TAP version 13
>>>>>>>>> (standard_in) 1: syntax error
>>>>>>>>> selftests: basic_test
>>>>>>>>> ========================================
>>>>>>>>> ok 1.. selftests: basic_test [PASS]
>>>>>>>>> (standard_in) 1: syntax error
>>>>>>>>> selftests: basic_percpu_ops_test
>>>>>>>>> ========================================
>>>>>>>>> ok 1.. selftests: basic_percpu_ops_test [PASS]
>>>>>>>>> (standard_in) 1: syntax error
>>>>>>>>> selftests: param_test
>>>>>>>>> ========================================
>>>>>>>>> ok 1.. selftests: param_test [PASS]
>>>>>>>>
>>>>>>>> Hi Mathieu,
>>>>>>>>
>>>>>>>> Odd. I don't see the error. I am curious if this specific to
>>>>>>>> env. Can you reproduce this with one of the existing tests,
>>>>>>>> kcmp or breakpoints
>>>>>>>
>>>>>>> Yes, it reproduces:
>>>>>>>
>>>>>>> cd tools/testing/selftests/kcmp
>>>>>>> make run_tests
>>>>>>> gcc -I../../../../usr/include/    kcmp_test.c  -o
>>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/kcmp/kcmp_test
>>>>>>> TAP version 13
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: kcmp_test
>>>>>>> ========================================
>>>>>>> ok 1.. selftests: kcmp_test [PASS]
>>>>>>>
>>>>>>> cd tools/testing/selftests/breakpoints
>>>>>>> make run_tests
>>>>>>> gcc     step_after_suspend_test.c  -o
>>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/step_after_suspend_test
>>>>>>> gcc     breakpoint_test.c  -o
>>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/breakpoint_test
>>>>>>> TAP version 13
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: step_after_suspend_test
>>>>>>> ========================================
>>>>>>> not ok 1.. selftests:  step_after_suspend_test [FAIL]
>>>>>>> (standard_in) 1: syntax error
>>>>>>> selftests: breakpoint_test
>>>>>>> ========================================
>>>>>>> ok 1.. selftests: breakpoint_test [PASS]
>>>>>>>
>>>>>>
>>>>>> The version of "make" on that machine is:
>>>>>>
>>>>>> make --version
>>>>>> GNU Make 3.81
>>>>>> Copyright (C) 2006  Free Software Foundation, Inc.
>>>>>> This is free software; see the source for copying conditions.
>>>>>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>>>>>> PARTICULAR PURPOSE.
>>>>>>
>>>>>> This program built for x86_64-pc-linux-gnu
>>>>>>
>>>>>> (if it helps reproducing)
>>>>>>
>>>>>
>>>>> Yup that's it. I have
>>>>>
>>>>> GNU Make 4.1
>>>>> Built for x86_64-pc-linux-gnu
>>>>> Copyright (C) 1988-2014 Free Software Foundation, Inc.
>>>>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>>>>> This is free software: you are free to change and redistribute it.
>>>>> There is NO WARRANTY, to the extent permitted by law.
>>>>>
>>>>> I will test with your patch and see what happens in my env.
>>>>
>>>> Hi,
>>>>
>>>> I still see the problem with v4.17-rc2. Did you have time to
>>>> consider merging my fix ?
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>
>>> Sorry for the delay. It slipped through. I will queue this for the next rc.
>>> Thanks for
>>> the ping. Hope it applies :)
>>>
>>> thanks,
>>> -- Shuah
>>>
>>>
>>
>> Now I remember why I didn't pull this in. With your patch, I see the same
>> failures you are seeing in my env. with
>>
>> GNU Make 4.1
>> Built for x86_64-pc-linux-gnu
>> Copyright (C) 1988-2014 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.
>>
>> I will have to figure out a different way to fix the problem.
> 
> It works fine here on my other machine that has GNU make 4.1 both with
> and without the patch. The patch fixes the behavior on GNU make 3.81.
> 
> I noticed I had to manually apply the patch to 4.17-rc2. Here is the updated diff.
> Please ensure that you both remove the appropriate "@" from beginning
> of lines, and add "\" characters at end of lines if you integrate the patch
> manually.
> 

Please rebase and resend the patch to avoid manual integration.

thanks,
-- Shuah

