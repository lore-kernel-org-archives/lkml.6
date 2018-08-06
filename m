Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7792C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6521421A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEvm2+nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6521421A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbeHFSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:07:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHFSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:07:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so6409234pgq.12;
        Mon, 06 Aug 2018 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o9BGUIoR9dQeHFZ+jaLx88+uAAXJDKqdB19eQwcQhuM=;
        b=HEvm2+nSj4PH5LU/6gxr8UxPRWMYb3AtkYKihCqVBhS7YOU/xvrzrRu9r5ah6CM+9G
         ES87rfEJeMNQAp564UWWCjN0LVGVltkh/v3OEder/IW+JubLDdt0/rvwGH9+F7DY6KX3
         /4nGX+MugSd8TxTDDDFx8wslUTNl0VeVry9YLDRwpcCKUYDh9kPkxE5k0j9mz2WpOIoU
         C0JKsEuWyYOcrvtC+5vTTlnhFLy32r9tr3u+etkth7wVH9DUhmWAcbT78Ts7p9bG36ZJ
         CdTVga3Th/jO/r0/ukHZuoyZPMrwuXEMkOXzOgoFSbPdh+s8NiR07wdBCiCsa7Q6oD5p
         cStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9BGUIoR9dQeHFZ+jaLx88+uAAXJDKqdB19eQwcQhuM=;
        b=Dx2ws7rnYqMFINPMbuZiEKZL9hGzmibQrG90G5NcopmlGIwe91H8ylvjnBVlgwA4+x
         NIN4IM2SM71UsSe9qbv7CAVcmMC+IU59fZsq7PEYSyh4V5ANI/j2QhTHhW9DchSuLEzm
         8TKTJI3debxf72x4kTiyFJbcxBIa2O/UEzdFnR1DdITK5xPv1+2SVi4PAL3lQf9x6P96
         lnRPNwEjsamX8Hbz2PknN3a+O8rOemmXmhYO4KSPWxv+3TyLyE72HitFaz7SViZeIU0c
         BZldpWIwrWqgIjB8ULre4/xB0uLfhUWO7mY4ke1KdVz4aO7iuTa7gnCzKsZTeQ9jQLUi
         eWZQ==
X-Gm-Message-State: AOUpUlE6eZXzFr6GHfDk6sPTFTYCzx5opIDL3Ywh9kToAoZH2JsW5lRn
        6DDChqOAqZWHoSPZeJIrY+iEL8Rl
X-Google-Smtp-Source: AAOMgpf4Cr/qnZUwztoWFRW6LuY3Jsgv/KHHubeRnoDZTx1g2nH/B2avCSnaJrC4Khm33YLpli+Pcw==
X-Received: by 2002:a62:51c6:: with SMTP id f189-v6mr7663108pfb.7.1533571089403;
        Mon, 06 Aug 2018 08:58:09 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p5-v6sm15943970pfn.57.2018.08.06.08.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 08:58:08 -0700 (PDT)
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1808051424440.29532-100000@netrider.rowland.org>
 <55fffb30-1388-af6a-70a6-cb738dab062f@roeck-us.net>
 <20180806083322.GA31637@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2035bda7-90ce-0ec3-757a-5c2ca8113bf4@roeck-us.net>
Date:   Mon, 6 Aug 2018 08:58:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806083322.GA31637@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 01:33 AM, Christoph Hellwig wrote:
> On Sun, Aug 05, 2018 at 02:38:22PM -0700, Guenter Roeck wrote:
>> AFAICS it used to be interrupt tolerant for all but x86 up to commit
>> 6894258eda ("dma-mapping: consolidate dma_{alloc,free}_{attrs,coherent}").
>> A quick test shows that the warning is indeed not seen if I run my test
>> on v3.18.y.
>>
>> You would have to ask Christoph why it is now interrupt-intolerant for all
>> architectures.
> 
> interrupt-tolerant actually is a very odd wording.  x86 itself (at least
> unless using an iommu) actually is fine with calling dma_free_* with
> interrupts disabled, but many other architectures are not.  For many
> architectures that are not cache coherent we'll have to manipulale
> the kernel page tables when freeing coherent memory, which we absolutely
> can't do from irq context.  And as usual in the kernel we try to enforce
> the same rules on everyone to allow for portable code.
> 
> Also except for the odd USB use cases that abuses dma_alloc_coherent
> for the bounce buffers in device local memory you are doing something
> wrong if you call dma_alloc*/dma_free* anywhere but during device
> initialization and removal.  These are slow path interfaces for
> allocating memory for things like descriptors and similar.  Your fast
> path should be using dma_map*/dma_unmap*.
> 

FWIW, that isn't "my" code. I just had the impunity to test it.

Cheers,
Guenter
