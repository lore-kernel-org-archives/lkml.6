Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD566C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8943E208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy1b8FSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8943E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeHBGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:47:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46631 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:47:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so559813pfn.13;
        Wed, 01 Aug 2018 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YXc18G3GVLYccvO9w8xJ9HuUCC29jKVSZQgmCPB5f8=;
        b=hy1b8FSqfxq9B1si5m6eu1E7ADN25J4ZGpMd/3KW+uOqmwdNW9xd88a6KgwaydFUjU
         zxy/AynR7abKJyCDpuvxF+1uddqPKptgVjfCqYUsplNddZBP5RZ+r8CbNDP83rQYWhp/
         RM5qcSUoZ2+S8V+9kdogMxxe00K/5kHO7PMcZGS5kQdC9S3qLHCcCX+kQpGW3XcNlQqg
         9wp7OzCfirf50XKe69JFlsAWxh6ztmGrhJF+g7CGzGjVfRyvJBT5wU3t1TAkhzAPSnzW
         W4kNu2IfeJ3WCTt0K3VwbG8o9vA6bR96Gr9SbDgfvMv29WQodE1rVqVBiLolBXZe/8b+
         3lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YXc18G3GVLYccvO9w8xJ9HuUCC29jKVSZQgmCPB5f8=;
        b=BHx+h04by63D3/8Sb08FfKg2l1prj/uzNzqLrHK9DVuCIoB9o12TptLSp1ptsXl/7z
         hVMYRZOG8kZ7frVgz9Up2MVgw3rKpFIuwKUfq53VAPsfpzurnSxWptdzTHm2LH/AWrKr
         I4j7OtiYq3gwDGAkDlOi1FOTZzdhnc3F9Ns4eEMoOV52hL5xDRs5EitJTUSho90kXzWV
         cBs60kAOTKHnOrEDiTjeMX+/VR2YCvk54ivAPmjP0KMZmKwS6NMLoz2ZQOFVuqjuQPim
         yBJFDMd3BITDsXNfIyBI9wvFAEii/fVrxx5gXwYinFy7yV72S6bybW9agWNt4qnyq46E
         PdYQ==
X-Gm-Message-State: AOUpUlGDYkggFS6AruprRzFvXRXyLWzVqSG3zzHLH7QnM5/HVe60fRZc
        ig2P2dNzGbB09LG+KdgYtkT8253t
X-Google-Smtp-Source: AAOMgpcA6cJv2Jy6xP4SkV1Re5223wd8Vb0dXyuKyz9SB+SsRepEcFlUAoB2ZL6lX8PNTCJA9PJJcw==
X-Received: by 2002:a62:9f85:: with SMTP id v5-v6mr1297268pfk.27.1533185920541;
        Wed, 01 Aug 2018 21:58:40 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r11-v6sm630159pgn.62.2018.08.01.21.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 21:58:39 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
Date:   Wed, 1 Aug 2018 21:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533168205.3158.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 05:03 PM, James Bottomley wrote:
> On Thu, 2018-08-02 at 07:57 +0800, Ming Lei wrote:
>> On Thu, Aug 2, 2018 at 7:47 AM, Guenter Roeck <linux@roeck-us.net>
>> wrote:
>>> On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
>>>> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
>>>>> On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell
>>>>> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20180731:
>>>>>>
>>>>>> The pci tree gained a conflict against the pci-current tree.
>>>>>>
>>>>>> The net-next tree gained a conflict against the bpf tree.
>>>>>>
>>>>>> The block tree lost its build failure.
>>>>>>
>>>>>> The staging tree still had its build failure due to an
>>>>>> interaction
>>>>>> with
>>>>>> the vfs tree for which I disabled CONFIG_EROFS_FS.
>>>>>>
>>>>>> The kspp tree lost its build failure.
>>>>>>
>>>>>> Non-merge commits (relative to Linus' tree): 10070
>>>>>>   9137 files changed, 417605 insertions(+), 179996 deletions(-
>>>>>> )
>>>>>>
>>>>>> -----------------------------------------------------------
>>>>>> ------
>>>>>> -----------
>>>>>>
>>>>>
>>>>> The widespread kernel hang issues are still seen. I managed
>>>>> to bisect it after working around the transient build failures.
>>>>> Bisect log is attached below. Unfortunately, it doesn't help
>>>>> much.
>>>>> The culprit is reported as:
>>>>>
>>>>> 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
>>>>>
>>>>> The preceding merge,
>>>>>
>>>>> 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
>>>>>
>>>>> checks out fine, as does the tip of scsi-next (commit
>>>>> 103c7b7e0184,
>>>>> "Merge branch 'misc' into for-next"). No idea how to proceed.
>>>>
>>>> This sounds like you may have a problem with this patch:
>>>>
>>>>      commit d5038a13eca72fb216c07eb717169092e92284f1
>>>>       Author: Johannes Thumshirn <jthumshirn@suse.de>
>>>>       Date:   Wed Jul 4 10:53:56 2018 +0200
>>>>
>>>>           scsi: core: switch to scsi-mq by default
>>>>
>>>> To verify, boot with the additional kernel parameter
>>>>
>>>> scsi_mod.use_blk_mq=0
>>>>
>>>> Which will reverse the effect of the above patch.
>>>>
>>>
>>> Yes, that fixes the problem.
>>
>> That may not the root cause, given this issue is only started to
>> see from next-20180731, but d5038a13eca7 (scsi: core: switch to
>> scsi-mq by default)
>> has been in -next for quite a while.
>>
>> Seems something new causes this issue.
> 
> Read my other email about how to find this.
> 
> https://marc.info/?l=linux-scsi&m=153316446223676
> 
> Now that we've confirmed the issue, Gunter, could you attempt to bisect
> it as that email describes?
> 

So, I am more and more baffled.

I ran another round of bisect, this time each test executing twice,
once with "scsi_mod.use_blk_mq=1" and once with "scsi_mod.use_blk_mq=0",
requiring both to pass. Bisect still points to the merge as culprit.

Ok, one step further: Actually _revert_ commit d5038a13eca72 before running
each test, meaning the default is use_blk_mq=0. Still run both tests.
Bisect _still_ points to the merge of scsi-next as culprit.

So, to me it looks like the problem is triggered by _something_ in
scsi-next, combined with _something_ in -next prior to the merge,
not specifically associated with use_blk_mq=[0|1] or d5038a13eca72,
but to a combination of some patch in scsi-next and some other patch.

I am running out of ideas. Any thoughts on how to track this down further ?

Guenter
