Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABE9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7252B20833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="An6bJbyT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RGNho1yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7252B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIRM36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:29:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeIRM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:29:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BE7960C4B; Tue, 18 Sep 2018 06:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537253925;
        bh=xOgwniLrBUo+1Z0z1uODEuo0EmZADqaUabTx93CsKEU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=An6bJbyTejMBKBPtko9CzgvUQvQEuWPtS8jNMrUyaG4Lxz6lWQcGzCCkPSE7myPdZ
         T2t+p2YQJ6dUTYv9SPd76GOAqgYPNUG4J6AenZn0EWcO8FsyPP8zNM6xK46HzFfM5v
         kU8iW27wzz9Dxt/a03kZOSvXjTxD2nhMddqSxbyk=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A20A0607DD;
        Tue, 18 Sep 2018 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537253924;
        bh=xOgwniLrBUo+1Z0z1uODEuo0EmZADqaUabTx93CsKEU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RGNho1ygbIfIDQMiqbvWPzjI5DeOmf+SY65rq7IaJnPjzLbWPGS9SQjZdgOCnlXK0
         N5B8uPrAn4nX0tZkthquruuH+uZDn6w9RkTk3g6SuD9pkl17tiQTMW+hBXL0UI7lnS
         AmZiA4DZofyMt4tLyUpc2ePpAwdEUT1T4Xn/Dtw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A20A0607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
To:     Jiri Slaby <jslaby@suse.cz>, Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <ebea1697-cf33-675b-172c-3e80303a9ee9@codeaurora.org>
Date:   Tue, 18 Sep 2018 12:28:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 11:41 AM, Jiri Slaby wrote:
> On 09/17/2018, 11:33 PM, Matthias Kaehlcke wrote:
>> sysrq_handle_crash() dereferences a NULL pointer on purpose to force
>> an exception, the local variable 'killer' is assigned to NULL and
>> dereferenced later. Clang detects the NULL pointer dereference at compile
>> time and emits a BRK instruction (on arm64) instead of the expected NULL
>> pointer exception. Change 'killer' to a global variable (and rename it
>> to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
>> detecting the condition. By default global variables are initialized
>> with zero/NULL in C, therefore an explicit initialization is not needed.
>>
>> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> Suggested-by: Evan Green <evgreen@chromium.org>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>   drivers/tty/sysrq.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index 06ed20dd01ba..49fa8e758690 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
>>   #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
>>   #endif /* CONFIG_VT */
>>   
>> +char *sysrq_killer;
>> +
>>   static void sysrq_handle_crash(int key)
>>   {
>> -	char *killer = NULL;
>> -
>>   	/* we need to release the RCU read lock here,
>>   	 * otherwise we get an annoying
>>   	 * 'BUG: sleeping function called from invalid context'
>> @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
>>   	rcu_read_unlock();
>>   	panic_on_oops = 1;	/* force panic */
>>   	wmb();
>> -	*killer = 1;
>> +	*sysrq_killer = 1;
> 
> Just because a static analyzer is wrong? Oh wait, even compiler is
> wrong. At least make it a static global. Or what about OPTIMIZER_HIDE_VAR?
> 

static global does not work, clang still inserts brk. As for 
OPTIMIZE_HIDE_VAR, it seems to work.
But, I dont think it is defined for clang in which case it defaults to 
using barrier(). There is already one wmb(), so will it be right?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
