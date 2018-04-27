Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZob6lGOXCqv+wVrr2WDBCMosf+sUAENZiy3Asyc8arxPMzGVEwo211z1VE9oN/SjL/JdpeW
ARC-Seal: i=1; a=rsa-sha256; t=1524864802; cv=none;
        d=google.com; s=arc-20160816;
        b=dAeYD45WzqjzYiyJZ0eYbMllaIzET+GjAXhwawc9oNufxx8GYR7n+vuFSZsFXh/no5
         A5WT+P1ACkB4jKoqYJamwcml0ZhJ+nQCdAu1/qZhkcoVaxFrGXG+TDuaTCRHZVHeBNdI
         v5JfdwpgN92en2YVPHcmqyg/jyCWZGB9eIiQ0SC9FcFHR++3KBAhc5lInvRWHq2hurNZ
         JUHE6JIIrZyMCwuanmZ1DlEbdSG5hwGrWGCDYgcm17TsE2jtOTBN3s68Fz+s4rNbXTBj
         1Ib8lSBr/w6RZMJKU38BYwKif0aPC5Fkt+T9ytWV47vVIWIZo5LZFMaaUyoPFh/ebncW
         P7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:thread-index:thread-topic
         :content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:arc-authentication-results;
        bh=7CLVzDZ3nTUZwuz+BDm7hxV8MPSjsfSaVaM5wcvq2Qs=;
        b=FhKupwoR9/COnB7VO8zFrBMEcT9eQ9wdndFwDWa+H9cFuCp1Xn7pV1veV0odfdlDB1
         81TENl44sdMlRn+2KVRzuyGCf0JnWmT1qAd048JffVKmQgDuVrShXUmDRhOmYSj4fqnK
         PsFrk+MbUj64gDRM06D7UKViZqq+tha1SKiIrCl2n3cTW7mglmld873P5cp0A9M/A6ox
         NEhjwvlBhrcSEd5fcsa9+Gm5kwE+78I0h5YfWsNwpb9TCmhlx/7Bmo1C+fJfFonhi2yE
         /ZhxZW0XwqY1EPeB2XeItcuOaWtrSIbO5r9PXIYmAE1j17NdC0xOF85jbTZiDYX2Y/Kq
         L4WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759353AbeD0VdV (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 17:33:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:53922 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759079AbeD0VdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 17:33:20 -0400
Date: Fri, 27 Apr 2018 17:33:18 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: shuah <shuah@kernel.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <769479298.6230.1524864798331.JavaMail.zimbra@efficios.com>
In-Reply-To: <3fa8c84a-6587-dfca-2e93-5cfe15f42c81@kernel.org>
References: <20171028134639.16811-1-mathieu.desnoyers@efficios.com> <44e3d6b0-6e0d-4482-fa7e-d8dac8619d4e@osg.samsung.com> <1490563551.1701.1509574972486.JavaMail.zimbra@efficios.com> <1717349402.1702.1509575073204.JavaMail.zimbra@efficios.com> <c1575990-8bb7-9997-0c0a-8a5b78b347c6@osg.samsung.com> <740429490.6175.1524860259330.JavaMail.zimbra@efficios.com> <670cba49-7419-5506-de06-05267f0493e9@kernel.org> <3fa8c84a-6587-dfca-2e93-5cfe15f42c81@kernel.org>
Subject: Re: [PATCH 1/1] selftests: Fix lib.mk run_tests target shell script
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: selftests: Fix lib.mk run_tests target shell script
Thread-Index: LPtIPjvP3gNV6g7/bWsafZ5VSj72wA==
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582509238172680386?=
X-GMAIL-MSGID: =?utf-8?q?1598936635063040863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 27, 2018, at 5:05 PM, shuah shuah@kernel.org wrote:

> On 04/27/2018 02:42 PM, Shuah Khan wrote:
>> On 04/27/2018 02:17 PM, Mathieu Desnoyers wrote:
>>> ----- On Nov 1, 2017, at 6:28 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>
>>>> On 11/01/2017 04:24 PM, Mathieu Desnoyers wrote:
>>>>> ----- On Nov 1, 2017, at 6:22 PM, Mathieu Desnoyers
>>>>> mathieu.desnoyers@efficios.com wrote:
>>>>>
>>>>>> ----- On Nov 1, 2017, at 5:33 PM, Shuah Khan shuahkh@osg.samsung.com wrote:
>>>>>>
>>>>>>> On 10/28/2017 07:46 AM, Mathieu Desnoyers wrote:
>>>>>>>> Within run_tests target, the whole script needs to be executed within
>>>>>>>> the same shell and not as separate subshells, so the initial test_num
>>>>>>>> variable set to 0 is still present when executing "test_num=`echo
>>>>>>>> $$test_num+1 | bc`;".
>>>>>>>>
>>>>>>>> Demonstration of the issue (make run_tests):
>>>>>>>>
>>>>>>>> TAP version 13
>>>>>>>> (standard_in) 1: syntax error
>>>>>>>> selftests: basic_test
>>>>>>>> ========================================
>>>>>>>> ok 1.. selftests: basic_test [PASS]
>>>>>>>> (standard_in) 1: syntax error
>>>>>>>> selftests: basic_percpu_ops_test
>>>>>>>> ========================================
>>>>>>>> ok 1.. selftests: basic_percpu_ops_test [PASS]
>>>>>>>> (standard_in) 1: syntax error
>>>>>>>> selftests: param_test
>>>>>>>> ========================================
>>>>>>>> ok 1.. selftests: param_test [PASS]
>>>>>>>
>>>>>>> Hi Mathieu,
>>>>>>>
>>>>>>> Odd. I don't see the error. I am curious if this specific to
>>>>>>> env. Can you reproduce this with one of the existing tests,
>>>>>>> kcmp or breakpoints
>>>>>>
>>>>>> Yes, it reproduces:
>>>>>>
>>>>>> cd tools/testing/selftests/kcmp
>>>>>> make run_tests
>>>>>> gcc -I../../../../usr/include/    kcmp_test.c  -o
>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/kcmp/kcmp_test
>>>>>> TAP version 13
>>>>>> (standard_in) 1: syntax error
>>>>>> selftests: kcmp_test
>>>>>> ========================================
>>>>>> ok 1.. selftests: kcmp_test [PASS]
>>>>>>
>>>>>> cd tools/testing/selftests/breakpoints
>>>>>> make run_tests
>>>>>> gcc     step_after_suspend_test.c  -o
>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/step_after_suspend_test
>>>>>> gcc     breakpoint_test.c  -o
>>>>>> /home/efficios/git/linux-rseq/tools/testing/selftests/breakpoints/breakpoint_test
>>>>>> TAP version 13
>>>>>> (standard_in) 1: syntax error
>>>>>> selftests: step_after_suspend_test
>>>>>> ========================================
>>>>>> not ok 1.. selftests:  step_after_suspend_test [FAIL]
>>>>>> (standard_in) 1: syntax error
>>>>>> selftests: breakpoint_test
>>>>>> ========================================
>>>>>> ok 1.. selftests: breakpoint_test [PASS]
>>>>>>
>>>>>
>>>>> The version of "make" on that machine is:
>>>>>
>>>>> make --version
>>>>> GNU Make 3.81
>>>>> Copyright (C) 2006  Free Software Foundation, Inc.
>>>>> This is free software; see the source for copying conditions.
>>>>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>>>>> PARTICULAR PURPOSE.
>>>>>
>>>>> This program built for x86_64-pc-linux-gnu
>>>>>
>>>>> (if it helps reproducing)
>>>>>
>>>>
>>>> Yup that's it. I have
>>>>
>>>> GNU Make 4.1
>>>> Built for x86_64-pc-linux-gnu
>>>> Copyright (C) 1988-2014 Free Software Foundation, Inc.
>>>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>>>> This is free software: you are free to change and redistribute it.
>>>> There is NO WARRANTY, to the extent permitted by law.
>>>>
>>>> I will test with your patch and see what happens in my env.
>>>
>>> Hi,
>>>
>>> I still see the problem with v4.17-rc2. Did you have time to
>>> consider merging my fix ?
>>>
>>> Thanks,
>>>
>>> Mathieu
>> 
>> Sorry for the delay. It slipped through. I will queue this for the next rc.
>> Thanks for
>> the ping. Hope it applies :)
>> 
>> thanks,
>> -- Shuah
>> 
>> 
> 
> Now I remember why I didn't pull this in. With your patch, I see the same
> failures you are seeing in my env. with
> 
> GNU Make 4.1
> Built for x86_64-pc-linux-gnu
> Copyright (C) 1988-2014 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> I will have to figure out a different way to fix the problem.

It works fine here on my other machine that has GNU make 4.1 both with
and without the patch. The patch fixes the behavior on GNU make 3.81.

I noticed I had to manually apply the patch to 4.17-rc2. Here is the updated diff.
Please ensure that you both remove the appropriate "@" from beginning
of lines, and add "\" characters at end of lines if you integrate the patch
manually.

Thanks,

Mathieu

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 9fd57efae439..ceb6c7c48547 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,10 +20,10 @@ all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 .ONESHELL:
 define RUN_TESTS
-       @export KSFT_TAP_LEVEL=`echo 1`;
-       @test_num=`echo 0`;
-       @echo "TAP version 13";
-       @for TEST in $(1); do                           \
+       @export KSFT_TAP_LEVEL=`echo 1`;                \
+       test_num=`echo 0`;                              \
+       echo "TAP version 13";                          \
+       for TEST in $(1); do                            \
                BASENAME_TEST=`basename $$TEST`;        \
                test_num=`echo $$test_num+1 | bc`;      \
                echo "selftests: $$BASENAME_TEST";      \

> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
