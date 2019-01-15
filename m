Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E092C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAB20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfAOS6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:58:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33331 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbfAOS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:58:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id d15so2239459qkj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuj7cOvNxGF5+nRBxRgPL1Y52pM//CMJ5wzdRBqrBVI=;
        b=DLD0WsshlAcA+66ScpxxEwMvsG46WeBidSU2rfNfjP7Nq8w+uD7PPvJvsFbvEyELUt
         rz+0+p6SH+JFBItTpgzAnQyw9Kg0nBvZaYRMyId+LVQM8398zbqNIO5TZ4H2ghqv7VQ6
         9ASnWVXvRjtah+4ZC9ppfmUZ7y/mWH/6KcywIlrEP1RkLF13HlvX/rq6vT1PLbZI1Ytx
         MN5txg2FKsseLABuZ4cOoGpTW9nmtbOgejqMrUesUn3RQW4x2GpSl0qzp1g3P/0yNfIf
         ovXprqClWsLkLw+6JKO4EaKUPpYFisdVsv0qLHjLOA2LcJxk+Mq1vkpJSLN8H9hoFzwH
         5HMw==
X-Gm-Message-State: AJcUukeBfpkRgdT6F1LM0pH4r1WNtCpua1JsxKZgOvQbfCJHpESXoGTy
        VBegnKBGbBqduuo+g5eA4MeZYccHb0w=
X-Google-Smtp-Source: ALg8bN5PwFRvt8tMBoei7HhsheKQXayEgaUeO5aqqUfxQow/atQ7kupZ7LZ98Ip/AxNws1/Diapk/Q==
X-Received: by 2002:a37:a211:: with SMTP id l17mr3851252qke.30.1547578709572;
        Tue, 15 Jan 2019 10:58:29 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id y32sm56175626qth.3.2019.01.15.10.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:58:28 -0800 (PST)
Subject: Re: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
To:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190111180523.27862-1-afd@ti.com>
 <3b0d05e1-d437-801b-1c41-97d55f9ac10f@redhat.com>
 <80a0888f-6780-884c-6571-86a1ba5d55cc@ti.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <54438c88-cad6-534d-64a5-f43e7b74f3bb@redhat.com>
Date:   Tue, 15 Jan 2019 10:58:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <80a0888f-6780-884c-6571-86a1ba5d55cc@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 9:47 AM, Andrew F. Davis wrote:
> On 1/14/19 8:39 PM, Laura Abbott wrote:
>> On 1/11/19 10:05 AM, Andrew F. Davis wrote:
>>> Hello all,
>>>
>>> This is a set of (hopefully) non-controversial cleanups for the ION
>>> framework and current set of heaps. These were found as I start to
>>> familiarize myself with the framework to help in whatever way I
>>> can in getting all this up to the standards needed for de-staging.
>>>
>>> I would like to get some ideas of what is left to work on to get ION
>>> out of staging. Has there been some kind of agreement on what ION should
>>> eventually end up being? To me it looks like it is being whittled away at
>>> to it's most core functions. To me that is looking like being a DMA-BUF
>>> user-space front end, simply advertising available memory backings in a
>>> system and providing allocations as DMA-BUF handles. If this is the case
>>> then it looks close to being ready to me at least, but I would love to
>>> hear any other opinions and concerns.
>>>
>>
>> Yes, at this point the only functionality that people are really
>> depending on is the ability to allocate a dma_buf easily from userspace.
>>
>>> Back to this patchset, the last patch may be a bit different than the
>>> others, it adds an unmapped heaps type and creation helper. I wanted to
>>> get this in to show off another heap type and maybe some issues we may
>>> have with the current ION framework. The unmapped heap is used when the
>>> backing memory should not (or cannot) be touched. Currently this kind
>>> of heap is used for firewalled secure memory that can be allocated like
>>> normal heap memory but only used by secure devices (OP-TEE, crypto HW,
>>> etc). It is basically just copied from the "carveout" heap type with the
>>> only difference being it is not mappable to userspace and we do not clear
>>> the memory (as we should not map it either). So should this really be a
>>> new heap type? Or maybe advertised as a carveout heap but with an
>>> additional allocation flag? Perhaps we do away with "types" altogether
>>> and just have flags, coherent/non-coherent, mapped/unmapped, etc.
>>>
>>> Maybe more thinking will be needed afterall..
>>>
>>
>> So the cleanup looks okay (I need to finish reviewing) but I'm not a
>> fan of adding another heaptype without solving the problem of adding
>> some sort of devicetree binding or other method of allocating and
>> placing Ion heaps. That plus uncached buffers are one of the big
>> open problems that need to be solved for destaging Ion. See
>> https://lore.kernel.org/lkml/20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain/
>>
>> for some background on that problem.
>>
> 
> I'm under the impression that adding heaps like carveouts/chunk will be
> rather system specific and so do not lend themselves well to a universal
> DT style exporter. For instance a carveout memory space can be reported
> by a device at runtime, then the driver managing that device should go
> and use the carveout heap helpers to export that heap. If this is the
> case then I'm not sure it is a problem for the ION core framework to
> solve, but rather the users of it to figure out how best to create the
> various heaps. All Ion needs to do is allow exporting and advertising
> them IMHO.
> 

