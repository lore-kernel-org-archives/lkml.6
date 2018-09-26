Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB368C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C155214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BDoaKVwh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FtmkEAcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C155214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeIZQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:05:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56614 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:05:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 55F7060C1D; Wed, 26 Sep 2018 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537955594;
        bh=R4vZs7YOgqX9RkzDn+JCMtYGDm1XJoCxErJBrYPclkg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BDoaKVwhWKzL8+knzb3c3ws7w0850fuDSdJI+7isSipkkt+1kj6JXR38EWPfUlTWd
         fWzUMvG6a8kdVjhDyCxqoVqFB2qywXGpNLMx23fmuZr+ELyHfzuFsUjfsvAg3Zjh/X
         Yu6IIX3GSOjTKQLDSDeNpwW3Pqexz388eavVGPe4=
Received: from [10.79.129.49] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31C1B6053C;
        Wed, 26 Sep 2018 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537955591;
        bh=R4vZs7YOgqX9RkzDn+JCMtYGDm1XJoCxErJBrYPclkg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FtmkEAcRvI2FHWmrZB3CKCRytojqWkUIXsorqbvDcNG2KYqj3ODMmJoBkn6jW3ZMA
         kEBfenQLiKHWiuDQ1Jg75PICcReYIZFAzPc3vNUhNC+DIBaKyQ1laVPA1IyrfFPaJ8
         Ap5+fSuK5ximvCPYLp8xEGhyYRLUu3BIv3RmjtyI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31C1B6053C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Joel Fernandes <joelaf@google.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>, tsoni@codeaurora.org,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        kernel-team <kernel-team@android.com>,
        devicetree@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Cross <ccross@android.com>, Joe Perches <joe@perches.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
 <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
 <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
 <CAJWu+oorTRschpgLODgVv50S57U6Su9SM57WVrVKiQBSXEVC9w@mail.gmail.com>
 <CAJWu+orL63-qfDL7B_Fs_Vx_rUr4fwn+DXK1mosmyM4jhj_BSw@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <67f42dd8-31e3-99fa-06b7-bd9f860ccef8@codeaurora.org>
Date:   Wed, 26 Sep 2018 15:22:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJWu+orL63-qfDL7B_Fs_Vx_rUr4fwn+DXK1mosmyM4jhj_BSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 2:10 AM, Joel Fernandes wrote:
> On Tue, Sep 25, 2018 at 1:39 PM, Joel Fernandes <joelaf@google.com> wrote:
>> On Tue, Sep 25, 2018 at 1:37 PM, Joel Fernandes <joelaf@google.com> wrote:
>>> On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>>>>
>>>>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>>>>
>>>>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>>>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> +
>>>>>>> +       trace_seq_init(&iter->seq);
>>>>>>> +       iter->ent = fbuffer->entry;
>>>>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>>>>> +       trace_seq_putc(&iter->seq, 0);
>>>>>>
>>>>>>
>>>>>> Would it be possible to store the binary trace record in the pstore
>>>>>> buffer instead of outputting text? I suspect that will both be faster
>>>>>> and less space.
>>>>>>
>>>>>
>>>>> I will try this and come back.
>>>>>
>>>>
>>>> Hi Joel,
>>>>
>>>> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>>>>
>>>> # dd if=/dev/zero of=/dev/null status=progress
>>>> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
>>>> 24171926+0 records in
>>>> 24171926+0 records out
>>>> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>>>>
>>>> This seems good when compared to 190 MB/s seen previously.
>>>> If this is Ok, then I will spin v2 with changes suggested.
>>>
>>> Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.
>>>
>>
>> Well so I think you should still not use spinlock to synchronize and
>> split the buffer. You could expand pstore_record to have a ts field or
>> introduce a new API like ->write_percpu instead of write, or
>> something. But I strongly feel you should lock. For ftrace function
> 
> Aargh, I meant you should *not* lock :-)
> 

OK I can try this and will measure some perf difference.

BTW I guess you missed my previous comment about not able to combine 
logs based on timestamp? Anyways I think if I add some extra ts field, 
then should be able to do it.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
