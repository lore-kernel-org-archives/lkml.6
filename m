Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqSub3MYfXSfMILKDT7/UgeoUnHzPvFAL6WjUxWdZUevqqp6yHz6AT2my2LM+dOSOKy8CQN
ARC-Seal: i=1; a=rsa-sha256; t=1524860275; cv=none;
        d=google.com; s=arc-20160816;
        b=uiZtAz8uogMucaOkXKM0IGSx5OzLS+KXrEDPEtFHOABGUE7KFqwt0ZVk99uwwhxsSt
         3m95vicz3i/dFoGiDLwD4YX3neIVfgfq12mgWHdtqWgm4SGFe6cgPxC+n4uyTkse9Pro
         7JD/SgdXOqXg6OikTYD1KfwKakd1oi9LTsagV3gzAf96NYfhLLopJrFdBP9u5go1nJEq
         hvE0CHfD1T3/z/bamPIztNliip/S7scA6aIoCysMNbfGJR0Zq0OfF56cTlCsuCy2toeI
         1XUb9f1Km5sWXEjTWHMjQBFQ51qcV1ZNu1b/V8Yog3EHnTQO1HRI4pXabQ8tSMR5uxvo
         iFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:thread-index:thread-topic
         :content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:arc-authentication-results;
        bh=CgG7N9J3y8kSzda4uj0ivJFAYlG4n0eWfMJkcq7ptwc=;
        b=WSYyrOfPrro/07SU8TvzjbPK4N1+QbICa4iT3XmD6ojuJulD5ULnmF4Sr7vUcDKzLU
         ucQDDJLpmCBlv2QUUDRdE04QdBsQZSm89ts0H0rshmL2fvO9PoMCEF+TrMcQ+VRaPcFh
         eqgv0BIrcyh0NKf1kEPhI1sQ/JvrXB8X/Z9nqMxjwkM+JuYNMcGuzWmlH8Qnz5SP5OA6
         gELVBvFsu92Aa8d/+yqIkJilWuP9arqOEkLbEtbt8VYXeY8sR4SFG6X3haHhQytE3dzg
         nOfcGKf8CLcXnXqAFD+FCd1gaKS+mc+oYdhdOjFuzVKiq0KG6boqvTG8j5RKXnewD04T
         nt2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759253AbeD0URm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 16:17:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:49408 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759077AbeD0URl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 16:17:41 -0400
Date: Fri, 27 Apr 2018 16:17:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        shuah <shuah@kernel.org>
Message-ID: <740429490.6175.1524860259330.JavaMail.zimbra@efficios.com>
In-Reply-To: <c1575990-8bb7-9997-0c0a-8a5b78b347c6@osg.samsung.com>
References: <20171028134639.16811-1-mathieu.desnoyers@efficios.com> <44e3d6b0-6e0d-4482-fa7e-d8dac8619d4e@osg.samsung.com> <1490563551.1701.1509574972486.JavaMail.zimbra@efficios.com> <1717349402.1702.1509575073204.JavaMail.zimbra@efficios.com> <c1575990-8bb7-9997-0c0a-8a5b78b347c6@osg.samsung.com>
Subject: Re: [PATCH 1/1] selftests: Fix lib.mk run_tests target shell script
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: selftests: Fix lib.mk run_tests target shell script
Thread-Index: AgtWnXq/p2YlPdliy0dki97L/T0sLw==
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582509238172680386?=
X-GMAIL-MSGID: =?utf-8?q?1598931888217823801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Nov 1, 2017, at 6:28 PM, Shuah Khan shuahkh@osg.samsung.com wrote:

> On 11/01/2017 04:24 PM, Mathieu Desnoyers wrote:
>> ----- On Nov 1, 2017, at 6:22 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>>> ----- On Nov 1, 2017, at 5:33 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>
>>>> On 10/28/2017 07:46 AM, Mathieu Desnoyers wrote:
>>>>> Within run_tests target, the whole script needs to be executed within
>>>>> the same shell and not as separate subshells, so the initial test_num
>>>>> variable set to 0 is still present when executing "test_num=`echo
>>>>> $$test_num+1 | bc`;".
>>>>>
>>>>> Demonstration of the issue (make run_tests):
>>>>>
>>>>> TAP version 13
>>>>> (standard_in) 1: syntax error
>>>>> selftests: basic_test
>>>>> ========================================
>>>>> ok 1.. selftests: basic_test [PASS]
>>>>> (standard_in) 1: syntax error
>>>>> selftests: basic_percpu_ops_test
>>>>> ========================================
>>>>> ok 1.. selftests: basic_percpu_ops_test [PASS]
>>>>> (standard_in) 1: syntax error
>>>>> selftests: param_test
>>>>> ========================================
>>>>> ok 1.. selftests: param_test [PASS]
>>>>
>>>> Hi Mathieu,
>>>>
>>>> Odd. I don't see the error. I am curious if this specific to
>>>> env. Can you reproduce this with one of the existing tests,
>>>> kcmp or breakpoints
>>>
>>> Yes, it reproduces:
>>>
>>> cd tools/testing/selftests/kcmp
>>> make run_tests
>>> gcc -I../../../../usr/include/    kcmp_test.c  -o
>>> /home/efficios/git/linux-rseq/tools/testing/selftests/kcmp/kcmp_test
>>> TAP version 13
>>> (standard_in) 1: syntax error
>>> selftests: kcmp_test
>>> ========================================
>>> ok 1.. selftests: kcmp_test [PASS]
>>>
>>> cd tools/testing/selftests/breakpoints
>>> make run_tests
>>> gcc     step_after_suspend_test.c  -o
>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/step_after_suspend_test
>>> gcc     breakpoint_test.c  -o
>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/breakpoint_test
>>> TAP version 13
>>> (standard_in) 1: syntax error
>>> selftests: step_after_suspend_test
>>> ========================================
>>> not ok 1.. selftests:  step_after_suspend_test [FAIL]
>>> (standard_in) 1: syntax error
>>> selftests: breakpoint_test
>>> ========================================
>>> ok 1.. selftests: breakpoint_test [PASS]
>>>
>> 
>> The version of "make" on that machine is:
>> 
>> make --version
>> GNU Make 3.81
>> Copyright (C) 2006  Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.
>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>> PARTICULAR PURPOSE.
>> 
>> This program built for x86_64-pc-linux-gnu
>> 
>> (if it helps reproducing)
>> 
> 
> Yup that's it. I have
> 
> GNU Make 4.1
> Built for x86_64-pc-linux-gnu
> Copyright (C) 1988-2014 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> I will test with your patch and see what happens in my env.

Hi,

I still see the problem with v4.17-rc2. Did you have time to
consider merging my fix ?

Thanks,

Mathieu


> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
