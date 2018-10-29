Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B6920657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B6920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJ3CMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:12:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45231 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeJ3CMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:12:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so4124154pll.12;
        Mon, 29 Oct 2018 10:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cirwb2wKZq9E8gThG4+eq7czFX7wqKCxrd/m7xxhadw=;
        b=GY5L4CRuIzznwMJq7PLfuCPK6rTiLPxsID20nmOB83A4RKFXYl8qGcuMva60ZavrpJ
         e/p5MtucxPxLJfsa1zMHhXAJFiWWYFG+qtF+Keuu9187vhAdn1ulpQRIUBjtJER1wMa2
         u8MPHnGbpK7hR+nDXseyC1vm9oiORiaBDmFO3BfSS+sOOHTQNSGPzqW0cwaCLzaGKPmP
         fN4OYSWr3PcL+T60vI7ffiN0bgGwh4FqS4na9JON+y3Wz+Re8Ywchd6ATEdghMb0U3Q0
         Lwmsi4mtx69M5Ak/PoedbxUKQFmqqx1fS1PHWenOL1X7kfbqGNxPjzzGCgMKIn+m89F/
         tA9A==
X-Gm-Message-State: AGRZ1gIhV9TmP6EnDb5CcQd6G/oZB36AwgPBqIQWiY4ycCSJ1MUNxTB2
        ZQhHqBrwprMYS42r+lJ0dcvhNN6h
X-Google-Smtp-Source: AJdET5dHOZO9d32Bjmpawg+dE6FzXsfL/8tFaykvhhNNHMDvUn0WxN2L96onii28TQPdPQrVKlmhjQ==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3-v6mr15271745plq.287.1540833781975;
        Mon, 29 Oct 2018 10:23:01 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f3-v6sm22480421pgd.41.2018.10.29.10.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:23:01 -0700 (PDT)
Message-ID: <1540833779.196084.56.camel@acm.org>
Subject: Re: [PATCH 03/14] blk-mq: provide dummy blk_mq_map_queue_type()
 helper
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 10:22:59 -0700
In-Reply-To: <20181029163738.10172-4-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-4-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 diff --git a/block/blk-mq.h b/block/blk-mq.h
+AD4 index 889f0069dd80..79c300faa7ce 100644
+AD4 --- a/block/blk-mq.h
+AD4 +-+-+- b/block/blk-mq.h
+AD4 +AEAAQA -80,6 +-80,12 +AEAAQA static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue(struct request+AF8-queue +ACo-q,
+AD4  	return q-+AD4-queue+AF8-hw+AF8-ctx+AFs-set-+AD4-map+AFs-0+AF0.mq+AF8-map+AFs-cpu+AF0AXQA7
+AD4  +AH0
+AD4  
+AD4 +-static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue+AF8-type(struct request+AF8-queue +ACo-q,
+AD4 +-							  int type, int cpu)
+AD4 +-+AHs
+AD4 +-	return blk+AF8-mq+AF8-map+AF8-queue(q, cpu)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  /+ACo
+AD4   +ACo sysfs helpers
+AD4   +ACo-/

How about renaming 'type' into something like hw+AF8-ctx+AF8-type to make it more
clear what its meaning is? How about declaring both the 'type' and 'cpu'
arguments as unsigned ints?

Thanks,

Bart.