I think it is a problem for the Ion core framework to take care of.
Ion is useless if you don't actually have the heaps. Nobody has
actually gotten a full Ion solution end-to-end with a carveout heap
working in mainline because any proposals have been rejected. I think
we need at least one example in mainline of how creating a carveout
heap would work.

> Thanks for the background thread link, I've been looking for some info
> on current status of all this and "ion" is a bit hard to search the
> lists for. The core reason for posting this cleanup series is to throw
> my hat into the ring of all this Ion work and start getting familiar
> with the pending issues. The last two patches are not all that important
> to get in right now.
> 
> In that thread you linked above, it seems we may have arrived at a
> similar problem for different reasons. I think the root issue is the Ion
> core makes too many assumptions about the heap memory. My proposal would
> be to allow the heap exporters more control over the DMA-BUF ops, maybe
> even going as far as letting them provide their own complete struct
> dma_buf_ops.
> 
> Let me give an example where I think this is going to be useful. We have
> the classic constraint solving problem on our SoCs. Our SoCs are full of
> various coherent and non-coherent devices, some require contiguous
> memory allocations, others have in-line IOMMUs so can operate on
> non-contiguous, etc..
> 
> DMA-BUF has a solution designed in for this we can use, namely
> allocation at map time after all the attachments have come in. The
> checking of each attached device to find the right backing memory is
> something the DMA-BUF exporter has to do, and so this SoC specific logic
> would have to be added to each exporting framework (DRM, V4L2, etc),
> unless we have one unified system exporter everyone uses, Ion.
> 

That's how dmabuf is supposed to work in theory but in practice we
also have the case of userspace allocates memory, mmaps, and then
a device attaches to it. The issue is we end up having to do work
and make decisions before all devices are actually attached.

> Then each system can define one (maybe typeless) heap, the correct
> backing type is system specific anyway, so let the system specific
> backing logic in the unified system exporter heap handle picking that.
> To allow that heaps need direct control of dma_buf_ops.
> 
> Direct heap control of dma_buf_ops also fixes the cache/non-cache issue,
> and my unmapped memory issue, each heap type handles the quirks of its
> backing storage in its own way, instead of trying to find some one size
> fits all memory operations like we are doing now.
> 

I don't think this is an issue of one-size fits all. We have flags
to differentiate between cached and uncached paths, the issue is
that doing the synchronization for uncached buffers is difficult.

I'm just not sure how an extra set of dma_buf ops actually solves
the problem of needing to synchronize alias mappings.

Thanks,
Laura

> We can provide helpers for the simple heap types still, but with this
> much of the heavy lifting moves out of the Ion core framework making it
> much more simple, something I think it will need for de-staging.
> 
> Anyway, I might be completely off base in my direction here, just let me
> know :)
> 

