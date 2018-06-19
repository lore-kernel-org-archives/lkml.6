Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E912DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981E62083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fGXgU4xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981E62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeFSXin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:38:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38118 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeFSXii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:38:38 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so1828184ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXaJm/qH4MGeqtcrNkVImrPXBiNffZIImWL6MRL018k=;
        b=fGXgU4xAlWAWq5O2sx/h3OoF6C06QDbfFGUREy8nS2I+Wk5tyGLPkS8dkopF64gEyx
         Zjo+aOWcRhvcPPXY1pdaezWbb/t2R9Hj/X8BxzdYUalGtoiCJsH+HmZkA7e/iD7l06K2
         xaxru65t+r626aFVzif5m4HCak9MB7OULrbRtOEaju9CD4sSikn9o3nHPixv+ZxCNudP
         KYdNQdwZT/E2VrcIM7KJEXZqWu8HM55yk9gDXTLyCkYfSeE81p5vHAGgXt72NigBwqEZ
         6WrKz3LjG6KnJN/XGdRoLm6ZOhXWt3gSoSsR4FaRLE+SiqKFVMhaOM64NtXAgzzUhsCP
         NWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXaJm/qH4MGeqtcrNkVImrPXBiNffZIImWL6MRL018k=;
        b=oGsKZE4jpiEulc0TDcYSM2zC+QMH830TasVEJSOrXQDv0JPfWiHpHCBPjbdjvRGOSG
         Tplp0UuCJ2zz4MHg1yqcorKRin7XvNp4MMSz+tOllitmbXPc/uQ+QlUZC8dq5uY2m0+2
         j2UXMMpjZCOVy0Sqd6mtBd6d0sXVAJsigRZ53cDciDcmpl49gOB6C1cuObBYMsXBi8GS
         Bv/094N+dWQEVie25A/jaZaLEokLIoZ4FHKjT753ojpQbBQXIuAFt/uVoOQ3SGECmhhN
         aX+nQv1xymTFNABzIXDvnLJaTDKzCMlHruprDLJSoLzUe5u8Dj6wV9yipfTZNw2UEXsH
         LrJA==
X-Gm-Message-State: APt69E3W9Isxt7I3k/LH6g/heeTYx6RfNXujgJqhCvcdLyu5mpXAdO5B
        bTQ+gxYsorweiVvcdkwatcUmug==
X-Google-Smtp-Source: ADUXVKKymM3mT9pTYGRj2Fm4dMrLK9CMfZAZvlLba2pW+oIcpVy7jRqh4sU/Rt7IHpESEFkVmNESHQ==
X-Received: by 2002:a6b:9006:: with SMTP id s6-v6mr4989985iod.31.1529451517820;
        Tue, 19 Jun 2018 16:38:37 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id z85-v6sm6936834ita.1.2018.06.19.16.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 16:38:36 -0700 (PDT)
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
To:     Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
 <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
 <87sh5jxmif.fsf@concordia.ellerman.id.au>
 <f82edaa2-4b1a-c747-3d58-ec86ceb4ee7e@kernel.dk>
 <87r2l2wdrc.fsf@concordia.ellerman.id.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06bd4bf6-92a0-5fce-01b6-9adbc7786513@kernel.dk>
Date:   Tue, 19 Jun 2018 17:38:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87r2l2wdrc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 5:35 PM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> On 6/19/18 1:29 AM, Michael Ellerman wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>> On 6/18/18 1:33 AM, Michael Ellerman wrote:
>>>>> Tejun Heo <tj@kernel.org> writes:
>>>>> ...
>>>>>> Jens Axboe (10):
>>>>>>       libata: introduce notion of separate hardware tags
>>>>>>       libata: convert core and drivers to ->hw_tag usage
>>>>>>       libata: bump ->qc_active to a 64-bit type
>>>>>>       libata: use ata_tag_internal() consistently
>>>>>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>>>>>       sata_nv: set host can_queue count appropriately
>>>>>>       libata: add extra internal command
>>>>>
>>>>> Replying here because I can't find the original mail.
>>>>>
>>>>> The above commit is causing one of my machines to constantly spew ata
>>>>> messages on the console, according to bisect:
>>>>>
>>>>> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
>>>>>
>>>>> To get it to boot I have to also apply:
>>>>>
>>>>>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
>>>>>
>>>>>
>>>>> The system boots OK and seems fine, except that it's just printing
>>>>> multiple of these per second:
>>>>>
>>>>>   ata2: Signature Update detected @ 0 msecs
>>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>>   ata2.00: configured for UDMA/100
>>>>>   ata2: Signature Update detected @ 0 msecs
>>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>>   ata2.00: configured for UDMA/100
>>>>>   ata2: Signature Update detected @ 0 msecs
>>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>>   ata2.00: configured for UDMA/100
>>>>>   ata2: Signature Update detected @ 0 msecs
>>>>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>>   ata2.00: configured for UDMA/100
>>>>>   ata2: Signature Update detected @ 0 msecs
> ...
>>
>> Actually, just try this one on top of current -git.
> 
> Yep that fixes it.
> 
> No more message spam, and when I try to mount sr0 it says "no medium".
> 
> I'll have to go into the office to actually put a disc in the drive
> to check it's really working, but it seems likely.
> 
> Thanks for debugging it, here's a tested-by if you like:
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, but I packaged it a little differently, see the other
series I CC'ed you on. It'll work the same, though. It's in Tejun's
tree now, so should end up with Linus some time this week I think.

Thanks for reporting and testing the fix!

-- 
Jens Axboe

