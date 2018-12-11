Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48690C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VRRt9Q1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F2F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLKSy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:54:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36060 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:54:56 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so5636950itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mp1SRtZzEwAGpb2qE9L2l96y//ET6XC5DhUuLKSBeIo=;
        b=VRRt9Q1hozbqu1fR0e8aIk3HznGRKB+flAYmwSlaWkGA51+nhw9NK/jDz4/DqE10It
         ZK2OY5OGNJFYG0RF1LnKcLWvTLryo23FgRWUB69VFepR0KeQXGIYsRmNN9bnqP4Sk69m
         Bh0UkJGnXbC/UAyD7L8QKo8I74d5xBmBFOV4RuCqRM1GF6AY8Qe7xwSCb57ISPgW5z83
         P36k/pM3UnciF9Pzfmsx7aBxcppu/qsF0G4Wsqv4aD6r2BCr6y9mMbXsL1qWssEpErGR
         gAVVcGuPhDo8O7XdprV5WRVUCqj38F0Ge0u7cQiiA3W2lVKxP+i94YAD+74BHTXEEPfk
         /UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp1SRtZzEwAGpb2qE9L2l96y//ET6XC5DhUuLKSBeIo=;
        b=j4HH31nkq36BbbGn11gdUa1h9yfQxGSilVJw8TeKHTcFwLUUovZrC6Nqf3WPxcT0yW
         sfGZxszmEKAL1rDwrEanQWTZPhl4P/ESOch5a5iAfwCADG7C+cLiNc3KDMQD06S2NWGh
         NW0u/DjQn0r2KZQjjGyLcnMJgIquQalQLcbl02D174DY6FZNf7uFhLVMXHI9CwQSJSWO
         Sj7LrcNBS0qmLiST4pu8PxZBHQjA1GbVpcp34j7m7lLmjmJ1MEMaCix6jT7IrgSwevvZ
         yVbIqQa2N8DyGoxgL6OdMH3yO34/XcUAAzWlVOUVmkqv0eWphyQwjYSIVC8o/+jPrVov
         MtZA==
X-Gm-Message-State: AA+aEWYmE9GtmbuRKnZkxlxeP+DLf+gmQp5SJNts+PyfTN8irzksDTWN
        Imj63ClLj9amKXrWg8CKDODTUw==
X-Google-Smtp-Source: AFSGD/Xmm3wFTIYnZEEHWsuUjv/ESEvHYFHBahzuHDVz7OtW4IvKHXeWZekz2J4esyGf7d5GO2CZeA==
X-Received: by 2002:a24:7fc3:: with SMTP id r186mr2819026itc.178.1544554495528;
        Tue, 11 Dec 2018 10:54:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v4sm2592600itv.20.2018.12.11.10.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:54:54 -0800 (PST)
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181128183531.5139-1-willy@infradead.org>
 <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
 <20181211184553.GH6830@bombadil.infradead.org>
 <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
 <20181211185311.GJ6830@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1629a25c-a9e7-e731-230d-e179e9f7a9a7@kernel.dk>
Date:   Tue, 11 Dec 2018 11:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211185311.GJ6830@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 11:53 AM, Matthew Wilcox wrote:
> On Tue, Dec 11, 2018 at 11:46:53AM -0700, Jens Axboe wrote:
>> On 12/11/18 11:45 AM, Matthew Wilcox wrote:
>>> I think we need the rcu read lock here to prevent ctx from being freed
>>> under us by free_ioctx().
>>
>> Then that begs the question, how about __xa_load() that is already called
>> under RCU read lock?
> 
> I've been considering adding it to the API, yes.  I was under the
> impression that nested rcu_read_lock() calls were not expensive, even
> with CONFIG_PREEMPT.

They are not expensive, but they are not free either. And if we know we
are already under a rcu read lock, it seems pretty pointless. For the
two cases (memremap and aio), the rcu read lock is right there, before
the call. Easy to verify that it's safe.

-- 
Jens Axboe

