Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C74C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B943821470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B943821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJQAcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:32:17 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57454 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJQAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:32:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3F3EBC18AA;
        Tue, 16 Oct 2018 16:41:02 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L8fz-C3JjnzF; Tue, 16 Oct 2018 16:41:02 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id C8B70C0480;
        Tue, 16 Oct 2018 16:40:56 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20181012222106.7f38b667@vmware.local.home>
 <20181015234231.e163ab77fd42dbd3ac9c84d5@kernel.org>
 <20181017002632.20fcb18bf94efb79aa58219b@kernel.org>
 <20181016113952.59893943@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ccadb761-025d-2447-c3e8-5762ea209347@kernel.org>
Date:   Tue, 16 Oct 2018 10:40:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016113952.59893943@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 09:39 AM, Steven Rostedt wrote:
> On Wed, 17 Oct 2018 00:26:32 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Mon, 15 Oct 2018 23:42:31 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>>> On Fri, 12 Oct 2018 22:21:06 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>   
>>>> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>
>>>> Now that ftracetest has over 80 tests, it is difficult to simply scroll
>>>> up the console window to find the failed tests when it reports just two
>>>> tests have failed. In order to make this stand out better, have the
>>>> color of the word "PASS" be green, "FAIL" and "XFAIL" be red, and all
>>>> other results be blue. This helps tremendously in quickly spotting the
>>>> failed tests by just scrolling up the console window.
>>>>   
>>>
>>> Looks good to me.
>>>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>  
>>
>> Oops, I found some problems.
>>
>>>
>>> Thanks!
>>>   
>>>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>> ---
>>>> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
>>>> index 5c71d58..4946b2e 100755
>>>> --- a/tools/testing/selftests/ftrace/ftracetest
>>>> +++ b/tools/testing/selftests/ftrace/ftracetest
>>>> @@ -153,7 +153,7 @@ else
>>>>  fi
>>>>  
>>>>  prlog() { # messages
>>>> -  [ -z "$LOG_FILE" ] && echo "$@" || echo "$@" | tee -a $LOG_FILE
>>>> +  [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE  
>>
>> I think we should strip escape-sequences from log files, like below;
>>
>> strip_esc() {
>>   sed -E "s/[[:cntrl:]]\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
>> }
>>
>>   [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | strip_esc | tee -a $LOG_FILE
>>
>>
>>>>  }
>>>>  catlog() { #file
>>>>    [ -z "$LOG_FILE" ] && cat $1 || cat $1 | tee -a $LOG_FILE
>>>> @@ -195,37 +195,37 @@ test_on_instance() { # testfile
>>>>  eval_result() { # sigval
>>>>    case $1 in
>>>>      $PASS)
>>>> -      prlog "	[PASS]"
>>>> +      prlog "	[\e[32mPASS\e[30m]"  
>>
>> The last one should be "\e[0m" (reset), "\e[30m" just set the color "black".
>> That doesn't work on my terminal, which is "white on black".
>>
>>
> 
> Ah thanks for the feedback. Want to write a patch on top, that Shuah
> can add?
> 
> -- Steve
> 

That will be great. I can apply the updated patch with Masami's Reviewed-by
perhaps.

thanks,
-- Shuah
