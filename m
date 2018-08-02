Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB4AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1997C20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tT0NIMfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1997C20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHBCIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:08:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40327 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHBCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:08:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so233918pff.7;
        Wed, 01 Aug 2018 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWxJ9J/kaBTEDjOI+Mik5ZXgmE9tvuYyIfBHE3AemwM=;
        b=tT0NIMfip3XpUkdJoP9oklRh0uWzFh5mB8H2XiQlZ9l4OAj8zWYkRcIUHhseD2EgL9
         EuGT1dASktaTWFP+A8cq4YUwoLeLMwiHtbndpCiSmp07aL3T2jZ2f8WNY3jidUanQhnm
         qLxikwptEcO8D03MHQZAJOx5KALrMU0Y3fTA98Uem3Q1SRWw8sebm3uiyoAHyDHWg34m
         rF7x27/oMyKi5Ymj9KixfzMy6WWj7o+01+BWzegCxE7gL3VzpLeByAcquZrYBImnWjyp
         39RYwgs5NW8YvXTyxQuV5DE7jFPVT+G+ffRf7vyEUfKd88dJ01DHz8bGNhXpmQP+tHvP
         No3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWxJ9J/kaBTEDjOI+Mik5ZXgmE9tvuYyIfBHE3AemwM=;
        b=jwxt2hUx+8gMADPBbqfU/dYkMG1fsh4a8ySm6uZXeKpYu2PNK1DfBLaaemw+Z4OGPo
         eOphMIIz7CplXvUzTp+94oAEAt9QHX3pVTsReD0iT0CScamuXj55kpT2HALNQS056366
         7cYoy2UFKKwgiPUrdtHNgrAoY+uFOd/nmmqC3+/a2qeRjbYUsrqo6i8dIB1PWJzTHXMz
         Bcz0nOaaxA88QWJPau6r1SahHxC6qOyitg5tSkpwIBytid0W1xcA80/wOTzK2sfq0T5V
         8OuSgQDI+zE9cOqZf2D1NDnp6MngGldU51uppNziv1s5s3vhKhzybt4zowlSjgbj6f1y
         v/rQ==
X-Gm-Message-State: AOUpUlHFu6c8SOW0fRDCYZJtpKD1rElBGiNCWk2QIZCTYAkfLAevusR6
        9DXRjLj0fCjsJf2QoTQAZl0CsJAq
X-Google-Smtp-Source: AAOMgpc1U9Ou+/Sbw6LmdAaIY8Mk6nevFxwXzbnoYeKO/wHbJh/Z809BW7+52sVQHJwhrWk6uL/XOg==
X-Received: by 2002:a63:ee56:: with SMTP id n22-v6mr462204pgk.402.1533169220127;
        Wed, 01 Aug 2018 17:20:20 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c12-v6sm357227pfl.20.2018.08.01.17.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 17:20:19 -0700 (PDT)
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
Message-ID: <c2f47956-c93d-d699-6046-c88990b6961f@roeck-us.net>
Date:   Wed, 1 Aug 2018 17:20:18 -0700
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

Already working on it.

Guenter
