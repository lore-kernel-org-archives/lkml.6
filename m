Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225gX0hFhvTrlRmxlSpTD101Hp5YcocK2WmlaSciPsLFvxJmfoEHHwC9h+uKxJWMS06+w6Zz
ARC-Seal: i=1; a=rsa-sha256; t=1519752350; cv=none;
        d=google.com; s=arc-20160816;
        b=XQw1gMo+1bA7J2zBlxoMJlm7JfvPZCF4SLni+Cm4HoOfA1X0HGZGWbV/M3NKM0lGlx
         fsW0MskBtoDN3v1Ua5nqqg68UwRU3PVeaVtoV98bqjOvgXZlXrl438jwOZ7QdeTe7uZq
         rLzDlLPr/WVJHQyPaXLS8nDGxPpMcdrxBY1lB3qgyl+ukfM42GQokwoFARQC2SYrp5xG
         KbYT9CLwsjWGGAYIzpcLI/Mbmqq8ieIgqBOwaWQ+zty2xp6ikkVMxI8SunFRySOOaUSF
         QsQiXRJLLSx+edXrTbHHPmSs5oZJ9Qg5T+dtWp/29aIWuKI9VSwUY+l3BDjZsby4Rz9q
         mleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=j6WDFwY1pC7sFFEsX/zt/+IIq/Y2LCROwKYim4taiD4=;
        b=Uvkogtz7tBHjftS5gRIMghi3SuAr9IlVbALs7MbXn7w5Vhd7bfqC72ApekAEZw4Ia/
         mdTGF1DHfq6fDqY7TfXe7DKMk7DHKJR4tYqSbpxyP2u+KVFGDnlWT2ehNuLB+cAKlZdv
         O5FZKDBxambt2YNpc1PHm9AHU+g5yY7YfO5G1WZ4p5M+ZkqkGek1kWurycogVuMDF4BV
         OuT7X18T4gM5av9MtPWpym/MayHXkiteE+YuNGyn1afAW+kQnXuPe/rda31eDwJFvkuI
         S3/7anb7i6Wrkb/OG5UJhbLdVlClXkqKdfa6QG4alwnfNzKLTZlMYunU/Az9WmX3okjC
         LqDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeB0RZt (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 12:25:49 -0500
Received: from osg.samsung.com ([64.30.133.232]:33509 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751552AbeB0RZr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 12:25:47 -0500
Subject: Re: [PATCH 5/5] selftests: futex Makefile add top level TAP header
 echo to RUN_TESTS
To: Darren Hart <dvhart@infradead.org>, mingo@redhat.com
Cc: shuah@kernel.org, tbird20d@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
 <bec2e6c01cbf3b2f6dc49e022a2a7543fc7f3182.1519423341.git.shuahkh@osg.samsung.com>
 <20180224214244.GA31352@fury>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <d8c446cb-fa30-ec1f-944a-c7763a3e80b7@osg.samsung.com>
Date: Tue, 27 Feb 2018 10:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224214244.GA31352@fury>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231540843660776?=
X-GMAIL-MSGID: =?utf-8?q?1593575841421240606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/24/2018 02:42 PM, Darren Hart wrote:
> On Fri, Feb 23, 2018 at 03:11:40PM -0700, Shuah Khan wrote:
>> Add top level TAP header echo, testname and separator line to make
>> the output consistent with the common run_tests target.
> 
> No objection to the changes, but I'll echo Ingo's request for a more
> detailed justification for why these changes are warranted. We've seen
> this a few times with recent changes to kselftests, I think too much
> might be being assumed regarding the individual test author's tracking
> of the core of the kselftests ongoing work.
> 

Ingo/Darren,

Sorry for not giving a better justification. I should have kept audience
in mind that test authors might not be up on the framework changes.

Nested TAP header example:

TAP version 13
selftests: step_after_suspend_test
========================================
TAP version 13                                           (#Nested header)
Bail out! open("/sys/power/state") failed (is this test running as root?)
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
not ok 1..1 selftests:  step_after_suspend_test [FAIL]
selftests: breakpoint_test
========================================
TAP version 13                                            (#Nested header)
Pass 110 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

<snip>

1..110
ok 1..2 selftests: breakpoint_test [PASS]


Some tests print TAP headers. This is helpful when test is run by itself.
However, when "make kselftest" or "make -C" is used then common run_tests
does its TAP header and nested headers get printed.

Nested headers are a problem for TAP13 parsers. Hence, I decided to go
with a simpler approach to suppress TAP headers using env. variable
that gets checked in the framework and suppresses the header.

selftests: kselftest framework: add handling for TAP header level

This minimizes the churn to actual tests and framework handles the
TAP details.

futex test overrides the generic run_tests, so it needed changes to
add a top level TAP header. Otherwise, you will see nested TAP header
for each of the individual futxex tests as shown in the example below.


TAP version 13
# futex_requeue_pi: Test requeue functionality
#       Arguments: broadcast=0 locked=0 owner=0 timeout=0ns
not ok 1 # error futex-requeue-pi
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 1
1..1

I can capture the nested TAP headers being a problem for parsers in
the changelog. I will have to send v2 anyway, "make -C" still has
the nested headers for fuxtex tests.

My goal is to not have the individual test authors be concerned about
the TAP13 details and handle it in the framework. I am making changes
to framework and test Makefiles for the TAP13 and other common formatting
type features as opposed to individual test code. Test Makefiles that use
lib.mk don't need changes either, futex needs changes mainly because of
overrides.

Hope this help. I will do a better job of explaining in the future.

thanks,
-- Shuah

