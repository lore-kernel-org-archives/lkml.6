Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF3C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FF821479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BclPSk33";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IPrgwByi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FF821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeIWVbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:31:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIWVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:31:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4706560C6C; Sun, 23 Sep 2018 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537716798;
        bh=k9lzblhHqQbmuaZaoyXA5IIlqXHWRmy4igZm8BG+q4w=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=BclPSk33ZdVMDaXv7ZEs42zFfymcL5NaYdv/EkLWqS7x2/1MKWHyaBr31djgSbG41
         qbHRYT7bDGAWjvd+aRyoZT8j0NNYGNx8CyrB84G2ThVDyJYSVpfEpG/o+WKGkmWvCw
         5F8AcFlWPeBjg6IHod1xnVS+7dQCok7M53MWDUBE=
Received: from [192.168.43.47] (unknown [27.59.63.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2073660B7F;
        Sun, 23 Sep 2018 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537716797;
        bh=k9lzblhHqQbmuaZaoyXA5IIlqXHWRmy4igZm8BG+q4w=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IPrgwByiyb/Cugq9OjjZZljqwSONqcV03mn7Wz1CoBg6aDxesPZjMl+rsuTEuY3fM
         5hCm0+F7mqGZUzFmq8K85T8K6yhBChyY3W3AxRt26L4WN80vzKCIedjL0UAHbwjmot
         Z8E+xGFl/RRHzoloxPpo3q16iJI/7SVrTvIzwr58=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2073660B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel-team <kernel-team@android.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Message-ID: <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
Date:   Sun, 23 Sep 2018 21:03:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> +
>>> +       trace_seq_init(&iter->seq);
>>> +       iter->ent = fbuffer->entry;
>>> +       event_call->event.funcs->trace(iter, 0, event);
>>> +       trace_seq_putc(&iter->seq, 0);
>>
>> Would it be possible to store the binary trace record in the pstore
>> buffer instead of outputting text? I suspect that will both be faster
>> and less space.
>>
> 
> I will try this and come back.
> 

Hi Joel,

I removed trace_seq_putc and there is some improvement seen: 203 MB/s

# dd if=/dev/zero of=/dev/null status=progress
12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
24171926+0 records in
24171926+0 records out
12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s

This seems good when compared to 190 MB/s seen previously.
If this is Ok, then I will spin v2 with changes suggested.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
