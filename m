Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C1ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA332150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yv7faaiQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fa1Fcdq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA332150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJQTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:23:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:23:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58FBD612F6; Wed, 17 Oct 2018 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539775671;
        bh=TLOEKPKFLxEc0Tmbpb2oOwgeF6MRjfPMkLQZfPUWPTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yv7faaiQm15UyKgux25dmKa5LWeJRm6UqJwOkuCiCPscEq46OX+6qIb2boz2oNCyi
         4OEyU6oV7+iC4mM3Kb2Kp1+ufhEn1ZrRXJMUlJFtOce/bQiBGXyuZwnL2cg+wl5rV1
         UBt1aTIL8GXb6EZmhAisP3LTLOqGvnxqRqavqNkE=
Received: from [10.79.129.10] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F28E6034D;
        Wed, 17 Oct 2018 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539775670;
        bh=TLOEKPKFLxEc0Tmbpb2oOwgeF6MRjfPMkLQZfPUWPTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fa1Fcdq6wfIScAxE2cKHGrHkzno/nRubnGYW4IRNNZGTGCptu9pSkQb1TWJzTBahj
         Yytv3ONeyhaPYUgQ9NHlTCdUI3PpxmpqG4D8zMAnyMt/hHlvE4J72bS9bd3AhHk4GR
         IINDuUFgAY6btVrCJJsD6/k/9yZss2KUPYoOLrvE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F28E6034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181016151516.786b16cc@gandalf.local.home>
 <0b014d85-9988-0bf5-7b72-911dbbcdadfc@codeaurora.org>
 <153972306834.5275.7510298070540576604@swboyd.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <17116a6b-156e-af2f-c20c-88bea10bfc92@codeaurora.org>
Date:   Wed, 17 Oct 2018 16:57:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153972306834.5275.7510298070540576604@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 2:21 AM, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2018-10-16 12:35:57)
>> On 10/17/2018 12:45 AM, Steven Rostedt wrote:
>>> On Wed, 17 Oct 2018 00:36:05 +0530
>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>>> On 10/17/2018 12:33 AM, Steven Rostedt wrote:
>>>>> On Wed, 17 Oct 2018 00:31:03 +0530
>>>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>>>     
>>>>>> Haa seems like you are right! With "ftrace=function
>>>>>> ftrace_filter=msm_read" , I can trigger the crash, but
>>>>>> sadly "ftrace_notrace=msm_read" also crashes.
>>>>>
>>>>> So there's more than one problem area.
>>>>>
>>>>> What about ftrace_notrace=m*
>>>>>
>>>>> ?
>>>>>     
>>>>
>>>> That too crashes.
>>>>
>>>
>>> Which compiler are you using and can you send me your config.
>>>
>> Config attached.
>>
>> Compiler: aarch64-linux-gnu-gcc (Linaro GCC 6.3-2017.02) 6.3.1 20170109
>>
>>> I wonder if there's something screwing up with the way ftrace nops are
>>> working on this board.
>>>
>>> A couple things of note, 1) it works fine after boot up. 2) it crashes
>>> in the initcall code, so it's not due to ftrace being enabled too early.
>>>
>>> I'd like to see the full command line as well. I bet if you remove the
>>> qcom,msm-uartdm from the command line, and had just ftrace=function, it
>>> may also boot fine too. Can you try that?
>>>
>>
>> Kernel command line: root=/dev/disk/by-partlabel/rootfs rw rootwait
>> ftrace=function ftrace_notrace=m* earlycon console=ttyMSM0,115200n8
>>
>> qcom,msm-uartdm is not in command line, it is the earlycon. So without
>> earlycon(bootconsole), board boots fine as we discussed earlier.
>>
> 
> Have you tried with earlycon and no ftrace things on the commandline?
> 
>   root=/dev/disk/by-partlabel/rootfs rw rootwait earlycon console=ttyMSM0,115200n8
> 
> If earlycon is causing problems, it sounds like this may be another case
> of earlycon uart handing off to the uart driver and that failing because
> something gets printed while the uart is transitioning from the earlycon
> console to the kernel boot console. I recall the uart would trample on
> itself in interesting ways.
> 

Yes I have tried with only earlycon enabled and everything is fine. 
Issue is reproduced only with ftrace=function cmdline.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
