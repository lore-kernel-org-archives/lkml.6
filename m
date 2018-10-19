Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A4ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D61320869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VwYi+KJN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VwYi+KJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D61320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJSWy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:54:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeJSWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:54:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EAE5461313; Fri, 19 Oct 2018 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539960510;
        bh=f+9WH9lO0R/rp/E0M2s+lUPu334QwfiDFHKgp1lftCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VwYi+KJNp3bKjMv7bAmLh4wQQpENsgdhTnHktuu8KHJ/MixWxbY6cJdQ0MphEgFyy
         7UQmJ2HdxmqMMqersSWO63c4NWYqjO43Evb3OkA6gjgMWKTXAELhfQsvjOkLK37XFR
         UbKs+qHbOZzTykVU8t0mCWary82TQpMly4V4HpOQ=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25B1F6028D;
        Fri, 19 Oct 2018 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539960510;
        bh=f+9WH9lO0R/rp/E0M2s+lUPu334QwfiDFHKgp1lftCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VwYi+KJNp3bKjMv7bAmLh4wQQpENsgdhTnHktuu8KHJ/MixWxbY6cJdQ0MphEgFyy
         7UQmJ2HdxmqMMqersSWO63c4NWYqjO43Evb3OkA6gjgMWKTXAELhfQsvjOkLK37XFR
         UbKs+qHbOZzTykVU8t0mCWary82TQpMly4V4HpOQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25B1F6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
 <20181019095122.0f1c0946@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
Date:   Fri, 19 Oct 2018 20:18:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019095122.0f1c0946@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 7:21 PM, Steven Rostedt wrote:
> On Fri, 19 Oct 2018 12:24:05 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>>>> Anyone see any problems here?
>>>
>>> This seems sane to me, he says in the other thread that he put 'notrace' to
>>> the msm serial functions (which AIUI should prevent ftrace instrumentation)
>>> and he still sees the issue.
>>>    
>>
>> Yes I did add notrace to all functions in msm serial and checked the
>> objdump to make sure that those were not instrumented, and yet the
>> target crashed. This doesnt seem like an issue with ftrace but rather
>> with msm early con.
> 
> The thing that still bothers me is that it boots fine without ftrace
> running, and that it requires tracing something to cause the problem.
> This tells me that ftrace has something to do with it. Perhaps it's
> just changing the timing.
> 

Yes tracing does cause issue but only if earlycon is present. If I 
disable earlycon, then even tracing wont cause any issue and target 
boots fine.

> You said that if you add 'ftrace_filter=msm_read' to the command line,
> it still crashes?
> 
> So only tracing that function we have an issue, right?
> 

Tracing msm_read does cause the crash, but that is not the only one 
causing the crash because even after "ftrace_notrace=msm_read" the board 
crashes which is why I suspect msm earlycon and not ftrace.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
