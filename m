Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C9620657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJ3CUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:20:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeJ3CUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:20:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so4246229pgq.4;
        Mon, 29 Oct 2018 10:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+j3ah8Gx9oCSywNqFyoHtJo+bLcW4JJtLtEa9pBpcE=;
        b=TW2gftMd4ztMGcyw9wRVh/Xp9eF08/yuiOjjld0EbLX1J7KjsYgGWhgUwiv4/286iu
         otZEN4Ezf5QYStLIzC/aLFcT3W5SWlfb/VGibBrKOQ+XAtcarTOwpIPe1LICDZ3f7mji
         Ws9i03akYWbFGQtALg6BFoBq7dhFBKcL2RT9tB/9fxrWJDeNcWoHUredhWW5fowheDO0
         bq507UFssNOphM9ZENgmB3OuU8zFP7z7ELFsCkpEvyQKb0ZeDo7G8FfS50HAsFbE+oGl
         XadReMkEUWJVVGbtPemKGgF7jGz6EUB/0tN7zjPeGoaVtpsPyC4CQVpwu/RuxVdhi5CN
         cL+A==
X-Gm-Message-State: AGRZ1gJGSNE0OvJykJ91jGwWnGUkw0NZ1Vogof/xtSra1EipzycVTqEL
        NG8mKrcAjCs3Ffa1ZWzw+IWZ2LzR
X-Google-Smtp-Source: AJdET5cjx3F4LGCa4YA5vbmeW3QN3dqIdfTRAJ6IfFJ21aGYvmcvsUhIb7FT1m0TcDzJLqtW0rR7FQ==
X-Received: by 2002:a63:5816:: with SMTP id m22-v6mr14429837pgb.332.1540834238245;
        Mon, 29 Oct 2018 10:30:38 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2190637pff.8.2018.10.29.10.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:30:37 -0700 (PDT)
Message-ID: <1540834236.196084.61.camel@acm.org>
Subject: Re: [PATCH 04/14] blk-mq: pass in request/bio flags to queue mapping
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 10:30:36 -0700
In-Reply-To: <20181029163738.10172-5-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-5-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 +AEAAQA -400,9 +-402,15 +AEAAQA void blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(struct request+AF8-queue +ACo-q,
+AD4  				  struct blk+AF8-mq+AF8-ctx +ACo-ctx,
+AD4  				  struct list+AF8-head +ACo-list, bool run+AF8-queue+AF8-async)
+AD4  +AHs
+AD4 -	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 blk+AF8-mq+AF8-map+AF8-queue(q, ctx-+AD4-cpu)+ADs
+AD4 -	struct elevator+AF8-queue +ACo-e +AD0 hctx-+AD4-queue-+AD4-elevator+ADs
+AD4 +-	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4 +-	struct elevator+AF8-queue +ACo-e+ADs
+AD4 +-	struct request +ACo-rq+ADs
+AD4 +-
+AD4 +-	/+ACo For list inserts, requests better be on the same hw queue +ACo-/
+AD4 +-	rq +AD0 list+AF8-first+AF8-entry(list, struct request, queuelist)+ADs
+AD4 +-	hctx +AD0 blk+AF8-mq+AF8-map+AF8-queue(q, rq-+AD4-cmd+AF8-flags, ctx-+AD4-cpu)+ADs

Passing all request cmd+AF8-flags bits to blk+AF8-mq+AF8-map+AF8-queue() makes it possible
for that function to depend on every single cmd+AF8-flags bit even if different
requests have different cmd+AF8-flags. Have you considered to pass the hw+AF8-ctx
type only to blk+AF8-mq+AF8-map+AF8-queue() to avoid that that function would start
depending on other cmd+AF8-flags?

Additionally, what guarantees that all requests in queuelist have the same
hw+AF8-ctx type? If a later patch will guarantee that, please mention that in
the comment about list+AF8-first+AF8-entry().

Thanks,

Bart.
