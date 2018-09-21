Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419EECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5A21571
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5A21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391561AbeIVDPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:15:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47870 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVDPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:15:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 92C01C0CA4;
        Fri, 21 Sep 2018 21:24:35 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F4ROzxTE5X6N; Fri, 21 Sep 2018 21:24:35 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 141B2C0588;
        Fri, 21 Sep 2018 21:24:26 +0000 (UTC)
Subject: Re: [PATCH v3 00/28] selftests/ftrace: Improve ftracetest with
 coverage check
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <9cf69344-5dfc-4961-163e-1e14bbe80647@kernel.org>
Date:   Fri, 21 Sep 2018 15:24:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 08/30/2018 08:12 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is the 3rd version of the series for improving ftracetest
> testcase using gcov/lcov. In this version I just fixed some
> reported issues and dropped some tests which is not needed.
> I also dropped a testcase for blktrace from this version.
> It will be discussed separated thread.
> 
> Previous version is here;
> 
> https://lkml.org/lkml/2018/8/16/393
> 
> GCOV_PROFILE_FTRACE has already been merged through tracing
> tree.
> 
> Ftracetest framework improvements:
>  - Add --stop-fail for detecting failure soon.
>  - Add --console for interactively debugging a testcase by shell.
>  - Add testcase-number prefix to logfile for finding log easier.
>  - Improve general init function
>  - Add SPDX license identifiers
>  - Call general init function after all testcases.
>  - Remove init/cleanup code from all testcase (since general init
>    function will fixed it up)
> 
> Testcase fixes:
>  - Fix to check $comm availability.
>  - Make checkbashisms clean
> 
> Testcase improvements:
>  - Use loopback address instead of localhost
>  - Improve kprobe on module testcase to load/unload module
>  - Improve kprobe testcase to check log data
>  - Improve kretprobe testcase to check log data
>  - Test kprobe-event argument with various bitsize
>  - Check set_event_pid result
> 
> Adding testcases:
>  - Add kprobe event with $comm argument testcase
>  - Add kprobe profile testcase
>  - Add kprobe-event with symbol argument testcase
>  - Add trace_printk sample module testcase
>  - Add ringbuffer size changing testcase
>  - Add function profiling statistics testcase
>  - Add max stack tracer testcase
>  - Add function filter on module testcase
>  - Add trace_pipe testcase
>  - Add stacktrace ftrace filter command testcase
>  - Add wakeup tracer testcase
>  - Add wakeup_rt tracer testcase
>  - Add ftrace cpumask testcase
> 
> TBD:
> Following testcase improvements are remaining.
>  - Checking of various supported types (like u8, u64 etc.)
>    testcases
> 
> Tested on x86-64 qemu.
> 
> # of passed:  84
> # of failed:  0
> # of unresolved:  0
> # of untested:  0
> # of unsupported:  0
> # of xfailed:  0
> # of undefined(test bug):  0
> 
> Thank you,
> 

Thanks for the patches. Sorry for the delay. I am applying the series to linux-kselftest
next for 4.20 release.

thanks,
-- Shuah

