Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0670D2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy68EDud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0670D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIFHIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:08:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34792 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:08:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so4224206plo.1;
        Wed, 05 Sep 2018 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/Iy9H1VfReeHP1QihtFtb2tZ2R5LbwwkqWbqHQve00A=;
        b=dy68EDudGm3V26cae9jT7OQUWCAHeZyBGAmfwcNR1H9a7Di1rrsjg1SwigTR7yuCvB
         QHhI3TUFw5LVYHG3dI4jfeuR00akYW9LbDkfEZUPKnSZWEt407JTs50zWRlZMsq7s7Pk
         eiukkC4FZwBVLupEFVZs09aIxEZ4xO8335hIRPmG1bigBFjGf/YaniCEQKSf8a3z0O41
         ZZByofkGhol3nsc/rBLxx1CuDpQJGjBGXSs9B0qcPK/fqzkREsoFSPWcuwC3yIg8KGgv
         iE2F4Sdv/pQ3nQPwnVvyc3I9NctPipvDTWI3SNDnUMea6lnnj1b6kbDcOuRTKKMz6TZL
         1OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/Iy9H1VfReeHP1QihtFtb2tZ2R5LbwwkqWbqHQve00A=;
        b=Ia9bOD35D2Yt1pxMAnRHdD3tOlIoaNXaaBZmb2N5UtZOj/NY5ix1EFQwU4BVRv9Paj
         1YqAmYOg46Qvv0yyb1XUIkFdCSU5HrzFWjn2+MNPW1XDEUecETavf0akVkP2ZsfB3207
         QkixC5+az4n+kLT7aybZFMu0GEtOWgg9bxC6YoAOBcFGoppQY3xxijH0B9ZHv0O+H1Et
         rFjb5SpqIqumotBpmvPi37EdG6FssCAVXIHdSsurXgF786HY003iOPBCdmW7fNqSdERB
         nz/W8LvSmwK7Dgf7Y3MjO5BDfBK9NHx50TCqtUtN/J+Nb+w2xbPGxzAm8xf1n8wLsGlP
         z6Xw==
X-Gm-Message-State: APzg51DIlVH+dffzm+l/vCl+u+A4H450rZqv81DDSsgwtxSRdWic3ND5
        oHj4dd09lFDmh1+0VBSe/T2okoTc
X-Google-Smtp-Source: ANB0VdYycsQJGjjEXA3MeFp83xCMw3RFDxrNm27Uy7IfX+6DtPsRFIzdFjEpamLTgnA7fBYYZGIgEA==
X-Received: by 2002:a17:902:714f:: with SMTP id u15-v6mr649317plm.154.1536201319051;
        Wed, 05 Sep 2018 19:35:19 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id l85-v6sm7276214pfk.34.2018.09.05.19.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:35:18 -0700 (PDT)
Subject: Re: [PATCH] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180901121659.1257-1-baijiaju1990@gmail.com>
 <nycvar.YFH.7.76.1809051026540.15880@cbobk.fhfr.pm>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <6ec3d032-6d33-d2af-965f-7f3457dc8311@gmail.com>
Date:   Thu, 6 Sep 2018 10:35:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1809051026540.15880@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/5 16:29, Jiri Kosina wrote:
> On Sat, 1 Sep 2018, Jia-Ju Bai wrote:
>
>> The driver may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_core.c, 111:
>> 	hid_hw_request in picolcd_send_and_wait
>> drivers/hid/hid-picolcd_core.c, 100:
>> 	_raw_spin_lock_irqsave in picolcd_send_and_wait
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_core.c, 245:
>> 	hid_hw_request in picolcd_reset
>> drivers/hid/hid-picolcd_core.c, 235:
>> 	_raw_spin_lock_irqsave in picolcd_reset
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-picolcd_fb.c, 215:
>> 	hid_hw_request in picolcd_fb_reset
>> drivers/hid/hid-picolcd_fb.c, 206:
>> 	_raw_spin_lock_irqsave in picolcd_fb_reset
>>
>> [FUNC] hid_alloc_report_buf(GFP_KERNEL)
>> drivers/hid/hid-core.c, 1435:
>> 	hid_alloc_report_buf in __hid_request
>> ./include/linux/hid.h, 1023:
>> 	__hid_request in hid_hw_request
>> drivers/hid/hid-lg4ff.c, 465:
>> 	hid_hw_request in lg4ff_play
>> drivers/hid/hid-lg4ff.c, 441:
>> 	_raw_spin_lock_irqsave in lg4ff_play
>>
>> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
>>
>> This bug is found by my static analysis tool DSAC.
> Could you please rewrite the changelog so that it's human readable? The
> above is a bit hard to understand, I think something along the lines of
> "__hid_request() has to be allocating with GFP_ATOMIC because there are
> the following callchains leading to __hid_request() being an atomic
> context: ... a->b->c.._hid_request()" etc.
>

Okay, I will send a new patch.


Best wishes,
Jia-Ju Bai
