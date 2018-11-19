Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D55C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4882F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a9QY1sdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4882F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeKSNca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:32:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeKSNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:32:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so828847pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 19:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+y+YQ/aWQh6G9Pndh0g/Jo+Can1pkVpa/QQVLOmq8Y=;
        b=a9QY1sdqDZUiuuu1rXiWsRZDbzEgW4GZXkxeui30fQvX3vg8RBbcF8qqiDxKvBr4dA
         RJTZX3QX3KXmawIC8Cq2bMJGpzMpdgaPitfUN9fZPO+kZ/NpRsePUwby8x4UnogNafbU
         tKIgdSO7k3eWdApulbJ5Cbzrdkh3nKv71ENcNtn5sAOSoXmJ3EyrskP3mQF2mU7WowLi
         aWigxxk0tRpaGRqXQmbkiAuypwtpAW4BtuIZ1pzp/kf0rJlWqlF381GPpzX304O0SyPK
         6pnI0WUaGk+0WukLv8K5/XZNJqrZY3ruYlfNkszYVOQ8G+PPonbzpTcjy2kqoKkkiliI
         ptLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+y+YQ/aWQh6G9Pndh0g/Jo+Can1pkVpa/QQVLOmq8Y=;
        b=J7HnLT5IQJlYjp7ifOhEMK9ZexNqKNxQ0VsFI5nQw5zPF0IxppV0FfNi5SQRL4ye9R
         o7L7NrWE3H7cKwoBx35G4I4b8kNavm2s3oiU/kL7fOd8gfqji4YPrt5ZsXK4HwgE0CnB
         AAL/ETFfNwTgYwP+9IkIrwnV1RVTWBdYjwg6nRSaodIQcrtQGeVf4QyxPv/IlypP73qa
         SnVZHI4mdOd3a2mF0t5twJr/5BU8e5xfVihfGX+y/GMHSrKqwggoxIhjXalXJ6hUwyTu
         ulLXYQpNvEuhmGGNngfhs/w2lPtVA39UJPy8PU82IsbUeCONNhG97hjKEB347bFuaacq
         7Ajw==
X-Gm-Message-State: AGRZ1gJkmYAkRKvOcWNKvhyEYftjAAOz43zirm3iELKRY4s3204Gn2sG
        d1lpyIXTwiIkLE7O1Ck4pvDPBg==
X-Google-Smtp-Source: AJdET5cTwQDcMN5//RJsS90xfsg40HWnovwuyPpZPwFZoVBwVqijvq9qBcNHKZj8vZSpLu4TZ2phAQ==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr17304659pgo.369.1542597018284;
        Sun, 18 Nov 2018 19:10:18 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b5sm22212402pfc.150.2018.11.18.19.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 19:10:17 -0800 (PST)
Subject: Re: [PATCH V10 01/19] block: introduce multi-page page bvec helpers
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        Boaz Harrosh <ooo@electrozaur.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
References: <20181115085306.9910-1-ming.lei@redhat.com>
 <20181115085306.9910-2-ming.lei@redhat.com> <20181116131305.GA3165@lst.de>
 <20181119022327.GC10838@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83fb4102-bffe-41f1-c8d0-3bdf61fe0ba8@kernel.dk>
Date:   Sun, 18 Nov 2018 20:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119022327.GC10838@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/18 7:23 PM, Ming Lei wrote:
> On Fri, Nov 16, 2018 at 02:13:05PM +0100, Christoph Hellwig wrote:
>>> -#define bvec_iter_page(bvec, iter)				\
>>> +#define mp_bvec_iter_page(bvec, iter)				\
>>>  	(__bvec_iter_bvec((bvec), (iter))->bv_page)
>>>  
>>> -#define bvec_iter_len(bvec, iter)				\
>>> +#define mp_bvec_iter_len(bvec, iter)				\
>>
>> I'd much prefer if we would stick to the segment naming that
>> we also use in the higher level helper.
>>
>> So segment_iter_page, segment_iter_len, etc.
> 
> We discussed the naming problem before, one big problem is that the 'segment'
> in bio_for_each_segment*() means one single page segment actually.
> 
> If we use segment_iter_page() here for multi-page segment, it may
> confuse people.
> 
> Of course, I prefer to the naming of segment/page, 
> 
> And Jens didn't agree to rename bio_for_each_segment*() before.

I didn't like frivolous renaming (and I still don't), but mp_
is horrible imho. Don't name these after the fact that they
are done in conjunction with supporting multipage bvecs. That
very fact will be irrelevant very soon

-- 
Jens Axboe

