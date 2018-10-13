Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52244C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 22:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA42077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VUJazSP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeJNGad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 02:30:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42812 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeJNGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 02:30:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so7515168plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dy8OGn++qkXUtglqZnMoFTudmTKlaXI3pKPshiuA8dE=;
        b=VUJazSP1gObbC6j1Dw4h3nQQdGHkuOJrEaFUg1vfzzOFNi1a1BxHaou4zTVxrf7BWT
         X8FyKZkfx8k419lftE0+pi1/Iio+Dlv0BtEjrWAHfa6IOMKyLEKhEg++4wF5M25/1XJN
         sELA2NLCTE7lu2NYgFf9zcDMyrSVjqLhMiR68TTd4L4CEEl49rjSZD1WLEUpOFMLWcMo
         9KzdNlR5a/TM/c+lKlrRyrTgwjjG34XNGPez95M1mF+IRYMyo7UcDgNqblnSZwn6rKFR
         TJMpbRFOR7OLijvCLoK/vUt9gNr7b3HyQMwqe1VJvsa4mqfJv6dEiws/906S+MGHgr8z
         GfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dy8OGn++qkXUtglqZnMoFTudmTKlaXI3pKPshiuA8dE=;
        b=bspJKtpsaFETZOKc9lGpsWI1FNjOM0Wf9tJwnHvPTBpqJcxW1qZViwbbQdFNTV+uTZ
         JhG+tgalQQljDFmCMren4PZa95v/mJFVL4HGhFMoeO2xe7zkCEc4KyjcKjHohWNpBVAD
         jc8weKle9p/RhuB+u8lkxZdtxGN0Id6LP027EtF6xsfj1dCBD4PpPSL/r9OqY5StHtQo
         OADkn/hi7iPKl32bdQJDFNRSFsPflkh0rs91DaaoTYx6zU/V9buhWEmrDsr7hvfVZj1l
         /c80BaCKr0vVnilZ1qRz/T/sqISxFzS0wqS9ZTLWMf336MDqPj7cqipDm7C1uuACPxCr
         kQMA==
X-Gm-Message-State: ABuFfogm8wlkqTvY5hTkg/HDl3dGy2045sdpHlgQOvOr8UtO5u+moeEY
        01bO4yfoNl5pLCZu8qMyddMpVwXwbew=
X-Google-Smtp-Source: ACcGV63/iDeegH5zvS8paTl7Ur87qwod+xk6vuJqUaDVStVwDo9pr9ULmwnfUPjYQEcdUNGsO5I4tQ==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr10810377pla.73.1539471107250;
        Sat, 13 Oct 2018 15:51:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d2-v6sm6854068pfn.118.2018.10.13.15.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 15:51:45 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] blk-mq: some fixes about updating hw queues
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d50f599-4243-6a11-b7d0-9eee9d71ec63@kernel.dk>
Date:   Sat, 13 Oct 2018 16:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 4:07 AM, Jianchao Wang wrote:
> Hi Jens
> 
> This patch set fixes some defects during update hw queues.
> 
> 1st patch refactor the blk-mq debugfs and sysfs register during
> blk_mq_update_nr_hw_queues.
> 
> 2nd patch change the GFP_KERNEL to GFP_NOIO during blk_mq_realloc_hw_ctxs,
> 
> 3rd patch try to realloc hctx when this hctx is mapped to a different node.
> 
> 4th patch should be able to fix the panic reported in follwing link
> https://marc.info/?l=linux-block&m=153799465603723&w=2
> 
> V2:
>  - Newly add 2nd and 3rd patch.
>  - Use blk_mq_map_queues when __blk_mq_update_nr_hw_queues fallbacks to
>    previous nr_hw_queues to avoid driver's .map_queues leak mapping of
>    some cpus due the fallback nr_hw_queues.
>  - Add Ming's Reviewed-by in 1st patch.
> 
> 
> Jianchao Wang[4]
> blk-mq: adjust debugfs and sysfs register when
> blk-mq: change gfp flags to GFP_NOIO in
> blk-mq: realloc hctx when hw queue is mapped to
> blk-mq: fallback to previous nr_hw_queues when
> 
>  block/blk-core.c  |   2 +-
>  block/blk-flush.c |   6 +--
>  block/blk-mq.c    | 155 ++++++++++++++++++++++++++++++++++--------------------
>  block/blk.h       |   2 +-
>  4 files changed, 102 insertions(+), 63 deletions(-)
> 

Applied, thanks.

-- 
Jens Axboe

