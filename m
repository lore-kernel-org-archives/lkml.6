Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0191C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E3A218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="i7qM56wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E3A218AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeHQMpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:45:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33158 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeHQMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:45:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so3491989plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0cMgd+htuoGLq7omwmgNGXTWYbQ617Fms4XSkZvK1+4=;
        b=i7qM56wjkTxY66G8xRAfuCVSMSILkedWeOOlEZXvAraaKiabYcBFRLX1zU0UfzGdBp
         XBkCJuIy8JYtfVJ5TnA9rCTUorIUQ5Y4uTE2RUytB5SKlcXLk5cWEqTcqdAUdQZ57NhF
         hsbCe1zKtf94/uyQPboT3YcwU0h+KI+eIXsGebd0ZC7/9xyUUuD4/a5zX3KUcsO31nN0
         vn/3yhZbwW3MNXju5CsBKncpUacmfNbbr+4CnbM9DB3um+WED+G8lvHei/q61ZxQXnmy
         SO2U0kFQMem/m4HW89NMyYZtNPFRYjJf9knmmQJMc3teKV8EkRjVZsP81NTGHtc0NX8j
         +T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0cMgd+htuoGLq7omwmgNGXTWYbQ617Fms4XSkZvK1+4=;
        b=PdUfyS14cQmqrdf2OANjW0OWvYMNUj6Ji1l1myUtC5B2YtESC1bkFRLCXwhFKkKMm+
         b/TmHShiDJUqEn5/Wnwm/d2SmA/JKVzzhkJAhBrC7TUa42yrxs2m38/XeG8vZ/tGeq/P
         JI1Qr6G8Fue+vCqBr9I58M23YxcyJiV3Tmp1slbAQ3+HpAZ/8saJu+eMjlx5IpIRASAp
         BQZJGy7RyfMcWKmN6oFLTmtfaqdaZ5aYP2Pg69I+rdtSBNol69pKLlDrK6rOPlu0gwck
         +GCNiIXMnKRtD7x1/TFrV18HKFRGScUm7iPVaQDYJVN4dR2/p7t23sakqQfsNn1YbF/N
         jTew==
X-Gm-Message-State: AOUpUlH6zk0SRGJCeb4Z2I1tFAH+LAI6Lru04PdVatMfeSD41JECW34h
        Ol64kPVhyMZh9EF0Sn2+PBnLsw5yDr9wIQ==
X-Google-Smtp-Source: AA+uWPx9HkYQf3AHDain4AHzRs3goIx7DVbgnsnVA3kUAgtA+kFZ90liY1cJWzCpAgMN+WsMRjM6OQ==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr33359086plo.225.1534498945919;
        Fri, 17 Aug 2018 02:42:25 -0700 (PDT)
Received: from [10.86.58.199] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id g85-v6sm4085175pfk.39.2018.08.17.02.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:42:24 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
 <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
Date:   Fri, 17 Aug 2018 11:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 11:34 AM, Javier Gonzalez wrote:
>> On 17 Aug 2018, at 11.29, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>>> On 17 Aug 2018, at 10.21, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>>> On 16 Aug 2018, at 13.34, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>
>>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>>>>> core.
>>>>>>
>>>>>> Hi Javier, I did not end up using your patch. I had misunderstood what
>>>>>> was implemented. Instead I implemented the detection of the each chunk by
>>>>>> first sensing the first page, then the last page, and if the chunk
>>>>>> is sensed as open, a per page scan will be executed to update the write
>>>>>> pointer appropriately.
>>>>> I see why you want to do it this way for maintaining the chunk
>>>>> abstraction, but this is potentially very inefficient as blocks not used
>>>>> by any target will be recovered unnecessarily.
>>>>
>>>> True. It will up to the target to not ask for more metadata than necessary (similarly for 2.0)
>>>>
>>>> Note that in 1.2, it is
>>>>> expected that targets will need to recover the write pointer themselves.
>>>>> What is more, in the normal path, this will be part of the metadata
>>>>> being stored so no wp recovery is needed. Still, this approach forces
>>>>> recovery on each 1.2 instance creation (also on factory reset). In this
>>>>> context, you are right, the patch I proposed only addresses the double
>>>>> erase issue, which was the original motivator, and left the actual
>>>>> pointer recovery to the normal pblk recovery process.
>>>>> Besides this, in order to consider this as a real possibility, we need
>>>>> to measure the impact on startup time. For this, could you implement
>>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>>> recovering (i) asynchronously and (ii) concurrently across luns so that
>>>>> we can establish the recovery cost more fairly? We can look at a
>>>>> specific penalty ranges afterwards.
>>>>
>>>> Honestly, 1.2 is deprecated.
>>> For some...
>> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 have
>> their own storage stack and spec that they will continue development
>> on, which can not be expected to be compatible with the OCSSD 1.2 that
>> is implemented in the lightnvm subsystem.
>>
> 
> There are 1.2 devices out there using the current stack with no changes. >

Yes, obviously, and they should continue to work. Which this patch 
doesn't change.

>>>> I don't care about the performance, I
>>>> care about being easy to maintain, so it doesn't borg me down in the
>>>> future.
>>> This should be stated clear in the commit message.
>>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks per
>>>> die, and 60us read time, will take 4 seconds to scan if all chunks are
>>>> free, a worst case something like ~10 seconds. -> Not a problem for
>>>> me.
>>> Worst case is _much_ worse than 10s if you need to scan the block to
>>> find the write pointer. We are talking minutes.
>>
>> I think you may be assuming that all blocks are open. My assumption is
>> that this is very rare (given the NAND characteristics). At most a
>> couple of blocks may be open per die. That leads me to the time
>> quoted.
>>
> 
> Worst case is worst case, no assumptions.
> 
>>> At least make the recovery reads asynchronous. It is low hanging fruit
>>> and will help the average case significantly.
>>>>> Also, the recovery scheme in pblk will change significantly by doing
>>>>> this, so I assume you will send a followup patchset reimplementing
>>>>> recovery for the 1.2 path?
>>>>
>>>> The 1.2 path shouldn't be necessary after this. That is the idea of
>>>> this work. Obviously, the set bad block interface will have to
>>>> preserved and called.
>>> If we base this patch on top of my 2.0 recovery, we will still need to
>>> make changes to support all 1.2 corner cases.
>>> How do you want to do it? We get this patch in shape and I rebase on top
>>> or the other way around?
>>
>> I'll pull this in when you're tested it with your 1.2 implementation.
> 
> Please, address the asynchronous read comment before considering pulling
> this path. There is really no reason not to improve this.
> 

I'll accept patches, but I won't spend time on it. Please let me know if 
you have other comments.

