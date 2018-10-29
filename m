Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008D9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA42082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJ3Ean (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:30:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36096 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Ean (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:30:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so4407637pgv.3;
        Mon, 29 Oct 2018 12:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNMoauqpAfi823ZmmMVfokT6Se+JuzdKR0GcAy1xDyM=;
        b=Li8f3ahXnfjxRDvunzSY9HusdmSa88EVFUxlpZppDfUwg3LxtKv0FWQjETwb8jR4IO
         KdqeFRpSBrxn9kXk5/djHTZ4VC4x2T9/Eb8EHTmsLI3abgMreM9+LY+0blfbpSToEWGn
         NBeDLqZwJ1wWthBtwgeudzr+F0xnAT0+0MRXId36jra6eduTtqDk8WWjegTDUjoCbeiX
         rJ4qAzApKs9uqLDbsCu4rNz244dmtDQIvOhNMOhXlHbkFamyPu9b8VBM6k7SEK3Q9P6D
         3Fp9STUxZASIlB9rfJCJURab7v0mlmcsQ2KpShJ3k/skh82hU6DcL6QKb66ux467w4ry
         jbHQ==
X-Gm-Message-State: AGRZ1gICw0gaIu+p73LoKDvhkWjI7zGawA/O8FUcW5ZE5yvv5H7dCCFF
        YLKIlS1Xk8tzhzD/FVkmkC0=
X-Google-Smtp-Source: AJdET5cUlgfMGMrJgxrvjyod5zeWvbd53dHmTeFdn2SNu9GIYkAp9Ru8APPf1GJbKhPqzQhArzotNw==
X-Received: by 2002:a62:9c4a:: with SMTP id f71-v6mr16837884pfe.135.1540842036461;
        Mon, 29 Oct 2018 12:40:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 126-v6sm23200208pff.105.2018.10.29.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 12:40:35 -0700 (PDT)
Message-ID: <1540842034.196084.89.camel@acm.org>
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 12:40:34 -0700
In-Reply-To: <20181029163738.10172-11-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-11-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 -static int cpu+AF8-to+AF8-queue+AF8-index(unsigned int nr+AF8-queues, const int cpu)
+AD4 +-static int cpu+AF8-to+AF8-queue+AF8-index(struct blk+AF8-mq+AF8-queue+AF8-map +ACo-qmap,
+AD4 +-			      unsigned int nr+AF8-queues, const int cpu)
+AD4  +AHs
+AD4 -	return cpu +ACU nr+AF8-queues+ADs
+AD4 +-	return qmap-+AD4-queue+AF8-offset +- (cpu +ACU nr+AF8-queues)+ADs
+AD4  +AH0
+AD4 
+AD4 +AFs ... +AF0
+AD4  
+AD4 --- a/include/linux/blk-mq.h
+AD4 +-+-+- b/include/linux/blk-mq.h
+AD4 +AEAAQA -78,10 +-78,11 +AEAAQA struct blk+AF8-mq+AF8-hw+AF8-ctx +AHs
+AD4  struct blk+AF8-mq+AF8-queue+AF8-map +AHs
+AD4  	unsigned int +ACo-mq+AF8-map+ADs
+AD4  	unsigned int nr+AF8-queues+ADs
+AD4 +-	unsigned int queue+AF8-offset+ADs
+AD4  +AH0AOw

I think it's unfortunate that the blk-mq core uses the .queue+AF8-offset member but
that mapping functions in block drivers are responsible for setting that member.
Since the block driver mapping functions have to set blk+AF8-mq+AF8-queue+AF8-map.nr+AF8-queues,
how about adding a loop in blk+AF8-mq+AF8-update+AF8-queue+AF8-map() that derives .queue+AF8-offset
from .nr+AF8-queues from previous array entries?

Thanks,

Bart.

