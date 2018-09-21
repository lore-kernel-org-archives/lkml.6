Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3A2206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZfJTFzoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3A2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbeIUUtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:49:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37348 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390164AbeIUUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:49:49 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so12543184iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xe7Q8DIiNcGuVcVOhi5q07ExrmVZrXiLuYUV2fXfkrI=;
        b=ZfJTFzoLni/h+Q8mgzFuqksFDlyl7LarsJIw97uKZ7emYfCXzhJpMN0hIm55kVl5o3
         Z81jJCca1JFJJnwfEviYMYkqrzFC7TVCO4CIozMAPW7FWeEOMgBFvxvZbKkD/cxEZv9w
         9aPJMhH0k+qLh6ScKlozBlNUHDj1n5y+31gix33KOg9/ikruNdiUhCJhz9kbcpC5Pzbk
         CYBsoFvWTdS9i7yC6Jy4dLvRkb9nbc9yBwYssTtIqSf//VM4LbyGly9rCMieEUcl8Nhv
         pz0xjDvWGAA4sZTta4USSxD4mR43ksoENgQaRXRNCAdc6oCI5P6eBjAcU1vpGXeY/TF2
         D+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xe7Q8DIiNcGuVcVOhi5q07ExrmVZrXiLuYUV2fXfkrI=;
        b=f1blF7LFz1poF9qwFHH2J+To1Pb9wKd4n54NdK+vlDlyLtdzWHMLUD0spAbbF3yJA6
         rv4DsWlcufHxToWJNGD0/1eMTVK72eGL9TV6dj1scF7e0UYs+s5AsPsReEFKwRidmura
         H6UJpiNY89O35QkDZ6uorI5jVJjm+l6vZ6+/Hz97hkq4zTki7XfP9rCNj5XPU6DvRYJm
         i2CGPMbLGL9NY2jU0PTh2WFfXAkZaMKlmL6o5VXWx0A+hIxjA4APWdROevziyE8I5QLT
         3CC/Oki1TwFPNk4Ieeksfw8ZsFBOmMFYPLRAQpGYTjQ9M+F9993vMpqTkwrXvCOIr5c9
         ou1A==
X-Gm-Message-State: APzg51BIM9/KQV6CEfVpxV1mf50el6QseUgFrWTizaMkzvQ2s3RQAkg1
        TyGJmgmMd1OArm88ZDHLI2ShQA==
X-Google-Smtp-Source: ACcGV62stjqul3nA9NSHW7Sy5UFUjlDw6rpgRTU7MbRTxk1GHmetjh9GpjB+iaXu1xOVE/CwxlchbQ==
X-Received: by 2002:a6b:9142:: with SMTP id t63-v6mr13369415iod.123.1537542033550;
        Fri, 21 Sep 2018 08:00:33 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m123-v6sm2385210itg.29.2018.09.21.08.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:00:32 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Christoph Hellwig <hch@lst.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Lameter <cl@linux.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180921130504.GA22551@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <98996e39-7d29-354c-9009-d4b1a1bbdeb0@kernel.dk>
Date:   Fri, 21 Sep 2018 09:00:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921130504.GA22551@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/18 7:05 AM, Christoph Hellwig wrote:
> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>> yes, is it a stable rule?
>>>
>>> This is the assumption in a lot of the kernel, so I think if somethings
>>> breaks this we are in a lot of pain.
>>
>> It seems that SLUB debug breaks this assumption. Kernel built with
>>
>> CONFIG_SLUB_DEBUG=y
>> CONFIG_SLUB=y
>> CONFIG_SLUB_DEBUG_ON=y
> 
> Looks like we should fix SLUB debug then..

Fully agree, it's such a fundamental property.

-- 
Jens Axboe

