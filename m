Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB7C2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cyU7tudF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pDc256VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB7C2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJQWqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:46:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJQWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:46:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4746F60769; Wed, 17 Oct 2018 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539787805;
        bh=Wk+VNzTAG2U1KHPsUStP31swo41CoB5YURu+ohyDsM4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=cyU7tudFTQJlTkyeLhF9T233971YnqnowoGxaxOK3TjatGMM0V7Z3DupYuoPLk5pm
         ioQMauuuRmFFpP+U2/HjoLGR39ygQIdlGtBg1eMNVBx6HwmoCI2i5wGZerQ5NNfAcA
         TB8e1ET2QcC5L4bVMOZDvoIXU2yuqhsUGKhxWq8Q=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8094E60769;
        Wed, 17 Oct 2018 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539787803;
        bh=Wk+VNzTAG2U1KHPsUStP31swo41CoB5YURu+ohyDsM4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=pDc256VKXag+l77psjUdtES+Weoeh76UBDjdV01E6aNvBco5vELXkoE4AQR5SI9eq
         HvEKQWtBe3NQ4FZjxemBRIzFgt4r56beoOTpRV2ewsBmDrH+FSfHtg3T6HfzhlfT+j
         cKUfwrPCpimgIqvvDBFwLc6/9Trul/t+vsSv4rWw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8094E60769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
 <20181017101355.GA230639@joelaf.mtv.corp.google.com>
 <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
Message-ID: <69d2f43d-dc96-9348-7f70-5db88e8f5c39@codeaurora.org>
Date:   Wed, 17 Oct 2018 20:19:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 5:08 PM, Sai Prakash Ranjan wrote:
>>
>> What do you think about the (untested) patch below? It seems to me 
>> that it
>> should solve the issue of missing early crash dumps, but I have not 
>> tested it
>> yet. Sai, would you mind trying it out and let me know if you can see the
>> early crash dumps properly now?
>>
>> ----8<---
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> Subject: [RFC] pstore: allocate compression during late_initcall
>>
>> ramoop's pstore registration (using pstore_register) has to run during
>> late_initcall because crypto backend may not be ready during
>> postcore_initcall. This causes missing of dmesg crash dumps which could
>> have been caught by pstore.
>>
>> Instead, lets allow ramoops pstore registration earlier, and once crypto
>> is ready we can initialize the compression.
>>
>> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>   fs/pstore/platform.c | 13 +++++++++++++
>>   fs/pstore/ram.c      |  2 +-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index 15e99d5a681d..f09066db2d4d 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
>>       }
>>   }
>> +static int __init pstore_compression_late_init(void)
>> +{
>> +    /*
>> +     * Check if any pstore backends registered earlier but did not 
>> allocate
>> +     * for compression because crypto was not ready, if so then 
>> initialize
>> +     * compression.
>> +     */
>> +    if (psinfo && !tfm)
>> +        allocate_buf_for_compression();
>> +    return 0;
>> +}
>> +late_initcall(pstore_compression_late_init);
>> +
>>   module_param(compress, charp, 0444);
>>   MODULE_PARM_DESC(compress, "Pstore compression to use");
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index bbd1e357c23d..98e48d1a9776 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -940,7 +940,7 @@ static int __init ramoops_init(void)
>>       ramoops_register_dummy();
>>       return platform_driver_register(&ramoops_driver);
>>   }
>> -late_initcall(ramoops_init);
>> +postcore_initcall(ramoops_init);
>>   static void __exit ramoops_exit(void)
>>   {
>>
> 
> Yes I could see the early crash dump. Also I tested with different 
> compression (LZO) instead of deflate just to be sure and it works fine, 
> thanks :)
> 
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 

I just noticed that allocate_buf_for_compression() is also called from 
pstore_register(). Shouldn't that call be removed now that ramoops_init 
is moved to postcore_initcall and allocate_buf_for_compression() will 
just return doing nothing when called from pstore_register()?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
