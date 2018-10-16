Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFE9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC9B21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PvJvc/Ef";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l7ysdptI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC9B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJQB4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:56:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQB4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:56:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DC38F612F6; Tue, 16 Oct 2018 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539713113;
        bh=v9UsiGiw9e1yioOSWt6WIEiPefDHfptpAdXO4v7qen0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PvJvc/EfVuRzsurhe4hoyc27qNJvBW2HDobOvi48/U6wCD86tQw9w7zW5yZSr4J8K
         J6Snsro9wSLeKRrgUBfMTMCa84Nxg6ZLRzKyTOYEijQQ8IaSyBH6pyUXa2Su6Y6ulg
         UsMJEqVj6CPdV57qj+tuOr3fpz2E/XBv+/yUrwf0=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48673606DD;
        Tue, 16 Oct 2018 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539713112;
        bh=v9UsiGiw9e1yioOSWt6WIEiPefDHfptpAdXO4v7qen0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l7ysdptIb4aj0L4FfPU24NJEZoVU/BoO57L1KZtOyKvL0bPy3apP6yq2Ng2Z1xwmx
         MHuihzEoPX7eIeWjtkEQoCBuWrO19MuuTpo+E6POXiiJmbEbvIM08e/VqzbCLsRy5E
         3KSugB9UhrfQeLVHDXi6HgfNimCjBdt1cNJCxvg4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48673606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
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
 <20181016112928.4b52afb5@gandalf.local.home>
 <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
 <20181016125721.236ada82@gandalf.local.home>
 <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
 <20181016134803.1b9260c1@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
Date:   Tue, 16 Oct 2018 23:35:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016134803.1b9260c1@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 11:18 PM, Steven Rostedt wrote:
> On Tue, 16 Oct 2018 23:06:24 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> On 10/16/2018 10:27 PM, Steven Rostedt wrote:
>>>
>>> OK, can you add to the command line:
>>>
>>>    ftrace=function ftrace_filter=*schedule*
>>>
>>> to see if it's a specific function that may be causing the issue (but
>>> hopefully it's not one of the scheduling functions that caused it).
>>>    
>>
>> Target boots fine with this. So its not scheduling functions that is
>> causing it. Also I tried with ftrace_filter=*msm* just to be sure if
>> tracing driver functions is causing any issue but its NOT.
> 
> OK, seems that something is being traced that shouldn't be.
> 
> When this happens after boot up, it's easy to bisect down to the
> problem function. But since it's at boot up, it will take a lot longer.
> 
> I would suggest to start by going down the alphabet.
> 
> 	ftrace_filter=a*
>   	ftrace_filter=b*
> 	ftrace_filter=c*
> 	[...]
> 
> And at least find the letter the bad function starts with.
> 
> Note, it could be more than one function (I've had that a couple of
> times), and to find that out, you can test with "ftrace_notrace". Say
> you find that the problem function starts with 'x'. You can do:
> 
> 	ftrace_notrace=x*
> 
> Which will trace all functions except those that start with an 'x', to
> make sure it still boots.
> 
> Remember, you still need to have ftrace=function for all of this.
> 
> Once you find the letter of the function, you can try the next letter,
> or perhaps come up with another method. I would say look at the
> functions in /sys/kernel/debug/tracing/available_filter_functions, but
> they don't list the init function (that can be traced). But you can
> use /proc/kallsyms instead.
> 

Ok got it, this sounds fun. I'll give it a try.

Thanks

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
