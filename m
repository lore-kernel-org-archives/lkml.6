Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D2214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S2ivtbgF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mvEa3JTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D2214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJQTdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:33:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:33:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01B11612F6; Wed, 17 Oct 2018 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539776299;
        bh=EbhW9WqrrqJur7Ew2D85lJ006WEMmh7PHp5h9p5rSt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S2ivtbgFRI6dFPD4Oxspof5BS3M5MZgrtPu3WnN3h9y2HaQYvWjO4+4H9aAxsJzXm
         KbQ8O4Zdrh56M7+9t9Y7iM89X/OAkZpga4JbHR/ZZyXJ9RZYTAueY0lZelX5MQbJbu
         QdIcOS8yEWEIe+7/pNAXTMZ0V7MmX8ra4PxkkNXs=
Received: from [10.79.129.10] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0572E60285;
        Wed, 17 Oct 2018 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539776297;
        bh=EbhW9WqrrqJur7Ew2D85lJ006WEMmh7PHp5h9p5rSt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mvEa3JTGIOyHr7C1ZDvRg1Tm2cs5XbGIAA8+G8jApQrdACgt8pggtML82Qhkg5s+3
         QUwtiGvtpGtdzUkiJaOaJaS7X12IVkbycVTtnCkezT/trPWG8Jzxrvtb6QN9TkPH8M
         DbbQ+NjMCd6aRV2aytYMn1T+UyFvoR2psAJ2feek=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0572E60285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
Date:   Wed, 17 Oct 2018 17:08:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017101355.GA230639@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 3:43 PM, Joel Fernandes wrote:
> Hi Kees,
> 
> On Tue, Oct 16, 2018 at 10:02:53AM -0700, Kees Cook wrote:
>> On Tue, Oct 16, 2018 at 8:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> On Tue, 16 Oct 2018 17:08:25 +0530
>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>> One more thing is for pstore dmesg-ramoops, I had to change
>>>> late_initcall to postcore_initcall which brings the question as to why
>>>> we changed to late_initcall?
>>>> Simple git blame shows to support crypto compress api, but is it really
>>>> helpful? A lot of boottime issues can be caught with pstore enabled at
>>>> postcore_initcall rather than late_initcall, this backtrace
>>>> is just one example. Is there any way we could change this?
>>>
>>> Does it break if the crypto is not initialized? Perhaps add a command
>>> line flag to have it happen earlier:
>>>
>>>   ramoops=earlyinit
>>>
>>> and add a postcore_initcall that checks if that flag is set, and if so,
>>> it does the work then, and the late_initcall() will do nothing.
>>>
>>> That way, you can still have unmodified kernels use pstore when it
>>> crashes at boot up.
>>
>> Even better, if we could find a way to make it work with a late
>> initialization of compression (i.e. postcore_initcall() by default
>> means anything caught would be uncompressed, but anything after
>> late_initcall() would be compressed). I'd be very happy to review
>> patches for that!
> 
> What do you think about the (untested) patch below? It seems to me that it
> should solve the issue of missing early crash dumps, but I have not tested it
> yet. Sai, would you mind trying it out and let me know if you can see the
> early crash dumps properly now?
> 
> ----8<---
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [RFC] pstore: allocate compression during late_initcall
> 
> ramoop's pstore registration (using pstore_register) has to run during
> late_initcall because crypto backend may not be ready during
> postcore_initcall. This causes missing of dmesg crash dumps which could
> have been caught by pstore.
> 
> Instead, lets allow ramoops pstore registration earlier, and once crypto
> is ready we can initialize the compression.
> 
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   fs/pstore/platform.c | 13 +++++++++++++
>   fs/pstore/ram.c      |  2 +-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 15e99d5a681d..f09066db2d4d 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
>   	}
>   }
>   
> +static int __init pstore_compression_late_init(void)
> +{
> +	/*
> +	 * Check if any pstore backends registered earlier but did not allocate
> +	 * for compression because crypto was not ready, if so then initialize
> +	 * compression.
> +	 */
> +	if (psinfo && !tfm)
> +		allocate_buf_for_compression();
> +	return 0;
> +}
> +late_initcall(pstore_compression_late_init);
> +
>   module_param(compress, charp, 0444);
>   MODULE_PARM_DESC(compress, "Pstore compression to use");
>   
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index bbd1e357c23d..98e48d1a9776 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -940,7 +940,7 @@ static int __init ramoops_init(void)
>   	ramoops_register_dummy();
>   	return platform_driver_register(&ramoops_driver);
>   }
> -late_initcall(ramoops_init);
> +postcore_initcall(ramoops_init);
>   
>   static void __exit ramoops_exit(void)
>   {
> 

Yes I could see the early crash dump. Also I tested with different 
compression (LZO) instead of deflate just to be sure and it works fine, 
thanks :)

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
