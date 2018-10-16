Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A22098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fepBcalZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iJAq2gyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJQB2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:28:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeJQB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:28:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CA576130B; Tue, 16 Oct 2018 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539711396;
        bh=5XEKdceFiuof2Vb6IDeQI+TFQvuemiZNmdNhEvXtgaI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fepBcalZOzyUi9hZx8oFvA+FIeOjtk601eszx65uP0N0QJfbWqAK1BQVHjex9vGx7
         f4gMVChFs3FuYv/C9OxQX5/26PjYBaOl8DKsc8KLu0JfPTdAgJmU45jm3rOcEuZHDn
         XXUf3wB12XUPDTkjGFl/SuJsmFZExgxvdFpKgUhs=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29FF46021C;
        Tue, 16 Oct 2018 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539711395;
        bh=5XEKdceFiuof2Vb6IDeQI+TFQvuemiZNmdNhEvXtgaI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iJAq2gyM32cP97m7YM5HuGON7ZfPBWwkBOJPI1rx4xjWdwIEA1ldZbTewaKv6E1Uu
         CkeCIAxJj9eehRJRk/KwJcNjmVbYQ4zlu2GEtD8SsmeyD3QfA6jKIpPtG/csDxX1bt
         w4QcwSKp7PB5c0cyQjWfbWNLsuHxFtvqZG37/AqQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29FF46021C
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
Date:   Tue, 16 Oct 2018 23:06:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016125721.236ada82@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 10:27 PM, Steven Rostedt wrote:
> 
> OK, can you add to the command line:
> 
>   ftrace=function ftrace_filter=*schedule*
> 
> to see if it's a specific function that may be causing the issue (but
> hopefully it's not one of the scheduling functions that caused it).
> 

Target boots fine with this. So its not scheduling functions that is 
causing it. Also I tried with ftrace_filter=*msm* just to be sure if
tracing driver functions is causing any issue but its NOT.


>>> Does it break if the crypto is not initialized? Perhaps add a command
>>> line flag to have it happen earlier:
>>>   
>>
>> I didnt see any breakage, have been using ramoops with postcore_initcall
>> for sometime now.
>>
>>>    ramoops=earlyinit
>>>
>>> and add a postcore_initcall that checks if that flag is set, and if so,
>>> it does the work then, and the late_initcall() will do nothing.
>>>
>>> That way, you can still have unmodified kernels use pstore when it
>>> crashes at boot up.
>>>    
>>
>> Sounds good.
> 
> Great, I guess you can write a patch to do that ;-)
> 

Sure I can :) but as Kees said it would be better if we could
find a way to make it work with a late initialization of compression.
I will try on that.

Thanks,

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
