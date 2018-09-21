Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB2ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B5221532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0uIrF0+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B5221532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbeIUUtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:49:16 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:51355 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbeIUUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:49:16 -0400
Received: by mail-it1-f178.google.com with SMTP id e14-v6so2278490itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jamrnX0sFRvEHJX20QnT1GhwLyV16WnRhGsixsSTKqY=;
        b=0uIrF0+KvQ8ImRKGV0by01j6c/FUCS2hKuX+/eVRSRq1SRsR/NC7O5mHOcBLIbBe+E
         zNZJbtC4INjqgPBd2uXkviIi8Wazo7f49zsgpg+y0ex+nstTe0UJOv8r86w4pmMRq1pk
         AbgBSeFZYm1VZLjN/Q82Flw2RnfIGxTpRyODmmxROgP6LE+N+SbQO2CJn4mqVVU8iGTs
         D6/P4zZUfeUartmQCMAoaxOO1B6Q0HUwS70t/n4eBYTTPLdMmZNMTQnexVAJDtwwafR2
         gfsSkH8prUWyng6hUsuuK0JnbnbjuBjOZSU/qzh9O2/u/Qc3rNMcaBJuexe/qJyE9hVu
         k3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jamrnX0sFRvEHJX20QnT1GhwLyV16WnRhGsixsSTKqY=;
        b=LcigR4s4VkIrT6CddTJdk2aeLG6Z7E4Scv/OqSAVJo6PF0ImYxMzaHp5ry8ioyMEGX
         0WUFW+C4iuq0dXJdPwcqdDLRUghGR8WK9F/t3NGwgbMpkko1MerjkuBIrmnJ1Hwf1Uuz
         /I4ZiXZSOgdrmUPza5X4LZEHplbU4lANWDqsXb3hxib5h5GfoDWYWasZZVT49miUSrda
         nFzQNHdMWebh6+GJVWWSLJRYcjnWdiRzb7ryH30y0Ywo79jhgVDNffr+HJQWJtizszvC
         2djuXBkZL4A5gDIXwyn86X6SQas5fuQJldolzRLNI7pGqVIm2NpGwD+52BWxaLzbg7hb
         y9Xg==
X-Gm-Message-State: ABuFfojmVBaP8uj4agPQDjAZUhKgfSmcJG6tJqZ33qjeWECQRuKNqb5d
        ncSZjRqpcV0zZ7f7eI7s9gCV3AjBmOY=
X-Google-Smtp-Source: ACcGV63YeXOSFq4C2nCexB9DGm5A/BZbAFPIOrl+1auWP2BTzKTicEMHaFVn+kxnZIgoXRpyuSKVEA==
X-Received: by 2002:a24:ecc4:: with SMTP id g187-v6mr1827473ith.145.1537541999939;
        Fri, 21 Sep 2018 07:59:59 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t134-v6sm2420845itb.41.2018.09.21.07.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 07:59:58 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180921015608.GA31060@dastard> <20180921070805.GC14529@lst.de>
 <20180921072511.GA8188@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65999732-fc76-bb86-65ed-01aace49b9c7@kernel.dk>
Date:   Fri, 21 Sep 2018 08:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921072511.GA8188@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/18 1:25 AM, Ming Lei wrote:
> On Fri, Sep 21, 2018 at 09:08:05AM +0200, Christoph Hellwig wrote:
>> On Fri, Sep 21, 2018 at 11:56:08AM +1000, Dave Chinner wrote:
>>>> 3) If slab can't guarantee to return 512-aligned buffer, how to fix
>>>> this data corruption issue?
>>>
>>> I think that the block layer needs to check the alignment of memory
>>> buffers passed to it and take appropriate action rather than
>>> corrupting random memory and returning a sucess status to the bad
>>> bio.
>>
>> Or just reject the I/O.  But yes, we already have the
>> queue_dma_alignment helper in the block layer, we just don't do it
>> in the fast path.  I think generic_make_request_checks needs to
>> check it, and print an error and return a warning if the alignment
>> requirement isn't met.
> 
> That can be done in generic_make_request_checks(), but some cost may be
> introduced, because each bvec needs to be checked in the fast path.

I think this is all crazy talk. We've never done this, we've always
assumed that an address of length N, will be N aligned as well. If
a driver sets queue dma alignment > than its sector size, then we're
in real trouble and would need to bounce IOs. That's silly enough
that it doesn't warrant being done in the core code imho, if you're
hw is that crappy, then do it in your queue_rq(). Could be done with
a core helper for sure, but I'm really not that interested in
having a full bvec loop for each bio just to check something that
(to my knowledge) hasn't been an issue in decades.

-- 
Jens Axboe

