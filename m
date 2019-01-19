Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D0EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9888620823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfASQup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:50:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36859 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfASQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:50:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so18697854qtn.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJnWQwUwnX0sbOUmpB4Cr+Rh7vD7qTFlUyS9FK9e7vM=;
        b=C92NXrcn6GsFJEBc8DHIDpp58wV9XDPKB+HlHk+jnjwf7gARZuD3zT3f7Kdm8jGq0c
         F7xFZGSZLkLNkhh4k1wQClolXop1DhskW9Bm4vErkm1IUKXevEfnrLMdtLS7gmdc2r3q
         r/DNi/LfMdWTQztEGsMVae7qHReKLZclYifJebExZGb0ORlHJtq7j3czH+HQj/o4dJfR
         e3x4oQG3p9NYuEJbQ46kGdi5NcPrS1JOxHLdt29j9hUgTTjUkTssHMVuQXFOoFQvusK4
         afmBhI5AK3Kkj2YjuVuzGJc+s9V5SpobZ1HMQromqXtj+QEI+NxAdAdAezvmhhupJyJb
         NsLg==
X-Gm-Message-State: AJcUukc7ekmVo0WwHb7vrA25vixS+nLIST5Aqaky970v2ujP+YY0K50z
        xWZW/5OhjA9tBj488kKi3vJnbw==
X-Google-Smtp-Source: ALg8bN6fUxHnnUr9XOVXiV9gmcpbkj404QuQXijiMPHWSsc/OuQVDYkP782gmGoyXUjs64T8g7xuFA==
X-Received: by 2002:a0c:9d81:: with SMTP id s1mr19916830qvd.82.1547916644301;
        Sat, 19 Jan 2019 08:50:44 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id c48sm62635843qtd.9.2019.01.19.08.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:50:43 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>
Cc:     sumit.semwal@linaro.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
Date:   Sat, 19 Jan 2019 08:50:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119102527.GA17723@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 2:25 AM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 10:37:46AM -0800, Liam Mark wrote:
>> Add support for configuring dma mapping attributes when mapping
>> and unmapping memory through dma_buf_map_attachment and
>> dma_buf_unmap_attachment.
>>
>> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> 
> And who is going to decide which ones to pass?  And who documents
> which ones are safe?
> 
> I'd much rather have explicit, well documented dma-buf flags that
> might get translated to the DMA API flags, which are not error checked,
> not very well documented and way to easy to get wrong.
> 

I'm not sure having flags in dma-buf really solves anything
given drivers can use the attributes directly with dma_map
anyway, which is what we're looking to do. The intention
is for the driver creating the dma_buf attachment to have
the knowledge of which flags to use.

Thanks,
Laura
